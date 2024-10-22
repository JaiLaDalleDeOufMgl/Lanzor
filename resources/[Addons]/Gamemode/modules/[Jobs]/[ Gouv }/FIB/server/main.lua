RegisterServerEvent('demande:Fbi')
AddEventHandler('demande:Fbi', function(coords, raison)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
    if xPlayer.job.name == 'fib' then
        for i = 1, #xPlayers, 1 do
            local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
            if thePlayer.job.name == 'fib' then
                TriggerClientEvent('FIB:renfortsetBlip', xPlayers[i], coords, raison)
            end
        end
    else
        TriggerEvent("tF:Protect", source, '(demande)');
    end
end)

ESX.RegisterServerCallback('getOtherPlayerDataFBI', function(source, cb, target, notify)
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

ESX.RegisterServerCallback('FBI:getVehicleInfos', function(source, cb, plate)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'fib' then
            TriggerEvent("tF:Protect", source, '(FBI:getVehicleInfos)')
            return
        end

        MySQL.Async.fetchAll('SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(result)

            local retrivedInfo = {
                plate = plate
            }

            if result[1] then
                MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
                    ['@identifier'] = result[1].owner
                }, function(result2)

                    retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname

                    retrivedInfo.vehicle = json.decode(result[1].vehicle)

                    cb(retrivedInfo)

                end)
            else
                cb(retrivedInfo)
            end
        end)
    end
end)

RegisterNetEvent('FBI:ConfiscatePlayerItem', function(target, itemType, itemName, amount)
    local source = source
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    if (not sourceXPlayer or not targetXPlayer) then return end

    local ped = GetPlayerPed(sourceXPlayer.source);
    local targetPed = GetPlayerPed(targetXPlayer.source);

    if sourceXPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source, '(confiscatePlayerItem)');
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
                        SendLogsOther("FIB", exports.Tree:serveurConfig().Serveur.label.." | FIB", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre un item "..amount.." "..sourceItem.label.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.FIBLogsJob)
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
                    SendLogsOther("FIB", exports.Tree:serveurConfig().Serveur.label.." | FIB", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre de l'argent "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.FIBLogsJob)
                end
            end
        
            if itemType == 'item_weapon' then
                targetXPlayer.removeWeapon(itemName, 0);
                sourceXPlayer.addWeapon(itemName, 255)
                SendLogsOther("FIB", exports.Tree:serveurConfig().Serveur.label.." | FIB", "Le joueur **"..sourceXPlayer.name.."** (***"..sourceXPlayer.identifier.."***) vient de prendre une arme "..amount.." "..itemName.." sur le joueur **"..targetXPlayer.name.."** (***"..targetXPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.FIBLogsJob)
            end
        end
    end
end);

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------



RegisterServerEvent("DEN:AddeIntoVehicle")
AddEventHandler("DEN:AddeIntoVehicle", function(target,vehicle)
    local source = source
    --local Svehicle = NetworkGetEntityFromNetworkId(vehicle)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source, '(AddeIntoVehicle)');
    else
        
        TriggerClientEvent("DEN:AddedInVehicle", xTarget.source, vehicle)
    end
end)

RegisterServerEvent('addJumelles:fib')
AddEventHandler('addJumelles:fib', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source, '(addJumelles:fib)');
        return
	end

    local nameItem = "jumelles"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(2521.207, -336.6898, 101));

    if (distance < 35.0) then
        if ItemSource then
            TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous possédez déjà ceci.")
        else
            xPlayer.addInventoryItem(nameItem, 1);
        end
    else        
        TriggerEvent("tF:Protect", source, '(addJumelles:fib) Zone');
        return
    end
end)

RegisterServerEvent('addChargeur:fib')
AddEventHandler('addChargeur:fib', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source,'(addChargeur:fib)');
        return
	end

    local nameItem = "clip"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(2521.207, -336.6898, 101));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addChargeur:fib) Zone');
        return
    end
end)

RegisterServerEvent('addGilet:fib')
AddEventHandler('addGilet:fib', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source, '(addGilet:fib)');
        return
	end

    local nameItem = "kevlar"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(2521.207, -336.6898, 101));

    if (distance < 35.0) then
        if not ItemSource then
            TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous possédez déjà ceci.")
        else
            xPlayer.addInventoryItem(nameItem, 1);
        end
    else        
        TriggerEvent("tF:Protect", source, '(addGilet:fib) Zone');
        return
    end
