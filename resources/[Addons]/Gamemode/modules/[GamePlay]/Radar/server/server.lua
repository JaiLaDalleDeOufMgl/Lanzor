

Locale   = 'fr'

Radars = {
    { station = 1, name = 'Commissariat', speedlimit = 80, r = 35, flash = { x = 398.1266, y = -1050.5014, z = 29.3957 }, props = { x = 419.1470, y = -1033.5052, z = 28.48 } },
    { station = 2, name = 'Benny\'s', speedlimit = 80, r = 40, flash = { x = -270.3585, y = -1139.8244, z = 23.0982 }, props = { x = -247.8916, y = -1125.0645, z = 18.84 } },
    { station = 3, name = 'San Andreas Avenue', speedlimit = 80, r = 40, flash = { x = -251.4578, y = -661.6170, z = 33.2561 }, props = { x = -232.1231, y = -650.5041, z = 32.27 } },
    { station = 4, name = 'Base Militaire', speedlimit = 130, r = 40, flash = { x = -2567.9621, y = 3362.5593, z = 13.3978 }, props = { x = -2551, y = 3369.9814, z = 13.52 }  },
}

RegisterNetEvent('esx_radars:sendBill', function(speed, sharedAccountName, label, amount)
	local _source = source
	local xTarget = ESX.GetPlayerFromId(_source)

	if xTarget.job ~= nil and xTarget.job.name ~= 'police' and xTarget.job.name ~= 'ambulance' then

		local society = ESX.DoesSocietyExist(sharedAccountName);

		if (society) then

			if amount < 0 then
				-- print('esx_radars: ' .. GetPlayerName(_source) .. ' tried sending a negative bill!')
			else
				if (xTarget) then
					MySQL.Async.execute(
						'INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
						{
							['@identifier']  = xTarget.identifier,
							['@sender']      = 'steam:RADARS_AUTO',
							['@target_type'] = 'society',
							['@target']      = sharedAccountName,
							['@label']       = label,
							['@amount']      = amount
						},
						function(rowsChanged)
							TriggerClientEvent('esx:showNotification', xTarget.source, _U('received_invoice', amount))
						end
					)
				end

			end

		end

		if (speed > 50) then
			RemoveDriveLicense(xTarget.identifier)
			TriggerClientEvent('esx:showNotification', xTarget.source, _U('remove_dmv'))
		end

	else
		TriggerClientEvent('esx:showNotification', xTarget.source, _U('employer_notified'))
	end
end)

RegisterNetEvent("police:SendFactureRadar", function(price)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local society = ESX.DoesSocietyExist("police");
	if (society) then
		local bank = xPlayer.getAccount('bank');
		if (bank and bank.money) then
			xPlayer.removeAccountMoney('bank', price);
			ESX.AddSocietyMoney("police", price);
			xPlayer.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.");
		end
	end
end)