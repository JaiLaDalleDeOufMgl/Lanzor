

TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)

local groupsRequired = {
	['kick'] = "moderateur"
}


RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(target, command, param)
	local xPlayer, xPlayerTarget = ESX.GetPlayerFromId(source), ESX.GetPlayerFromId(target)

	if command == "group" then
		if xPlayerTarget == nil then
			TriggerClientEvent('chatMessage', xPlayer.source, 'SYSTEM', {255, 0, 0}, "Player not found")
		else
			ESX.GroupCanTarget(xPlayer.getGroup(), param, function(canTarget)
				if canTarget then
					TriggerEvent('esx:customDiscordLog', xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") a modifié le groupe de permission de " .. xPlayerTarget.name .. " [" .. xPlayerTarget.source .. "] (" .. xPlayerTarget.identifier .. ") - Ancien : " .. xPlayer.getGroup() .. " / Nouveau : " .. param)
					
					xPlayerTarget.setGroup(param)
					ESX.SavePlayer(xPlayerTarget, function() end)
					
					TriggerClientEvent('chatMessage', xPlayer.source, "SYSTEME", {0, 0, 0}, "Group of ^2^*" .. xPlayerTarget.getName() .. "^r^0 has been set to ^2^*" .. param)
				else
					TriggerClientEvent('chatMessage', xPlayer.source, 'SYSTEME', {255, 0, 0}, "Invalid group or insufficient group.")
				end
			end)
		end
	elseif command == "level" then
		if xPlayerTarget == nil then
			TriggerClientEvent('chatMessage', xPlayer.source, 'SYSTEM', {255, 0, 0}, "Player not found")
		else
			param = tonumber(param)
			if param ~= nil and param >= 0 then
				if xPlayer.getLevel() >= param then
					TriggerEvent('esx:customDiscordLog', xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") a modifié le niveau de permission de " .. xPlayerTarget.name .. " [" .. xPlayerTarget.source .. "] (" .. xPlayerTarget.identifier .. ") - Ancien : " .. xPlayer.getLevel() .. " / Nouveau : " .. param)
					xPlayerTarget.setLevel(param)
					TriggerClientEvent('chatMessage', xPlayer.source, "SYSTEME", {0, 0, 0}, "Permission level of ^2" .. xPlayerTarget.getName() .. "^0 has been set to ^2 " .. tostring(param))
				else
					TriggerClientEvent('chatMessage', xPlayer.source, 'SYSTEME', {255, 0, 0}, "Insufficient level.")
				end
			else
				TriggerClientEvent('chatMessage', xPlayer.source, 'SYSTEME', {255, 0, 0}, "Invalid level.")
			end
		end
	end
end)

-- Rcon commands
AddEventHandler('rconCommand', function(commandName, args)
	if commandName == 'setlevel' then
		if (tonumber(args[1]) ~= nil and tonumber(args[1]) >= 0) and (tonumber(args[2]) ~= nil and tonumber(args[2]) >= 0) then
			local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

			if xPlayer == nil then
				Rconprint("Player not ingame\n")
				CancelEvent()
				return
			end

			TriggerEvent('esx:customDiscordLog', "CONSOLE a modifié le niveau de permission de " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Ancien : " .. xPlayer.getLevel() .. " / Nouveau : " .. tostring(args[2]))
			xPlayer.setLevel(tonumber(args[2]))
		else
			Rconprint("Usage: setlevel [user-id] [level]\n")
			CancelEvent()
			return
		end

		CancelEvent()
	elseif commandName == 'setgroup' then
		if (tonumber(args[1]) ~= nil and tonumber(args[1]) >= 0) and (tostring(args[2]) ~= nil) then
			local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))

			if xPlayer == nil then
				Rconprint("Player not ingame\n")
				CancelEvent()
				return
			end

			TriggerEvent('esx:customDiscordLog', "CONSOLE a modifié le groupe de permission de " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Ancien : " .. xPlayer.getGroup() .. " / Nouveau : " .. tostring(args[2]))
			xPlayer.setGroup(tostring(args[2]))
		else
			Rconprint("Usage: setgroup [user-id] [group]\n")
			CancelEvent()
			return
		end

		CancelEvent()
	end
end)

