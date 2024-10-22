

local cooldown = {} 
local local_date = os.date('%H:%M:%S', os.time())

RegisterNetEvent('ambulance:reaPrison', function(player)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	if (target == -1) then
        DropPlayer(source, "Use trigger :)")
    end
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(1751.59, 2481.67, 45.81)) > 100.0 then 
        TriggerEvent("tF:Protect", source, '(ambulance:reaPrison)');
        return
    end
    if cooldown[source] and os.time() - cooldown[source] < 300 then
		xPlayer.showNotification("Veuillez attendre avant d'utiliser cette fonction à nouveau")
        return
    end
    cooldown[source] = os.time()
	TriggerClientEvent('ambulance:revive', player)
end)

RegisterServerEvent('annonce:serviceAmbulance')
AddEventHandler('annonce:serviceAmbulance', function(status)

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

	local haveBandages = xPlayer.getInventoryItem('bandage')
	local haveMedi = xPlayer.getInventoryItem('medikit')
	if status == "fin" then

		if haveMedi then
			local numberMedKit = haveMedi.count
			if haveMedi.count >= 1 then
				xPlayer.removeInventoryItem('medikit', numberMedKit)
			end
		end

		if haveBandages then
			local numberBandage = haveBandages.count
			if haveBandages.count >= 1 then
				xPlayer.removeInventoryItem('bandage', numberBandage)
			end
		end

		RemoveCountEmsInService(source)
	elseif (status == "prise") then
		AddCountEmsInService(source)
	end

	if (xPlayer) then
		if xPlayer.job.name ~= "ambulance" then
			TriggerEvent("tF:Protect", source, '(annonce:serviceAmbulance)')
			return
		end

		for i = 1, #xPlayers, 1 do
			local ThePlayers = ESX.GetPlayerFromId(xPlayers[i])
			if (ThePlayers) then
				if ThePlayers.job.name == 'ambulance' then
					TriggerClientEvent('ambulance:InfoService', xPlayers[i], status, xPlayer.name)
				end
			end
		end
	end
end)

RegisterServerEvent('ambulance:deleteCall')
AddEventHandler('ambulance:deleteCall', function(k)

    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

	if (xPlayer) then
		if xPlayer.job.name ~= "ambulance" then
			TriggerEvent("tF:Protect", source, '(ambulance:deleteCall)')
			return
		end
	
		for i = 1, #xPlayers, 1 do
			local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
			if thePlayer.job.name == 'ambulance' then
				TriggerClientEvent('isInServiceCheck', xPlayers[i], "-")
				TriggerClientEvent('ambulance:deleteAppel', xPlayers[i], k)
			end
		end
	end
end)

