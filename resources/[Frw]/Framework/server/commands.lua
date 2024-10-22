AddEventHandler('chatMessage', function(_, _, message)
	if (message):find(Config.CommandPrefix) ~= 1 then
		return
	end
	CancelEvent();
end);

---@param commandName string
---@param source number
---@param commandArgs table
local function HandleCommand(commandName)
	local command = ESX.Commands[string.lower(commandName)];
	local msg = "^7[^1Command^7]^0 Commande executée ^7(^0id: ^1%s^0, command: ^1%s^0, args: ^1%s^7)^0";

	if (command) then
		RegisterCommand(commandName, function(source, commandArgs)
			local xPlayer = source ~= 0 and ESX.GetPlayerFromId(source) or false;

			if command.group ~= nil then
				if (xPlayer and ESX.Groups[xPlayer.getGroup()].level >= ESX.Groups[command.group].level or (not xPlayer and source == 0)) then
					if (command.arguments > -1) and (command.arguments ~= #commandArgs) then

						TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)

					else

						local success, exec = pcall(command.callback, source ~= nil and source or 0, #commandArgs > 0 and commandArgs or {}, xPlayer ~= nil and xPlayer or false);
						
						if (success) then

							if (source ~= 0) then

								ESX.Logs.Info((#commandArgs > 0 and msg or "^7[^1Command^7]^0 Commande executée ^7(^0id: ^1%s^0, command: ^1%s^7)^0"):format(source, commandName, table.concat(commandArgs, " ")));
							
							end

						else

							ESX.Logs.Error(string.format("Une erreur est survenue pendant l'exécution de la commande: ^4%s^0, Détails de l'erreur: ^1%s^0", commandName, exec ~= nil and exec or "Aucune information^0."));

						end

					end
				else
					if (xPlayer) then
						xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color..'Permissions Insuffisantes !')
					end
				end
			else
				if (command.arguments > -1) and (command.arguments ~= #commandArgs) then
					if (xPlayer) then
						TriggerEvent("esx:incorrectAmountOfArguments", source, command.arguments, #commandArgs)
					else
						ESX.Logs.Error("^7[^1Command^7]^0 Incorrect amount of arguments for command " .. commandName .. " (expected " .. command.arguments .. ", got " .. #commandArgs .. ")")
					end
				else
					command.callback(source ~= nil and source or 0, #commandArgs > 0 and commandArgs or {}, xPlayer ~= nil and xPlayer or false);
				end
			end
		end);
	end
end

function ESX.AddCommand(command, callback, suggestion, arguments)
	ESX.Commands[string.lower(command)] = {};
	ESX.Commands[string.lower(command)].group = nil;
	ESX.Commands[string.lower(command)].callback = callback;
	ESX.Commands[string.lower(command)].arguments = arguments or -1;

	if type(suggestion) == 'table' then
		if type(suggestion.params) ~= 'table' then
			suggestion.params = {}
		end

		if type(suggestion.help) ~= 'string' then
			suggestion.help = ''
		end

		table.insert(ESX.CommandsSuggestions, {name = ('%s%s'):format(Config.CommandPrefix, command), help = suggestion.help, params = suggestion.params})
	end
end

function ESX.AddGroupCommand(command, group, callback, suggestion, arguments)
	ESX.Commands[string.lower(command)] = {}
	ESX.Commands[string.lower(command)].group = group
	ESX.Commands[string.lower(command)].callback = callback
	ESX.Commands[string.lower(command)].arguments = arguments or -1

	if type(suggestion) == 'table' then
		if type(suggestion.params) ~= 'table' then
			suggestion.params = {}
		end

		if type(suggestion.help) ~= 'string' then
			suggestion.help = ''
		end

		table.insert(ESX.CommandsSuggestions, {name = ('%s%s'):format(Config.CommandPrefix, string.lower(command)), help = suggestion.help, params = suggestion.params})
		HandleCommand(string.lower(command));
	end
end

-- SCRIPT --
ESX.AddGroupCommand('pos', 'admin', function(source, args, user)
	local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent('esx:teleport', source, vector3(x, y, z))
	else
		ESX.ChatMessage(source, "Invalid coordinates!")
	end
end, {help = "Teleport to coordinates", params = {
	{name = "x", help = "X coords"},
	{name = "y", help = "Y coords"},
	{name = "z", help = "Z coords"}
}})

ESX.AddGroupCommand('setjob', 'admin', function(source, args, user)
	local source = source

	if (#args == 3) then
		if tonumber(args[1]) and args[2] and tonumber(args[3]) then
			local xPlayer = ESX.GetPlayerFromId(source)
			local tPlayer = ESX.GetPlayerFromId(args[1])

			if tPlayer then
				local KargetName = GetPlayerName(args[1])
				local SetjobeurName = source ~= 0 and GetPlayerName(source) or "Console"
				if ESX.DoesJobExist(args[2], args[3]) then
					tPlayer.setJob(args[2], args[3])
					xPlayer.showNotification("Vous avez setjob : "..KargetName.." "..args[2].." - "..args[3])
					SendLogsCommande("Setjob", exports.Tree:serveurConfig().Serveur.label.." | Setjob"," **"..SetjobeurName.."** vient de setjob **"..KargetName.."** en **"..args[2].."** "..args[3].." ", exports.Tree:serveurConfig().Logs.SetJob)
				else
					ESX.ChatMessage(source, 'That job does not exist.')
				end
			else
				if (tPlayer) then
					ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
				else
					--print("^1Le joueur n'est pas en ligne.^0")
				end
			end
		else
			if (source ~= 0) then
				ESX.ChatMessage(source, "Invalid arguments.")
			else
				--print("^1Invalid arguments.^0")
			end
		end
	else
		if (source ~= 0) then
			ESX.ChatMessage(source, "Invalid arguments.")
		else
			--print("^1Invalid arguments.^0")
		end
	end
end, {help = _U('setjob'), params = {
	{name = "playerId", help = _U('id_param')},
	{name = "job", help = _U('setjob_param2')},
	{name = "grade_id", help = _U('setjob_param3')}
}})

ESX.AddGroupCommand('setjob2', 'admin', function(source, args, user)
	if (#args == 3) then
		if tonumber(args[1]) and args[2] and tonumber(args[3]) then
			local xPlayer = ESX.GetPlayerFromId(args[1])

			if xPlayer then
				local KargetName2 = GetPlayerName(args[1])
				local SetjobeurNam2 = source ~= 0 and GetPlayerName(source) or "Console"
				if ESX.DoesJobExist(args[2], args[3]) then
					xPlayer.setJob2(args[2], args[3])
                    xPlayer.showNotification("Vous avez setjob2 : "..KargetName2.." "..args[2].." - "..args[3])
					SendLogsCommande("Setjob2", exports.Tree:serveurConfig().Serveur.label.." | Setjob"," **"..SetjobeurNam2.."** vient de setjob2 **"..KargetName2.."** en **"..args[2].."** "..args[3].." ", exports.Tree:serveurConfig().Logs.SetJob)
				else
					ESX.ChatMessage(source, 'That job does not exist.')
				end
			else
				if (xPlayer) then
					ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
				else
					--print("^1Le joueur n'est pas en ligne.^0")
				end
			end
		else
			if (source ~= 0) then
				ESX.ChatMessage(source, "Invalid arguments.")
			else
				--print("^1Invalid arguments.^0")
			end
		end
	else
		if (source ~= 0) then
			ESX.ChatMessage(source, "Invalid arguments.")
		else
			--print("^1Invalid arguments.^0")
		end
	end
end, {help = _U('setjob'), params = {
	{name = "playerId", help = _U('id_param')},
	{name = "job2", help = _U('setjob_param2')},
	{name = "grade_id", help = _U('setjob_param3')}
}})

ESX.AddGroupCommand('car', 'animateur', function(source, args, user)
	-- TriggerClientEvent('esx:spawnVehicle', source, args[1])
	local model = (type(args[1]) == 'number' and args[1] or GetHashKey(args[1]))
	local xPlayer = ESX.GetPlayerFromId(source)
	local plyCoords = GetEntityCoords(GetPlayerPed(source))

	exports[exports.Tree:serveurConfig().Serveur.hudScript]:SpawnVehicle(model, plyCoords, 0.0, nil, false, function(vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(xPlayer.source), vehicle:GetHandle(), -1)
		vehicle:SetLocked(false)
	end, xPlayer)
end, {help = _U('spawn_car'), params = {
	{name = "car", help = _U('spawn_car_param')}
}})

ESX.AddGroupCommand('dv', 'helpeur', function(source, args, user)
	TriggerClientEvent('esx:deleteVehicle', source, args[1])
end, {help = _U('delete_vehicle'), params = {
	{name = 'radius', help = 'Optional, delete every vehicle within the specified radius'}
}})

ESX.AddGroupCommand('giveitem', 'admin', function(source, args, user)
	local xTarget = ESX.GetPlayerFromId(args[1])
	local xPlayer = ESX.GetPlayerFromId(source)
	local XargetName = GetPlayerName(args[1]) or 'CONSOLE'
	local ItemeurName = source ~= 0 and GetPlayerName(source) or "Console"

	if xTarget then
		local item = args[2]
		local count = tonumber(args[3])

		if (count) then

			xTarget.addInventoryItem(item, count, nil, true)
			xTarget.showNotification('Vous venez de recevoir x'..exports.Tree:serveurConfig().Serveur.color..''..count..' '..item..'~s~ dans vottre inventaire.')

			if (xPlayer) then
				xPlayer.showNotification('Le joueurs ('..exports.Tree:serveurConfig().Serveur.color..''..args[1]..' ~s~- '..exports.Tree:serveurConfig().Serveur.color..''..XargetName..'~s~) viens de recevoir x'..exports.Tree:serveurConfig().Serveur.color..''..count..' '..item..'~s~ dans son inventaire.')
			end

		if args[2] == "cash" or args[2] == "dirtycash" then
			SendLogsCommande("Staff", exports.Tree:serveurConfig().Serveur.label.." | Give", "**"..ItemeurName.."** vient de donner "..count.." **"..item.."** a **"..XargetName.."**", exports.Tree:serveurConfig().Logs.GiveItem)
		else
			SendLogsCommande("Staff", exports.Tree:serveurConfig().Serveur.label.." | Give", "**"..ItemeurName.."** vient de donner "..count.." **"..item.."** a **"..XargetName.."**", exports.Tree:serveurConfig().Logs.GiveItem)
		end

		else
			xPlayer.showNotification(_U('invalid_amount'))
		end
	else
		xPlayer.showNotification('Le joueur n\'est pas en ligne.')
	end
end, {help = _U('giveitem'), params = {
	{name = "playerId", help = _U('id_param')},
	{name = "item", help = _U('item')},
	{name = "amount", help = _U('amount')}
}})

ESX.AddGroupCommand('giveweapon', 'gerant', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]));
	local TargetName = xPlayer.getName();

	local xAdmin = ESX.GetPlayerFromId(source);
	local GiveurName = xAdmin ~= nil and xAdmin.getName() or "Console"

	if (xPlayer) then
		local weaponName = args[2]

		if (ESX.GetWeapon(weaponName)) then
			
			xPlayer.addWeapon(weaponName, nil, nil, true);
			xPlayer.showNotification('Vous venez de recevoir x'..exports.Tree:serveurConfig().Serveur.color..'1 '..weaponName..'~s~ dans vottre inventaire.')

			if (xAdmin) then
				xPlayer.showNotification('Le joueurs ('..exports.Tree:serveurConfig().Serveur.color..''..args[1]..' ~s~- '..exports.Tree:serveurConfig().Serveur.color..''..TargetName..'~s~) viens de recevoir x'..exports.Tree:serveurConfig().Serveur.color..'1 '..weaponName..'~s~ dans son inventaire.')
			end

			SendLogsCommande("Staff", exports.Tree:serveurConfig().Serveur.label.." | Give", "**"..GiveurName.."** vient de donner **"..weaponName.."** a **"..TargetName.."**", exports.Tree:serveurConfig().Logs.GiveWeapons)
		else
			ESX.ChatMessage(source, 'Le nom de l\'arme est invalide.');
		end
	else
		ESX.ChatMessage(source, "Le joueur n'est pas en ligne.");
	end

end, {help = _U('giveweapon'), params = {
	{name = "playerId", help = _U('id_param')},
	{name = "weaponName", help = _U('weapon')},
}})


ESX.AddGroupCommand('clearinventory', 'admin', function(source, args, user)

	if args[1] then
		xPlayer = ESX.GetPlayerFromId(source)
		tPlayer = ESX.GetPlayerFromId(args[1])
	else
		xPlayer = ESX.GetPlayerFromId(source)
		tPlayer = ESX.GetPlayerFromId(source)
	end

	if tPlayer then
		tPlayer.clearInventoryItem()
		xPlayer.showNotification('Vous avez clear l\'inventaire de : '..tPlayer.name)
		SendLogsCommande("Clear", exports.Tree:serveurConfig().Serveur.label.." | Clear", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a clear l'inventaire de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.ClearInventory)
	else
		ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
	end
end, {help = _U('command_clearinventory'), params = {
	{name = "playerId", help = _U('command_playerid_param')}
}})

ESX.AddGroupCommand('clearallloadout', 'admin', function(source, args, user)

	if args[1] then
		xPlayer = ESX.GetPlayerFromId(source)
		tPlayer = ESX.GetPlayerFromId(args[1])
	else
		xPlayer = ESX.GetPlayerFromId(source)
		tPlayer = ESX.GetPlayerFromId(source)
	end

	if (tPlayer) then
		tPlayer.clearAllInventoryWeapons(true);
        xPlayer.showNotification('Vous avez clear les armes de : '..tPlayer.name)
		SendLogsCommande("Clear", exports.Tree:serveurConfig().Serveur.label.." | Clear (PermaWeapon)", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a clear les armes de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.ClearLoadout)
	else
		ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
	end
	
end, {help = _U('command_clearloadout'), params = {
	{name = "playerId", help = _U('command_playerid_param')}
}})

ESX.AddGroupCommand('clearloadout', 'admin', function(source, args, user)

    if args[1] then
        xPlayer = ESX.GetPlayerFromId(source)
        tPlayer = ESX.GetPlayerFromId(args[1])
    else
        xPlayer = ESX.GetPlayerFromId(source)
        tPlayer = ESX.GetPlayerFromId(source)
    end
	
	if (tPlayer) then
		tPlayer.clearAllInventoryWeapons(false);
        xPlayer.showNotification('Vous avez clear les armes de : '..tPlayer.name)
		SendLogsCommande("Clear", exports.Tree:serveurConfig().Serveur.label.." | Clear", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a clear les armes de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.ClearLoadout)
	else
		ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
	end
    
end, {help = _U('command_clearloadout'), params = {
    {name = "playerId", help = _U('command_playerid_param')}
}})

ESX.AddGroupCommand('saveall', 'fondateur', function(source, args, user)
	ESX.SavePlayers();
end, {help = "Sauvegarder tout les joueurs dans la base de données.", params = {}});

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if (eventData.secondsRemaining == 60) then
		SetTimeout(30000)
		ESX.SavePlayers()
		ESX.Logs.Success("Sauvegarder tout les joueurs dans la base de données.");
	end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
	ESX.SavePlayers()
	ESX.Logs.Success("Sauvegarder tout les joueurs dans la base de données.");
end)

ESX.AddGroupCommand('debugplayer', 'fondateur', function(source, args, user)

	if (args[1]) then

		local player;

		if (args[1]:find("license:")) then

			player = ESX.GetPlayerFromIdentifier(args[1]);

		else
			player = ESX.GetPlayerFromId(tonumber(args[1]));
		end
		if (player) then
			TriggerEvent('esx:playerDropped', player.source, xPlayer, reason)
			ESX.Players[player.source] = nil;
		end
	else
		if (source > 0) then
			ESX.GetPlayerFromId(source).showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous devez entrer une license ou un id valide.");
		else
			ESX.Logs.Warn("^1Vous devez entrer une license ou un id valide.");
		end
	end
end, {help = "Debug un joueur hors ligne", params = {
	{name = "playerInfo", help = "ID/license du joueur"}
}});

ESX.AddGroupCommand('debugdev', 'fondateur', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source);
		for _, player in pairs(ESX.Players) do
			if (type(player) == "table") then
				TriggerEvent('esx:playerLoaded', source, xPlayer);
				player.triggerEvent('esx:playerLoaded', {
					character_id = player.character_id,
					identifier = player.identifier,
					accounts = player.getAccounts(),
					level = player.getLevel(),
					group = player.getGroup(),
					job = player.getJob(),
					job2 = player.getJob2(),
					inventory = player.getInventory(),
					lastPosition = player.getLastPosition(),
					maxWeight = player.maxWeight
				});
			end
		end
end, {help = "Ne pas utiliser ou ban", params = {}});


function SendLogsCommande(name, title, message, web)
	local local_date = os.date('%H:%M:%S', os.time())
	local content = {
		{
			["title"] = title,
			["description"] = message,
			["type"]  = "rich",
			["color"] = 16776960,
			["footer"] =  {
			["text"] = "Powered by "..exports.Tree:serveurConfig().Serveur.label,
			},
		}
	}
	PerformHttpRequest(web, function(err, text, headers) 
		print(err)
		print(text)
	end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end