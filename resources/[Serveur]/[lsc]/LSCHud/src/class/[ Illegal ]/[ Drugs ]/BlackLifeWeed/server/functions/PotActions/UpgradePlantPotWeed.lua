function _GamemodeDrugWeed:UpgradePlantPotWeed(plotSize, plotIndex, potIndex, ProgressGrow)
    if (self.plotList[plotSize][plotIndex] == "empty") then
        return
    end

    local PotProcces = Gamemode.enums.Labos.Types['weed']['procces']['potRecolt']
    local PotInfos = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex].PotList[potIndex]

    local VarietySeed = Gamemode.enums.Labos.Types['weed']['procces'].Variety[self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.variety]

    local GrowProgressState = self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.GrowProgressState

    if (GrowProgressState == nil) then
        GrowProgressState = 0
    end

    local Update, SizePotWeed = false, false
    
    if (ProgressGrow > 30 and GrowProgressState < 30) then
        self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.GrowProgressState = 30

        Update = true
        SizePotWeed = "med"
    elseif (ProgressGrow > 50 and GrowProgressState < 50) then
        self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.GrowProgressState = 50

        Update = true
        SizePotWeed = "medXL"
    elseif (ProgressGrow > 70 and GrowProgressState < 70) then
        self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.GrowProgressState = 70

        Update = true
        SizePotWeed = "large"
    end

    if (Update) then
        DeleteEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)
        self.bucket:RemoveFromBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")

        self.plotList[plotSize][plotIndex].PotList[potIndex].object = VarietySeed.object[SizePotWeed]
        self.plotList[plotSize][plotIndex].PotList[potIndex].prop = CreateObjectNoOffset(VarietySeed.object[SizePotWeed], PotInfos.x, PotInfos.y, PotInfos.z - 1.0, true, true, true)

        self.plotList[plotSize][plotIndex].PotList[potIndex].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)

        FreezeEntityPosition(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, true)
        self.bucket:AddInBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")

        self:SendClientsUpdatePlot(plotSize, plotIndex)
    end
end