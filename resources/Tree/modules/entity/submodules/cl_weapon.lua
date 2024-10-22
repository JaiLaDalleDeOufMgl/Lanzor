Tree.Entity.Weapon = {}

local spawnedmodel = nil
local weaponModel = nil

function Tree.Entity.Weapon.spawnMovingWeapon(weapon)
    if weaponModel == weapon then
        return
    end
    Tree.Entity.Weapon.deleteMovingWeapon()
    weaponModel = weapon
    RequestWeaponAsset(weaponModel)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    spawnedWeapon = CreateWeaponObject(weaponModel, pedCoords.x, pedCoords.y, pedCoords.z, true, 1.0, false)
    SetEntityVisible(spawnedWeapon, false, false)
    CreateThread(function()
        local heading = 0.0
        while spawnedWeapon do
            local camCoords = GetFinalRenderedCamCoord()
            local camRot = GetFinalRenderedCamRot(2)
            local forwardVector = Tree.Math.Rotation.toDirection(camRot)
            local spawnPos = camCoords + forwardVector * 4.0
            local _, groundZ = GetGroundZFor_3dCoord(spawnPos.x, spawnPos.y, spawnPos.z, 1)
            spawnPos = vector3(spawnPos.x, spawnPos.y, groundZ + 1.5)
            SetEntityCoords(spawnedWeapon, spawnPos.x, spawnPos.y, spawnPos.z, false, false, false, true)
            SetEntityVisible(spawnedWeapon, true, false)
            heading = heading + 0.25
            SetEntityHeading(spawnedWeapon, heading)
            Wait(1)
        end
    end)
end


function Tree.Entity.Weapon.deleteMovingWeapon()
    if spawnedWeapon then
        DeleteEntity(spawnedWeapon)
        spawnedmodel = nil
    end
end

function Tree.Entity.Weapon.loadTable(weapon)
    for k,v in pairs(object) do
        RequestWeaponAsset(v.model)
        while not HasWeaponAssetLoaded(v.model) do
            Wait(0)
        end
    end
    return true
end