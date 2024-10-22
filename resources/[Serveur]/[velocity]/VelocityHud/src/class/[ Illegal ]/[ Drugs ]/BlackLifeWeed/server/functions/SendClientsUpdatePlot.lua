function _GamemodeDrugWeed:SendClientsUpdatePlot(plotSize, plotIndex)
    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('Gamemode:Labo:Weed:UpdatePlot', src, plotSize, plotIndex, self:GetPlotByIndex(plotSize, plotIndex))
    end
end