RegisterServerEvent('updateCall')
AddEventHandler('updateCall', function(appelsdesmorts, playerDead)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()

	if (xPlayer) then
		if xPlayer.job.name ~= "ambulance" then
			TriggerEvent("tF:Protect", source, '(ambulance:deleteCall)')
			return
		end
	
		for i = 1, #xPlayers, 1 do
			local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
			if thePlayer.job.name == 'ambulance' then
				for k,v in pairs(appelsdesmorts) do
					if v.playerDead == playerDead then
						TriggerClientEvent('isInServiceCheck', xPlayers[i], "-")
						v.NameOfJoueurs = xPlayer.getFirstName().." "..xPlayer.getLastName()
						TriggerClientEvent('ambulance:updateCall', xPlayers[i], appelsdesmorts)
					end
				end
			end
		end

		local content = {
			{
				["title"] = "**__Prise Appelle__**",
				["fields"] = {
					{ name = "**- Date & Heure :**", value = local_date },
					{ name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." | "..xPlayer.name },
				},
				["type"]  = "rich",
				["color"] = 16711680,
				["footer"] =  {
					["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
				},
			}
		}
		PerformHttpRequest(exports.Tree:serveurConfig().Logs.AmbulanceJobLogs, function(err, text, headers) end, 'POST', json.encode({username = "Logs Appelle", embeds = content}), { ['Content-Type'] = 'application/json' })

	end
end)

RegisterServerEvent("babyboy:sendMessageToAccepte")
AddEventHandler("babyboy:sendMessageToAccepte", function(playerDead, dist)
	local playerDead = playerDead
	local distance = math.ceil(dist)
	TriggerClientEvent('esx:showNotification', playerDead, "~s~Un EMS a pris votre appelle ! Distance : "..distance.."m")
end)

RegisterServerEvent('ambulance:sendnotification')
AddEventHandler('ambulance:sendnotification', function(type, args)

  	local source = source

	if type ~= nil then

		if type == 'guns' then

			TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Cette personne a été tuée par une arme à feu, précisément: "..args)

		end
		
	end

end)

RegisterServerEvent('ambulance:healsomeone')
AddEventHandler('ambulance:healsomeone', function(player, type)
		
	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer) then

		if xPlayer.job.name ~= "ambulance" then

			TriggerEvent("tF:Protect", source, '(ambulance:healsomeone)')

			return

		end

		local hasBandages = xPlayer.getInventoryItem('bandage')
		local hasMedi = xPlayer.getInventoryItem('medikit')

		if type == 'small' then

			if hasBandages.count >= 1 then

				TriggerClientEvent('ambulance:heal', player, type)

				TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous avez soigné votre patient.")

				xPlayer.removeInventoryItem('bandage', 1)

			else

				TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas de bandage sur vous")

			end

		elseif type == 'big' then

			if hasMedi.count >= 1 then

				TriggerClientEvent('ambulance:heal', player, type)

				TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous avez soigné votre patient.")

				xPlayer.removeInventoryItem('bandage', 1)

			else

			TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas de kit de soin sur vous")

			end

		end

	end

end)

RegisterNetEvent('ambulance:spawnVehicle', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer) then
		if xPlayer.job.name ~= 'ambulance' then
			TriggerEvent("tF:Protect", source, '(ambulance:spawnVehicle)')
			return
		end
	end
end)

RegisterNetEvent('ambulance:sendBill', function(player, price)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer) then
		if xPlayer.job.name ~= "ambulance" then
			TriggerEvent("tF:Protect", source, '(ambulance:sendBill)')
			return
		end
		TriggerClientEvent('ambulance:revive', player)
		local xTarget = ESX.GetPlayerFromId(player)
		if (xTarget) then
			xTarget.removeAccountMoney('bank', price)
			ESX.AddSocietyMoney("ambulance", price)
			xTarget.showNotification("Votre compte en banque à été réduit de "..price.."~g~$~s~.")
			xPlayer.showNotification("~g~Vous avez reçu un paiement de "..price.."$")
			local source = ESX.GetPlayerFromId(player)
			local content = {
				{
					["title"] = "**__Facture F6__**",
					["fields"] = {
						{ name = "**- Date & Heure :**", value = local_date },
						{ name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." | "..xPlayer.name },
						{ name = "- Montant facture :", value = "+"..price.."$"}
					},
					["type"]  = "rich",
					["color"] = 16711680,
					["footer"] =  {
						["text"] = "By Kabylee | "..exports.Tree:serveurConfig().Serveur.label,
					},
				}
			}
			PerformHttpRequest(exports.Tree:serveurConfig().Logs.AmbulanceJobLogs, function(err, text, headers) end, 'POST', json.encode({username = "Logs Facture", embeds = content}), { ['Content-Type'] = 'application/json' })
		end
	end
end)

