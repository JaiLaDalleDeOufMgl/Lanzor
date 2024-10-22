AddEventHandler('esx:playerLoaded', function(src, xPlayer)
    local payload = {}
    for _, zone in pairs(MOD_Zones:getAllZones()) do
        if (not zone.notSendCl) then
            payload[#payload + 1] = zone:minify()
        end
    end

    TriggerClientEvent('Gamemode:Zones:AddZones', src, payload)

    MOD_Zones:loadZonesByJob(src, xPlayer.job)
    MOD_Zones:loadZonesByJob(src, xPlayer.job2)
end)