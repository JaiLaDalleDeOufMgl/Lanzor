RegisterNetEvent('Gamemode:Labo:Weed:UpdatePlot')
AddEventHandler('Gamemode:Labo:Weed:UpdatePlot', function(plotSize, plotIndex, plotData)
    MOD_Weed:UpdatePlotByIndex(plotSize, plotIndex, plotData)
end)