RegisterNetEvent('Gamemode:Vehicle:SetVehicleProperties')
AddEventHandler('Gamemode:Vehicle:SetVehicleProperties', function(netId, properties)
    local timer = GetGameTimer()
    while not NetworkDoesEntityExistWithNetworkId(tonumber(netId)) do
        Wait(0)
        if GetGameTimer() - timer > 10000 then
            return
        end
    end

    local vehicle = NetToVeh(tonumber(netId))
    local timer = GetGameTimer()
    while NetworkGetEntityOwner(vehicle) ~= PlayerId() do
        Wait(0)
        if GetGameTimer() - timer > 10000 then
            return
        end
    end

    ESX.Game.SetVehicleProperties(vehicle, properties)
end)