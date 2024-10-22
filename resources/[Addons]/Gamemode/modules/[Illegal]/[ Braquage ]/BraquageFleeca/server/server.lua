Fleeca = Fleeca or {}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Fleeca.BanksRobbed = {}

RegisterServerEvent('cFleeca:OpenDoor')
AddEventHandler('cFleeca:OpenDoor', function(getObjdoor, doorpos)
    local _src = source
    TriggerClientEvent("cFleeca:OpenDoor", -1, getObjdoor, doorpos)
end)

RegisterServerEvent('cFleeca:CloseDoor')
AddEventHandler('cFleeca:CloseDoor', function(getObjdoor, doorpos)
    local _src = source
    TriggerClientEvent("cFleeca:CloseDoor", -1, getObjdoor, doorpos)
end)

RegisterServerEvent('cFleeca:SetCooldown')
AddEventHandler('cFleeca:SetCooldown', function(id)
    local _src = source
    Fleeca.BanksRobbed[id]= os.time()
end)

RegisterServerEvent("cFleeca:GetCoolDown")
AddEventHandler("cFleeca:GetCoolDown", function(id)
    local _src = source
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if Fleeca.BanksRobbed[id] then 
        if (os.time() - Fleeca.CoolDown) > Fleeca.BanksRobbed[id] then 
            xPlayer.removeInventoryItem("id_card_f", 1)
            TriggerClientEvent("cFleeca:BinginDrill", _source)
        else
            TriggerClientEvent("esx:showNotification", _source, "Cette banque a déjà été braqué.")
        end
    else
        xPlayer.removeInventoryItem("id_card_f", 1)
        TriggerClientEvent("cFleeca:BinginDrill", _source)
    end
end)

RegisterNetEvent("fleeca:callThePolice")
AddEventHandler("fleeca:callThePolice", function(FleecaIndex)
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == 'police' then
            TriggerClientEvent("initializePoliceBlipfleeca",xPlayers[i], FleecaIndex)
            
        end
    end
end)

local players = {};

RegisterNetEvent('cFleeca:GiveMoney', function(money)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local ped = GetPlayerPed(source);
    local coords = GetEntityCoords(ped);

    if (xPlayer) then
        if (not players[xPlayer.identifier] or GetGameTimer() - players[xPlayer.identifier] > 10000) then
            players[xPlayer.identifier] = GetGameTimer();
            for i = 1, #Fleeca.posFleeca do
                if (#(coords -  Fleeca.posFleeca[i].rewardPos) < 30) then
                    xPlayer.addAccountMoney('dirtycash', money);
                end
            end
        else
            TriggerEvent("tF:Protect", source, "cFleeca:GiveMoney");
        end
    end

end);

RegisterNetEvent("fleeca:starthack")
AddEventHandler("fleeca:starthack", function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local Players = ESX.GetPlayers()
	local copsOnDuty = 0

    for i = 1, #Players do
        local xPlayer = ESX.GetPlayerFromId(Players[i])
        if xPlayer.job.name == "police" then
            copsOnDuty = copsOnDuty + 1
        end
    end

    local haveItem = xPlayer.getInventoryItem("id_card_f")
    if copsOnDuty >= Fleeca.RequiredCops then
        if haveItem then
            TriggerClientEvent("cFleeca:StartDrill", xPlayer.source)
            xPlayer.removeInventoryItem("id_card_f", 1)
        else
            TriggerClientEvent("esx:showNotification", source, "Vous ne possédez pas la carte de sécurité.")
            return
        end
    else
        TriggerClientEvent("esx:showNotification", source, "La Brinks viens de passer, il n'y a plus d'argent.")
        return
    end
end)

function SendLogs(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["title"]= title,
			["description"]= message,
			["type"]= "rich",
			["color"] = 16776960,
			["footer"]=  {
			["text"]= "Powered by "..exports.Tree:serveurConfig().Serveur.label.." | Time: "..local_date.."",
			},
		}
	}
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end