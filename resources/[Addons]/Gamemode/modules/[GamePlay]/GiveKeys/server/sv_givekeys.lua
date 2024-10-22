MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM open_car WHERE NB = @NB', {
		['@NB'] = 2
	})
end)


RegisterServerEvent('babyboy:GiveDoubleKeys')
AddEventHandler('babyboy:GiveDoubleKeys', function(target, plate)
	local _source = source
	local xPlayer

	if target ~= 'no' then
		xPlayer = ESX.GetPlayerFromId(target)
	else
		xPlayer = ESX.GetPlayerFromId(_source)
	end

	MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate,
		['@NB'] = 2
	}, function()
		ESX.GiveCarKey(xPlayer, plate, true);
        -- xPlayer.showNotification("Vous avez recu un double de clés !");
	end)

    -- Pour give le double des clé : TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
end)


RegisterServerEvent('babyboy:DeleteDoubleKeys')
AddEventHandler('babyboy:DeleteDoubleKeys', function(target, plate)
	local _source = source
	local xPlayer

	if target ~= 'no' then
		xPlayer = ESX.GetPlayerFromId(target)
	else
		xPlayer = ESX.GetPlayerFromId(_source)
	end

	MySQL.Async.execute('DELETE INTO open_car WHERE plate = @plate', {
		['@plate'] = plate,
	}, function()
		exports['JustGod']:RemoveCarKey(plate, true)

		-- ESX.GiveCarKey(xPlayer, plate, true);
        -- xPlayer.showNotification("Vous avez recu un double de clés !");
	end)

    -- Pour give le double des clé : TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
end)