RegisterNetEvent('ambulance:réanimer', function(player)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer) then
		if xPlayer.job.name ~= "ambulance" then
			TriggerEvent("tF:Protect", source, '(ambulance:réanimer)')
			return
		end
		local hasMedi = xPlayer.getInventoryItem('medikit')
		if hasMedi then
			TriggerClientEvent('ambulance:revive', player)
			xPlayer.removeInventoryItem('medikit', 1)
			xPlayer.showNotification("Réanimation effectuée, Facture envoyé !")
			local society = ESX.DoesSocietyExist("ambulance")
			if (society) then
				local xTarget = ESX.GetPlayerFromId(player)
				if (xTarget) then
					xTarget.removeAccountMoney('bank', 400)
					ESX.AddSocietyMoney("ambulance", 400)
					xTarget.showNotification("Votre compte en banque à été réduit de 400~g~$~s~.")
				local source = ESX.GetPlayerFromId(player)
			end

			local content = {
				{
					["title"] = "**__Réanimation__**",
					["fields"] = {
						{ name = "**- Date & Heure :**", value = local_date },
						{ name = "- Employé :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." | "..xPlayer.name },
						{ name = "- Patient (Joueurs réanimer) :", value = xTarget.getFirstName().." "..xTarget.getLastName().." | "..xTarget.name },
						{ name = "- Montant facture automatique :", value = "+400$" },
					},
					["type"]  = "rich",
					["color"] = 16711680,
					["footer"] =  {
						["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
					},
				}
			}
			PerformHttpRequest(exports.Tree:serveurConfig().Logs.AmbulanceJobLogs, function(err, text, headers) end, 'POST', json.encode({username = "Logs Réanimation", embeds = content}), { ['Content-Type'] = 'application/json' })
		
		else
			TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas de kit de soin sur vous")
		end
	end
end
end)

RegisterServerEvent('ambulance:sendrapport')
AddEventHandler('ambulance:sendrapport', function(firstname, name, type, amount)

	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer) then

		if xPlayer.job.name ~= "ambulance" then

			TriggerEvent("tF:Protect", source, '(ambulance:sendrapport)');

			return
		end

		if (type) then

			if type == 'petit' then

				type = "Petits soins"

			elseif type == 'grand' then

				type = "Grands soins"

			elseif type == 'rea' then

				type = "Réanimation"

			end

		end

		MySQL.Async.execute('INSERT INTO rapports VALUES (@Prenom, @Nom, @Type, @Montant)', {    
			['@Prenom'] = firstname,
			['@Nom'] = name,
			['@Type'] = type,
			['@Montant'] = amount,
		}, function()    

		end)

	end

end)

RegisterServerEvent('ambulance:deleterapport')
AddEventHandler('ambulance:deleterapport', function(firstname, name, type, amount)

	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer) then

		if xPlayer.job.name ~= "ambulance" then

			TriggerEvent("tF:Protect", source, '(ambulance:deleterapport)');

			return

		end

		MySQL.Async.execute("DELETE FROM rapports WHERE Prenom = @a AND Nom = @b AND Type = @c AND Montant = @d", {

			['a'] = firstname,
			['b'] = name,
			['c'] = type,
			['d'] = amount

		}, function()

		end)

	end

end)

ESX.RegisterServerCallback('getAllRapports', function(source, cb)

	local source = source

	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer) then

		if xPlayer.job.name ~= "ambulance" then

			TriggerEvent("tF:Protect", source, '(getAllRapports)');
	
			return
	
		end
		
		MySQL.Async.fetchAll('SELECT * FROM rapports', {}, function(result)

			cb(result)

		end)

	end

end)

RegisterServerEvent('réanimer')
AddEventHandler('réanimer', function(player)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(player)

	if (xPlayer) and (tPlayer) then
		if xPlayer.getGroup() == "user" then
			TriggerEvent("tF:Protect", source, '(réanimer)');
			return
		end

		TriggerClientEvent('ambulance:revive', player)
	end
end)

RegisterServerEvent('ambulance:payNPC')
AddEventHandler('ambulance:payNPC', function()

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer) then
		xPlayer.removeAccountMoney('bank', 1500)
		TriggerClientEvent('esx:showNotification', source, "Vous avez payer 1500 ~g~$~s~ de frais médicaux.")
	end
end)

-- RegisterServerEvent('ambulance:antidote')
-- AddEventHandler('ambulance:antidote', function(antidote)
--   	local source = source
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	if xPlayer.job.name == "ambulance" then
-- 		if antidote == "weapon_antidote" or antidote == "WEAPON_ANTIDOTE" then
-- 			xPlayer.addWeapon(antidote, 255)
-- 		else
-- 			TriggerEvent("tF:Protect", source, '(ambulance:antidote)');
-- 		end
-- 	else
-- 		TriggerEvent("tF:Protect", source, '(ambulance:antidote)');
-- 	end	
-- end)

