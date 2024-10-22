Tree.Entity.Object = {}

local spawnedObject = nil
local objectModel = nil

function Tree.Entity.Object.spawnMovingObject(objectName)
    objectModel = GetHashKey(objectName)
    if not IsModelValid(objectModel) then
        return
    end
    if IsModelValid(objectModel) and IsModelInCdimage(objectModel) then
        RequestModel(objectModel)
        while not HasModelLoaded(objectModel) do
            Wait(1)
        end
        if spawnedObject then
            DeleteEntity(spawnedObject)
            spawnedObject = nil
        end
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        spawnedObject = CreateObject(objectModel, pedCoords.x, pedCoords.y, pedCoords.z, false, false, false)
        SetEntityVisible(spawnedObject, false, false)
        SetEntityCollision(spawnedObject, false, false)
        CreateThread(function()
            local heading = 0.0
            while spawnedObject do
                local camCoords = GetFinalRenderedCamCoord()
                local camRot = GetFinalRenderedCamRot(2)
                local forwardVector = Tree.Math.Rotation.toDirection(camRot)
                local spawnPos = camCoords + forwardVector * 10.0
                local _, groundZ = GetGroundZFor_3dCoord(spawnPos.x, spawnPos.y, spawnPos.z, 1)
                spawnPos = vector3(spawnPos.x, spawnPos.y, groundZ)
                SetEntityCoords(spawnedObject, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false, true)
                SetEntityVisible(spawnedObject, true, false)
                heading = heading + 0.25
                SetEntityHeading(spawnedObject, heading)
                Wait(1)
            end
        end)
    end
end

function Tree.Entity.Object.deleteMovingObject()
    if spawnedObject then
        DeleteEntity(spawnedObject)
        spawnedObject = nil
    end
end

function Tree.Entity.Object.loadTable(object)
    for k,v in pairs(object) do
        if IsModelValid(GetHashKey(v.model)) then
            RequestModel(GetHashKey(v.model))
            while not HasModelLoaded(GetHashKey(v.model)) do
                Wait(0)
            end
        end
    end
    return true
end

function Tree.Entity.Object.loadTable2(object)
    for k,v in pairs(object) do
        print(v)
        if IsModelValid(GetHashKey(v)) then
            RequestModel(GetHashKey(v))
            while not HasModelLoaded(GetHashKey(v)) do
                Wait(0)
            end
        end
    end
    return true
end