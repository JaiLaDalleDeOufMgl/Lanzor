local local_date = os.date('%H:%M:%S', os.time())

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'realestateagent', 'alerte agent immo', true, true)
TriggerEvent('esx_society:registerSociety', 'realestateagent', 'realestateagent', 'society_realestateagent', 'society_realestateagent', 'society_realestateagent', {type = 'public'})

local TimeoutJob7 = {};

RegisterServerEvent('Ouvre:realestateagent')
AddEventHandler('Ouvre:realestateagent', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "realestateagent" then
            TriggerEvent("tF:Protect", source, '(Ouvre:realestateagent)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agent Immobilier', 'Annonce', 'L\'Agence immobilier est actuellement ~g~ouvert ~s~ !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:realestateagent')
AddEventHandler('Ferme:realestateagent', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "realestateagent" then
            TriggerEvent("tF:Protect", source, '(Ferme:realestateagent)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agent Immobilier', 'Annonce', 'L\'Agence immobilier est actuellement ~r~fermée ~s~ !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:realestateagent')
AddEventHandler('Recrutement:realestateagent', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "realestateagent" then
            TriggerEvent("tF:Protect", source, '(Recrutement:realestateagent)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agent Immobilier', 'Annonce', 'Recrutement en cours, rendez-vous a l\'Agence immobilier !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('realestateagent:spawnVehicleImmo', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'realestateagent' then
        TriggerEvent("tF:Protect", source, '(realestateagent:spawnVehicleImmo)');
        return
    end
end)