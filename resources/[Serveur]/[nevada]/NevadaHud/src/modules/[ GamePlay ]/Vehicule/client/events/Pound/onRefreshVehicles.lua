RegisterNetEvent('Gamemode:Pound:RefreshVehicles')
AddEventHandler('Gamemode:Pound:RefreshVehicles', function()
    TriggerServerEvent('Gamemode:Pound:RequestVehicles')
end)