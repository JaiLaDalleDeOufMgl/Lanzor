RegisterNetEvent('Gamemode:Pound:ReceiveVehicles')
AddEventHandler('Gamemode:Pound:ReceiveVehicles', function(vehicles)
    MOD_Vehicle.Pound.vehicles = vehicles
end)