end)

RegisterServerEvent('addMunitions:fib')
AddEventHandler('addMunitions:fib', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source, '(addMunitions:fib)');
        return
	end

    local nameItem = "munitions"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(2521.207, -336.6898, 101));

    if (distance < 35.0) then
        if not ItemSource then
            TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous possédez déjà ceci.")
        else
            xPlayer.addInventoryItem(nameItem, 1);
        end
    else        
        TriggerEvent("tF:Protect", source, '(addMunitions:fib) Zone');
        return
    end
end)

RegisterServerEvent("DEN:OutVehicle")
AddEventHandler("DEN:OutVehicle", function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local xTargetPed = GetPlayerPed(xTarget.source)
    local OutCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
    if xPlayer.job.name ~= 'fib' then
        TriggerEvent("tF:Protect", source, '(OutVehicle)');
    else
        SetEntityCoords(xTargetPed, OutCoords.x, OutCoords.y, OutCoords.z)
    end
end)

RegisterServerEvent('Space:Menotter')
AddEventHandler('Space:Menotter', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    
    if xPlayer.job.name ~= 'fib' then
        return
    end

    if (target ~= -1 and targetXPlayer) then
        if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 15.0 ) then
            -- TriggerClientEvent('Space:Menotter', target)
            TriggerClientEvent('menotterlejoueur', target)
		else
			TriggerEvent("tF:Protect", source, '(Space:Menotter)')
        end
    end
end)

RegisterServerEvent('Space:Escorter')
AddEventHandler('Space:Escorter', function(target)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
    
    if xPlayer.job.name ~= 'fib' then
        return
    end

    if (target ~= -1 and targetXPlayer) then
        if ( #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(target))) < 15.0 ) then
            -- TriggerClientEvent('Space:Escorter', target, source)
            TriggerClientEvent('actionescorter', target, source)
		else
			TriggerEvent("tF:Protect", source, '(Space:Escorter)')
        end
    end
end)

RegisterNetEvent('Space:spawnVehicle', function(model, position, heading)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name ~= 'fib' then
		TriggerEvent("tF:Protect", source, '(Space:spawnVehicle)');
		return
	end
end)

RegisterServerEvent('buyWeaponForFIB')
AddEventHandler('buyWeaponForFIB', function(weapon)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local coords = GetEntityCoords(GetPlayerPed(source));
	local distance = #(coords - vector3(2521.207, -336.6898, 100.8933));
	if xPlayer.job.name == 'fib' then
		if weapon == "weapon_stungun" or weapon == "weapon_flashlight" or weapon == "weapon_nightstick" or weapon == "weapon_combatpistol" or weapon == "weapon_carbinerifle" or weapon == "weapon_pumpshotgun" then
			if (distance < 35.0) then
				xPlayer.addWeapon(weapon, 255, { antiActions = 'police', removeReboot = true })
			else
				TriggerEvent("tF:Protect", source, '(buyWeaponForFIB_distance)');
			end
		else
			TriggerEvent("tF:Protect", source, '(buyWeaponForFIB_weapon)');
		end
	else
        TriggerEvent("tF:Protect", source, '(buyWeaponForFIB_job)');
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (not xPlayer) then return; end

    xPlayer.removeWeaponSystem("weapon_stungun")
    xPlayer.removeWeaponSystem("weapon_flashlight")
    xPlayer.removeWeaponSystem("weapon_nightstick")
    xPlayer.removeWeaponSystem("weapon_combatpistol")
    xPlayer.removeWeaponSystem("weapon_carbinerifle")
    xPlayer.removeWeaponSystem("weapon_pumpshotgun")
end)

AddEventHandler('playerSpawned', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (not xPlayer) then return; end

    xPlayer.removeWeaponSystem("weapon_stungun")
    xPlayer.removeWeaponSystem("weapon_flashlight")
    xPlayer.removeWeaponSystem("weapon_nightstick")
    xPlayer.removeWeaponSystem("weapon_combatpistol")
    xPlayer.removeWeaponSystem("weapon_carbinerifle")
    xPlayer.removeWeaponSystem("weapon_pumpshotgun")
end)