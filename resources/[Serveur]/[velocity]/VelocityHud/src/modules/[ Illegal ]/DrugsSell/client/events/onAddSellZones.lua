RegisterNetEvent('Gamemode:Drugs:AddSellZones')
AddEventHandler('Gamemode:Drugs:AddSellZones', function(zones)
    for _, zone in pairs(zones) do
        MOD_DrugSell:add(zone)
    end
end)