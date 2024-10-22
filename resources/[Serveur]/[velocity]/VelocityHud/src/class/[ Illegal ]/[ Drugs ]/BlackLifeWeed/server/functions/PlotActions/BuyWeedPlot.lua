function _GamemodeDrugWeed:BuyWeedPlot(plotSize, plotIndex)
    local PlotInfo = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex]

    if (self.plotList[plotSize][plotIndex] == "empty") then
        self.plotList[plotSize][plotIndex] = { name = PlotInfo.name, PotList = {}, LampList = {} }

        for i=1, #PlotInfo.PotList, 1 do
            self.plotList[plotSize][plotIndex].PotList[i] = "empty"
        end

        for i=1, #PlotInfo.LampList, 1 do
            self.plotList[plotSize][plotIndex].LampList[i] = "empty"
        end
    end

    self:SendClientsUpdatePlot(plotSize, plotIndex)
end