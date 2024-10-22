local local_date = os.date('%H:%M:%S', os.time())

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'burgershot', 'alerte burgershot', true, true)

TriggerEvent('esx_society:registerSociety', 'burgershot', 'burgershot', 'society_burgershot', 'society_burgershot', 'society_burgershot', {type = 'public'})

local TimeoutJob7 = {};

RegisterServerEvent('Ouvre:BurgerShot')
AddEventHandler('Ouvre:BurgerShot', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "burgershot" then
            TriggerEvent("tF:Protect", source, '(Ouvre:BurgerShot)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BurgerShot', 'Annonce', 'Le BurgerShot est actuellement ouvert !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:BurgerShot')
AddEventHandler('Ferme:BurgerShot', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "burgershot" then
            TriggerEvent("tF:Protect", source, '(Ferme:BurgerShot)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BurgerShot', 'Annonce', 'Le BurgerShot est désormais Fermer~s~ !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:BurgerShot')
AddEventHandler('Recrutement:BurgerShot', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob7[xPlayer.identifier] or GetGameTimer() - TimeoutJob7[xPlayer.identifier] > 600000) then
		TimeoutJob7[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "burgershot" then
            TriggerEvent("tF:Protect", source, '(Recrutement:BurgerShot)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'BurgerShot', 'Annonce', 'Recrutement en cours, rendez-vous au BurgerShot !', 'MESSAGE', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterNetEvent('burgershot:brugerclassique')
AddEventHandler('burgershot:brugerclassique', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ped = GetPlayerPed(_source);
    local coords = GetEntityCoords(ped)
    local craftbruger = vector3(-1199.3, -898.95, 14.0)

    local garnitures = xPlayer.getInventoryItem('garnitures')
    local painburger = xPlayer.getInventoryItem('painburger')
	local burgerclassique = xPlayer.getInventoryItem('burgerclassique')
    local steak = xPlayer.getInventoryItem('steak')

    if xPlayer.job.name ~= "burgershot" then
        TriggerEvent("tF:Protect", source, '(burgershot:brugerclassique)');
        return
    end

    if #(coords - craftbruger) > 20.0 then
        TriggerEvent("tF:Protect", source, '(burgershot:brugerclassique)');
        return
    end

    if not garnitures then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de garnitures pour faire ceci')
    elseif not steak then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de steak pour faire ceci')
	elseif not painburger then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de painburger pour faire ceci')
    else
        logsCrea("[Création Burger] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item crée : **Burger", exports.Tree:serveurConfig().Logs.BurgerShotJobLogs)
        xPlayer.removeInventoryItem('garnitures', 1)
		xPlayer.removeInventoryItem('painburger', 1)
        xPlayer.removeInventoryItem('steak', 1)
        xPlayer.addInventoryItem('burgerclassique', 1)    
    end
end)

RegisterNetEvent('burgershot:garnitures')
AddEventHandler('burgershot:garnitures', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local ped = GetPlayerPed(_source);
    local coords = GetEntityCoords(ped)
    local craftgarniture = vector3(-1200.94, -896.47, 13.99)

    local tomates = xPlayer.getInventoryItem('tomates')
	local cornichons = xPlayer.getInventoryItem('cornichons')
    local salade = xPlayer.getInventoryItem('salade')

    if xPlayer.job.name ~= "burgershot" then
        TriggerEvent("tF:Protect", source, '(burgershot:garnitures)');
        return
    end

    if #(coords - craftgarniture) > 20.0 then
        TriggerEvent("tF:Protect", source, '(burgershot:garnitures)');
        return
    end

    if not tomates then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de tomates pour faire ceci')
	elseif not cornichons then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de cornichons pour faire ceci')
	elseif not salade then
        TriggerClientEvent('esx:showNotification', source, 'Vous n\'avez plus de salade pour faire ceci')
    else
        xPlayer.removeInventoryItem('tomates', 1)
		xPlayer.removeInventoryItem('cornichons', 1)
		xPlayer.removeInventoryItem('salade', 1)
        xPlayer.addInventoryItem('garnitures', 1)  
        logsCrea("[Création Garniture] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item crée : **Garniture", exports.Tree:serveurConfig().Logs.BurgerShotJobLogs)
    end
end)

RegisterNetEvent('burgershot:BuyItem')
AddEventHandler('burgershot:BuyItem', function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local price = price
    local item = item

    if xPlayer.job.name ~= "burgershot" then
        TriggerEvent("tF:Protect", source, '(burgershot:BuyCornichons)');
        return
    end

    local society = ESX.DoesSocietyExist("burgershot");

    if (society) then

        if (xPlayer) then
            if xPlayer.canCarryItem(item, 1) then
                xPlayer.addInventoryItem(item, 1)
                ESX.RemoveSocietyMoney("burgershot", price);
                TriggerClientEvent('esx:showNotification', source, "~g~Achats effectué !")
                logsGurgerShotAchat("[Achat Coffre] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Item acheter : **"..item.. " prix : "..price.."$", exports.Tree:serveurConfig().Logs.BurgerShotJobLogs)

            else
                TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez de place sur vous")
            end
        end

    end
    
end)

function logsCrea(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 3100835,
            ["footer"]=  {
                ["text"]= "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsGurgerShotAchat(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2615305,
            ["footer"]=  {
                ["text"]= "Powered for "..exports.Tree:serveurConfig().Serveur.label.." | "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end