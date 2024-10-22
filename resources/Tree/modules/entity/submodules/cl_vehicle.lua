Tree.Entity.Vehicle = {}

local spawnedVehicle = nil
local vehicleModel = nil

function Tree.Entity.Vehicle.spawnMovingVehicle(car)
    if vehicleModel == GetHashKey(car) then
        return
    end
    Tree.Entity.Vehicle.deleteMovingVehicle()
    vehicleModel = GetHashKey(car)
    RequestModel(vehicleModel)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    spawnedVehicle = CreateVehicle(vehicleModel, pedCoords.x, pedCoords.y, pedCoords.z, 0.0, false, false)
    SetEntityVisible(spawnedVehicle, false, false)
    SetEntityCollision(spawnedVehicle, false, false)
    CreateThread(function()
        local heading = 0.0
        while spawnedVehicle do
            local camCoords = GetFinalRenderedCamCoord()
            local camRot = GetFinalRenderedCamRot(2)
            local forwardVector = Tree.Math.Rotation.toDirection(camRot)
            local spawnPos = camCoords + forwardVector * 10.0
            local _, groundZ = GetGroundZFor_3dCoord(spawnPos.x, spawnPos.y, spawnPos.z, 1)
            spawnPos = vector3(spawnPos.x, spawnPos.y, groundZ)
            SetEntityCoords(spawnedVehicle, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false, true)
            SetEntityVisible(spawnedVehicle, true, false)
            heading = heading + 0.25
            SetEntityHeading(spawnedVehicle, heading)
            Wait(1)
        end
    end)
end


function Tree.Entity.Vehicle.deleteMovingVehicle()
    if spawnedVehicle then
        DeleteEntity(spawnedVehicle)
        spawnedVehicle = nil
    end
end

function Tree.Entity.Vehicle.loadTable(vehicle)
    for k,v in pairs(vehicle) do
        print(v.model)
        RequestModel(v.model)
        while not HasModelLoaded(v.model) do
            Wait(0)
        end
    end
    return true
end