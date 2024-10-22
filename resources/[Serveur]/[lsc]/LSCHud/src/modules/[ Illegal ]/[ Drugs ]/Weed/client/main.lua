MOD_Weed.LabData = {
    Data = {
        plotList = {},
        playerInLab = false,
        onPlotShop = false,
    },
    ObjectPreview = {},
    MenuList = {}
}

MOD_Weed.ObjectPreview = {}

MOD_Weed.MenuWeed = nil






local Objects = {
    'candy_weed_dry',
    'mac_weed_dry',
    'og_weed_dry',
    'rain_weed_dry',
    'tropic_weed_dry',
}

CreateThread(function()
    for i=1, #Objects do
        RequestModel(Objects[i])
        while not HasModelLoaded(Objects[i]) do
            Wait(500)
        end
    end
end)

local AllProps = {}

RegisterCommand('deleteDryWeed', function()
    for i=1, #AllProps do
        DeleteEntity(AllProps[i])
    end
end)

RegisterCommand('loadDryWeed', function()
    local CordsXfirst = 1043.856
    local CordsXsecond = CordsXfirst - 1.20
    local CordsXtrois = CordsXsecond - 1.4

    local CordsY = -3208.326


    for i=1, 9 do
        if (i > 1) then
            CordsY = CordsY + 1.0
        end

        local NewCoords = vector3(CordsXfirst, CordsY, -35.75868)

        local Aleat = math.random(1, #Objects)
        local Obj = Objects[Aleat]

        local Prop = CreateObjectNoOffset(Obj, NewCoords, false, true, false)
        SetEntityCollision(Prop, false, true)
        FreezeEntityPosition(Prop, true)
        -- SetModelAsNoLongerNeeded(Obj)

        table.insert(AllProps, Prop)
    end

    local CordsY = -3208.326
    for i=1, 9 do
        if (i > 1) then
            CordsY = CordsY + 1.0
        end

        local NewCoords = vector3(CordsXsecond, CordsY, -35.75868)

        local Aleat = math.random(1, #Objects)
        local Obj = Objects[Aleat]

        local Prop = CreateObjectNoOffset(Obj, NewCoords, false, true, false)
        SetEntityCollision(Prop, false, true)
        FreezeEntityPosition(Prop, true)
        -- SetModelAsNoLongerNeeded(Obj)

        table.insert(AllProps, Prop)
    end

    local CordsY = -3208.326
    for i=1, 9 do
        if (i > 1) then
            CordsY = CordsY + 1.0
        end

        local NewCoords = vector3(CordsXtrois, CordsY, -35.75868)

        local Aleat = math.random(1, #Objects)
        local Obj = Objects[Aleat]

        local Prop = CreateObjectNoOffset(Obj, NewCoords, false, true, false)
        SetEntityCollision(Prop, false, true)
        FreezeEntityPosition(Prop, true)
        -- SetModelAsNoLongerNeeded(Obj)

        table.insert(AllProps, Prop)
    end
end)













local ObjectsPlant = {
    'candy_weed_lrg_a',
    'mac_weed_lrg_a',
    'og_weed_lrg_a',
    'rain_weed_lrg_a',
    'tropic_weed_lrg_a',
}

CreateThread(function()
    for i=1, #ObjectsPlant do
        RequestModel(ObjectsPlant[i])
        while not HasModelLoaded(ObjectsPlant[i]) do
            Wait(500)
        end
    end
end)


local AllPropsPlant = {}

RegisterCommand('deletePlantWeed', function()
    for i=1, #AllPropsPlant do
        DeleteEntity(AllPropsPlant[i])
    end
end)

RegisterCommand('loadPlantWeed', function()
    local PlotList = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList['small']

    for i=1, #PlotList do
        for _, pos in pairs(PlotList[i].PotList) do
            CreateThread(function()
                local Aleat = math.random(1, #ObjectsPlant)
                local HashKey = GetHashKey(ObjectsPlant[Aleat])
    
                local SpawnObject = CreateObject(HashKey, pos.x, pos.y, pos.z - 3.55)
                -- PlaceObjectOnGroundProperly(SpawnObject)
                FreezeEntityPosition(SpawnObject, true)
    
                table.insert(AllPropsPlant, SpawnObject)
            end)
        end
    
        for _, pos in pairs(PlotList[i].LampList) do
            CreateThread(function()
                local HashKey = GetHashKey("bkr_prop_grow_lamp_02b")
                local SpawnObject = CreateObject(HashKey, pos.x, pos.y, pos.z)
    
                FreezeEntityPosition(SpawnObject, true)
                SetEntityRotation(SpawnObject, 0, 0, pos.w, 2, true)
    
                table.insert(AllPropsPlant, SpawnObject)
            end)
        end
    end
end)