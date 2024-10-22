local pnjGelEnabled
local pnjGelCoords
local pnjVehicles = {}

local function ArreterPNJDansZone()

    CreateThread(function()

        while pnjGelEnabled do

            local loopTime = 1000*3
            
            if (not pnjGelEnabled) then
                break
            end

            local playerCoords = GetEntityCoords(PlayerPedId())

            if (type(pnjGelCoords) == "vector3" and #(playerCoords-pnjGelCoords) < 100.0) then
            
                loopTime = 400
                local allVehicles = GetGamePool("CVehicle")

                for i = 1, #allVehicles do
            
                    local vehicle = allVehicles[i]
            
                    if (DoesEntityExist(vehicle) and not pnjVehicles[vehicle]) then
            
                        local vehicleCoords = GetEntityCoords(vehicle)
                        
                        if (#(playerCoords-vehicleCoords) < 100.0) then
    
                            local entityPopulationType = GetEntityPopulationType(vehicle)
    
                            if (entityPopulationType == 5) then
                                
                                local vehicleDriver = GetPedInVehicleSeat(vehicle, -1)
                                local vehicleDriverPopulationType = GetEntityPopulationType(vehicleDriver)
    
                                if (vehicleDriver ~= 0 and vehicleDriverPopulationType == 5) then
                                
                                    SetEntityCollision(vehicle, false, false)
                                    FreezeEntityPosition(vehicle, true)
                                    pnjVehicles[vehicle] = true

                                end
    
                            end
    
                        end
    
                    end
            
                end

            end

            Wait(loopTime)

        end

    end)

end

local function StopArreterPNJDansZone()

    local allVehicles = pnjVehicles

    for vehicle, _ in pairs(allVehicles) do

        local vehicle = vehicle

        if DoesEntityExist(vehicle) then

            SetEntityCollision(vehicle, true, true)
            FreezeEntityPosition(vehicle, false)

        end

    end

    pnjVehicles = {}

end

RegisterNetEvent("GelPNJ")
AddEventHandler("GelPNJ", function(pnjState, gelCoords)

    if (type(pnjState) ~= "boolean" or type(gelCoords) ~= "table") then
        return
    end

    pnjGelCoords = vector3(gelCoords.x, gelCoords.y, gelCoords.z);
    pnjGelEnabled = pnjState;

    if (pnjGelEnabled == false) then
        StopArreterPNJDansZone()
    elseif (pnjGelEnabled == true) then
        ArreterPNJDansZone();
    end

end)