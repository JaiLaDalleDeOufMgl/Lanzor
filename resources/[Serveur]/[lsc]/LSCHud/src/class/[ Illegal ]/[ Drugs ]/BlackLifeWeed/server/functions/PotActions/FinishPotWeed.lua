function _GamemodeDrugWeed:FinishPotWeed(plotSize, plotIndex, potIndex)
    local PotProcces = Gamemode.enums.Labos.Types['weed']['procces']['potRecolt']
    local PotInfos = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex].PotList[potIndex]

    local VarietySeed = Gamemode.enums.Labos.Types['weed']['procces'].Variety[self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.variety]

    if (self.plotList[plotSize][plotIndex] ~= "empty") then
        DeleteEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)
        self.bucket:RemoveFromBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")

        self.plotList[plotSize][plotIndex].PotList[potIndex] = {
            object = VarietySeed.object['largeXL'],
            prop = CreateObjectNoOffset(VarietySeed.object['largeXL'], PotInfos.x, PotInfos.y, PotInfos.z - 1.0, true, true, true),
            state = PotProcces.state,

            metadata = {
                finished = true,
                health = self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.health,
                fertilizer = self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.fertilizer,

                variety = self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.variety
            }
        }

        self.plotList[plotSize][plotIndex].PotList[potIndex].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)

        FreezeEntityPosition(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, true)
        self.bucket:AddInBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")
    end

    self:SendClientsUpdatePlot(plotSize, plotIndex)
end