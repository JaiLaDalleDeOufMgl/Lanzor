

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'unicorn', 'alerte unicorn', true, true)

TriggerEvent('esx_society:registerSociety', 'unicorn', 'unicorn', 'society_unicorn', 'society_unicorn', 'society_unicorn', {type = 'public'})

local TimeoutJob4 = {};

RegisterServerEvent('Ouvre:unicorn')
AddEventHandler('Ouvre:unicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "unicorn" then
            TriggerEvent("tF:Protect", source,'(Ouvre:unicorn)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', 'Annonce', 'L\'Unicorn est désormais Ouvert~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:unicorn')
AddEventHandler('Ferme:unicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "unicorn" then
            TriggerEvent("tF:Protect", source,'(Ferme:unicorn)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', 'Annonce', 'L\'Unicorn est désormais Fermer~s~ !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:unicorn')
AddEventHandler('Recrutement:unicorn', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob4[xPlayer.identifier] or GetGameTimer() - TimeoutJob4[xPlayer.identifier] > 600000) then
		TimeoutJob4[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "unicorn" then
            TriggerEvent("tF:Protect", source,'(Recrutement:unicorn)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Unicorn', 'Annonce', 'Les Recrutement en cours, rendez-vous au Vanilla Unicorn !', 'CHAR_MP_STRIPCLUB_PR', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

--Shop Unicorn 
RegisterNetEvent('Unicorn:BuyEau')
AddEventHandler('Unicorn:BuyEau', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyEau)');
        return
    end

    if xPlayer.canCarryItem('water', 1) then
        xPlayer.addInventoryItem('water', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **Eau", exports.Tree:serveurConfig().Logs.UnicornJobLogs)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyIceTea')
AddEventHandler('Unicorn:BuyIceTea', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyIceTea)');
        return
    end

    if xPlayer.canCarryItem('icetea', 1) then
        xPlayer.addInventoryItem('icetea', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **icetea", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyLimonade')
AddEventHandler('Unicorn:BuyLimonade', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyLimonade)');
        return
    end

    if xPlayer.canCarryItem('limonade', 1) then
        xPlayer.addInventoryItem('limonade', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **limonade", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
        return
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyVine')
AddEventHandler('Unicorn:BuyVine', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyVine)');
        return
    end

    if xPlayer.canCarryItem('vine', 1) then
        xPlayer.addInventoryItem('vine', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **vine", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyWhiskycoca')
AddEventHandler('Unicorn:BuyWhiskycoca', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyWhiskycoca)');
        return
    end

    if xPlayer.canCarryItem('wiskycoca', 1) then
        xPlayer.addInventoryItem('wiskycoca', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **wiskycoca", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyMojito')
AddEventHandler('Unicorn:BuyMojito', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyMojito)');
        return
    end
    if xPlayer.canCarryItem('mojito', 1) then
        xPlayer.addInventoryItem('mojito', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **mojito", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyCoca')
AddEventHandler('Unicorn:BuyCoca', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyCoca)');
        return
    end

    if xPlayer.canCarryItem('coca', 1) then
        xPlayer.addInventoryItem('coca', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **coca", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyFanta')
AddEventHandler('Unicorn:BuyFanta', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyFanta)');
        return
    end

    if xPlayer.canCarryItem('fanta', 1) then
        xPlayer.addInventoryItem('fanta', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **fanta", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyChips')
AddEventHandler('Unicorn:BuyChips', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyChips)');
        return
    end

    if xPlayer.canCarryItem('chips', 1) then
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **chips", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        xPlayer.addInventoryItem('chips', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyCacahuete')
AddEventHandler('Unicorn:BuyCacahuete', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyCacahuete)');
        return
    end

    if xPlayer.canCarryItem('cacahuete', 1) then
        xPlayer.addInventoryItem('cacahuete', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **cacahuete", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:BuyOlive')
AddEventHandler('Unicorn:BuyOlive', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)  

    if xPlayer.job.name ~= "unicorn" then
        TriggerEvent("tF:Protect", source, '(Unicorn:BuyOlive)');
        return
    end

    if xPlayer.canCarryItem('olive', 1) then
        xPlayer.addInventoryItem('olive', 1)
        logsBuyFrigo("[Achat Frigo] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **olive", exports.Tree:serveurConfig().Logs.UnicornJobLogs)

        TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color..'Vous n\'avez pas assez de place dans votre inventaire')
    end
end)

RegisterNetEvent('Unicorn:StartDance')
AddEventHandler('Unicorn:StartDance', function()
    TriggerClientEvent('Unicorn:StartStrip', -1)
    TriggerClientEvent('Unicorn:StartBoucleMoney', -1)
end)

RegisterNetEvent('Unicorn:StopDance')
AddEventHandler('Unicorn:StopDance', function()
    TriggerClientEvent('Unicorn:StopStrip', -1)
end)

RegisterNetEvent('Unicorn:PayStrip')
AddEventHandler('Unicorn:PayStrip', function()
    local source = source
    local price = 1000
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer.getAccount('cash').money >= price then

        local society = ESX.DoesSocietyExist("unicorn");

        if (society) then

            xPlayer.removeAccountMoney('cash', price);
            ESX.AddSocietyMoney("unicorn", price);

        end

    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas de cash sur vous !")
    end
end)