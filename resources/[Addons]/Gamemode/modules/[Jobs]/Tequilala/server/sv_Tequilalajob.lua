

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'tequilala', 'alerte tequilala', true, true)

TriggerEvent('esx_society:registerSociety', 'tequilala', 'tequilala', 'society_tequilala', 'society_tequilala', 'society_tequilala', {type = 'public'})

local TimeoutJob4 = {};

RegisterServerEvent('Ouvre:tequilala')
AddEventHandler('Ouvre:tequilala', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "tequilala" then
            TriggerEvent("tF:Protect", source, '(Ouvre:tequilala)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Tequilala', 'Annonce', 'Le Tequilala est désormais ~g~Ouvert~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:tequilala')
AddEventHandler('Ferme:tequilala', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "tequilala" then
            TriggerEvent("tF:Protect", source, '(Ferme:tequilala)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Tequilala', 'Annonce',  'Le Tequilala est désormais ~r~Fermer~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:tequilala')
AddEventHandler('Recrutement:tequilala', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "tequilala" then
            TriggerEvent("tF:Protect", source, '(Recrutement:tequilala)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Tequilala', 'Annonce', 'Les Recrutement en cours, rendez-vous au Vanilla Tequilala !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

--Shop Tequilala 
RegisterNetEvent('Tequilala:BuyEau')
AddEventHandler('Tequilala:BuyEau', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyEau)');
        return
    end

    if xPlayer.canCarryItem('water', 1) then
        xPlayer.addInventoryItem('water', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **Eau", exports.Tree:serveurConfig().Logs.TequilaJobLogs)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyIceTea')
AddEventHandler('Tequilala:BuyIceTea', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyIceTea)');
        return
    end

    if xPlayer.canCarryItem('icetea', 1) then
        xPlayer.addInventoryItem('icetea', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **icetea", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyLimonade')
AddEventHandler('Tequilala:BuyLimonade', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyLimonade)');
        return
    end

    if xPlayer.canCarryItem('limonade', 1) then
        xPlayer.addInventoryItem('limonade', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **limonade", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
        return
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyVine')
AddEventHandler('Tequilala:BuyVine', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyVine)');
        return
    end

    if xPlayer.canCarryItem('vine', 1) then
        xPlayer.addInventoryItem('vine', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **vine", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyWhiskycoca')
AddEventHandler('Tequilala:BuyWhiskycoca', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyWhiskycoca)');
        return
    end

    if xPlayer.canCarryItem('wiskycoca', 1) then
        xPlayer.addInventoryItem('wiskycoca', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **wiskycoca", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyMojito')
AddEventHandler('Tequilala:BuyMojito', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyMojito)');
        return
    end
    if xPlayer.canCarryItem('mojito', 1) then
        xPlayer.addInventoryItem('mojito', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **mojito", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyCoca')
AddEventHandler('Tequilala:BuyCoca', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyCoca)');
        return
    end

    if xPlayer.canCarryItem('coca', 1) then
        xPlayer.addInventoryItem('coca', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **coca", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyFanta')
AddEventHandler('Tequilala:BuyFanta', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyFanta)');
        return
    end

    if xPlayer.canCarryItem('fanta', 1) then
        xPlayer.addInventoryItem('fanta', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **fanta", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyChips')
AddEventHandler('Tequilala:BuyChips', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyChips)');
        return
    end

    if xPlayer.canCarryItem('chips', 1) then
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **chips", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        xPlayer.addInventoryItem('chips', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyCacahuete')
AddEventHandler('Tequilala:BuyCacahuete', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyCacahuete)');
        return
    end

    if xPlayer.canCarryItem('cacahuete', 1) then
        xPlayer.addInventoryItem('cacahuete', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **cacahuete", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:BuyOlive')
AddEventHandler('Tequilala:BuyOlive', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "tequilala" then
        TriggerEvent("tF:Protect", source, '(Tequilala:BuyOlive)');
        return
    end

    if xPlayer.canCarryItem('olive', 1) then
        xPlayer.addInventoryItem('olive', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **olive", exports.Tree:serveurConfig().Logs.TequilaJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Tequilala:StartDance')
AddEventHandler('Tequilala:StartDance', function()
    TriggerClientEvent('Tequilala:StartStrip', -1)
    TriggerClientEvent('Tequilala:StartBoucleMoney', -1)
end)

RegisterNetEvent('Tequilala:StopDance')
AddEventHandler('Tequilala:StopDance', function()
    TriggerClientEvent('Tequilala:StopStrip', -1)
end)

RegisterNetEvent('Tequilala:PayStrip')
AddEventHandler('Tequilala:PayStrip', function()
    local source = source
    local price = 1000
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getAccount('cash').money >= price then

        local society = ESX.DoesSocietyExist("tequilala");

        if (society) then

            xPlayer.removeAccountMoney('cash', price);
            ESX.AddSocietyMoney("tequilala", price);

        end

    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de cash sur vous !")
    end
end)

local local_date = os.date('%H:%M:%S', os.time())

function logsBuyFrigo(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 13463011,
            ["footer"]=  {
                ["text"]= "Powered for "..exports.Tree:serveurConfig().Serveur.label.." |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end