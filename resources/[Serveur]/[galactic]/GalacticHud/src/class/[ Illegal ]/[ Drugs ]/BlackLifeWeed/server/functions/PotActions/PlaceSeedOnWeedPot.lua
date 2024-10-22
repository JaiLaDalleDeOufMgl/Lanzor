function _GamemodeDrugWeed:PlaceSeedOnWeedPot(plotSize, plotIndex, potIndex, seedVariety)
    local PotProcces = Gamemode.enums.Labos.Types['weed']['procces']['potInGrow']
    local VarietySeed = Gamemode.enums.Labos.Types['weed']['procces'].Variety[seedVariety]

    local PotInfos = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex].PotList[potIndex]

    if (self.plotList[plotSize][plotIndex].PotList[potIndex].state == PotProcces.state) then return end

    if (self.plotList[plotSize][plotIndex] ~= "empty") then
        DeleteEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)
        self.bucket:RemoveFromBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")

        self.plotList[plotSize][plotIndex].PotList[potIndex] = {
            object = VarietySeed.object.small,
            prop = CreateObjectNoOffset(VarietySeed.object.small, PotInfos.x, PotInfos.y, PotInfos.z - 1.0, true, true, true),
            state = PotProcces.state,

            metadata = {
                state = "needwater",
                variety = VarietySeed.variety,

                water = 25,
                fertilizer = 0,
                health = 100,

                growHitS = (100 / (math.random(VarietySeed.TimeGrow.min, VarietySeed.TimeGrow.max) * 60)),
                growProgress = 0
            }
        }

        self.plotList[plotSize][plotIndex].PotList[potIndex].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[plotSize][plotIndex].PotList[potIndex].prop)

        FreezeEntityPosition(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, true)
        self.bucket:AddInBucket(self.plotList[plotSize][plotIndex].PotList[potIndex].prop, "object")
    end

    self:SendClientsUpdatePlot(plotSize, plotIndex)
end