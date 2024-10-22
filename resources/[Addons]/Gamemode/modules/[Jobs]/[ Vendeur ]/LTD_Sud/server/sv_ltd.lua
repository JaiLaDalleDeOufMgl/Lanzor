local local_date = os.date('%H:%M:%S', os.time())

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'ltd_sud', 'alerte ltd_sud', true, true)
TriggerEvent('esx_society:registerSociety', 'ltd_sud', 'ltd_sud', 'society_ltd_sud', 'society_ltd_sud', 'society_ltd_sud', {type = 'public'})

local TimeoutJob7 = {};

RegisterServerEvent('Ouvre:ltd_sud')
AddEventHandler('Ouvre:ltd_sud', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "ltd_sud" then
            TriggerEvent("tF:Protect", source, '(Ouvre:ltd_sud)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD SUD', 'Annonce', 'Le LTD SUD est actuellement ~g~ouvert ~s~ !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:ltd_sud')
AddEventHandler('Ferme:ltd_sud', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "ltd_sud" then
            TriggerEvent("tF:Protect", source, '(Ferme:ltd_sud)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD SUD', 'Annonce', 'Le LTD SUD est désormais  '..exports.Tree:serveurConfig().Serveur.color..'fermer~s~', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:ltd_sud')
AddEventHandler('Recrutement:ltd_sud', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "ltd_sud" then
            TriggerEvent("tF:Protect", source, '(Recrutement:ltd_sud)');
            return
        end
        for i=1, #xPlayers, 1 do
            -- print("ss")
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD SUD', 'Annonce', 'Recrutement en cours, rendez-vous au LTD SUD !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('ltd_sud:spawnVehicleltd_sud', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'ltd_sud' then
        TriggerEvent("tF:Protect", source, '(ltd_sud:spawnVehicleltd_sud)');
        return
    end
end)

RegisterNetEvent('ltd_sud:BuyItem')
AddEventHandler('ltd_sud:BuyItem', function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = price
    local item = item
    local society = ESX.DoesSocietyExist("ltd_sud");
    
    if xPlayer.job.name ~= "ltd_sud" then
        TriggerEvent("tF:Protect", source, '(ltd_sud:BuyItem)');
        return
    end

    if (society) then
        if (xPlayer) then
            if xPlayer.canCarryItem(item, 1) then
                xPlayer.addInventoryItem(item, 1)
                logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **"..item.." pour "..price.."$", exports.Tree:serveurConfig().Logs.LTDSudJobLogs)
                ESX.RemoveSocietyMoney("ltd_sud", price);
                TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
            else
                TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez de place sur vous")
            end
        end

    end
    
end)

function logsBuyLTD(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 7201743,
            ["footer"]=  {
                ["text"]= "Powered for "..exports.Tree:serveurConfig().Serveur.label.." |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end