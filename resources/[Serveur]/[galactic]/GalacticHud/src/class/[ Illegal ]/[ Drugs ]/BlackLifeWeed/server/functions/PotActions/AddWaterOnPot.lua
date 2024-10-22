function _GamemodeDrugWeed:AddWaterOnPot(plotSize, plotIndex, potIndex)
    local PotInfos = self.plotList[plotSize][plotIndex].PotList[potIndex]
    local EnumsGrowInfo = Gamemode.enums.Labos.Types['weed']['procces'].GrowInfos

    if (self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.water ~= 100 and (PotInfos.metadata.water + EnumsGrowInfo.WaterAddOnPlant) >= 100) then
        self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.water = 100
    else
        if ((PotInfos.metadata.water + EnumsGrowInfo.WaterAddOnPlant) > 100) then
            print('PEUX PAS PLUS CHEF')
        else
            print("AJOUT D'EAU DANS LA PLANTE")
            self.plotList[plotSize][plotIndex].PotList[potIndex].metadata.water += EnumsGrowInfo.WaterAddOnPlant
        end
    end
end