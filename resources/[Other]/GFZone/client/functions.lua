modules = {}
modules.Functions = {}
modules.PlayerData = {}
modules.PlayersData = {}

playerInGF = false
PrePhaseTimer = 0
PrePhaseStarted = false
VotingPhaseTimer = 0
VotingPhaseStarted = false
CurrentMap = nil
CurrentMapBlip = nil
CurrentDisplayBlip = nil
MapLoaded = false
InZone = false
LobbyPed = nil
PLAYER_CURRENT_WEAPON = nil

ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Wait(500)
    end
end)

-- Functions --
function modules.Functions.OnScreenNotification(array)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    if (array.message ~= nil) then
        AddTextComponentSubstringPlayerName(tostring(array.message))
    else
        error("Missing arguments, message")
    end
    if (array.time_display ~= nil) then
        EndTextCommandPrint(tonumber(array.time_display), 1)
    else
        EndTextCommandPrint(1, 1)
    end
    if (array.sound ~= nil) then
        if (array.sound.audio_name ~= nil) then
            if (array.sound.audio_ref ~= nil) then
                PlaySoundFrontend(-1, array.sound.audio_name, array.sound.audio_ref, true)
            else
                error("Missing arguments, audio_ref")
            end
        else
            error("Missing arguments, audio_name")
        end
    end
end


function modules.Functions.ReturnTimeLeft(timeLeftMS)
    if timeLeftMS >= 1 then
        local seconds = math.floor(timeLeftMS / 1000) % 60
        local minutes = math.floor(timeLeftMS / 60000) % 60
		local hours = math.floor(timeLeftMS / 3600000)

        local formattedTime = 0
		if hours > 0 then
			formattedTime = string.format("%02dh%02dm%02ds", hours, minutes, seconds)
        elseif minutes > 0 then
            formattedTime = string.format("%02dm%02ds", minutes, seconds)
        else
            formattedTime = string.format("%02d secondes", seconds)
        end
        return formattedTime
    else
        return 0
    end
end

function modules.GetPlayerSessionKDA()
    return (modules.PlayerData.session.kills / modules.PlayerData.session.deaths)
end

function modules.GetPlayerOverallKDA()
    return ((modules.PlayerData.stats.kills + modules.PlayerData.session.kills) / (modules.PlayerData.stats.deaths + modules.PlayerData.session.deaths))
end

function modules.GetKDA(kills, deaths)
    if kills == 0 and deaths == 0 then return 0.0 end
    return (kills / deaths)
end

function modules.UpdateLeaderboard(classement)
    local new_classement = {}
    local howMany = #classement
    local ranking = 0
    for k,v in spairs(classement, function(t,a,b) return t[b].kills < t[a].kills end) do
        ranking = ranking + 1
        table.insert(new_classement, {rank = ranking,name = v.name, kills = v.kills, deaths = v.deaths, kd = modules.GetKDA(v.kills, v.deaths)})
        if v.source and v.source == GetPlayerServerId(PlayerId()) then
            TriggerEvent('gunfight:SendNUIMessage', {
                action = "updateRank",
                rank = ranking, howMany = howMany, kills = v.kills, deaths = v.deaths, kd = modules.GetKDA(v.kills, v.deaths)
            })
        end
    end
    TriggerEvent('gunfight:SendNUIMessage', {action = "populateLeaderBoard", data = new_classement})
end

function modules.LoadMap(map)
    local newMap = Config.Maps[map]

    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
		Wait(50)
	end
    if CurrentMapBlip then
        RemoveBlip(CurrentMapBlip)
        CurrentMapBlip = nil
    end
    playerInGF = true
    RemoveAllPedWeapons(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), newMap.general_spawn, false, false, false, false)
    CurrentMap = map
    CurrentMapBlip = AddBlipForRadius(newMap.center_map, newMap.radius_map)

    SetBlipHighDetail(CurrentMapBlip, true)
    SetBlipHighDetail(CurrentMapBlip, true)
    SetBlipColour(CurrentMapBlip, 1)
    SetBlipAlpha (CurrentMapBlip, 128)
    DoScreenFadeIn(800)
    modules.StartPrePhase()
end

function modules.StartPrePhase()
    Citizen.CreateThread(function()
        while PrePhaseTimer > 0 do
            Wait(0)
            DisableControlAction(0, 25, true) -- Input Aim
            DisableControlAction(0, 24, true) -- Input Attack
            DisableControlAction(2, 25, true) -- Input Aim
            DisableControlAction(2, 24, true) -- Input Attack
        end
    end)
