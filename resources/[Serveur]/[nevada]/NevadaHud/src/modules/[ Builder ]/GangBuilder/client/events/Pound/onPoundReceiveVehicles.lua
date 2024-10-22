RegisterNetEvent('Gamemode:GangBuilder:PoundReceiveVehicles')
AddEventHandler('Gamemode:GangBuilder:PoundReceiveVehicles', function(vehicles)
    MOD_GangBuilder.data.pound.vehicles = vehicles
end)