-- Announce
ESX.AddGroupCommand('announce', "admin", function(source, args, user)
	TriggerClientEvent('chatMessage', -1, "ANNONCE", {255, 0, 0}, table.concat(args, " "))
end, {help = "Announce a message to the entire server", params = { {name = "announcement", help = "The message to announce"} }})

-- Kick
ESX.AddGroupCommand('kick', "moderateur", function(source, args, user)
	if args[1] then
		if GetPlayerName(tonumber(args[1])) then
			local target = tonumber(args[1])
			local reason = args
			local xPlayer = ESX.GetPlayerFromId(source);
			local tPlayer = ESX.GetPlayerFromId(args[1]);
			table.remove(reason, 1)

			if #reason == 0 then
				reason = "Kick: Vous avez été exclu du serveur."
			else
				reason = "Kick: " .. table.concat(reason, " ")
			end

			TriggerClientEvent('chatMessage', source, "SYSTEME", {255, 0, 0}, "Player ^2" .. GetPlayerName(target) .. "^0 has been kicked (^2" .. reason .. "^0)")
			DropPlayer(target, reason)
			SendLogs("Staff", exports.Tree:serveurConfig().Serveur.label.." | Kick", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de kick le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) pour la raison [**"..reason.."**]", exports.Tree:serveurConfig().Logs.StaffKickPlayers)
		else
			TriggerClientEvent('chatMessage', source, "SYSTEME", {255, 0, 0}, "Incorrect player ID!")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEME", {255, 0, 0}, "Incorrect player ID!")
	end
end, {help = "Kick a user with the specified reason or no reason", params = { {name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"} }})

ESX.AddGroupCommand('setgroup', "fondateur", function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source);

	if args[1] then
		local target = tonumber(args[1])
		local xTarget = ESX.GetPlayerFromId(target);
		if xTarget == nil then
			if (xPlayer) then
				TriggerClientEvent('chatMessage', user.source, 'SYSTEM', {255, 0, 0}, "Player not found");
			else
				ESX.Logs.Warn("Player not found");
			end
		else
			ESX.GroupCanTarget(xPlayer and xPlayer.getGroup() or "fondateur", xTarget.getGroup(), function(canTarget)
				local log = "**Console** a modifié le groupe de permission de **" .. xTarget.name .. "** [**" .. xTarget.source .. "**] (**" .. xTarget.identifier .. "**)  (**".. xTarget.getGroup() .."** > **".. args[2] .."**)";
				if (xPlayer) then
					log = "**" .. xPlayer.name .. "** [**" .. xPlayer.source .. "**] (**" .. xPlayer.identifier .. "**) a modifié le groupe de permission de **" .. xTarget.name .. "** [**" .. xTarget.source .. "**] (**" .. xTarget.identifier .. "**)  (**".. xTarget.getGroup() .."** > **".. args[2] .."**)";
				end
				if canTarget then
					SendLogs("setgroup", exports.Tree:serveurConfig().Serveur.label.." | SetGroup", log, exports.Tree:serveurConfig().Logs.SetGroup)
					TriggerEvent('esx:customDiscordLog', log);
					xTarget.setGroup(args[2]);
					if (xPlayer) then
						TriggerClientEvent('chatMessage', xPlayer.source, "SYSTEME", {0, 0, 0}, "Group of ^2^*" .. xTarget.getName() .. "^r^0 has been set to ^2^*" .. args[2])
					else
						ESX.Logs.Success("Console 'setgroup' Group of " .. xTarget.getName() .. " has been set to " .. args[2]);
					end
				else
					if (xPlayer) then
						TriggerClientEvent('chatMessage', xPlayer.source, 'SYSTEME', {255, 0, 0}, "Invalid group or insufficient group.")
					else
						ESX.Logs.Error("Console 'setgroup' Invalid group.");
					end
				end
			end);
		end
	else
		if (source ~= 0) then
			TriggerClientEvent('chatMessage', source, "SYSTEME", {255, 0, 0}, "Incorrect player ID!")
		else
			print("Incorrect player ID!")
		end
	end
end, {
	help = "Set a new group to a player", 
	params = { 
		{
			name = "userid", 
			help = "The ID of the player"
		}, 
		{
			name = "reason", help = "The group to put"
		} 
	}
});