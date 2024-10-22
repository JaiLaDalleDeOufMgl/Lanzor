RegisterNetEvent('Gamemode:Zones:AddZone')
AddEventHandler('Gamemode:Zones:AddZone', function(zone)
    MOD_Zones:add(zone)
end)