

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local timeoutMalibu = {}


TriggerEvent('esx_society:registerSociety', 'bahamas', 'bahamas', 'society_bahamas', 'society_bahamas', 'society_bahamas', {type = 'public'})

RegisterServerEvent("Malibu:AnnonceOuverture")
AddEventHandler("Malibu:AnnonceOuverture", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer then
        return 
    end
    if (not timeoutMalibu[xPlayer.identifier] or GetGameTimer() - timeoutMalibu[xPlayer.identifier] > 600000) then
		timeoutMalibu[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", _source, "Kabyle ta bz encore une fois peut être que tu comprendras la prochaine fois bisous ❤️ !")
            return
        end
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Malibu', 'Annonce', 'Le Malibu est désormais ~g~Ouvert~s~ !', 'CHAR_MOLLY', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.")
    end
end)


RegisterServerEvent("Malibu:AnnonceFermeture")
AddEventHandler("Malibu:AnnonceFermeture", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer then
        return 
    end
    if (not timeoutMalibu[xPlayer.identifier] or GetGameTimer() - timeoutMalibu[xPlayer.identifier] > 600000) then
		timeoutMalibu[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", _source, "Kabyle ta bz encore une fois peut être que tu comprendras la prochaine fois bisous ❤️ !")
            return
        end
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Malibu', 'Annonce', 'Le Malibu est désormais ~r~fermée~s~ !', 'CHAR_MOLLY', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.")
    end
end)

RegisterServerEvent("Malibu:AnnonceRecrutement")
AddEventHandler("Malibu:AnnonceRecrutement", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer then
        return 
    end
    if (not timeoutMalibu[xPlayer.identifier] or GetGameTimer() - timeoutMalibu[xPlayer.identifier] > 600000) then
		timeoutMalibu[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "bahamas" then
            TriggerEvent("tF:Protect", _source, "Kabyle ta bz encore une fois peut être que tu comprendras la prochaine fois bisous ❤️ !")
            return
        end
        for i = 1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Malibu', 'Annonce', 'Les Recrutement en cours, rendez-vous au Malibu !', 'CHAR_MOLLY', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.")
    end
end)

RegisterNetEvent("Malibu:BuyItem")
AddEventHandler("Malibu:BuyItem", function(amount, v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then 
        return 
    end
    if xPlayer.job.name ~= "bahamas" then
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