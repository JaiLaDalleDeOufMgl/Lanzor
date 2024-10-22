RegisterNetEvent('Gamemode:Drugs:RemoveSellZone')
AddEventHandler('Gamemode:Drugs:RemoveSellZone', function(zoneId)
    MOD_DrugSell:delete(zoneId)
end)