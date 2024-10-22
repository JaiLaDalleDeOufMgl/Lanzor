function MOD_Weed:ShowFloatText(TableTextFloat)
    local ShowOnFloatingHelpText = {}

    for k,v in pairs(TableTextFloat) do
        local OnScren, x, y = GetScreenCoordFromWorldCoord(v.coords.x, v.coords.y, v.coords.z)
        local x = x*100
        local y = (y*100) - 5

        local PlotInfoList = {
            PotList = {},
            LampList = {}
        }

        if (v.plotData ~= "empty") then
            for _k, _v in pairs(v.plotData) do
                if (_k == "LampList" or _k == "PotList") then
                    for __, item in pairs(_v) do
                        if (item ~= "empty") then
                            if (_k == "LampList") then 
                                table.insert(PlotInfoList[_k], 'green')
                            else
                                table.insert(PlotInfoList[_k], 'white')
                            end
                        end
                    end
                end
            end
        end

        table.insert(ShowOnFloatingHelpText, {
            title = v.name,
            buy = v.plotbuy,

            potList = PlotInfoList.PotList,
            potMax = 4,

            lampList = PlotInfoList.LampList,
            lampMax = 1,

            x = x.."%",
            y = y.."%",
        })
    end

    sendUIMessage({
        event = 'WeedFloatingHelpText',
        data = ShowOnFloatingHelpText
    })
end

function MOD_Weed:LoadFloatText(PlotList)
    local playerCoords = GetEntityCoords(PlayerPedId())
    
    interval = 1000

    local TableTextFloat = {}
    for size, data in pairs(PlotList) do
        for key, plot in pairs(data) do
            local coordPlotInfo = plot.plotInfo
    
            if (#(playerCoords - coordPlotInfo) < 3.0) then
                interval = 0
    
                local HasPlotBelong = MOD_Weed.LabData.Data.plotList[size][key]
    
                local PlotBuy = false
                if (HasPlotBelong ~= "empty") then PlotBuy = true end
    
                table.insert(TableTextFloat, {
                    name = plot.name,
                    key = key,
                    coords = coordPlotInfo,
                    plotbuy = PlotBuy,
                    plotData = HasPlotBelong
                })
            end
        end
    end

    self:ShowFloatText(TableTextFloat)

    return interval
end

function MOD_Weed:StartPlotTask()
    local PlotListSmall = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList['small']
    local PlotListBig = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList['big']

    while (MOD_Weed.LabData.playerInLab) do
        local Interval = 1000

        local playerCoords = GetEntityCoords(PlayerPedId())

        Interval = MOD_Weed:LoadFloatText(Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList)


        local PlotList = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList
        local OnClosetPlant = false

        for sizePlot in pairs(PlotList) do

            local PlotListSize = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[sizePlot]

            for indexPlot, plot in pairs(PlotListSize) do
                local HasPlotBelong = MOD_Weed.LabData.Data.plotList[sizePlot][indexPlot]
    
                if (HasPlotBelong ~= "empty") then
                    for indexPot in pairs(PlotListSize[indexPlot].PotList) do
                        local PotIsEmpty = MOD_Weed.LabData.Data.plotList[sizePlot][indexPlot].PotList[indexPot]
    
                        if (PotIsEmpty ~= "empty") then
                            local ent = Entity(NetToObj(PotIsEmpty.propNetId))
                            local coordsPlot = GetEntityCoords(ent)
                            local dist = #(playerCoords - coordsPlot)
    
                            if (dist < 1.2 and not MOD_Weed.LabData.onUseItem) then
                                Interval = 0

                                SetEntityDrawOutline(ent, true)
                                SetEntityDrawOutlineColor(211, 210, 19, 255)

                                local PotProcces = Gamemode.enums.Labos.Types['weed']['procces'][PotIsEmpty.state]
                                if (PotProcces) then
                                    OnClosetPlant = PotProcces.HelpText
                                else
                                    OnClosetPlant = 'Appuiyer sur E pour ouvrir la gestion de la plante'
                                end

                                if (IsControlJustPressed(0, 38)) then
                                    CreateThread(function()
                                        PotProcces.action(sizePlot, indexPlot, indexPot)
                                    end)
                                end
                            else
                                SetEntityDrawOutline(ent, false)
                            end
                        end
                    end
                end
            end
        end
        
        if (OnClosetPlant) then
            ESX.ShowHelpNotification(OnClosetPlant)
        end

        Wait(Interval)
    end
end