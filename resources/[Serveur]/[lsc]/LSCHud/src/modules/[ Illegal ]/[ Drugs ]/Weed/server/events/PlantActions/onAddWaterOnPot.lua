RegisterNetEvent('Gamemode:Labo:Weed:AddWaterOnPot')
AddEventHandler('Gamemode:Labo:Weed:AddWaterOnPot', function(plotSize, plotIndex, potIndex)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab.Drug:AddWaterOnPot(plotSize, plotIndex, potIndex)
    end
end)