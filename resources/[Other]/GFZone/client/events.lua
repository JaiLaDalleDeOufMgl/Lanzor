-- Events
RegisterNetEvent('Piwel_GFZone:Client:SendPlayerData')
AddEventHandler('Piwel_GFZone:Client:SendPlayerData', function(data, map, loggedIn, Voting, classement)
    modules.PlayersData = data
    modules.PlayerData = data[GetPlayerServerId(PlayerId())]

    CurrentMap = map

    if classement ~= nil and next(classement) ~= nil then
        modules.UpdateLeaderboard(classement)
    end
    if loggedIn then
        playerInGF = true
        TriggerEvent('Piwel_GFZone:Sharing:SetPlayerInGF', true)
    end
    if Voting then
        TriggerEvent('Piwel_GFZone:Client:OpenVoteMenu', map)
    end
end)

RegisterNetEvent('Piwel_GFZone:Client:UnloadedPlayer')
AddEventHandler('Piwel_GFZone:Client:UnloadedPlayer', function()
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
		Wait(50)
	end
    --TriggerServerEvent('Piwel_GFZone:Server:SetRoutingBucket', false)
    TriggerServerEvent("Piwel_GFZone:Server:SetRoutingBucket", false)
    SetEntityCoords(PlayerPedId(), Config.Lobby.Respawn.x, Config.Lobby.Respawn.y, Config.Lobby.Respawn.z, false, false, false, false)
    SetEntityHeading(PlayerPedId(), Config.Lobby.Respawn.w)
    playerInGF = false
    TriggerEvent('Piwel_GFZone:Sharing:SetPlayerInGF', false)
    CurrentMap = nil
    RemoveBlip(CurrentMapBlip)
    playerInGF = false
    PrePhaseTimer = 0
    PrePhaseStarted = false
    VotingPhaseTimer = 0
    VotingPhaseStarted = false
    CurrentMapBlip = nil
    MapLoaded = false
    InZone = false
    DoScreenFadeIn(3000)
    ESX.ShowNotification("~g~Vous avez quitter la zone GF. Vous êtes de retour en RolePlay!")
end)

RegisterNetEvent('Piwel_GFZone:Client:LoadMap')
AddEventHandler('Piwel_GFZone:Client:LoadMap', function(data)
    SetEntityMaxHealth(PlayerPedId(), 200)
    --TriggerServerEvent('Piwel_GFZone:Server:SetRoutingBucket', true)
    TriggerServerEvent("Piwel_GFZone:Server:SetRoutingBucket", true)
    modules.LoadMap(data)
end)

RegisterNetEvent('Piwel_GFZone:Client:JoinMap')
AddEventHandler('Piwel_GFZone:Client:JoinMap', function(data)
    CurrentMap = data
    SetEntityMaxHealth(PlayerPedId(), 200)
    --TriggerServerEvent('Piwel_GFZone:Server:SetRoutingBucket', true)
    TriggerServerEvent("Piwel_GFZone:Server:SetRoutingBucket", true)
    modules.RespawnPlayer()
end)

RegisterNetEvent('Piwel_GFZone:Client:RespawnPlayer')
AddEventHandler('Piwel_GFZone:Client:RespawnPlayer', function()
    modules.RespawnPlayer()
end)

RegisterNetEvent('Piwel_GFZone:Client:UpdatePrePhaseTimer')
AddEventHandler('Piwel_GFZone:Client:UpdatePrePhaseTimer', function(int)
    PrePhaseTimer = int
    if not PrePhaseStarted then modules.StartPrePhase() end
    if PrePhaseTimer > 0 and playerInGF then
        modules.Functions.OnScreenNotification({message = "La partie va commencer dans "..modules.Functions.ReturnTimeLeft(PrePhaseTimer)..".", time_display = 1000})
    elseif PrePhaseTimer == 0 and playerInGF then
        modules.Functions.OnScreenNotification({message = "La partie commence ! Eliminez vos énemies et augmentez vos statistiques !", time_display = 1000})
        modules.RespawnPlayer()
        PrePhaseStarted = false
    end
end)

RegisterNetEvent('Piwel_GFZone:Client:UpdateVotingPhaseTimer')
AddEventHandler('Piwel_GFZone:Client:UpdateVotingPhaseTimer', function(int)
    VotingPhaseTimer = int
    if VotingPhaseTimer > 0 and playerInGF then
        modules.Functions.OnScreenNotification({message = "Il vous reste "..modules.Functions.ReturnTimeLeft(VotingPhaseTimer).." pour voter. La partie va bientôt redémarrer.", time_display = 1000})
    elseif VotingPhaseTimer == 0 and playerInGF then
        modules.Functions.OnScreenNotification({message = "Votes terminés. La partie va commencer !", time_display = 1000})
        AnimpostfxStop('MenuMGIn')
        VotingPhaseStarted = false
    end
end)

RegisterNetEvent('Piwel_GFZone:Client:OpenVoteMenu')
AddEventHandler('Piwel_GFZone:Client:OpenVoteMenu', function(oldMap)
    VotingPhaseStarted = true
    AnimpostfxPlay("MenuMGIn", 1, true)
end)

RegisterNetEvent('Piwel_GFZone:Client:KillEffect')
AddEventHandler('Piwel_GFZone:Client:KillEffect', function()
    AnimpostfxPlay("SuccessNeutral", 500, false)
    SetEntityHealth(PlayerPedId(), 200)
end)

RegisterCommand('testeffect', function()
    local effect=  "SuccessNeutral"
    AnimpostfxPlay("SuccessNeutral", 500, false)
end, false)

AddEventHandler('Piwel_GFZone:IsPlayerInGFZone', function(cb)
	cb(playerInGF)
end)