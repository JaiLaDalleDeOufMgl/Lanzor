

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local timeoutBahamas = {}


TriggerEvent('esx_society:registerSociety', 'bahamas2', 'bahamas2', 'society_bahamas2', 'society_bahamas2', 'society_bahamas2', {type = 'public'})

RegisterServerEvent("Bahamas2:AnnonceOuverture")
AddEventHandler("Bahamas2:AnnonceOuverture", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer then
        return 
    end
    if (not timeoutBahamas[xPlayer.identifier] or GetGameTimer() - timeoutBahamas[xPlayer.identifier] > 600000) then
		timeoutBahamas[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas2" then
            TriggerEvent("tF:Protect", _source, "Kabyle ta bz encore une fois peut être que tu comprendras la prochaine fois bisous ❤️ !")
            return
        end
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bahamas', 'Annonce', 'Le Bahamas est désormais ~g~Ouvert~s~ !', 'CHAR_MOLLY', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.")
    end
end)


RegisterServerEvent("Bahamas2:AnnonceFermeture")
AddEventHandler("Bahamas2:AnnonceFermeture", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer then
        return 
    end
    if (not timeoutBahamas[xPlayer.identifier] or GetGameTimer() - timeoutBahamas[xPlayer.identifier] > 600000) then
		timeoutBahamas[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas2" then
            TriggerEvent("tF:Protect", _source, "Kabyle ta bz encore une fois peut être que tu comprendras la prochaine fois bisous ❤️ !")
            return
        end
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bahamas', 'Annonce', 'Le Bahamas est désormais ~r~fermée~s~ !', 'CHAR_MOLLY', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.")
    end
end)

RegisterServerEvent("Bahamas2:AnnonceRecrutement")
AddEventHandler("Bahamas2:AnnonceRecrutement", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer then
        return 
    end
    if (not timeoutBahamas[xPlayer.identifier] or GetGameTimer() - timeoutBahamas[xPlayer.identifier] > 600000) then
		timeoutBahamas[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas2" then
            TriggerEvent("tF:Protect", _source, "Kabyle ta bz encore une fois peut être que tu comprendras la prochaine fois bisous ❤️ !")
            return
        end
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bahamas', 'Annonce', 'Les Recrutement en cours, rendez-vous au Bahamas !', 'CHAR_MOLLY', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.")
    end
end)

RegisterNetEvent("Bahamas:BuyItem")
AddEventHandler("Bahamas:BuyItem", function(amount, v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then 
        return 
    end
    if xPlayer.job.name ~= "bahamas2" then
        TriggerEvent("tF:Protect", _source, "Kabyle ta bz encore une fois peut être que tu comprendras la prochaine fois bisous ❤️ !")
        return
    end
    if xPlayer.canCarryItem(v.item, amount) then
        xPlayer.addInventoryItem(v.item, amount)
        xPlayer.showNotification("Vous avez acheté x"..amount.." un(e) "..v.label.."")
    else
        xPlayer.showNotification("~r~Vous n'avez pas assez de place dans votre inventaire.")
    end
end)