AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    Wait(5000)

    local payload = {}
    for _, zone in pairs(MOD_Zones:getAllZones()) do
        if (not zone.notSendCl) then
            payload[#payload + 1] = zone:minify()
        end
    end

    TriggerClientEvent('Gamemode:Zones:AddZones', -1, payload)
end)