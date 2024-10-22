-- --[[
--   This file is part of Gamemode RolePlay.
--   Copyright (c) Gamemode RolePlay - All Rights Reserved
--   Unauthorized using, copying, modifying and/or distributing of this file,
--   via any medium is strictly prohibited. This code is confidential.
-- --]]

local housesStates = {}

Citizen.CreateThread(function()
    for _,house in pairs(robberiesConfiguration.houses) do
        table.insert(housesStates, {state = true, robbedByID = nil})
    end
end)

RegisterNetEvent("esx_robberies:houseRobbed")
AddEventHandler("esx_robberies:houseRobbed",function(houseID)
    local _src = source

    local pseudo  = GetPlayerName(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local steamhex = xPlayer.identifier
    local local_date = os.date('%H:%M:%S', os.time())

    local content = {
        {
            ["title"] = "**Cambriolages :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = pseudo.." [".._src.."] ["..steamhex.."]" },
                { name = "- Maison braquer :", value = houseID },
                -- { name = "- Argent Gagner :", value = price.."$" },
            },
            ["type"]  = "rich",
            ["color"] = 14673055,
            ["footer"] =  {
            ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    PerformHttpRequest(exports.Tree:serveurConfig().Logs.CambriolageMaison, function(err, text, headers) end, 'POST', json.encode({username = "Logs SHOP", embeds = content}), { ['Content-Type'] = 'application/json' })

    housesStates[houseID].state = false
    housesStates[houseID].robbedByID = _src
    Citizen.SetTimeout((1000*60)*robberiesConfiguration.houseRobRegen, function()
        housesStates[houseID].state = true
        housesStates[houseID].robbedByID = nil
    end)
end)

RegisterNetEvent("esx_robberies:callThePolice")
AddEventHandler("esx_robberies:callThePolice", function(houseIndex)
    local authority = robberiesConfiguration.houses[houseIndex].authority
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
            TriggerClientEvent("initializePoliceBlip",xPlayers[i], houseIndex, robberiesConfiguration.houses[houseIndex].policeBlipDuration)
        end
    end
end)

RegisterNetEvent("esx_robberies:getHousesStates")
AddEventHandler("esx_robberies:getHousesStates", function()
    local _src = source
    TriggerClientEvent("esx_robberies:getHousesStates", _src, housesStates)
end)



local TRoberyPlayer = {}

RegisterNetEvent('esx_robberies:setPlayerRob')
AddEventHandler('esx_robberies:setPlayerRob', function()
    TRoberyPlayer[source] = true
end)



local players = {};

RegisterNetEvent('esx_robberies:money', function(robbItems)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);

    if (not robbItems) then return end
    if (next(robbItems) == nil) then return end

    if (not players[xPlayer.identifier] or GetGameTimer() - players[xPlayer.identifier] > 60000) then

        local finalReward = 0
        for index,item in pairs(robbItems) do
            finalReward = finalReward + item.resell;
        end

        players[xPlayer.identifier] = GetGameTimer();
        xPlayer.addAccountMoney('dirtycash', finalReward);
    else
        TriggerEvent("tF:Protect", source, "esx_robberies:money (https://www.youtube.com/watch?v=dQw4w9WgXcQ)")
    end
end)

RegisterNetEvent('esx_robberies:money', function(robbItems, houseID)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    local _src = source

    if (not TRoberyPlayer[source]) then return end
    TRoberyPlayer[source] = false


    if (next(robbItems) == nil) then return end

    if robbItems == nil then
        TriggerEvent("tF:Protect", source, "esx_robberies:money")
    else
        for k,v in pairs(robbItems) do
            if v.name == nil then
                TriggerEvent("tF:Protect", source, "esx_robberies:money")
            elseif v.resell == nil then
                TriggerEvent("tF:Protect", source, "esx_robberies:money")
            end
        end
    end
    
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(526.7914, -1655.516, 29.35936)) > 10.0 then 
        TriggerEvent("tF:Protect", source, '(esx_robberies:money)');
        return
    end

    local rewardTotal = math.random(7000, 12500)
    if rewardTotal < 13000 then
        xPlayer.addAccountMoney('dirtycash', rewardTotal);
        xPlayer.showNotification("Vous venez de vendre les Bijoux Volés\nVous avez reçu : "..exports.Tree:serveurConfig().Serveur.color..""..rewardTotal.."~s~$")

        local _src = source
        local pseudo  = GetPlayerName(source)
        local steamhex = xPlayer.identifier
        local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Argent Gagner :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Joueur :", value = pseudo.." [".._src.."] ["..steamhex.."]" },
                    { name = "- Argent Gagner :", value = rewardTotal.."$" },
                },
                ["type"]  = "rich",
                ["color"] = 000000,
                ["footer"] =  {
                ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
                },
            }
        }
        PerformHttpRequest(exports.Tree:serveurConfig().Logs.CambriolageMaison, function(err, text, headers) end, 'POST', json.encode({username = "Logs SHOP", embeds = content}), { ['Content-Type'] = 'application/json' })
    else
        TriggerEvent("tF:Protect", source, "esx_robberies:money")
    end
end)

