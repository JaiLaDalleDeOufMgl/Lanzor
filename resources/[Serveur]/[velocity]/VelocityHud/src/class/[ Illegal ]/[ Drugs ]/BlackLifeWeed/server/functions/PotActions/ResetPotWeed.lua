function _GamemodeDrugWeed:ResetPotWeed(plotSize, plotIndex, potIndex)
    local PotProcces = Gamemode.enums.Labos.Types['weed']['procces']['placePot']
    local PotInfos = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex].PotList[potIndex]

    if (self.plotList[plotSize][plotIndex] ~= "empty") then
        DeleteEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)
        self.bucket:RemoveFromBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")

        self.plotList[plotSize][plotIndex].PotList[potIndex] = {
            object = PotProcces.object,
            prop = CreateObjectNoOffset(PotProcces.object, PotInfos.x, PotInfos.y, PotInfos.z - 1.0, true, true, true),
            state = PotProcces.state
        }

        self.plotList[plotSize][plotIndex].PotList[potIndex].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)

        FreezeEntityPosition(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, true)
        self.bucket:AddInBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")
    end

    self:SendClientsUpdatePlot(plotSize, plotIndex)
end