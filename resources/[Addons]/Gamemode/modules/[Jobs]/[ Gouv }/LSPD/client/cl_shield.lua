CreateThread(function()
    while ESX == nil do
		Wait(0)
	end
end)

local shieldActive = false
local shieldEntity = nil
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"
local prop = "prop_ballistic_shield"

RegisterCommand("shield", function()
    if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'bcso' then
        if shieldActive then
            DisableShield()
        else
            local sWeapon = GetSelectedPedWeapon(PlayerPedId())
            local weapon = ESX.GetWeaponFromHash(sWeapon)
            if sWeapon == GetHashKey("WEAPON_UNARMED") then
                EnableShield()
            else
                ESX.ShowNotification("Vous ne pouvez pas sortir de bouclier avec une arme en mains !")
            end
        end
    end
end, false)

function EnableShield()
    shieldActive = true
    local ped = GetPlayerPed(-1)
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(100)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    -- SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))
    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = GetPlayerPed(-1)
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    -- SetWeaponAnimationOverride(ped, GetHashKey("Default"))
    SetEnableHandcuffs(ped, false)
    shieldActive = false
end

Citizen.CreateThread(function()
    while true do
        if shieldActive then
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
        end
        Wait(1000)
    end
end)