RegisterNetEvent('Gamemode:GangBuilder:ReceiveVehicles')
AddEventHandler('Gamemode:GangBuilder:ReceiveVehicles', function(vehicles)
    MOD_GangBuilder:SetVehicles(vehicles)
end)