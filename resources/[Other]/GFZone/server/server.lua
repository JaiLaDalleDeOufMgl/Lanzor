-- Local parameters
local PlayersInZone = {}
local CurrentMap = nil
local LastMap = nil
local PrePhaseTimer = 0

local Votes = {}
local PlayerVotes = {}
local Voting = false
local VotingPhaseTimer = 0

-- Modules & Core
modules = {}
Core = {}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function Core.LoadPlayer(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    MySQL.Async.fetchAll('SELECT * FROM `users_gf_stats` WHERE `identifier` = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(data)
        if data[1] == nil then
            MySQL.Async.execute('INSERT INTO `users_gf_stats` (identifier, name) VALUES (@identifier, @name)', {['@identifier'] = xPlayer.identifier, ['@name'] = GetPlayerName(xPlayer.source)})
        end
        PlayersInZone[xPlayer.source] = {
            identifier = xPlayer.identifier,
            session = {
                kills = 0,
                deaths = 0
            },
            stats = {
                kills = (((data[1] ~= nil and data[1].kills ~= nil) and data[1].kills) or 0),
                deaths = (((data[1] ~= nil and data[1].deaths ~= nil) and data[1].deaths) or 0)
            }
        }
        TriggerClientEvent('Piwel_GFZone:Sharing:SetPlayerInGF', xPlayer.source, true)
        if CurrentMap == nil then
            Core.PickAutomaticMap()
        else
            while CurrentMap == nil do Core.PickAutomaticMap() Wait(500) end
            modules.LoadMap(CurrentMap, player)
        end
        while CurrentMap == nil do Core.PickAutomaticMap() Wait(500) end
        modules.RefreshStats(false, Voting)
        Wait(2000)
        TriggerClientEvent('gunfight:SendNUIMessage', xPlayer.source, {
            action = "notification", 
            status = "enter"
        })
        TriggerClientEvent('Piwel_GFZone:Client:SendPlayerData', xPlayer.source, PlayersInZone, CurrentMap, true, Voting, {})
    end)
end

function Core.PickAutomaticMap()
    local random = math.random(1, #Config.Maps)

    while random == lastMap do
        random = math.random(1, #Config.Maps)
        Wait(500)
    end
    CurrentMap = random
    modules.LoadMap(CurrentMap)
    modules.StartMapTimer()
    modules.PrePhaseTimer()
end

function modules.PrePhaseTimer()
    PrePhaseTimer = (Config.PrePhaseTimer * 1000)
    Citizen.CreateThread(function()
        while PrePhaseTimer > 0 do
            Citizen.Wait(1000)
            PrePhaseTimer = PrePhaseTimer - 1000
            if next(PlayersInZone) ~= nil then
                for playerId in pairs(PlayersInZone) do
                    TriggerClientEvent('Piwel_GFZone:Client:UpdatePrePhaseTimer', playerId, PrePhaseTimer)
                end
            end
        end
        PrePhaseTimer = 0
        return
    end)
end

function modules.StartVoteMap()
    Voting = true
    local NewMap = nil
    for playerId in pairs(PlayersInZone) do
        TriggerClientEvent('Piwel_GFZone:Client:OpenVoteMenu', playerId, CurrentMap)
    end
    VotingPhaseTimer = (Config.VotingPhaseTimer * 1000)
    Citizen.CreateThread(function()
        while VotingPhaseTimer > 0 do
            Citizen.Wait(1000)
            VotingPhaseTimer = VotingPhaseTimer - 1000
            if next(PlayersInZone) ~= nil then
                for playerId in pairs(PlayersInZone) do
                    TriggerClientEvent('Piwel_GFZone:Client:UpdateVotingPhaseTimer', playerId, VotingPhaseTimer)
                end
            end
        end
        for playerId in pairs(PlayersInZone) do
            TriggerClientEvent('Piwel_GFZone:Client:CloseVoteMenu', playerId)
        end
        local NewMap = nil
        local LatestVote = 0
        if next(Votes) ~= nil then
            for line, vote in pairs(Votes) do
                if vote then
                    if NewMap == nil then
                        NewMap = line
                        LatestVote = vote
                    elseif LatestVote < vote then 
                        NewMap = line
                    end
                end
            end
            CurrentMap = NewMap
            modules.LoadMap(CurrentMap)
            modules.StartMapTimer()
            modules.PrePhaseTimer()
        else
            Core.PickAutomaticMap()
        end
        PlayerVotes = {}
        Votes = {}
        Voting = false
        VotingPhaseTimer = 0
        return
    end)
end

-- RegisterCommand('startvotemap', function()
--     modules.StartVoteMap()
-- end, false)

function modules.StartMapTimer()
    local timer = ((Config.TimeBeforeNewMap * 60) * 1000)
    Citizen.CreateThread(function()
        while timer > 0 do
            Citizen.Wait(1000)
            timer = timer - 1000
        end
        if timer == 0 then
            if next(PlayersInZone) ~= nil then
                Voting = true
                modules.StartVoteMap()
            else
                Core.PickAutomaticMap()
            end
        end
        return
    end)
end

function modules.LoadMap(map, player)
    if next(PlayersInZone) == nil or map == nil then return end
    if not player then
        for id, data in pairs(PlayersInZone) do
            TriggerClientEvent('Piwel_GFZone:Client:LoadMap', id, map)
        end
    elseif player and PrePhaseTimer ~= 0 then
        TriggerClientEvent('Piwel_GFZone:Client:LoadMap', player, map)
    elseif player and PrePhaseTimer == 0 then
        TriggerClientEvent('Piwel_GFZone:Client:JoinMap', player, map)
    end
end

function modules.RefreshStats(loggedIn, voting)
    if next(PlayersInZone) == nil then return end

    local classement = {}
    MySQL.Async.fetchAll('SELECT * FROM `users_gf_stats`', {}, function(data)
        if next(data) ~= nil then
            for line, player in pairs(data) do
                local xPlayer = ESX.GetPlayerFromIdentifier(player.identifier)
                if xPlayer and PlayersInZone[xPlayer.source] then
                    table.insert(classement, {source = xPlayer.source, name = GetPlayerName(xPlayer.source), kills = PlayersInZone[xPlayer.source].stats.kills, deaths = PlayersInZone[xPlayer.source].stats.deaths})
                else
                    table.insert(classement, {name = (((player.name ~= nil and player.name ~= "") and player.name) or "Joueur inconnu"), kills = player.kills, deaths = player.deaths})
                end
            end
            for playerId in pairs(PlayersInZone) do
                TriggerClientEvent('Piwel_GFZone:Client:SendPlayerData', playerId, PlayersInZone, CurrentMap, false, false, classement)
            end
        end
    end)
end

function modules.SetPlayerStats(player, disconnect)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    MySQL.Async.execute("UPDATE `users_gf_stats` SET `kills`= '".. PlayersInZone[xPlayer.source].stats.kills .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)
    MySQL.Async.execute("UPDATE `users_gf_stats` SET `deaths`= '".. PlayersInZone[xPlayer.source].stats.deaths .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)

    if disconnect then PlayersInZone[xPlayer.source] = nil return end
    -- PlayersInZone[xPlayer.source].stats.kills = PlayersInZone[xPlayer.source].stats.kills + PlayersInZone[xPlayer.source].session.kills
    -- PlayersInZone[xPlayer.source].stats.deaths = PlayersInZone[xPlayer.source].stats.deaths + PlayersInZone[xPlayer.source].session.deaths
    PlayersInZone[xPlayer.source].session.kills = 0
    PlayersInZone[xPlayer.source].session.deaths = 0
    modules.RefreshStats()
end

function modules.UpdatePlayerStats(player, stats)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    PlayersInZone[xPlayer.source].session.kills = stats.kills
    PlayersInZone[xPlayer.source].session.deaths = stats.deaths
    modules.RefreshStats(player, false)
end

function modules.PlayerAddKill(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    PlayersInZone[xPlayer.source].session.kills = PlayersInZone[xPlayer.source].session.kills + 1
    PlayersInZone[xPlayer.source].stats.kills = PlayersInZone[xPlayer.source].stats.kills + 1
    modules.RefreshStats()
end

function modules.PlayerAddDeath(player)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    PlayersInZone[xPlayer.source].session.deaths = PlayersInZone[xPlayer.source].session.deaths + 1
    PlayersInZone[xPlayer.source].stats.deaths = PlayersInZone[xPlayer.source].stats.deaths + 1

    modules.RefreshStats()
end

function Core.UnloadPlayer(player, disconnect)
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    if Voting then
        TriggerClientEvent('Piwel_GFZone:Client:CloseVoteMenu', xPlayer.source)
    end

    TriggerClientEvent('gunfight:SendNUIMessage', xPlayer.source, {
        action = "notification", 
        status = "leave"
    })

    if not disconnect then
        TriggerClientEvent('Piwel_GFZone:Client:UnloadedPlayer', xPlayer.source)
        TriggerClientEvent('Piwel_GFZone:Sharing:SetPlayerInGF', xPlayer.source, false)
        TriggerClientEvent('esx:showNotification', xPlayer.source, exports.Tree:serveurConfig().Serveur.color.."Vous avez quitter la zone GF~s~. Résumé de votre session:\n~g~"..PlayersInZone[xPlayer.source].session.kills.." kills\n"..exports.Tree:serveurConfig().Serveur.color..""..PlayersInZone[xPlayer.source].session.deaths.." morts")
    end

    modules.SetPlayerStats(xPlayer.source, disconnect)
    modules.RefreshStats()

    PlayersInZone[xPlayer.source] = nil

    MySQL.Async.execute('UPDATE `users` SET position=@position WHERE identifier=@identifier', {
        ['@position'] = '{"x":'..Config.Lobby.Respawn.x..',"y":'..Config.Lobby.Respawn.y..',"z":'..Config.Lobby.Respawn.z..',"heading":'..Config.Lobby.Respawn.w..'}',
        ['@identifier'] = xPlayer.identifier
    })
end

-- Events
RegisterNetEvent('Gamemode_GFZone:Server:onPlayerDeath')
AddEventHandler('Gamemode_GFZone:Server:onPlayerDeath', function(data)
	local victim = source

    if not PlayersInZone[victim] then return end

    local killData = {}

    if data.killedByPlayer then
        if data.killerServerId then
            local killer = ESX.GetPlayerFromId(data.killerServerId)
            if PlayersInZone[killer.source] then
                TriggerClientEvent('Piwel_GFZone:Client:KillEffect', killer.source)
                modules.PlayerAddKill(data.killerServerId)
                modules.PlayerAddDeath(victim)
                TriggerClientEvent('Piwel_GFZone:Client:RespawnPlayer', victim)
                TriggerClientEvent('esx:showNotification', data.killerServerId, "Vous avez tué "..exports.Tree:serveurConfig().Serveur.color..""..GetPlayerName(victim).."~s~.")
                TriggerClientEvent('esx:showNotification', data.killerServerId, "Vous gagnez ~g~$"..Config.KillReward.."~s~ pour ce "..exports.Tree:serveurConfig().Serveur.color.."kill.")
                killer.addAccountMoney('dirtycash', Config.KillReward)
                TriggerClientEvent('esx:showNotification', victim, exports.Tree:serveurConfig().Serveur.color.."Vous êtes mort. Tué par "..GetPlayerName(data.killerServerId)..".")

                killData = {
                    action = "addKill", 
                    weapon = (ESX.GetWeaponFromHash(data.deathCause).name ~= nil and ESX.GetWeaponFromHash(data.deathCause).name) or "",
                    killer = GetPlayerName(data.killerServerId),
                    victim = GetPlayerName(victim),
                }
            end
        end
    else
        modules.PlayerAddDeath(victim)
        TriggerClientEvent('Piwel_GFZone:Client:RespawnPlayer', victim)
        TriggerClientEvent('esx:showNotification', victim, exports.Tree:serveurConfig().Serveur.color.."Vous êtes mort. Tué par vous-même.")
        killData = {
            action = "addKill", 
            weapon = "WEAPON_UNARMED",
            killer = "",
            victim = GetPlayerName(victim),
        }
    end

    for playerId in pairs(PlayersInZone) do
        TriggerClientEvent('gunfight:SendNUIMessage', playerId, killData)
    end
end)

-- RegisterNetEvent('Piwel_GFZone:Server:VoteForMap')
-- AddEventHandler('Piwel_GFZone:Server:VoteForMap', function(mapId)
-- 	local player = source
--     local xPlayer = ESX.GetPlayerFromId(player)
--     if not xPlayer then return end

--     if Voting then
--         if PlayerVotes[xPlayer.source] then
--             Votes[PlayerVotes[xPlayer.source]] = Votes[PlayerVotes[xPlayer.source]] - 1
--         end
--         if not Votes[mapId] then Votes[mapId] = 0 end
--         Votes[mapId] = Votes[mapId] + 1
--         PlayerVotes[xPlayer.source]=  mapId
--         for playerId in pairs(PlayersInZone) do
--             TriggerClientEvent('Piwel_GFZone:Client:UpdateVotes', playerId, Votes)
--         end
--     else
--         TriggerClientEvent('Piwel_GFZone:Client:CloseVoteMenu', xPlayer.source)
--     end
-- end)

RegisterServerEvent("Piwel_GFZone:Server:VoteForMap")
AddEventHandler("Piwel_GFZone:Server:VoteForMap", function(mapId)
	local player = source
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    if Voting then
        if PlayerVotes[xPlayer.source] then
            Votes[PlayerVotes[xPlayer.source]] = Votes[PlayerVotes[xPlayer.source]] - 1
        end
        if not Votes[mapId] then Votes[mapId] = 0 end
        Votes[mapId] = Votes[mapId] + 1
        PlayerVotes[xPlayer.source]=  mapId
        for playerId in pairs(PlayersInZone) do
            TriggerClientEvent('Piwel_GFZone:Client:UpdateVotes', playerId, Votes)
        end
    else
        TriggerClientEvent('Piwel_GFZone:Client:CloseVoteMenu', xPlayer.source)
    end
end)

-- RegisterNetEvent('Piwel_GFZone:Server:UnloadPlayer')
-- AddEventHandler('Piwel_GFZone:Server:UnloadPlayer', function()
-- 	local player = source
--     local xPlayer = ESX.GetPlayerFromId(player)
--     if not xPlayer then return end

--     Core.UnloadPlayer(player)
--     TriggerClientEvent('Piwel_GFZone:Sharing:SetPlayerInGF', xPlayer.source, false)
--     RemoveAllPedWeapons(GetPlayerPed(player), true)
-- end)

RegisterServerEvent("Piwel_GFZone:Server:UnloadPlayer")
AddEventHandler("Piwel_GFZone:Server:UnloadPlayer", function()
	local player = source
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer then return end

    Core.UnloadPlayer(player)
    TriggerClientEvent('Piwel_GFZone:Sharing:SetPlayerInGF', xPlayer.source, false)
    RemoveAllPedWeapons(GetPlayerPed(player), true)
end)

-- RegisterNetEvent('Piwel_GFZone:Server:LoadPlayer')
-- AddEventHandler('Piwel_GFZone:Server:LoadPlayer', function()
-- 	local player = source
--     local xPlayer = ESX.GetPlayerFromId(player)
--     if not xPlayer or PlayersInZone[xPlayer.source] then return end

--     Core.LoadPlayer(player)
-- end)

RegisterServerEvent("Piwel_GFZone:Server:LoadPlayer")
AddEventHandler("Piwel_GFZone:Server:LoadPlayer", function()
	local player = source
    local xPlayer = ESX.GetPlayerFromId(player)
    if not xPlayer or PlayersInZone[xPlayer.source] then return end

    Core.LoadPlayer(player)
end)

-- RegisterNetEvent('Piwel_GFZone:Server:SetRoutingBucket')
-- AddEventHandler('Piwel_GFZone:Server:SetRoutingBucket', function(bool)
-- 	local player = source

-- 	if player > 0 then
-- 		SetPlayerRoutingBucket(source, ((bool and 1) or 0))
-- 	end
-- end)

RegisterServerEvent("Piwel_GFZone:Server:SetRoutingBucket")
AddEventHandler("Piwel_GFZone:Server:SetRoutingBucket", function(bool)
    local _source = source
	if _source > 0 then
		SetPlayerRoutingBucket(_source, ((bool and 1) or 0))
	end
end)

AddEventHandler('playerDropped', function()
	local player = source
    local xPlayer = ESX.GetPlayerFromId(player)

    if not xPlayer or not PlayersInZone[xPlayer.source] then return end
    RemoveAllPedWeapons(GetPlayerPed(player), true)
    Core.UnloadPlayer(player, true)
end)

local AdminsInGF = {}
ESX.AddGroupCommand('admingf', 'admin', function (source, args, user)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer or not xPlayer.source then return end
    if AdminsInGF[xPlayer.source] then
        SetPlayerRoutingBucket(xPlayer.source, 0)
        AdminsInGF[xPlayer.source] = false
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous êtes sorti de l'instance de la zone GF. Refaite /admingf pour y retourner à tout moment.")
    else
        SetPlayerRoutingBucket(xPlayer.source, 1)
        AdminsInGF[xPlayer.source] = true
        TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Vous êtes désormais dans l'instance de la zone GF. Refaite /admingf pour en sortir.")
    end
end, {help = "Entrer/sortir dans l'instance de la zone GF.", params = {}})

RegisterCommand('entergf', function(source, args)
    Core.LoadPlayer(source)
end, false)