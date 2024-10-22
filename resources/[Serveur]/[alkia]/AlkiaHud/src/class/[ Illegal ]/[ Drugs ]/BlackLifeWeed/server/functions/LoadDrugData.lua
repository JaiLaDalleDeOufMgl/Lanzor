function _GamemodeDrugWeed:LoadDrugData(plotData)
    for size, data in pairs(plotData) do
        self.plotList[size] = plotData[size]

        for i=1, #self.plotList[size] do
            if (self.plotList[size][i] ~= "empty") then
                for _i=1, #self.plotList[size][i].LampList do
                    if (self.plotList[size][i].LampList[_i] ~= "empty") then
                        local LampInfos = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[size][i].LampList[_i]
                        local LampObject = self.plotList[size][i].LampList[_i].object

                        self.plotList[size][i].LampList[_i].prop = CreateObjectNoOffset(LampObject, LampInfos.x, LampInfos.y, LampInfos.z, true, true, true)
                        self.plotList[size][i].LampList[_i].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[size][i].LampList[_i].prop)
                    
                        SetEntityRotation(self.plotList[size][i].LampList[_i].prop, 0, 0, LampInfos.w, 2, true)
                        FreezeEntityPosition(self.plotList[size][i].LampList[_i].prop, true)
                        self.bucket:AddInBucket(self.plotList[size][i].LampList[_i].prop, "object")
                    end
                end

                for _i=1, #self.plotList[size][i].PotList do
                    if (self.plotList[size][i].PotList[_i] ~= "empty") then
                        local PotInfos = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[size][i].PotList[_i]
                        local PotObject = self.plotList[size][i].PotList[_i].object
                        
                        self.plotList[size][i].PotList[_i].prop = CreateObjectNoOffset(PotObject, PotInfos.x, PotInfos.y, PotInfos.z - 1.0, true, true, true)
                        self.plotList[size][i].PotList[_i].propNetId = NetworkGetNetworkIdFromEntity(self.plotList[size][i].PotList[_i].prop)
                    
                        FreezeEntityPosition(self.plotList[size][i].PotList[_i].prop, true)
                        self.bucket:AddInBucket(self.plotList[size][i].PotList[_i].prop, "object")
                    end
                end
            end
        end
    end
end