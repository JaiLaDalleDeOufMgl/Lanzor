


-- Chaque reboot retour au garage
MySQL.ready(function()
	MySQL.Async.execute('UPDATE owned_vehicles SET state = true WHERE state = false', {})
end)

-- test
RegisterServerEvent('garage:modifyRangeState')
AddEventHandler('garage:modifyRangeState', function(vehicle, state)
	--local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(ESX.GetIdentifierFromId(source))
	local state = state
	local plate = vehicle.plate
	if plate ~= nil then
		plate = plate:gsub("^%s*(.-)%s*$", "%1")
	end
	for _,v in pairs(vehicules) do
		if v.plate == plate then
			MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
			break
		end
	end
end)

ESX.RegisterServerCallback('garage:getVehicles', function(source, cb)
	--local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE type='car' AND  owner = @owner",{['@owner'] = ESX.GetIdentifierFromId(source)}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, state = v.state, plate = v.plate})
		end
		cb(vehicules)
	end)
end)

RegisterServerEvent('garage:modifyState')
AddEventHandler('garage:modifyState', function(vehicle, state)
	local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = getPlayerVehicles(ESX.GetIdentifierFromId(source))
	local state = state
	local plate = vehicle.plate
	if plate ~= nil then
		plate = plate:gsub("^%s*(.-)%s*$", "%1")
	end
	for _,v in pairs(vehicules) do
		if v.plate == plate then
			MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate})
			break
		end
	end
end)

ESX.RegisterServerCallback('garage:GetOutVehicles',function(source, cb)	
	--local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier AND state=false",{['@identifier'] = ESX.GetIdentifierFromId(source)}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicules, {vehicle = vehicle, plate = v.plate})
		end
		cb(vehicules)
	end)
end)

function getPlayerVehicles(identifier)
	
	local vehicles = {}
	local data = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier})	
	for _,v in pairs(data) do
		local vehicle = json.decode(v.vehicle)
		table.insert(vehicles, {id = v.id, plate = v.plate})
	end
	return vehicles
end

--ranger véhicule
ESX.RegisterServerCallback('garage:RangeVehicle', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			--if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
					cb(true)
					-- print(json.encode(vehicleProps))
				end)
			--else
				--print(('garage:: %s Tentative de chat! Tente de ranger: ' .. vehiclemodel .. '. Voiture d\'origine: '.. originalvehprops.model):format(xPlayer.identifier))
				--cb(false)
			--end
		else
			cb(false)
		end
	end)
end)

--verif si joueur a les sous pour fourriere
ESX.RegisterServerCallback('garage:moneyCheck', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getAccount('cash').money >= 500 then
		cb(true)
	else
		cb(false)
	end
end)

--fait payer joueur pour fourriere
RegisterServerEvent('garage:fourrierePay')
AddEventHandler('garage:fourrierePay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('cash', 2500)
	TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Fourriere~s~\nVoici votre véhicule (-~g~" .. 2500 .."$~s~)")
end)

--fait payer joueur pour GARAGE
RegisterServerEvent('garage:garagePay')
AddEventHandler('garage:garagePay', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('cash', 500)
	TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Garage~s~\nVoici votre véhicule (-~g~" .. 500 .."$~s~)")
end)