RegisterServerEvent('accepteCall:sendLogs')
AddEventHandler('accepteCall:sendLogs', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	-- print(xPlayer.getFirstName(), xPlayer.getLastName())
end)

RegisterServerEvent('ambulance:Lampe')
AddEventHandler('ambulance:Lampe', function(lampeTorche)

local source = source
local xPlayer = ESX.GetPlayerFromId(source)
local lampeTorche = "weapon_flashlight"
	if xPlayer.job.name == "ambulance" then
		if lampeTorche == "weapon_flashlight" or lampeTorche == "WEAPON_FLASHLIGHT" then
			xPlayer.addWeapon(lampeTorche)
		else
			TriggerEvent("tF:Protect", source, '(ambulance:Lampe)');
		end
	else
		TriggerEvent("tF:Protect", source, '(ambulance:Lampe)');
	end	
end)

RegisterServerEvent('ambulance:tazer')
AddEventHandler('ambulance:tazer', function(tazer)

local source = source
local xPlayer = ESX.GetPlayerFromId(source)
local tazer = "weapon_stungun"
	if xPlayer.job.name == "ambulance" then
		if tazer == "weapon_stungun" or lampeTorche == "WEAPON_STUNGUN" then
			xPlayer.addWeapon(tazer, 255, { antiActions = 'police', removeReboot = true })
		else
			TriggerEvent("tF:Protect", source, '(ambulance:tazer)');
		end
	else
		TriggerEvent("tF:Protect", source, '(ambulance:tazer)');
	end	
end)

RegisterNetEvent('clear:armeAfterDeath')
AddEventHandler('clear:armeAfterDeath', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if not isDead then 
		if #(GetEntityCoords(GetPlayerPed(source))-vector3(-1863.93, -330.5, 49.44)) > 20.0 then 
			TriggerEvent("tF:Protect", source, '(clear:armeAfterDeath)');
			return
		end

		local weaponList = xPlayer.clearAllInventoryWeapons(false); 

		for k,v in pairs(weaponList) do
			weaponList[k] = v.name
		end

		local content = {
			{
				["title"] = "**__Unité X__**",
				["fields"] = {
					{ name = "**- Date & Heure :**", value = local_date },
					{ name = "- Joueur respawn :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
					{ name = "- Armes perdu :", value = json.encode(weaponList) },
				},
				["type"]  = "rich",
				["color"] = 16711680,
				["footer"] =  {
					["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
				},
			}
		}
		PerformHttpRequest(exports.Tree:serveurConfig().Logs.AmbulanceJobLogs, function(err, text, headers) end, 'POST', json.encode({username = "Logs Unité X", embeds = content}), { ['Content-Type'] = 'application/json' })
	else
		TriggerEvent("tF:Protect", source, '(clear:armeAfterDeath)');
	end
end)

RegisterNetEvent('ambulance:setDeathStatus')
AddEventHandler('ambulance:setDeathStatus', function(isDead)
  	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if (xPlayer) then
		MySQL.Sync.execute('UPDATE users SET isDead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

ESX.RegisterServerCallback('GamemodeRP:GetDeath', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        cb(result[1].isDead)
    end)
end)

RegisterServerEvent('ambulance:takebandage')
AddEventHandler('ambulance:takebandage', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer) then
		local hasBandages = xPlayer.getInventoryItem('bandage')
		-- print(json.encode(hasBandages))
		if xPlayer.job.name ~= "ambulance" then
			TriggerEvent("tF:Protect", source, '(ambulance:takebandage)');
			return
		end
		
		xPlayer.addInventoryItem('bandage', 1)
	end
end)

RegisterServerEvent('ambulance:takemedikits')
AddEventHandler('ambulance:takemedikits', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name ~= "ambulance" then
		TriggerEvent("tF:Protect", source, '(ambulance:takemedikits)');
		return
	end
	
	xPlayer.addInventoryItem('medikit', 1)
end)

ESX.RegisterUsableItem('medikit', function(source)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer) then
		xPlayer.removeInventoryItem('medikit', 1)
		TriggerClientEvent('ambulance:heal', source, 'big')
		TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous avez utiliser un kit de soin")
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer) then
		xPlayer.removeInventoryItem('bandage', 1)
		TriggerClientEvent('ambulance:heal', source, 'small')
		TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous avez utilisé un bandage")
	end
end)

