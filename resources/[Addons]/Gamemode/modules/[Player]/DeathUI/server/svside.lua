

local TimeoutAmbulance = {};

RegisterServerEvent('ambulance:sendsignal')
AddEventHandler('ambulance:sendsignal', function(playerDead, x,y,z)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if (xPlayer) then
        if (not TimeoutAmbulance[xPlayer.identifier] or GetGameTimer() - TimeoutAmbulance[xPlayer.identifier] > 300000) then
            TimeoutAmbulance[xPlayer.identifier] = GetGameTimer();
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer.job.name == 'ambulance' then
                    TriggerClientEvent('isInServiceCheck', xPlayers[i], "+")
                    TriggerClientEvent('ambulance:signal', xPlayers[i], playerDead, x,y,z)
                    TriggerClientEvent('ambulance:sendMarker', xPlayers[i], playerDead, x,y,z)
                end
            end
        else
            xPlayer.showNotification("Vous devez attendre 5 minutes avant de pouvoir refaire un appel.");
        end
    end
end)

ESX.RegisterServerCallback('ambulance:getDeathStatus', function(source, cb)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then
        MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(isDead)	
            cb(isDead)
        end)
    end
end)

RegisterServerEvent('ambulance:sendAnnonce')
AddEventHandler('ambulance:sendAnnonce', function(args)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if (xPlayer) then
        if xPlayer.job.name ~= "ambulance" then
            TriggerEvent("tF:Protect", source, '(ambulance:sendAnnonce)')
            return
        end
        if args == "+" then
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Demande', 'Notification', "Une personne à besoin d'aide !", 'CHAR_CALL911', 8)
        elseif args == "-" then
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Demande', 'Notification', "Une demande vient d'être prise en charge.", 'CHAR_CALL911', 8)
        end
    end
end)

local waitingForRevive = {}

RegisterNetEvent('réanimerafterdie', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if (GetGameTimer() - waitingForRevive[xPlayer.identifier] >= 200) then
        xPlayer.removeWeaponSystem("gadget_parachute")
        TriggerClientEvent('ambulance:reviveAfterDie', source)
    end
end)

local playerInGF = false

RegisterNetEvent('Piwel_GFZone:Sharing:SetPlayerInGF')
AddEventHandler('Piwel_GFZone:Sharing:SetPlayerInGF', function(bool)
    playerInGF = bool
    if playerInGF then 
        SetPedCanSwitchWeapon(PlayerPedId(), true)
    end
end)

AddEventHandler("Gamemode:Player:playerDied", function(src)
    if playerInGF then return end
    local player = ESX.GetPlayerFromId(src);
    if (player) then
        if (not waitingForRevive[player.identifier]) then
            waitingForRevive[player.identifier] = GetGameTimer()
            player.triggerEvent("JustGod:ReceiveDeathStatus", true);
        end
    end
end)

AddEventHandler("Gamemode:Player:playerRevived", function(src)
    if playerInGF then return end
    local player = ESX.GetPlayerFromId(src);
    if (player) then
        if (waitingForRevive[player.identifier]) then
            waitingForRevive[player.identifier] = nil
            player.triggerEvent("JustGod:ReceiveDeathStatus", false);
        end
    end
end)
