function MOD_Weed:PlotPlaceSetupPreview(plotId)
    local PlotList = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList['small']

    local PlotPotList = PlotList[plotId].PotList

    local PlotLampList = PlotList[plotId].LampList

    for _, pos in pairs(PlotPotList) do
        CreateThread(function()
            local HashKey = GetHashKey("pot_weed_s_v_t")
            local SpawnObject = CreateObject(HashKey, pos.x, pos.y, pos.z)
            PlaceObjectOnGroundProperly(SpawnObject)

            FreezeEntityPosition(SpawnObject, true)
            SetEntityAlpha(SpawnObject, 200, false)

            table.insert(MOD_Weed.LabData.ObjectPreview, SpawnObject)
        end)
    end

    for _, pos in pairs(PlotLampList) do
        CreateThread(function()
            local HashKey = GetHashKey("bkr_prop_grow_lamp_02b")
            local SpawnObject = CreateObject(HashKey, pos.x, pos.y, pos.z)

            FreezeEntityPosition(SpawnObject, true)
            SetEntityAlpha(SpawnObject, 200, false)
            SetEntityRotation(SpawnObject, 0, 0, pos.w, 2, true)

            table.insert(MOD_Weed.LabData.ObjectPreview, SpawnObject)
        end)
    end
end