RegisterNetEvent('Gamemode:Drugs:AddSellZone')
AddEventHandler('Gamemode:Drugs:AddZSellone', function(zone)
    MOD_DrugSell:add(zone)
end)