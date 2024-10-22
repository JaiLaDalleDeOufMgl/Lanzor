

RegisterServerEvent('sCore:annonceplayerup')
AddEventHandler('sCore:annonceplayerup', function(msg)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.grade_name == 'boss' then
        TriggerClientEvent("esx:showNotification", -1, ""..xPlayer.job.label.."\n : ~o~"..msg)
    else
        return
    end
end)

RegisterServerEvent('annonce:servicePolice')
AddEventHandler('annonce:servicePolice', function(status)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local name = xPlayer.getName(source)
    local xPlayers = ESX.GetPlayers()
    if status == "fin" then
        xPlayer.removeWeaponSystem("weapon_stungun")
        
        xPlayer.removeWeaponSystem("weapon_nightstick")
        
        xPlayer.removeWeaponSystem("weapon_combatpistol")
        
        xPlayer.removeWeaponSystem("weapon_beanbag")
        
        xPlayer.removeWeaponSystem("weapon_carbinerifle")
        
        xPlayer.removeWeaponSystem("weapon_pumpshotgun")

        
        RemoveCountPoliceInService(source)
    elseif (status == "prise") then
        AddCountPoliceInService(source)
    end
    if xPlayer.job.name == 'police' then
        for i = 1, #xPlayers, 1 do
            local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
            if thePlayer.job.name == 'police' then
                TriggerClientEvent('police:InfoService', xPlayers[i], status, name)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(annonce:servicePolice)');
    end
end)

RegisterServerEvent('police:verif')
AddEventHandler('police:verif', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(police:verif)');
    end
end)

RegisterNetEvent('police:spawnVehicle', function(model)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(police:spawnVehicle)');
        return
    end
end)

AddEventHandler('playerSpawned', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return; end

    xPlayer.removeWeaponSystem("weapon_stungun")

    xPlayer.removeWeaponSystem("weapon_nightstick")

    xPlayer.removeWeaponSystem("weapon_combatpistol")
    
    xPlayer.removeWeaponSystem("weapon_beanbag")
    
    xPlayer.removeWeaponSystem("weapon_carbinerifle")
    
    xPlayer.removeWeaponSystem("weapon_advancedrifle")
    
    xPlayer.removeWeaponSystem("weapon_pumpshotgun")
end)

AddEventHandler('playerDropped', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not xPlayer) then return; end

    xPlayer.removeWeaponSystem("weapon_stungun")

    xPlayer.removeWeaponSystem("weapon_nightstick")

    xPlayer.removeWeaponSystem("weapon_combatpistol")

    xPlayer.removeWeaponSystem("weapon_beanbag")

    xPlayer.removeWeaponSystem("weapon_carbinerifle")

    xPlayer.removeWeaponSystem("weapon_advancedrifle")

    xPlayer.removeWeaponSystem("weapon_pumpshotgun")
end)

RegisterServerEvent('buyWeaponForLSPD')
AddEventHandler('buyWeaponForLSPD', function(weapon)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local coords = GetEntityCoords(GetPlayerPed(source));
	local distance = #(coords - vector3(470.6805, -971.2394, 23.93));
	if xPlayer.job.name == 'police' then
		if weapon == "weapon_stungun" or weapon == "weapon_flashlight" or weapon == "weapon_nightstick" or weapon == "weapon_combatpistol" or weapon == "weapon_carbinerifle" or weapon == "weapon_pumpshotgun" or weapon == "weapon_beanbag" then
			if (distance < 35.0) then
                logsAmmu("[Achat Armes - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens d'acheter :** "..weapon, exports.Tree:serveurConfig().Logs.PoliceJobLogs)

                xPlayer.addWeapon(weapon, 255, { antiActions = 'police', removeReboot = true })
			else
				TriggerEvent("tF:Protect", source,'(buyWeaponForLSPD_distance)');
			end
		else
			TriggerEvent("tF:Protect", source,'(buyWeaponForLSPD_falseWeapon)');
		end
	else
        TriggerEvent("tF:Protect", source,'(buyWeaponForLSPD_FalseJob)');
    end
end)

RegisterServerEvent('menotterForPolice')
AddEventHandler('menotterForPolice', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'police' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('menotterlejoueur', target)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(menotterForPolice)');
    end
end);

RegisterServerEvent('escorterpolice')
AddEventHandler('escorterpolice', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'police' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('actionescorter', target, source)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(escorterpolice)');
    end
end);

