
function DEN:SpawnVeh(veh,pos,heading,instantwarp)
    RequestModel(veh)
    while not HasModelLoaded(veh) do
        Citizen.Wait(10)
    end
    local hash = GetHashKey(veh)
    local veh = CreateVehicle(hash, pos.x,pos.y,pos.z, heading, false, false)
    if instantwarp then
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        SetVehicleEngineOn(PlayerPedId(), true, true, false)
    end
end
function DEN:BreakEngine(veh,time)
    SetVehicleEngineHealth(veh, -4000.0)
    Wait(time)
    SetVehicleEngineHealth(veh, 0)
end
function DEN:FullCustom(veh,repair,color)
    if repair then
        SetVehicleFixed(veh)
    end
    if color == nil then 
        ESX.Game.SetVehicleProperties(veh, {
            modEngine = 3,
            modBrakes = 2,
            modTransmission = 2,
            modSuspension = 3,
            windowTint = 1,
            modXenon = true ,
            modTurbo = true,
            fuelLevel = 100
        })
    else
        ESX.Game.SetVehicleProperties(veh, {
            color1 = color,
            color2 = color,
            modEngine = 3,
            modBrakes = 2,
            modTransmission = 2,
            modSuspension = 3,
            windowTint = 1,
            modXenon = true ,
            modTurbo = true,
            fuelLevel = 100
        })
    end
end