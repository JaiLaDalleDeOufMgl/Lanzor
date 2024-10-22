---

--- Create at [01/11/2022] 11:32:50

--- File name [zoneManagement]
---

function SafeZone:playerIsIn()
    return playerIsInSafeZone or false
end

local _GetResourceState = GetResourceState;

function SafeZone:checkIfPlayerIsIn()
    playerIsInSafeZone = false
    local zoneList = SafeZone.Config.zoneList
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for i = 1, #zoneList do
        local currentZone = zoneList[i]
        if (currentZone ~= nil) then
            local radius = type(currentZone) == "table" and currentZone.radius ~= nil and currentZone.radius or SafeZone.Config.zoneRadius;
            local dist = #(playerCoords - vector3(currentZone.x, currentZone.y, currentZone.z))

            if (dist < radius) then

                if (type(currentZone) == "table") then
                    playerIsInSafeZone = true;
                else
                    playerIsInSafeZone = true;
                end
                
            end
        end
    end
end


exports('checkIfPlayerIsInSafeZone', function()
    return SafeZone:playerIsIn()
end)

local ratelimit = false

function SafeZone:checkControls()
    local playerPed = PlayerPedId()
    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
    local disabledKeys = SafeZone.Config.disabledKeys
    for i = 1, #disabledKeys do
        local currentKey = disabledKeys[i]
        if (currentKey ~= nil) then
            DisableControlAction(currentKey.group, currentKey.key, true)
            if IsDisabledControlJustPressed(currentKey.group, currentKey.key) then
                if currentKey.message then
                    if ratelimit or IsPauseMenuActive() then
                        return
                    else
                        ratelimit = true
                        ESX.ShowNotification(currentKey.message)
                        SetTimeout(5000, function()
                            ratelimit = false
                        end)
                    end
                end
            end
        end
    end
end

function SafeZone:onEntered(callback)
    local playerPed = PlayerPedId()
    NetworkSetFriendlyFireOption(false)
    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
    DisablePlayerFiring(playerPed, true)

    exports[exports.Tree:serveurConfig().Serveur.hudScript]:onEnterSafeZone(3000)

    if (callback ~= nil and type(callback) == "function") then
        callback()
    end
end

function SafeZone:onExited(callback)
    local playerPed = PlayerPedId()
    NetworkSetFriendlyFireOption(true)
    DisablePlayerFiring(playerPed, false)

    exports[exports.Tree:serveurConfig().Serveur.hudScript]:onExitSafeZone(3000)

    if (callback ~= nil and type(callback) == "function") then
        callback()
    end
end


local SendEvent = false

CreateThread(function()
    while ESX == nil do
        Wait(0)
    end

    while ESX.GetPlayerData() == nil or ESX.GetPlayerData().job == nil do
        Wait(0)
    end

    while true do
        local loopInterval = 1000
        SafeZone:checkIfPlayerIsIn()

        local playerIsIn = SafeZone:playerIsIn()
        local playerJob = ESX.GetPlayerData().job

        if (not SafeZone.Config.bypassJob.active or (SafeZone.Config.bypassJob.active == true and SafeZone.Config.bypassJob.list[playerJob.name] == nil)) then
            if (playerIsIn == true) then
                loopInterval = 0

                if (not SendEvent) then
                    SendEvent = true
                    -- exports[exports.Tree:serveurConfig().Serveur.hudScript]:SaveCurrentWeaponAmmoInv()
                end

                SafeZone:checkControls()

                if (actionOn == nil) then
                    SafeZone:onEntered(function()
                        actionOn = true
                    end)
                end

            else
                if (SendEvent) then
                    SendEvent = false
                end

                if (actionOn == true) then
                    SafeZone:onExited(function()
                        actionOn = nil
                    end)
                end
            end
        end

        Wait(loopInterval)
    end
end)

exports("IsInSafeZone", function()
    return SafeZone:playerIsIn()
end)