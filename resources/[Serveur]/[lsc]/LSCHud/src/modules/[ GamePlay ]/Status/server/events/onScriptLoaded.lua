CreateThread(function()
	Wait(1000)

	local players = ESX.GetPlayers()

	for _,playerId in ipairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		MySQL.Async.fetchAll('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			local data = {}

			if result[1].status then
				data = json.decode(result[1].status)
			end

			if (data == nil) then return end

			xPlayer.set('status', data)

			TriggerClientEvent('Gamemode:Status:SetStatus', xPlayer.source, data)
		end)
	end
end)