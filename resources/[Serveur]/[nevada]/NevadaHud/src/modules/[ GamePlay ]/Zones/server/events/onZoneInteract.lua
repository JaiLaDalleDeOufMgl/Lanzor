RegisterNetEvent('Gamemode:Zone:onInteraction')
AddEventHandler('Gamemode:Zone:onInteraction', function(zoneId)
    local _src = source

    local xPlayer = ESX.GetPlayerFromId(_src)

    local Zone = MOD_Zones:getZone(zoneId)

    Zone.handler(xPlayer, Zone)
end)