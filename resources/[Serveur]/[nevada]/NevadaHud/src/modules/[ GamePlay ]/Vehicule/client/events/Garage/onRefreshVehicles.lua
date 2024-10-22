RegisterNetEvent('Gamemode:Garage:RefreshVehicles')
AddEventHandler('Gamemode:Garage:RefreshVehicles', function()
    TriggerServerEvent('Gamemode:Garage:RequestVehicles')
end)