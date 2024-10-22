RegisterServerEvent('gouv:payWeapon')
AddEventHandler('gouv:payWeapon', function(name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "gouv" then
        TriggerEvent("tF:Protect", source, '(gouv:payWeapon)');
        return
    end

    name = string.lower(name)

    if (xPlayer.canCarryItem(name, 1)) then
        xPlayer.addWeapon(name, 255, { antiActions = 'police', removeReboot = true })
    else
        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas de place sur vous !")
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (not xPlayer) then return; end

    xPlayer.removeWeaponSystem("weapon_stungun")
    xPlayer.removeWeaponSystem("weapon_combatpistol")
    xPlayer.removeWeaponSystem("weapon_carbinerifle")
    xPlayer.removeWeaponSystem("weapon_advancedrifle")
    xPlayer.removeWeaponSystem("weapon_combatshotgun")
    xPlayer.removeInventoryItem("jumelles", 1)
end)

AddEventHandler('playerDropped', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (not xPlayer) then return; end

    xPlayer.removeWeaponSystem("weapon_stungun")
    xPlayer.removeWeaponSystem("weapon_combatpistol")
    xPlayer.removeWeaponSystem("weapon_carbinerifle")
    xPlayer.removeWeaponSystem("weapon_advancedrifle")
    xPlayer.removeWeaponSystem("weapon_combatshotgun")
    xPlayer.removeInventoryItem("jumelles", 1)
end)

RegisterServerEvent('gouv:payItem')
AddEventHandler('gouv:payItem', function(name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "gouv" then
        TriggerEvent("tF:Protect", source, '(gouv:payWeapon)');
        return
    end

    name = string.lower(name)

    if (xPlayer.canCarryItem(name, 1)) then
        xPlayer.addInventoryItem(name, 1)
        -- xPlayer.addWeapon(name, 255, { antiActions = 'police', removeReboot = true })
    else
        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas de place sur vous !")
    end
end)

RegisterServerEvent('addChargeur:gouv')
AddEventHandler('addChargeur:gouv', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source,'(addChargeur:gouv)');
        return
	end

    local nameItem = "clip"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(-401.72, 1088.16, 334.90));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addChargeur:gouv) Zone');
        return
    end
end)


RegisterServerEvent('addMunitions:gouv')
AddEventHandler('addMunitions:gouv', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source,'(addMunitions:gouv)');
        return
	end

    local nameItem = "munitions"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(-401.72, 1088.16, 334.90));

    if (distance < 35.0) then
        xPlayer.addInventoryItem(nameItem, 1);
    else
        TriggerEvent("tF:Protect", source,'(addMunitions:gouv) Zone');
        return
    end
end)



RegisterServerEvent('addGilet:gouv')
AddEventHandler('addGilet:gouv', function()
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'gouv' then
        TriggerEvent("tF:Protect", source, '(addGilet:gouv)');
        return
	end

    local nameItem = "kevlar"
	local ItemSource = xPlayer.getInventoryItem(nameItem)
    
    local coords = GetEntityCoords(GetPlayerPed(source));
    local distance = #(coords - vector3(-401.72, 1088.16, 334.90));

    if (distance < 35.0) then
        if ItemSource then
            TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous possédez déjà ceci.")
        else
            xPlayer.addInventoryItem(nameItem, 1);
        end
    else        
        TriggerEvent("tF:Protect", source, '(addGilet:gouv) Zone');
        return
    end
end)