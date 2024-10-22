local ESX = getFramework()

Tree.RegisterServerCallback("tree:ammunation:getPPA", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = "weapon",
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end)


RegisterNetEvent("tree:ammunation:buyPPA", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getAccount('cash').money >= SharedAmmunation.pricePPA then
        xPlayer.removeAccountMoney('cash', SharedAmmunation.pricePPA)
        MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @identifier AND type = @type', {
            ['@identifier'] = xPlayer.identifier,
            ['@type'] = 'weapon'
        },function(result)
            Citizen.Wait(500)
            if result[1] then
                xPlayer.showNotification(Tree.Config.Serveur.color.."Vous avez déjà acheté le PPA !")
                return
            else
                MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
                    ['@type'] = 'weapon',
                    ['@owner'] = xPlayer.identifier
                })
                xPlayer.addInventoryItem('weapon', 1, { antiActions = true })
            end
        end)
    else
        xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
    end
end)

RegisterNetEvent("tree:ammunation:buyWeapon", function(v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if v.type == "weapon" then
        if xPlayer.getAccount('cash').money >= v.price then
            xPlayer.removeAccountMoney('cash', v.price)
            xPlayer.addWeapon(v.item, 250)
            xPlayer.showNotification("~g~Vous avez acheté un(e) x1 "..v.label)
        else
            xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
        end
    elseif v.type == "item" then
        if xPlayer.getAccount('cash').money >= v.price then
            xPlayer.removeAccountMoney('cash', v.price)
            xPlayer.addInventoryItem(v.item, 1)
            xPlayer.showNotification("~g~Vous avez acheté un(e) x1 "..v.label)
        else
            xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
        end
    end
end)

RegisterServerEvent('tree:ammunation:removeClip')
AddEventHandler('tree:ammunation:removeClip', function(ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)

	TriggerEvent('Gamemode:Inventory:AddWeaponAmmo', false, ammo, source)
end)

RegisterServerEvent('tree:ammunation:removeMunitions')
AddEventHandler('tree:ammunation:removeMunitions', function(ammo)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('munitions', 1)
end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('tree:ammunation:useClip', source)
end)

ESX.RegisterUsableItem('munitions', function(source)
	TriggerClientEvent('tree:ammunation:useMunitions', source)
end)


