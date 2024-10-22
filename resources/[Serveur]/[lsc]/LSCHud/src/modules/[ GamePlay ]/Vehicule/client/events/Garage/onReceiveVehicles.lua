RegisterNetEvent('Gamemode:Garage:ReceiveVehicles')
AddEventHandler('Gamemode:Garage:ReceiveVehicles', function(vehicles)
    MOD_Vehicle.Garage.vehicles = vehicles
end)