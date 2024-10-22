AddEventHandler('esx:playerLoaded', function(src, xPlayer)
    local payload = {}
    for _, zone in pairs(MOD_DrugSell:getAllZonesSell()) do
        payload[#payload + 1] = zone:minify()
    end

    TriggerClientEvent('Gamemode:Drugs:AddSellZones', src, payload)
end)