ESX.AddGroupCommand('revive', 'helpeur', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]));
	if (xPlayer) then
		local ReviveurName = source ~= 0 and GetPlayerName(source) or 'Console'
		TriggerClientEvent('ambulance:revive', tonumber(args[1]))
		local VictimeName = GetPlayerName(args[1])
		source.showNotification('Vous avez revive : '..exports.Tree:serveurConfig().Serveur.color..''..VictimeName)
		SendLogs("Revive", exports.Tree:serveurConfig().Serveur.label.." | Revive", "**"..ReviveurName.."** vient de revive **"..VictimeName.."**", exports.Tree:serveurConfig().Logs.AmbulanceJobLogs)
	elseif (source ~= 0) then
		TriggerClientEvent('ambulance:revive', source)
		SendLogs("Revive", exports.Tree:serveurConfig().Serveur.label.." | Revive", " **"..GetPlayerName(source).."** vient de se revive soi-même", exports.Tree:serveurConfig().Logs.AmbulanceJobLogs)
	else
		-- print("^1Commande réserver au joueurs.^0");
	end
end, {help = "Indiquez l'id d'un joueur pour le revive"})

ESX.AddGroupCommand('reviveall', 'fondateur', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not xPlayer then 
		return
	end
	TriggerClientEvent('ambulance:revive', -1)
	xPlayer.showNotification('~g~Vous venez de revive tout le serveur')
end, {help = "Permet de revive tout le serveur"})

local Admins = {};

ESX.AddGroupCommand('slay', 'admin', function(source, args)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			TriggerClientEvent('ambulance:slay', tonumber(args[1]))
		end
	else
		TriggerClientEvent('ambulance:slay', source)
	end
end, {help = "Indiquez l'id d'un joueur pour le tuer"})

ESX.AddGroupCommand('heal', 'helpeur', function(source, args)
	local ReviveurName2 = source ~= 0 and GetPlayerName(source) or 'Console'
	local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]));
	if (xPlayer) then
		local VictimeName2 = GetPlayerName(args[1])
		TriggerClientEvent('ambulance:heal', tonumber(args[1]), 'big')
		TriggerClientEvent('esx_status:add', args[1], 'thirst', 1000000)
		TriggerClientEvent('esx_status:add', args[1], 'hunger', 1000000)
		xPlayer.showNotification('Vous avez heal : '..exports.Tree:serveurConfig().Serveur.color..''..VictimeName2)
		SendLogs('Heal', exports.Tree:serveurConfig().Serveur.label.." | Heal", "**"..ReviveurName2.."** vient de heal **"..VictimeName2.."**", exports.Tree:serveurConfig().Logs.AmbulanceJobLogs)
	elseif (source ~= 0) then
		TriggerClientEvent('ambulance:heal', source, 'big')
		TriggerClientEvent('esx_status:add', source, 'thirst', 1000000)
		TriggerClientEvent('esx_status:add', source, 'hunger', 1000000)
		xPlayer.showNotification('Vous avez heal : '..exports.Tree:serveurConfig().Serveur.color..''..ReviveurName2)
		SendLogs('Heal', exports.Tree:serveurConfig().Serveur.label.." | Heal", "**"..ReviveurName2.."** vient de se heal soi-même", exports.Tree:serveurConfig().Logs.AmbulanceJobLogs)
	else
		-- print("^1Commande réserver au joueurs.^0");
	end
end, {help = "Indiquez l'id d'un joueur pour le tuer"})