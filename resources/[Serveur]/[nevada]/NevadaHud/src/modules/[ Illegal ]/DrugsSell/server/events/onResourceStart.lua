AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    Wait(1000)

    MOD_DrugSell:AddZoneSell(vector3(-1718.65, -1092.72, 12), 100)

    Wait(5000)

    local payload = {}
    for _, zone in pairs(MOD_DrugSell:getAllZonesSell()) do
        payload[#payload + 1] = zone:minify()
    end

    TriggerClientEvent('Gamemode:Drugs:AddSellZones', -1, payload)
end)