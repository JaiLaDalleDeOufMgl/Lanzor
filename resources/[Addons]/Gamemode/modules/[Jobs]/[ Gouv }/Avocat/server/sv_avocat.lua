TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'avocat', 'alerte Avocat', true, true)
TriggerEvent('esx_society:registerSociety', 'avocat', 'avocat', 'society_avocat', 'society_avocat', 'society_avocat', {type = 'public'})

local TimeoutJob7 = {};

RegisterServerEvent('Ouvre:avocat')
AddEventHandler('Ouvre:avocat', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "avocat" then
            TriggerEvent("tF:Protect", source, '(Ouvre:avocat)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avocat', 'Annonce', 'Le cabinet d\'avocat est actuellement ~g~ouvert ~s~ !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:avocat')
AddEventHandler('Ferme:avocat', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "avocat" then
            TriggerEvent("tF:Protect", source, '(Ferme:avocat)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avocat', 'Annonce', 'Le cabinet d\'avocat est désormais  '..exports.Tree:serveurConfig().Serveur.color..'fermer~s~', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:avocat')
AddEventHandler('Recrutement:avocat', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "avocat" then
            TriggerEvent("tF:Protect", source, '(Recrutement:avocat)');
            return
        end
        for i=1, #xPlayers, 1 do
            -- print("ss")
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avocat', 'Annonce', 'Recrutement en cours, rendez-vous au cabinet d\'Avocat !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('avocat:spawnVehicleAvocat', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'avocat' then
        TriggerEvent("tF:Protect", source, '(avocat:spawnVehicleAvocat)');
        return
    end
end)