end

function modules.RespawnTimer()
    for line, data in pairs(modules.PlayersData) do
        SetPedCanBeTargetted(GetPlayerPed(GetPlayerFromServerId(line)), false)
    end
    SetPedCanBeTargetted(PlayerPedId(), false)
    SetEntityAlpha(PlayerPedId(), 51, false)
    local timer = Config.RespawnInvincibleTimer * 1000
    Citizen.CreateThread(function()
        while timer > 0 do
            Citizen.Wait(0)
            DisableControlAction(0, 24, true) -- Input Attack
            DisableControlAction(2, 24, true) -- Input Attack
            DisablePlayerFiring(PlayerId(), true)
        end
    end)
    Citizen.CreateThread(function()
        while timer > 0 do
            Citizen.Wait(1000)
            timer = timer - 1000
        end
        for line, data in pairs(modules.PlayersData) do
            SetPedCanBeTargetted(GetPlayerPed(GetPlayerFromServerId(line)), true)
        end
        SetPedCanBeTargetted(PlayerPedId(), true)
        ResetEntityAlpha(PlayerPedId())
    end)
end

function modules.RespawnPlayer()
    if CurrentMap ~= nil then
        if CurrentMapBlip == nil then 
            CurrentMapBlip = AddBlipForRadius(Config.Maps[CurrentMap].center_map, Config.Maps[CurrentMap].radius_map)

            SetBlipHighDetail(CurrentMapBlip, true)
            SetBlipHighDetail(CurrentMapBlip, true)
            SetBlipColour(CurrentMapBlip, 1)
            SetBlipAlpha (CurrentMapBlip, 128)
        end
        DoScreenFadeOut((Config.WaitingTimeBeforeRespawn * 1000))
        while not IsScreenFadedOut() do
            Wait(50)
        end
        RemoveAllPedWeapons(PlayerPedId(), true)
        local old_ped = PlayerPedId()
        local random = math.random(1, #Config.Maps[CurrentMap].spawns)
        while IsAnyPedNearPoint(Config.Maps[CurrentMap].spawns[random].x, Config.Maps[CurrentMap].spawns[random].y, Config.Maps[CurrentMap].spawns[random].z, 10.0) do
            random = math.random(1, #Config.Maps[CurrentMap].spawns)
            Wait(5)
        end
        NetworkResurrectLocalPlayer(Config.Maps[CurrentMap].spawns[random].x, Config.Maps[CurrentMap].spawns[random].y, Config.Maps[CurrentMap].spawns[random].z, Config.Maps[CurrentMap].spawns[random].x, Config.Maps[CurrentMap].spawns[random].w, true, false)
        DeleteEntity(old_ped)
        SetPlayerInvincible(PlayerPedId(), false)
        ClearPedBloodDamage(PlayerPedId())
        ClearTimecycleModifier()
        AnimpostfxStop('DeathFailOut')
        -- GiveWeaponToPed(PlayerPedId(), GetHashKey(Config.Maps[CurrentMap].mapWeapon), 10000, false, true)
        DoScreenFadeIn(800)
        MapLoaded = true
        modules.RespawnTimer()
    else
        --TriggerServerEvent('Piwel_GFZone:Server:UnloadPlayer')
        TriggerServerEvent("Piwel_GFZone:Server:UnloadPlayer")
    end
end

function modules.IsPlayerInGFZone()
    return playerInGF
end

function modules.CreatePed()
    if not LobbyPed then
        RequestModel(GetHashKey(Config.Lobby.NPC_Infos.model))

        while not HasModelLoaded(GetHashKey(Config.Lobby.NPC_Infos.model)) do
			Citizen.Wait(1)
		end
		local NPC = CreatePed(4, GetHashKey(Config.Lobby.NPC_Infos.model), Config.Lobby.NPC_Infos.pos, false, true)

        SetEntityCoords(NPC, GetEntityCoords(NPC).x, GetEntityCoords(NPC).y, GetEntityCoords(NPC).z-2.0, true, true, true, false)
		LobbyPed = NPC

        SetPedDefaultComponentVariation(LobbyPed)
        SetEntityInvincible(LobbyPed, true)
        SetBlockingOfNonTemporaryEvents(LobbyPed, true)
        FreezeEntityPosition(LobbyPed, true)
        GiveWeaponToPed(NPC, GetHashKey(string.upper(Config.Lobby.NPC_Infos.weapon)), 1, true, true)
        SetModelAsNoLongerNeeded(GetHashKey(Config.Lobby.NPC_Infos.model))

        -- Blip
        CurrentDisplayBlip = AddBlipForCoord(Config.Lobby.NPC_Infos.pos)
        SetBlipSprite (CurrentDisplayBlip, Config.Lobby.Blip.sprite)
        SetBlipDisplay(CurrentDisplayBlip, Config.Lobby.Blip.Display)
        SetBlipScale(CurrentDisplayBlip, Config.Lobby.Blip.Scale)
        SetBlipColour(CurrentDisplayBlip, Config.Lobby.Blip.color)
        SetBlipAsShortRange(CurrentDisplayBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.Lobby.Blip.name)
        EndTextCommandSetBlipName(CurrentDisplayBlip)
    end
end

function modules.StartOutMapTimer()
    local timer = 5000
    CreateThread(function()
        while timer > 0 do
            if not InZone then
                modules.Functions.OnScreenNotification({message = exports.Tree:serveurConfig().Serveur.color.."Vous êtes hors de la zone GF. Vous avez "..modules.Functions.ReturnTimeLeft(timer).." pour y retourner sinon vous serez tué.", time_display = 1000})
                Wait(1000)
                timer = timer - 1000
            else
                timer = 0
            end
        end
        if timer <= 0 and not InZone then
            SetEntityHealth(PlayerPedId(), 0)
        end
    end)
end

-- Exports
function exportHandler(exportName, func)
    AddEventHandler(('__cfx_export_gfzone_%s'):format(exportName), function(setCB)
        setCB(func)
    end)
end

-- exportHandler('IsPlayerInGFZone', function(options)
--     target.addGlobalPed(convert(options))
-- end)

function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Thread
local function ShowHelpNotification(msg, thisFrame, beep, duration)
	AddTextEntry('esxHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('esxHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('esxHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

Citizen.CreateThread(function()
    while not ESX.IsPlayerLoaded() do
        Wait(500)
    end

    modules.CreatePed()

    while true do
        local sleepThread = 1000
        local player_coords = GetEntityCoords(PlayerPedId())

        --print(playerInGF)
        if playerInGF then
            sleepThread = 0

            if VotingPhaseTimer > 0 then
                
            end
            if CurrentMap ~= nil then
                DrawMarker(1, Config.Maps[CurrentMap].center_map.x, Config.Maps[CurrentMap].center_map.y, Config.Maps[CurrentMap].center_map.z - 50.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Maps[CurrentMap].radius_map*2, Config.Maps[CurrentMap].radius_map * 2, 500.0, 255, 0, 0, 75, false, true, 2, nil, nil, false)
                local RETVAL, PLAYER_WEAPON = GetCurrentPedWeapon(PlayerPedId(), 1)
                if PLAYER_CURRENT_WEAPON ~= PLAYER_WEAPON then
                    PLAYER_CURRENT_WEAPON = PLAYER_WEAPON
                    SetPedInfiniteAmmo(PlayerPedId(), true, PLAYER_CURRENT_WEAPON)
                end
                if MapLoaded then
                    if #(GetEntityCoords(PlayerPedId()) - Config.Maps[CurrentMap].center_map) > (Config.Maps[CurrentMap].radius_map + 2.0) then
                        if InZone then
                            InZone = false 
                            modules.StartOutMapTimer()
                        end
                    else
                        InZone = true
                    end
                end
            end

            if IsPedFatallyInjured(PlayerPedId()) then
                AnimpostfxPlay('DeathFailOut', 0, false)
            end
        elseif not playerInGF then
            local npc_coords = vector3(Config.Lobby.NPC_Infos.pos.x, Config.Lobby.NPC_Infos.pos.y, Config.Lobby.NPC_Infos.pos.z)
            if #(player_coords - npc_coords) < 3.0 then
                sleepThread = 0
                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour rentrer dans la "..exports.Tree:serveurConfig().Serveur.color.."zone GF~s~", true)
                if IsControlJustReleased(0, 51) then
                    --TriggerServerEvent('Piwel_GFZone:Server:LoadPlayer')
                    TriggerServerEvent("Piwel_GFZone:Server:LoadPlayer")
                end
            end
        end

        Citizen.Wait(sleepThread)
    end
end)

RegisterCommand('lobby', function()
    if not in_combat and playerInGF then
        --TriggerServerEvent('Piwel_GFZone:Server:UnloadPlayer')
        TriggerServerEvent("Piwel_GFZone:Server:UnloadPlayer")
        MapLoaded = false
        SetPedInfiniteAmmo(PlayerPedId(), false, PLAYER_CURRENT_WEAPON)
    end
end)