function _GamemodeDrugWeed:InitTickPot()
    CreateThread(function()
        while true do
            for size, data in pairs(self.plotList) do
                for i=1, #self.plotList[size] do
                    if (self.plotList[size][i] ~= "empty") then
                        for _i=1, #self.plotList[size][i].PotList do
                            if (self.plotList[size][i].PotList[_i].state == "potInGrow") then
                                local PotInfo = self.plotList[size][i].PotList[_i]
                                local EnumsGrowInfo = Gamemode.enums.Labos.Types['weed']['procces'].GrowInfos

                                if (self.plotList[size][i].PotList[_i].metadata.growProgress >= 100) then
                                    self:FinishPotWeed(size, i, _i)
                                    goto continue
                                end

                                if (self.plotList[size][i].PotList[_i].metadata.health <= 0) then
                                    self:ResetPotWeed(size, i, _i)
                                    goto continue
                                end

                                if (self:GetPlotHasLamp(size, i)) then
                                    self.plotList[size][i].PotList[_i].metadata.state = 'ingrow'
                                    self.plotList[size][i].PotList[_i].metadata.growProgress += PotInfo.metadata.growHitS

                                    print('GROW PROGRESS', self.plotList[size][i].PotList[_i].metadata.growProgress)
                                else
                                    self.plotList[size][i].PotList[_i].metadata.state = 'needlamp'
                                end

                                if (self.plotList[size][i].PotList[_i].metadata.water <= 0) then
                                    self.plotList[size][i].PotList[_i].metadata.health -= EnumsGrowInfo.LifeHitPlantNoWater

                                    self.plotList[size][i].PotList[_i].metadata.state = 'needwater'
                                elseif (self.plotList[size][i].PotList[_i].metadata.water > 0) then
                                    self.plotList[size][i].PotList[_i].metadata.water -= EnumsGrowInfo.WaterHitPlant
                                end

                                local ProgressGrow = self.plotList[size][i].PotList[_i].metadata.growProgress
                                self:UpgradePlantPotWeed(size, i, _i, ProgressGrow)

                                ::continue::
                            end
                        end
                    end
                end
            end

            Wait(1000)
        end
    end)
end