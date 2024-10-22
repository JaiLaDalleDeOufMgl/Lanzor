function PlayEffect(pdict, pname)
    CreateThread(function()
        local position = GetOffsetFromEntityInWorldCoords(nozzle, 0.0, 0.28, 0.17)
        UseParticleFxAssetNextCall(pdict)
        local pfx = StartParticleFxLoopedAtCoord(pname, position.x, position.y, position.z, 0.0, 0.0, GetEntityHeading(nozzle), 1.0, false, false, false, false)
        Wait(100)
        StopParticleFxLooped(pfx, 0)
    end)
end

function putNozzleInVehicle(vehicle, ptankBone, isBike, dontClear, newTankPosition)
    local ped = PlayerPedId()

    if isBike then
        AttachEntityToEntity(nozzle, vehicle, ptankBone, 0.0 + newTankPosition.x, -0.2 + newTankPosition.y, 0.2 + newTankPosition.z, -80.0, 0.0, 0.0, true, true, false, false, 1, true)
    else
        AttachEntityToEntity(nozzle, vehicle, ptankBone, -0.18 + newTankPosition.x, 0.0 + newTankPosition.y, 0.75 + newTankPosition.z, -125.0, -90.0, -90.0, true, true, false, false, 1, true)
    end
    
    if not dontClear and IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
        ClearPedTasks(ped)
    end

    nozzleDropped = false
    holdingNozzle = false
    nozzleInVehicle = true
    wastingFuel = false
    vehicleFueling = vehicle
end

function dropNozzle()
    DetachEntity(nozzle, true, true)
    nozzleDropped = true
    holdingNozzle = false
    nozzleInVehicle = false
    vehicleFueling = false
    SendNUIMessage({
        event = 'FuelState',
        bool = false
    })

end

function returnNozzleToPump()
    DeleteEntity(nozzle)
    RopeUnloadTextures()
    DeleteRope(rope)

    nozzleDropped = false
    holdingNozzle = false
    nozzleInVehicle = false
    vehicleFueling = false

    SendNUIMessage({
        event = 'FuelState',
        bool = false
    })
end

function grabExistingNozzle()
    local ped = PlayerPedId()

    AttachEntityToEntity(nozzle, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    nozzleDropped = false
    holdingNozzle = true
    nozzleInVehicle = false
    vehicleFueling = false
end

function grabNozzleFromPump()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)

    API_Streaming:requestAnimDict("anim@am_hold_up@male")
    TaskPlayAnim(ped, "anim@am_hold_up@male", "shoplift_high", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
    Wait(300)
    nozzle = CreateObject(`prop_cs_fuel_nozle`, 0, 0, 0, true, true, true)
    AttachEntityToEntity(nozzle, ped, GetPedBoneIndex(ped, 0x49D9), 0.11, 0.02, 0.02, -80.0, -90.0, 15.0, true, true, false, true, 1, true)
    RopeLoadTextures()
    while not RopeAreTexturesLoaded() do
        Wait(0)
    end
    RopeLoadTextures()

    local pump, pumpHandle = nearPump(pedCoords)

    while not pump do
        Wait(0)
    end
    rope = AddRope(pump.x, pump.y, pump.z, 0.0, 0.0, 0.0, 3.0, 1, 1000.0, 0.0, 1.0, false, false, false, 1.0, true)
    while not rope do
        Wait(0)
    end
    ActivatePhysics(rope)

    Wait(50)

    local nozzlePos = GetEntityCoords(nozzle)
    nozzlePos = GetOffsetFromEntityInWorldCoords(nozzle, 0.0, -0.033, -0.195)
    AttachEntitiesToRope(rope, pumpHandle, nozzle, pump.x, pump.y, pump.z + 1.45, nozzlePos.x, nozzlePos.y, nozzlePos.z, 5.0, false, false, nil, nil)
    nozzleDropped = false
    holdingNozzle = true
    nozzleInVehicle = false
    vehicleFueling = false
    usedPump = pumpHandle


    
    SendNUIMessage({
        event = 'FuelState',
        bool = true
    })

    SendNUIMessage({
        event = 'FuelUpdate',
        cost = "0.00",
        tank = "0.00"
    })
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(true)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_x, _y)
end

function nearPump(coords)
    local entity = nil
    for hash in pairs(Gamemode.enums.Vehicle.Fuel.pumpModels) do
        entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.8, hash, true, true, true)
        if entity ~= 0 then break end
    end
    if Gamemode.enums.Vehicle.Fuel.pumpModels[GetEntityModel(entity)] then
        return GetEntityCoords(entity), entity
    end
end