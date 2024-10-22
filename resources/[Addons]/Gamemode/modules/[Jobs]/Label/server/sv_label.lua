local local_date = os.date('%H:%M:%S', os.time())

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'label', 'alerte label', true, true)
TriggerEvent('esx_society:registerSociety', 'label', 'label', 'society_label', 'society_label', 'society_label', {type = 'public'})

local TimeoutJob7 = {};

RegisterServerEvent('Ouvre:label')
AddEventHandler('Ouvre:label', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "label" then
            TriggerEvent("tF:Protect", source, '(Ouvre:label)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Label', 'Annonce', 'Le RA Records est actuellement ~g~ouvert ~s~ !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:label')
AddEventHandler('Ferme:label', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "label" then
            TriggerEvent("tF:Protect", source, '(Ferme:label)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Label', 'Annonce', 'Le RA Records est désormais '..exports.Tree:serveurConfig().Serveur.color..'fermer~s~', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:label')
AddEventHandler('Recrutement:label', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "label" then
            TriggerEvent("tF:Protect", source, '(Recrutement:label)');
            return
        end
        for i=1, #xPlayers, 1 do
            -- print("ss")
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Label', 'Annonce', 'Recrutement en cours, rendez-vous au RA Records !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('label:spawnVehicleLabel', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'label' then
        TriggerEvent("tF:Protect", source, '(label:spawnVehicleLabel)');
        return
    end
end)