RegisterServerEvent('menotterForGouv')
AddEventHandler('menotterForGouv', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'gouv' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('menotterlejoueur', target)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(menotterForGouv)');
    end
end);

RegisterServerEvent('escorterGouv')
AddEventHandler('escorterGouv', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target);
    
    if xPlayer.job.name == 'gouv' then
        if (target ~= -1 and targetXPlayer) then
            if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 5.0 ) then
                TriggerClientEvent('actionescorter', target, source)
            end
        end
    else
        TriggerEvent("tF:Protect", source,'(escorterGouv)');
    end
end);

RegisterServerEvent('message', function(player)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pName = xPlayer.getName()
    if (xPlayer.job.name == "police" and player) then
        if (#(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(player))) < 5.0) then
            TriggerClientEvent('esx:showNotification', player, "Vous êtes fouiller par " ..pName.. ".")
        end
    end
end);

RegisterServerEvent('messageGouv', function(player)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local pName = xPlayer.getName()
    if (xPlayer.job.name == "gouv" and player) then
        if (#(GetEntityCoords(GetPlayerPed(xPlayer.source)) - GetEntityCoords(GetPlayerPed(player))) < 5.0) then
            TriggerClientEvent('esx:showNotification', player, "Vous êtes fouiller par " ..pName.. ".")
        end
    end
end);

RegisterServerEvent('demande')
AddEventHandler('demande', function(coords, raison)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    if xPlayer.job.name ~= "police" then
        TriggerEvent("tF:Protect", source,'(demande)');
    else
        for i = 1, #xPlayers, 1 do
            local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
            if thePlayer.job.name == 'police' then
                TriggerClientEvent('renfort:setBlip', xPlayers[i], coords, raison)
            end
        end
    end
end)

RegisterServerEvent('insertintocasier')
AddEventHandler('insertintocasier', function(name, firstname, dob, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(insertintocasier)');
        return
    end
    MySQL.Async.execute('INSERT INTO casier VALUES (@identifier, @Nom, @Prenom, @Naissance, @Raison, @Auteur)', {  
        ['@identifier'] = xPlayer.identifier,        
        ['@Nom'] = firstname,      
        ['@Prenom'] = name,      
        ['@Naissance'] = dob,
        ['@Raison'] = reason,
        ['@Auteur'] = GetPlayerName(source),
		--['@Auteur'] = GetPlayerName(source)
        
    }, function(rowsChanged)            
    end)
    TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Le casier judiciaire a bien �t� enregistr� !")
    local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('updateinfos', xPlayers[i])
            --TriggerClientEvent("esx:showNotification", xPlayers[i], "Une plainte vient d'arriv�e !")
		end
	end
end)

RegisterServerEvent('validerplainte')
AddEventHandler('validerplainte', function(name, firstname, tel, nom1, prenom1, num1, reason)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(validerplainte)');
        return
    end
    MySQL.Async.execute('INSERT INTO plaintes VALUES (@identifier, @Prenom, @Nom, @Num, @Prenom1, @Nom1, @Num1, @Raison, @Auteur)', {  
        ['@identifier'] = xPlayer.identifier,
        ['@Prenom'] = name,            
        ['@Nom'] = firstname,      
        ['@Num'] = tel,
        ['@Prenom1'] = nom1,            
        ['@Nom1'] = prenom1,      
        ['@Num1'] = num1,
        ['@Raison'] = reason,
        ['@Auteur'] = GetPlayerName(source),
		--['@Auteur'] = GetPlayerName(source)
        
    }, function(rowsChanged)            
    end)
    local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent('updateinfos', xPlayers[i])
            TriggerClientEvent("esx:showNotification", xPlayers[i], exports.Tree:serveurConfig().Serveur.color.."Une plainte vient d'arriv�e !")
		end
	end
end)

ESX.RegisterServerCallback('getPlaintes', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM plaintes', {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('getData', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM casier', {}, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('plaitetraiter')
AddEventHandler('plaitetraiter', function(prenom, nom, num)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(plaitetraiter)');
        return
    end
    MySQL.Async.execute("DELETE FROM plaintes WHERE Prenom = @a AND Nom = @b AND Num = @c", {
        ['a'] = prenom,
        ['b'] = nom,
        ['c'] = num
    }, function()
    end)
    for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent("esx:showNotification", xPlayers[i], exports.Tree:serveurConfig().Serveur.color.."La plainte de monsieur "..prenom.. " "..nom.. " a bien �t� trait�e par le policier " ..xPlayer.getName().. " .")
            TriggerClientEvent('checkplaintes', xPlayers[i])
		end
	end
end)

RegisterServerEvent('deletecasier')
AddEventHandler('deletecasier', function(firstname, name, dob, reason, author)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer.job.name == 'police' then
        TriggerEvent("tF:Protect", source,'(deletecasier)');
        return
    end
    MySQL.Async.execute("DELETE FROM casier WHERE Prenom = @a AND Nom = @b AND naissance = @c AND raison = @d AND auteur = @e", {
        ['a'] = firstname,
        ['b'] = name,
        ['c'] = dob,
        ['d'] = reason,
        ['e'] = author
    }, function()
    end)
    for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'police' then
			TriggerClientEvent("esx:showNotification", xPlayers[i], exports.Tree:serveurConfig().Serveur.color.."Le casier judiciare de monsieur "..firstname.. " "..name.. " a bien �t� supprim� par le policier " ..xPlayer.getName().. " .")
            TriggerClientEvent('updateinfos', xPlayers[i])
		end
	end
end)

RegisterNetEvent('confiscatePlayerItem', function(target, itemType, itemName, amount)
    local source = source
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(confiscatePlayerItem)');
    else
        if (#(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 4.0) then
            if itemType == 'item_standard' then
                local targetItem = targetXPlayer.getInventoryItem(itemName)
                local sourceItem = sourceXPlayer.getInventoryItem(itemName)

                if (targetItem and targetItem.count >= amount) then
                    if (sourceXPlayer.canCarryItem(itemName, amount)) then
                        targetXPlayer.removeInventoryItem(itemName, amount);
                        sourceXPlayer.addInventoryItem(itemName, amount);
                        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué "..exports.Tree:serveurConfig().Serveur.color..""..amount..' '..sourceItem.label.."~s~.")
                        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris "..exports.Tree:serveurConfig().Serveur.color..""..amount..' '..sourceItem.label.."~s~.")
                        SendLogs("", exports.Tree:serveurConfig().Serveur.label.." | ", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
                    else
                        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez de place dans votre inventaire.");
                    end
                end
            end
                
            if itemType == 'item_account' then
                local targetAccount = targetXPlayer.getAccount(itemName)
                if (targetAccount and targetAccount.money >= amount) then
                    targetXPlayer.removeAccountMoney(itemName, amount);
                    sourceXPlayer.addAccountMoney(itemName, amount);
                    
                    TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué "..exports.Tree:serveurConfig().Serveur.color..""..amount.."$ ~s~argent non déclaré~s~.");
                    TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris "..exports.Tree:serveurConfig().Serveur.color..""..amount.."$ ~s~argent non déclaré~s~.");
                    SendLogs("", exports.Tree:serveurConfig().Serveur.label.." | ", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
                end
            end
        
            if itemType == 'item_weapon' then
                        targetXPlayer.removeWeapon(itemName, 0);
                        sourceXPlayer.addWeapon(itemName, amount);
                        SendLogs("", exports.Tree:serveurConfig().Serveur.label.." | ", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
            end
        end
    end
end);

RegisterNetEvent('confiscatePlayerItemGouv', function(target, itemType, itemName, amount)
    local source = source
    local XPlayer = ESX.GetPlayerFromId(source)
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source,'(confiscatePlayerItemGouv)');
    else
        if (#(GetEntityCoords(targetPed) - GetEntityCoords(ped)) < 4.0) then
            if itemType == 'item_standard' then
                local targetItem = targetXPlayer.getInventoryItem(itemName)
                local sourceItem = sourceXPlayer.getInventoryItem(itemName)

                if (targetItem and targetItem.count >= amount) then
                    if (sourceXPlayer.canCarryItem(itemName, amount)) then
                        targetXPlayer.removeInventoryItem(itemName, amount);
                        sourceXPlayer.addInventoryItem(itemName, amount);
                        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqu� "..exports.Tree:serveurConfig().Serveur.color..""..amount..' '..sourceItem.label.."~s~.")
                        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris "..exports.Tree:serveurConfig().Serveur.color..""..amount..' '..sourceItem.label.."~s~.")
                        SendLogs("Gouv", exports.Tree:serveurConfig().Serveur.label.." | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
                    else
                        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez de place dans votre inventaire.");
                    end
                end
            end
                
            if itemType == 'item_account' then
                local targetAccount = targetXPlayer.getAccount(itemName)
                if (targetAccount and targetAccount.money >= amount) then
                    targetXPlayer.removeAccountMoney(itemName, amount);
                    sourceXPlayer.addAccountMoney(itemName, amount);
                    
                    TriggerClientEvent("esx:showNotification", source, "Vous avez confisqu� "..exports.Tree:serveurConfig().Serveur.color..""..amount.."$ ~s~argent non d�clar�~s~.");
                    TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris "..exports.Tree:serveurConfig().Serveur.color..""..amount.."$ ~s~argent non d�clar�~s~.");
                    SendLogs("Gouv", exports.Tree:serveurConfig().Serveur.label.." | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
                end
            end
        
            if itemType == 'item_weapon' then
                targetXPlayer.removeWeapon(itemName, 0);
                sourceXPlayer.addWeapon(itemName, amount);
                SendLogs("Gouv", exports.Tree:serveurConfig().Serveur.label.." | Gouv", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.PoliceJobLogs)

            end
        end
    end
end);

ESX.RegisterServerCallback('getOtherPlayerDataPolice', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, exports.Tree:serveurConfig().Serveur.color.."~Quelqu'un vous fouille")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)


ESX.RegisterServerCallback('getVehicleInfos', function(source, cb, plate)
    local _source = source
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		if result[1] then
            local retrivedInfo = {plate = plate}
            local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)
            retrivedInfo.owner = xPlayer.getFirstName().." "..xPlayer.getLastName()
            cb(retrivedInfo)
		else
			cb(retrivedInfo)
		end
	end)
end)


RegisterNetEvent('babyboy:amendeForVehicle')
AddEventHandler('babyboy:amendeForVehicle', function(plate)
    local _source = source
    local plate = plate

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		if result[1] then
            MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
                {
                    ['@identifier']  = result[1].owner,
                    ['@sender']      = "license:9e1c0d102aaa47c0b874f2276063395ad59e82d1",
                    ['@target_type'] = 'player',
                    ['@target']      = "police",
                    ['@label']       = "Stationnement",
                    ['@amount']      = 500,
                }, function() 
            end)
		end
	end)
end)


RegisterNetEvent("police:SendFacture", function(target, price)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(police:SendFacture)');
        return
	end

    local society = ESX.DoesSocietyExist("police");
    local xTarget = ESX.GetPlayerFromId(target);
    -- if (price <= xTarget.getAccount("bank").money) then
        if (society) then
            local xTarget = ESX.GetPlayerFromId(target);
            if (xTarget) then
                xTarget.removeAccountMoney('bank', price);
                ESX.AddSocietyMoney("police", price);
                xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.");
                xPlayer.showNotification("Vous avez donné une amende de "..price.."~g~$~s~");

                local link = exports.Tree:serveurConfig().Logs.PoliceJobLogs
                local local_date = os.date('%H:%M:%S', os.time())
                local content = {
                    {
                        ["title"] = "**Envoie facture :**",
                        ["fields"] = {
                            { name = "**- Date & Heure :**", value = local_date},
                            { name = "- Receveur :", value = xPlayer.name.." ["..xPlayer.identifier.."]"},
                            { name = "- Envoyeur :", value = xTarget.name.." ["..xTarget.identifier.."]"},
                            { name = "- Information facture :", value = "Entreprise : `LSPD`\nMontant de la facture : `"..price },
        
                        },
                        ["type"]  = "rich",
                        ["color"] = 7615135,
                        ["footer"] =  {
                        ["text"] = exports.Tree:serveurConfig().Serveur.label.." - LOGS",
                        },
                    }
                }
                PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Facture", embeds = content}), { ['Content-Type'] = 'application/json' })
            end
        end
    -- else
    --     xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."La personne n'a pas assez d'argent !");
    --     xTarget.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez d'argent !");
    -- end
end);

ESX.RegisterServerCallback('fpolice:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('babyboy:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fib', function(inventory)
		cb(inventory.items)
	end)
end)


RegisterNetEvent('fpolice:getStockItem')
AddEventHandler('fpolice:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(fpolice:getStockItem)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a retir� "..count.." "..inventoryItem.." du coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
		else
			TriggerClientEvent('esx:showNotification', _source, "<C>Quantit� invalide")
		end
	end)
end)

RegisterNetEvent('babyboy:getStockItem')
AddEventHandler('babyboy:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source,'(babyboy:getStockItem)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fib', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a retir� "..count.." "..inventoryItem.." du coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
		else
			TriggerClientEvent('esx:showNotification', _source, "<C>Quantit� invalide")
		end
	end)
end)

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

RegisterNetEvent('fpolice:putStockItems')
AddEventHandler('fpolice:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(fpolice:putStockItems)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

        if sourceItem then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            logsItemDestroy("[Destruction Item - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..inventoryItem.label.." x"..count, exports.Tree:serveurConfig().Logs.PoliceJobLogs)
            TriggerClientEvent('esx:showNotification', _source, "Objet d�pos� "..count.." "..inventoryItem.label.."");
            rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a d�pos� "..count.." "..inventoryItem.label.." dans le coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
        else
            TriggerClientEvent('esx:showNotification', _source, "Quantit� invalide")
        end
	end)
end)

RegisterNetEvent('babyboy:deleteMoney')
AddEventHandler('babyboy:deleteMoney', function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = pSociety.GetSociety(society)
	local amount = ESX.Math.Round(tonumber(amount))
	local money = ESX.Math.GroupDigits(amount)..""..pSociety.Trad["money_symbol"]

	if xPlayer.job.name == "police" or xPlayer.job.name == "fib" or xPlayer.job.name == "bcso" then
		if amount > 0 and xPlayer.getAccount('dirtycash').money >= amount then
			xPlayer.removeAccountMoney('dirtycash', amount)
			xPlayer.showNotification("~g~Vous avez détruie "..amount.."$");
            logsSaleSaisie("[Destruction Argent - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..amount.."$", exports.Tree:serveurConfig().Logs.PoliceJobLogs)

		else
			TriggerClientEvent("RageUIv1:Popup", source, "Montant invalide !")
		end
	else
        TriggerEvent("tF:Protect", source, "(babyboy:deleteMoney)")
	end
end)

RegisterNetEvent('babyboy:putStockItems')
AddEventHandler('babyboy:putStockItems', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
    if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source,'(babyboy:putStockItems)');
        return
	end
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_fib', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

        if sourceItem then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('esx:showNotification', _source, "Objet déposé "..count.." "..inventoryItem.label.."");
            rxeLogsDiscord("[COFFRE] "..xPlayer.getName().." a déposé "..count.." "..inventoryItem.label.." dans le coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
        else
            TriggerClientEvent('esx:showNotification', _source, "Quantit� invalide")
        end
	end)
end)

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

ESX.RegisterServerCallback('policejob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('babyboy:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_fib', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('policejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)

        logsWeaponDestroy("[Destruction Armes - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..") - "..xPlayer.job.label.." - "..xPlayer.job.grade_name.."\n\n**Viens de détruire :** "..weaponName, exports.Tree:serveurConfig().Logs.PoliceJobLogs)

		rxeLogsDiscord("[COFFRE ARMES] "..xPlayer.getName().." a d�pos� "..weaponName.." du coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('babyboy:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
		rxeLogsDiscord("[COFFRE ARMES] "..xPlayer.getName().." a d�pos� "..weaponName.." du coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_fib', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('babyboy:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 0)
	rxeLogsDiscord("[COFFRE ARMES FIB] "..xPlayer.getName().." a retir� "..weaponName.." du coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_fib', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('policejob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 0)
	rxeLogsDiscord("[COFFRE ARMES POLICE] "..xPlayer.getName().." a retir� "..weaponName.." du coffre", exports.Tree:serveurConfig().Logs.PoliceJobLogs)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_police', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('fpolice:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('babyboy:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

function rxeLogsDiscord(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "Coffre LSPD & FIB",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs Police", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logToDiscordPolice(name,message,color)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = exports.Tree:serveurConfig().Logs.PoliceJobLogs

    local embeds = {
        {
            ["title"]= message,
            ["type"]= "rich",
            ["color"] = color,
            ["footer"]=  {
                ["text"]= "Heure: " ..local_date,
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logToDiscordGouv(name,message,color)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = exports.Tree:serveurConfig().Logs.PoliceJobLogs

    local embeds = {
        {
            ["title"]= message,
            ["type"]= "rich",
            ["color"] = color,
            ["footer"]=  {
                ["text"]= "Heure: " ..local_date,
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('tF_policejob:putInVehicle')
AddEventHandler('tF_policejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('tF_policejob:putInVehicle', target)
    end
end)

RegisterNetEvent('tF_policejob:handcuff')
AddEventHandler('tF_policejob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' then
		TriggerClientEvent('tF_policejob:handcuff', target)
    end
end)

RegisterNetEvent('tF_policejob:OutVehicle')
AddEventHandler('tF_policejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'police' then
		TriggerClientEvent('tF_policejob:OutVehicle', target)
    end
end)

RegisterServerEvent('addGilet:police')
AddEventHandler('addGilet:police', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(addGilet:police)');
        return
	end

    local nameItem = "kevlar"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(470.80, -971.34, 23.93));

    if (distance < 35.0) then
        if ItemSource then
            TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous possédez déjà ceci.")
        else
            xPlayer.addInventoryItem(nameItem, 1);
        end
    else
        TriggerEvent("tF:Protect", source,'(addGilet:police) Zone');
        return
    end
end)


RegisterServerEvent('addChargeur:police')
AddEventHandler('addChargeur:police', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(addChargeur:police)');
        return
	end

    local nameItem = "clip"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(470.79, -971.34, 23.93));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addChargeur:police) Zone');
        return
    end
end)

RegisterServerEvent('addMunitions:police')
AddEventHandler('addMunitions:police', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(addMunitions:police)');
        return
	end

    local nameItem = "munitions"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(-1098.93, -826.18, 14.28));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addMunitions:police) Zone');
        return
    end
end)

local itemsSearch = {
    'coke',
    'coke_pooch',
    'ketamine',
    'pooch_ketamine',
    'xylazine',
    'xylazine_pooch',
    'opium',
    'opium_pooch',
    'meth',
    'meth_pooch',
    'weed',
    'weed_pooch',
}



RegisterNetEvent("police:checkDrug", function(player)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(player)

    if xPlayer.job.name ~= 'police' then
        TriggerEvent("tF:Protect", source,'(police:checkDrug)');
        return
    end
    if xTarget then
        local hasDrugs = false
        for i = 1, #itemsSearch do
            local item = xTarget.getInventoryItem(itemsSearch[i])
            if item and item.count > 0 then
                hasDrugs = true
                break
            end
        end
        if hasDrugs then 
            xPlayer.showNotification("~g~Le chien sent une odeur de drogue sur la personne.")
        else
            xPlayer.showNotification("~r~Le chien ne sent pas d'odeur de drogue sur la personne.")
        end
    end
end)


function logsWeaponDestroy(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 376818,
            ["footer"]=  {
                ["text"]= "Powered for "..exports.Tree:serveurConfig().Serveur.label.." © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsItemDestroy(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 376818,
            ["footer"]=  {
                ["text"]= "Powered for "..exports.Tree:serveurConfig().Serveur.label.." © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function logsSaleSaisie(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 15869189,
            ["footer"]=  {
                ["text"]= "Powered for "..exports.Tree:serveurConfig().Serveur.label.." © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsAmmu(message,url)
    local local_date = os.date('%H:%M:%S', os.time())
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"] = message,
            ["type"] ="rich",
            ["color"] = 2061822,
            ["footer"] =  {
                ["text"] = "Powered for "..exports.Tree:serveurConfig().Serveur.label.." © |  "..local_date.."",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end




local ObjectPolice = {}

RegisterNetEvent('Gamemode:Police:AddProps')
AddEventHandler('Gamemode:Police:AddProps', function(netId)
    table.insert(ObjectPolice, netId)
end)

RegisterNetEvent('Gamemode:Police:RemoveProps')
AddEventHandler('Gamemode:Police:RemoveProps', function(netId)
    for index, ObjId in pairs(ObjectPolice) do
        if (ObjId == netId) then
            table.remove(ObjectPolice, index)
        end
    end
end)


ESX.RegisterServerCallback('GetAllPropsPolice', function(source, cb)
    cb(ObjectPolice)
end)


RegisterNetEvent("Police:ShotFire", function(coords)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    if not xPlayer then 
        return 
    end
    for i = 1, #xPlayers do
        local xTarget = ESX.GetPlayerFromId(xPlayers[i])
        if xTarget.job.name == 'police' then
            TriggerClientEvent("Police:ShotFire", xPlayers[i], coords)
        end
    end
end)