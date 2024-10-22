RegisterNetEvent('Gamemode:Zones:AddZones')
AddEventHandler('Gamemode:Zones:AddZones', function(zones)
    for _, zone in pairs(zones) do
        MOD_Zones:add(zone)
    end
end)