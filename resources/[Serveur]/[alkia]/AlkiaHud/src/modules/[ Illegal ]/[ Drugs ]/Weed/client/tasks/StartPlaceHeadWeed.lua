function MOD_Weed:StartPlaceHeadWeed(HeadWeed)
    if (not MOD_Weed.LabData.playerInLab) then return end
    if (MOD_Weed.LabData.onUseItem) then return end
    MOD_Weed.LabData.onUseItem = true

    local InfoHeadWeed = Gamemode.enums.Labos.Types['weed']['procces'].Drying.Variety[HeadWeed]

    local Object = InfoHeadWeed.object
    
    local Player = PlayerPedId()
    local Coords = GetEntityCoords(Player)
    local Heading = GetEntityHeading(Player)

    RequestModel(Object)
    while not HasModelLoaded(Object) do
        Wait(0)
    end

    local OffsetCoords = GetOffsetFromEntityInWorldCoords(Player, 0.0, 0.75, 0.0)
    local Prop = CreateObjectNoOffset(Object, OffsetCoords, false, true, false)
    SetEntityHeading(Prop, Heading)
    SetEntityCollision(Prop, false, true)
    SetEntityAlpha(Prop, 100)
    FreezeEntityPosition(Prop, true)
    SetModelAsNoLongerNeeded(Object)

    CreateThread(function()
        while (MOD_Weed.LabData.onUseItem) do
            Wait(0)

            local PropsWorld = {
                OffsetCoords = GetOffsetFromEntityInWorldCoords(Player, 0.0, 0.75, 0.0),
                Heading = GetEntityHeading(Player),
                IndexEmplacement = nil,
                plotInfos = {}
            }

            SetEntityDrawOutline(Prop, true)
            SetEntityDrawOutlineColor(255,0,0,255)
            
            local PlotListSmall = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList['small']
            for key, plot in pairs(PlotListSmall) do
                local HasPlotBelong = MOD_Weed.LabData.Data.plotList['small'][key]

                if (HasPlotBelong ~= "empty") then
                    for _k, _v in pairs(PlotListSmall[key].LampList) do
                        local PotIsEmpty = MOD_Weed.LabData.Data.plotList['small'][key].LampList[_k]

                        if (PotIsEmpty == "empty") then
                            local coordPot = vector3(_v.x, _v.y, _v.z)
                            local CoordsProps = vector3(PropsWorld.OffsetCoords.x, PropsWorld.OffsetCoords.y, PropsWorld.OffsetCoords.z)

                            DrawMarker(20, coordPot.x, coordPot.y, coordPot.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 0, 0, 100, false, true, 2, false, false, false, false)

                            if (#(CoordsProps - coordPot) < 3.0) then
                                SetEntityDrawOutlineColor(0,255,0,255)

                                PropsWorld.OffsetCoords = _v
                                PropsWorld.IndexEmplacement = _k

                                PropsWorld.plotInfos = {
                                    size = 'small',
                                    index = key
                                }
                            end
                        end
                    end
                end
            end

            ESX.ShowHelpNotification('Appuiyez sur E pour posser votre Pot ou sur R pour annuler')
            
			SetEntityCoordsNoOffset(Prop, PropsWorld.OffsetCoords)
			SetEntityHeading(Prop, PropsWorld.Heading)
            SetEntityCollision(Prop, false, true)
            
            if (IsControlJustPressed(0, 38)) then 
                DeleteObject(Prop)

                if (PropsWorld.IndexEmplacement ~= nil) then
                    print()
                    -- TriggerServerEvent('Gamemode:Labo:Weed:PlaceLampOnPlot', PropsWorld.plotInfos.size, PropsWorld.plotInfos.index, PropsWorld.IndexEmplacement)
                end

                MOD_Weed.LabData.onUseItem = false
            end

            if (IsControlJustPressed(0, 140)) then 
                DeleteObject(Prop)

                MOD_Weed.LabData.onUseItem = false
            end
        end
    end)

end