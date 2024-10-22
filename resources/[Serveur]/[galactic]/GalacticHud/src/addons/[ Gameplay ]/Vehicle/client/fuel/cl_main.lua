nozzleDropped = false
holdingNozzle = false
nozzleInVehicle = false

nozzle = nil
rope = nil
vehicleFueling = nil
usedPump = nil
pumpCoords = nil
wastingFuel = false
nearTank = false

-- Setting the electric vehicle config keys to hashes.
for _, vehHash in pairs(Gamemode.enums.Vehicle.Fuel.electricVehicles) do
    Gamemode.enums.Vehicle.Fuel.electricVehicles[vehHash] = vehHash
end


-- Getting the vehicle infront if the player.
local function vehicleInFront()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    local entity = nil
    local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)

    local rayHandle = CastRayPointToPoint(pedCoords.x, pedCoords.y, pedCoords.z - 1.3, offset.x, offset.y, offset.z, 10, ped, 0)
    local A, B, C, D, entity = GetRaycastResult(rayHandle)
    if IsEntityAVehicle(entity) then
        return entity
    end
end


-- Refuel the vehicle.
CreateThread(function()
    while true do
        Wait(2000)

        if vehicleFueling then
            local PlayerMoney = 0

            local moneyPromise = promise.new()
            ESX.TriggerServerCallback("Gamemode:Fuel:GetPlayerMoney", function(money)
                PlayerMoney = money
                moneyPromise:resolve()
            end)
            Citizen.Await(moneyPromise)

            local classMultiplier = Gamemode.enums.Vehicle.Fuel.vehicleClasses[GetVehicleClass(vehicleFueling)]

            local cost = 0

            if (PlayerMoney > 0) then
                while vehicleFueling do
                    local fuel = MOD_Vehicle:GetFuel(vehicleFueling)

                    if not DoesEntityExist(vehicleFueling) then
                        dropNozzle()
                        break
                    end

                    fuel = MOD_Vehicle:GetFuel(vehicleFueling)
                    cost = cost + ((2.0 / classMultiplier) * Gamemode.enums.Vehicle.Fuel.fuelCostMultiplier) - math.random(0, 100) / 100

                    if PlayerMoney < cost then
                        vehicleFueling = false
                        break
                    end

                    if fuel < 97 then
                        MOD_Vehicle:SetFuel(vehicleFueling, fuel + ((2.0 / classMultiplier) - math.random(0, 100) / 100))
                    else
                        fuel = 100.0
                        MOD_Vehicle:SetFuel(vehicleFueling, fuel)
                        vehicleFueling = false
                    end

                    SendNUIMessage({
                        event = 'FuelUpdate',
                        cost = string.format("%.2f", cost),
                        tank = string.format("%.2f", fuel)
                    })

                    Wait(600)
                end

                if cost ~= 0 then
                    TriggerServerEvent("Gamemode:Fuel:PayFuelVehicle", (cost - 1))
                    cost = 0
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        local interval = 1000

        if IsPedInAnyVehicle(PlayerPedId()) or IsPedInAnyBoat(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
            SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId()), 100.0)
        end



        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local pump, pumpHandle = nearPump(pedCoords)

        if (pump) then
            interval = 0

            if not holdingNozzle and not nozzleInVehicle and not nozzleDropped then
                DrawText3D(pump.x, pump.y, pump.z + 1.2, "Saisir le pistolet [E]")

                if IsControlJustPressed(0, 51) then
                    grabNozzleFromPump()
                    Wait(1000)
                    ClearPedTasks(ped)
                end
                
            elseif holdingNozzle and not nearTank and pumpHandle == usedPump then

                DrawText3D(pump.x, pump.y, pump.z + 1.2, "Déposer le pistolet [E]")

                if IsControlJustPressed(0, 51) then
                    API_Streaming:requestAnimDict("anim@am_hold_up@male")
                    TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                    Wait(300)
                    returnNozzleToPump()
                    Wait(1000)
                    ClearPedTasks(ped)
                end
            end
        end

        Wait(interval)
    end
end)

