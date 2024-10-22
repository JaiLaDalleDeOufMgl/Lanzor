RegisterNetEvent('Gamemode:Labo:Weed:BuyPlot')
AddEventHandler('Gamemode:Labo:Weed:BuyPlot', function(plotSize, plotIndex)
    local xPlayer = ESX.GetPlayerFromId(source)
    local PlyCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))

    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab.Drug:BuyWeedPlot(plotSize, plotIndex)
    end
end)