function _GamemodeDrugWeed:PlaceWeedLampOnPlot(plotSize, plotIndex, potIndex)
    if (self.plotList[plotSize][plotIndex] ~= "empty") then
        local LampObject = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex].LampObject
        local LampInfos = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[plotSize][plotIndex].LampList[potIndex]

        self.plotList[plotSize][plotIndex].LampList[potIndex] = {
            object = LampObject,
            prop = CreateObjectNoOffset(LampObject, LampInfos.x, LampInfos.y, LampInfos.z, true, true, true)
        }

        self.plotList[plotSize][plotIndex].LampList[potIndex].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[plotSize][plotIndex].LampList[potIndex].prop)

        SetEntityRotation(self.plotList[plotSize][plotIndex].LampList[potIndex].prop, 0, 0, LampInfos.w, 2, true)
        FreezeEntityPosition(self.plotList[plotSize][plotIndex].LampList[potIndex].prop, true)
        self.bucket:AddInBucket(self.plotList[plotSize][plotIndex].LampList[potIndex].prop, "object")
    end

    self:SendClientsUpdatePlot(plotSize, plotIndex)
end