-- Attaching and taking the nozzle form the vehicle, and dropping the nozzle form the player or vehicle.
CreateThread(function()
    while true do
        local interval = 1500

        if (holdingNozzle or nozzleInVehicle or nozzleDropped) then
            interval = 0

            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            local pump, pumpHandle = nearPump(pedCoords)

            -- drop the nozzle and remove it if it's far away from the pump.
            if pump then
                pumpCoords = GetEntityCoords(usedPump)
            end

            if nozzle and pumpCoords then
                nozzleLocation = GetEntityCoords(nozzle)

                if #(pumpCoords - pedCoords) < 3.0 then
                    SendNUIMessage({
                        event = 'FuelState',
                        bool = true
                    })
                else
                    SendNUIMessage({
                        event = 'FuelState',
                        bool = false
                    })
                end


                if #(nozzleLocation - pumpCoords) > 6.0 then
                    dropNozzle()
                elseif #(pumpCoords - pedCoords) > 100.0 then
                    returnNozzleToPump()
                end
                if nozzleDropped and #(nozzleLocation - pedCoords) < 1.5 then
                    DrawText3D(nozzleLocation.x, nozzleLocation.y, nozzleLocation.z, "Saisir le pistolet [E]")

                    if IsControlJustPressed(0, 51) then
                        API_Streaming:requestAnimDict("anim@mp_snowball")
                        TaskPlayAnim(ped, "anim@mp_snowball", "pickup_snowball", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                        Wait(700)
                        grabExistingNozzle()
                        ClearPedTasks(ped)
                    end
                end
            end

            local veh = vehicleInFront()

            -- Animations for manually fueling and effect for sparying fuel.
            if holdingNozzle and nozzle then
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 24, true)

                if IsDisabledControlPressed(0, 24) then
                    if veh and tankPosition and #(pedCoords - tankPosition) < 1.2 then
                        if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                            API_Streaming:requestAnimDict("timetable@gardener@filling_can")
                            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                        end
                        wastingFuel = false
                        vehicleFueling = veh
                    else
                        if IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                            vehicleFueling = false
                            ClearPedTasks(ped)
                        end
                        if nozzleLocation then
                            wastingFuel = true
                            PlayEffect("core", "veh_trailer_petrol_spray")
                        end
                    end
                else
                    if IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
                        vehicleFueling = false
                        ClearPedTasks(ped)
                    end
                    wastingFuel = false
                end
            end

            if veh then
                local vehClass = GetVehicleClass(veh)
                local zPos = Gamemode.enums.Vehicle.Fuel.nozzleBasedOnClass[vehClass + 1]
                local isBike = false

                local nozzleModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }
                local textModifiedPosition = {
                    x = 0.0,
                    y = 0.0,
                    z = 0.0
                }
                
                if vehClass == 8 and vehClass ~= 13 and not Gamemode.enums.Vehicle.Fuel.electricVehicles[GetHashKey(veh)] then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "engine")
                    end
                    isBike = true
                elseif vehClass ~= 13 and not Gamemode.enums.Vehicle.Fuel.electricVehicles[GetHashKey(veh)] then
                    tankBone = GetEntityBoneIndexByName(veh, "petrolcap")
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "petroltank_l")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "hub_lr")
                    end
                    if tankBone == -1 then
                        tankBone = GetEntityBoneIndexByName(veh, "handle_dside_r")
                        nozzleModifiedPosition.x = 0.1
                        nozzleModifiedPosition.y = -0.5
                        nozzleModifiedPosition.z = -0.6
                        textModifiedPosition.x = 0.55
                        textModifiedPosition.y = 0.1
                        textModifiedPosition.z = -0.2
                    end
                end

                tankPosition = GetWorldPositionOfEntityBone(veh, tankBone)

                if tankPosition and #(pedCoords - tankPosition) < 1.2 then
                    if not nozzleInVehicle and holdingNozzle then
                        nearTank = true
                        DrawText3D(tankPosition.x + textModifiedPosition.x, tankPosition.y + textModifiedPosition.y, tankPosition.z + zPos + textModifiedPosition.z, "Fixer le pistolet [E]")
                        
                        if IsControlJustPressed(0, 51) then
                            API_Streaming:requestAnimDict("timetable@gardener@filling_can")
                            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                            Wait(300)
                            putNozzleInVehicle(veh, tankBone, isBike, true, nozzleModifiedPosition)
                            Wait(300)
                            ClearPedTasks(ped)
                        end
                    elseif nozzleInVehicle then
                        DrawText3D(tankPosition.x + textModifiedPosition.x, tankPosition.y + textModifiedPosition.y, tankPosition.z + zPos + textModifiedPosition.z, "Saisir le pistolet [E]")
                        
                        if IsControlJustPressed(0, 51) then
                            API_Streaming:requestAnimDict("timetable@gardener@filling_can")
                            TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
                            Wait(300)
                            grabExistingNozzle()
                            Wait(300)
                            ClearPedTasks(ped)
                        end
                    end 
                end
            else
                nearTank = false
            end
        end

        Wait(interval)
    end
end)