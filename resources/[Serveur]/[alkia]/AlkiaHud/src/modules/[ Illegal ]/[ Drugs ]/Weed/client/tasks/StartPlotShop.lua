local RateLimite = 0
local MaxRateLimite = 1
local TimeRateLimite = 500

function AddRateLimite()
    RateLimite += 1
    SetTimeout(TimeRateLimite, function()
        RateLimite -= 1
    end)
end

function MOD_Weed:StartPlotShop(size)
    MOD_Weed.LabData.Data.onPlotShop = true

    local EnumPlotList = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[size]

    local PlotList = {}
    for key, value in pairs(self.LabData.Data.plotList[size]) do
        if (value == "empty") then
            local Data = EnumPlotList[key]
            Data.index = key

            table.insert(PlotList, Data)
        end
    end

    if (#PlotList == 0) then return end

    CreateThread(function()
        local IndexSelect = 1
        MOD_Weed:PlotShopChangeCam(PlotList[IndexSelect].index, size)

        FreezeEntityPosition(PlayerPedId(), true)

        while (MOD_Weed.LabData.Data.onPlotShop) do
            if (IsControlJustPressed(0, 174)) then
                if (RateLimite < MaxRateLimite) then
                    AddRateLimite()

                    IndexSelect -= 1
                    if (IndexSelect < 1) then
                        IndexSelect = 1
                    else
                        MOD_Weed:PlotShopChangeCam(PlotList[IndexSelect].index, size)
                    end
                end
            end

            if (IsControlJustPressed(0, 175)) then
                if (RateLimite < MaxRateLimite) then
                    AddRateLimite()

                    IndexSelect += 1
                    if (IndexSelect > #PlotList) then 
                        IndexSelect = #PlotList
                    else
                        MOD_Weed:PlotShopChangeCam(PlotList[IndexSelect].index, size)
                    end
                end
            end

            if (IsControlJustPressed(0, 191)) then
                TriggerServerEvent('Gamemode:Labo:Weed:BuyPlot', size, PlotList[IndexSelect].index)
                
                MOD_Weed.LabData.Data.onPlotShop = false

                MOD_Weed:PlotShopDeleteCam()
            end

            if (IsControlJustPressed(0, 194)) then
                MOD_Weed.LabData.Data.onPlotShop = false

                MOD_Weed:PlotShopDeleteCam()
            end

            Wait(0)
        end

        FreezeEntityPosition(PlayerPedId(), false)
    end)
end