function MOD_Weed:StartPlacePot()
    if (not MOD_Weed.LabData.playerInLab) then return end
    if (MOD_Weed.LabData.onUseItem) then return end
    MOD_Weed.LabData.onUseItem = true

    local Object = "pot_weed_s_v_t" 
    
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
    PlaceObjectOnGroundProperly(Prop)
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
                    for _k, _v in pairs(PlotListSmall[key].PotList) do
                        local PotIsEmpty = MOD_Weed.LabData.Data.plotList['small'][key].PotList[_k]

                        if (PotIsEmpty == "empty") then
                            local coordPot = _v
                            local CoordsProps = vector3(PropsWorld.OffsetCoords.x, PropsWorld.OffsetCoords.y, PropsWorld.OffsetCoords.z)

                            DrawMarker(20, coordPot.x, coordPot.y, coordPot.z - 0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.4, 255, 0, 0, 100, false, true, 2, false, false, false, false)

                            if (#(CoordsProps - coordPot) < 1.0) then
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
            PlaceObjectOnGroundProperly(Prop)
            SetEntityCollision(Prop, false, true)

            if (IsControlJustPressed(0, 38)) then 
                DeleteObject(Prop)

                print('Place on emplacement', PropsWorld.IndexEmplacement)
                if (PropsWorld.IndexEmplacement ~= nil) then
                    TriggerServerEvent('Gamemode:Labo:Weed:PlacePotOnPlot', PropsWorld.plotInfos.size, PropsWorld.plotInfos.index, PropsWorld.IndexEmplacement)
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

