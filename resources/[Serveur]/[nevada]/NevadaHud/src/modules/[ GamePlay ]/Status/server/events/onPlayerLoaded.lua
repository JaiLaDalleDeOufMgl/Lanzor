AddEventHandler('esx:playerLoaded', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
	}, function(result)
		local data = {}


		if result[1].status then
			data = json.decode(result[1].status)
		end

		if (data == nil) then return end

		xPlayer.set('status', data)

		TriggerClientEvent('Gamemode:Status:SetStatus', _source, data)
	end)
end)