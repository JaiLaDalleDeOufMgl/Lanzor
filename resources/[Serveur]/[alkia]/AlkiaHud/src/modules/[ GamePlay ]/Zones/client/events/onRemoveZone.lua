RegisterNetEvent('Gamemode:Zones:RemoveZone')
AddEventHandler('Gamemode:Zones:RemoveZone', function(zoneId)
    MOD_Zones:delete(zoneId)
end)