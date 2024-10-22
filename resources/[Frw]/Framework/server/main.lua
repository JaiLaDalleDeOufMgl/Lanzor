sqlReady = false

MySQL.ready(function()
	sqlReady = true
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	local _source = source
	local license, steam, xbl, discord, live, fivem = '', '', '', '', '', ''
	local name, ip, guid = GetPlayerName(_source), GetPlayerEP(_source), GetPlayerGuid(_source)
	if playerName:find "\xF0" then deferrals.done("Emojis interdit.") end
	while not sqlReady do
		Citizen.Wait(100)
	end

	for k, v in pairs(GetPlayerIdentifiers(_source)) do
		if string.sub(v, 1, string.len('license:')) == 'license:' then
			license = v
		elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
			steam = v
		elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
			xbl = v
		elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
			discord = v
		elseif string.sub(v, 1, string.len('live:')) == 'live:' then
			live = v
		elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
			fivem = v
		end
	end

	if license ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM account_info WHERE license = @license', {
			['@license'] = license
		}, function(result)
			if result[1] ~= nil then
				MySQL.Async.execute('UPDATE account_info SET steam = @steam, xbl = @xbl, discord = @discord, live = @live, fivem = @fivem, `name` = @name, ip = @ip, guid = @guid WHERE license = @license', {
					['@license'] = license,
					['@steam'] = steam,
					['@xbl'] = xbl,
					['@discord'] = discord,
					['@live'] = live,
					['@fivem'] = fivem,
					['@name'] = name,
					['@ip'] = ip,
					['@guid'] = guid
				})
			else
				MySQL.Async.execute('INSERT INTO account_info (license, steam, xbl, discord, live, fivem, `name`, ip, guid) VALUES (@license, @steam, @xbl, @discord, @live, @fivem, @name, @ip, @guid)', {
					['@license'] = license,
					['@steam'] = steam,
					['@xbl'] = xbl,
					['@discord'] = discord,
					['@live'] = live,
					['@fivem'] = fivem,
					['@name'] = name,
					['@ip'] = ip,
					['@guid'] = guid
				})
			end
		end)
	end
end)

RegisterServerEvent('verifPossible')
AddEventHandler('verifPossible', function(job)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.label ~= job then
		TriggerClientEvent('playsongtroll', source)
		ExecuteCommand('ban '..source..' 0 Tried to set new job')
	end
end)

RegisterServerEvent('verifPossible2')
AddEventHandler('verifPossible2', function(job2)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job2.label ~= job2 then
		TriggerClientEvent('playsongtroll', source)
		ExecuteCommand('ban '..source..' 0 Tried to set new job2')
	end
end)

CreateThread(function()
	while true do
		TriggerClientEvent('players:update', -1, GetNumPlayerIndices())
		Wait(15000)
	end
end)

---@param job table
---@return table
function ESX.ConvertJobSkins(job)

	local jobSkins = {};

	if (job.skin_male) then

		if (type(job.skin_male) == "string") then

			jobSkins["male"] = json.decode(job.skin_male);

		elseif (type(job.skin_male) == "table") then

			jobSkins["male"] = job.skin_male;

		else

			jobSkins["male"] = {};

		end

	else

		jobSkins["male"] = {};

	end

	if (job.skin_female) then

		if (type(job.skin_female) == "string") then

			jobSkins["female"] = json.decode(job.skin_female);

		elseif (type(job.skin_female) == "table") then

			jobSkins["female"] = job.skin_female;

		else

			jobSkins["female"] = {};

		end

	else

		jobSkins["female"] = {};

	end

	return jobSkins;

end

function LoadUser(source, identifier)
	local tasks = {}

	local userData = {
		name = GetPlayerName(source),
		accounts = {},
		job = {},
		job2 = {},
		inventory = {},
		clothes = {}
	}

	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll('SELECT character_id, permission_group, permission_level, accounts, job, job_grade, job2, job2_grade, inventory, clothes, position, firstname, lastname FROM users WHERE identifier = @identifier', {
			['@identifier'] = identifier
		}, function(result)
			local job, grade = result[1].job, tostring(result[1].job_grade)
			local job2, grade2 = result[1].job2, tostring(result[1].job2_grade)

			if (result[1].firstname) then
				userData.firstname = result[1].firstname
			else
				userData.firstname = 'No firstname defined'
			end

			if (result[1].lastname) then
				userData.lastname = result[1].lastname
			else
				userData.lastname = 'No lastname defined'
			end

			if result[1].character_id then
				userData.character_id = result[1].character_id
			else
				userData.character_id = 0
			end

			if result[1].permission_group then
				userData.permission_group = result[1].permission_group
			else
				userData.permission_group = Config.DefaultGroup
			end

			if result[1].permission_level ~= nil then
				userData.permission_level = result[1].permission_level
			else
				userData.permission_level = Config.DefaultLevel
			end

			if result[1].accounts and result[1].accounts ~= '' then
				local formattedAccounts = json.decode(result[1].accounts) or {}

				for i = 1, #formattedAccounts, 1 do
					if Config.Accounts[formattedAccounts[i].name] == nil then
						-- print(('[^3WARNING^7] Ignoring invalid account "%s" for "%s"'):format(formattedAccounts[i].name, identifier))
						table.remove(formattedAccounts, i)
					else
						formattedAccounts[i] = {
							name = formattedAccounts[i].name,
							money = formattedAccounts[i].money or 0
						}
					end
				end

				userData.accounts = formattedAccounts
			else
				userData.accounts = {}
			end

			for name, account in pairs(Config.Accounts) do
				local found = false

				for i = 1, #userData.accounts, 1 do
					if userData.accounts[i].name == name then
						found = true
					end
				end

				if not found then
					table.insert(userData.accounts, {
						name = name,
						money = account.starting or 0
					})
				end
			end

			table.sort(userData.accounts, function(a, b)
				return Config.Accounts[a.name].priority < Config.Accounts[b.name].priority
			end)

			if not ESX.DoesJobExist(job, grade) then
				-- print(('[^3WARNING^7] Ignoring invalid job for %s [job: %s, grade: %s]'):format(identifier, job, grade))
				job, grade = 'unemployed', '0'
			end

			if not ESX.DoesJobExist(job2, grade2) then
				-- print(('[^3WARNING^7] Ignoring invalid job2 for %s [job: %s, grade: %s]'):format(identifier, job2, grade2))
				job2, grade2 = 'unemployed2', '0'
			end

			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			local job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
			local skins = ESX.ConvertJobSkins(grade2Object);
			local skins2 = ESX.ConvertJobSkins(grade2Object);

			userData.job.id = jobObject.id
			userData.job.name = jobObject.name
			userData.job.label = jobObject.label
			userData.job.canWashMoney = jobObject.canWashMoney
			userData.job.canUseOffshore = jobObject.canUseOffshore

			userData.job.grade = tonumber(grade)
			userData.job.grade_name = gradeObject.name
			userData.job.grade_label = gradeObject.label
			userData.job.grade_salary = gradeObject.salary

			userData.job.skin_male = {}
			userData.job.skin_female = {}

			if gradeObject.skin_male then

				userData.job.skin_male = skins["male"];

			end

			if gradeObject.skin_female then
				userData.job.skin_female = skins["female"];
			end

			userData.job2.id = job2Object.id
			userData.job2.name = job2Object.name
			userData.job2.label = job2Object.label
			userData.job2.canWashMoney = job2Object.canWashMoney
			userData.job2.canUseOffshore = job2Object.canUseOffshore

			userData.job2.grade = tonumber(grade2)
			userData.job2.grade_name = grade2Object.name
			userData.job2.grade_label = grade2Object.label
			userData.job2.grade_salary = grade2Object.salary

			userData.job2.skin_male = {}
			userData.job2.skin_female = {}

			if grade2Object.skin_male then
				userData.job2.skin_male = skins2["male"];
			end

			if grade2Object.skin_female then
				userData.job2.skin_female = skins2["female"];
			end

			userData.inventory = result[1].inventory
			userData.clothes = result[1].clothes

			if result[1].position and result[1].position ~= '' then
				local formattedPosition = json.decode(result[1].position)
				userData.lastPosition = ESX.Vector(formattedPosition)
			else
				userData.lastPosition = Config.DefaultPosition
			end

			cb()
		end)
	end)

	-- Run Tasks
	Async.parallel(tasks, function(results)
		local xPlayer = CreatePlayer(source, identifier, userData)
		ESX.Players[source] = xPlayer

		TriggerEvent('esx:playerLoaded', source, xPlayer);

		xPlayer.triggerEvent('esx:playerLoaded', {
			character_id = xPlayer.character_id,
			identifier = xPlayer.identifier,
			accounts = xPlayer.getAccounts(),
			level = xPlayer.getLevel(),
			group = xPlayer.getGroup(),
			job = xPlayer.getJob(),
			job2 = xPlayer.getJob2(),
			inventory = xPlayer.getInventory(),
			clothes = xPlayer.getInventoryClothes(),
			lastPosition = xPlayer.getLastPosition(),
			weight = xPlayer.getWeight(),
			maxWeight = xPlayer.getMaxWeight(),
		});

		xPlayer.triggerEvent('chat:addSuggestions', ESX.CommandsSuggestions)

		
		local GetItemPlayer = xPlayer.getInventoryItem('idcard')
		if (not GetItemPlayer) then
			xPlayer.addInventoryItem('idcard', 1, { antiActions = 'idCard' })
		end

		local GetItemPlayer = xPlayer.getInventoryItem('drive')
		if (not GetItemPlayer) then
			CheckLicense(xPlayer, 'drive', function(result)
				if (result) then
					xPlayer.addInventoryItem('drive', 1, { antiActions = 'driveCard' })
				end
			end)
		end

		local GetItemPlayer = xPlayer.getInventoryItem('weapon')
		if (not GetItemPlayer) then
			CheckLicense(xPlayer, 'weapon', function(result)
				if (result) then
					xPlayer.addInventoryItem('weapon', 1, { antiActions = 'weaponCard' })
				end
			end)
		end
	end)
end

function CheckLicense(xPlayer, type, cb)
	local identifier = xPlayer.identifier
	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end
	end)
end

function RegisterUser(source, identifier)
	ESX.DB.DoesUserExist(identifier, function(exists)
		if exists then
			LoadUser(source, identifier)
		else
			ESX.DB.CreateUser(identifier, function()
				LoadUser(source, identifier)
			end)
		end
	end)
end

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer then
		TriggerEvent('esx:playerDropped', _source, xPlayer, reason)

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[_source] = nil

			exports[exports.Tree:serveurConfig().Serveur.hudScript]:removePlayerDropped(xPlayer.identifier)
		end)
	end
end)

RegisterServerEvent('esx:firstJoinProper')
AddEventHandler('esx:firstJoinProper', function()
    local _source = source
    Citizen.CreateThread(function()
        local identifier = ESX.GetIdentifierFromId(_source)
        if identifier then
            if ESX.GetPlayerFromIdentifier(identifier) then
                DropPlayer(_source, "Impossible de vous identifier, une personne joue déjà avec votre compte Rockstar sur le Serveur.")
            else
                RegisterUser(_source, identifier)
            end
        else
            DropPlayer(_source, "Impossible de vous identifier, merci de réouvrir FiveM.")
        end
        RegisterUser(_source, identifier)
    end)
end)

RegisterServerEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)

	if xItem then
		if xItem.count > 0 then
			ESX.UseItem(xPlayer.source, itemName)
		else
			xPlayer.showAdvancedNotification(exports.Tree:serveurConfig().Serveur.label, "Inventaire", _U('act_imp'), nil, 7)
		end
	end
end)

RegisterServerEvent('esx:positionSaveReady')
AddEventHandler('esx:positionSaveReady', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.positionSaveReady = true
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier = xPlayer.identifier,
		accounts = xPlayer.getAccounts(),
		inventory = xPlayer.getInventory(),
		job = xPlayer.getJob(),
		job2 = xPlayer.getJob2(),
		lastPosition = xPlayer.getLastPosition(),
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier = xPlayer.identifier,
		accounts = xPlayer.getAccounts(),
		inventory = xPlayer.getInventory(),
		job = xPlayer.getJob(),
		job2 = xPlayer.getJob2(),
		lastPosition = xPlayer.getLastPosition(),
	})
end)

ESX.RegisterServerCallback('esx:getActivePlayers', function(source, cb)
	local players = {}

	for k, v in pairs(ESX.Players) do
		table.insert(players, {id = k, name = GetPlayerName(k)})
	end

	cb(players)
end)

ESX.StartDBSync()
ESX.StartPositionSync()
ESX.StartPayCheck()

function SendLogs(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["title"]= title,
			["description"]= message,
			["type"]= "rich",
			["color"] = 16776960,
			["footer"]=  {
			["text"]= "Powered by "..exports.Tree:serveurConfig().Serveur.label.." | Time: "..local_date.."",
			},
		}
	}
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function SendLogsForKsos(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["author"] = {
				["name"] = title,
				["icon_url"] = "https://cdn.discordapp.com/avatars/1092926934947741780/375e62a40eb5a119262046ee4afe5726.png?size=1024"
			},
			["description"]= message,
			["type"]= "rich",
			["color"] = 16776960,
			["footer"]=  {
				["text"]= "by"..exports.Tree:serveurConfig().Serveur.label.." © | "..local_date.."",
				["icon_url"] = "https://media.discordapp.net/attachments/880115508752572426/880115577778237520/shields.png?width=676&height=676",
			},
		}
	}
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function SendLogsScreen(name, title, message, image, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["author"] = {
				["name"] = title,
				["icon_url"] = "https://cdn.discordapp.com/attachments/1017780688243662858/1024864740314468442/logo_exellity_3.png?width=676&height=676"
			},
			["description"]= message,
			["type"]= "rich",
			["color"] = 16776960,
			['image'] = {['url'] = image },
			["footer"]=  {
				["text"]= "by"..exports.Tree:serveurConfig().Serveur.label.." © | "..local_date.."",
				["icon_url"] = "https://media.discordapp.net/attachments/880115508752572426/880115577778237520/shields.png?width=676&height=676",
			},
		}
	}
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("JustGod:SeeYou", function(eventName, resourceName)
	local src = source;
	local xPlayer = ESX.GetPlayerFromId(src);
	if (xPlayer) then
		-- print(("Le joueur ^1%s^0 a éxécuté ^1%s^0 depuis la resource ^1%s^0"):format(xPlayer.getName(), eventName, resourceName));
	end
end);

local _PLAYER_SCREEN = nil

function SendPlayerScreen(data)
	local screen = data
	_PLAYER_SCREEN = screen
end

function GetPlayerScreen()
	return _PLAYER_SCREEN
end

local function PlayerScreen(licence)
	MySQL.Async.fetchAll('SELECT banimg FROM seashield_banlist WHERE License = @License',{
		['License'] = licence
	}, function(data)
		SendPlayerScreen(data[1].banimg)
	end)
end

AddEventHandler('playerDropped', function(reason)
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then

		local license, steam, xbl, discord, live, fivem = nil, nil, nil, nil, nil, nil
		local _PLAYER_LICENSE = xPlayer.identifier
		local _PLAYER_NAME = xPlayer.name
		local _STEAMHEX = nil
		local _DISCORD = nil
		local _Raison = "Autres"

        if (string.find(reason, "SeaShield")) then
			
            for k, v in pairs(GetPlayerIdentifiers(source)) do
                if string.sub(v, 1, string.len('license:')) == 'license:' then
                    license = v
                elseif string.sub(v, 1, string.len('steam:')) == 'steam:' then
                    steam = v
                elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
                    xbl = v
                elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
                    discord = v
                elseif string.sub(v, 1, string.len('live:')) == 'live:' then
                    live = v
                elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
                    fivem = v
                end
            end

			Wait(5000)

			-- PlayerScreen(_PLAYER_LICENSE)

			Wait(1000)

			-- local _PLAYER_SCREEN = GetPlayerScreen()

            if steam == nil then _STEAMHEX = "Inconnu" else _STEAMHEX = steam end
            if discord == nil then _DISCORD = "Inconnu" else _DISCORD = discord end
            if (string.find(reason, "Use Protect Trigger")) then _Raison = "À tenté d'utiliser un event de façon pas très legit." end
            if (string.find(reason, "Give Weapon")) then _Raison = "À tenté de se give une arme d'une façon pas très legit." end
            if (string.find(reason, "Blacklist Weapon")) then _Raison = "À tenté de se give une arme blacklist par le serveur." end
            if (string.find(reason, "Tried to stop SeaShield")) then _Raison = "À tenté de stopper l'anti-cheat." end
            if (string.find(reason, "Spawn Blacklist Particles")) then _Raison = "À tenté de faire spawn des particules blacklist par le serveur." end
            if (string.find(reason, "Spawn Mass Vehicles")) then _Raison = "À tenté de faire spawn plusieurs véhicules en même temps." end
			if (string.find(reason, "Spawn Blacklist Vehicle")) then _Raison = "À tenté de faire spawn un véhicules blacklist par le serveur." end
			if (string.find(reason, "Anti Spectate")) then _Raison = "À tenté de se mettre en mode spectateur." end
			if (string.find(reason, "Use /me usebug LOL")) then _Raison = "À tenté d'utiliser un usebug pour faire crash les joueurs autour de lui." end
			if (string.find(reason, "Exploit /porter")) then _Raison = "À tenté de s'amuser a porté une personne en no clip." end

            if _Raison ~= "Autres" then
				if (not string.find(_PLAYER_NAME, "http")) or (not string.find(_PLAYER_NAME, "discord")) then
					-- if _PLAYER_SCREEN == nil then 
						SendLogsForKsos(exports.Tree:serveurConfig().Serveur.label, "Anti-Cheat", "**Un nouveau tricheur a été banni du serveur "..exports.Tree:serveurConfig().Serveur.label.." ** \n\n **Nom :** ".._PLAYER_NAME.." \n **Raison :** ".._Raison.." \n **Steam Hex :** ".._STEAMHEX.." \n **Discord :** <@".._DISCORD:gsub("discord:", "")..">\n **Licence :** ".._PLAYER_LICENSE.."", exports.Tree:serveurConfig().Logs.BanPlayers)
					-- else
					-- 	SendLogsScreen("Gamemode", "Anti-Cheat", "**Un nouveau tricheur a été banni du serveur Gamemode** \n\n **Nom :** ".._PLAYER_NAME.." \n **Raison :** ".._Raison.." \n **Steam Hex :** ".._STEAMHEX.." \n **Discord :** <@".._DISCORD:gsub("discord:", "")..">\n **Licence :** ".._PLAYER_LICENSE.."", _PLAYER_SCREEN,"https://achanger/webhooks/1093171366708133948/fQ6zujyNjGXItJh0upcAvs12cIs4cDNf3Upss87YBUEk7mIzagggxpOyNme8RsHn6PtH")
					-- 	_PLAYER_SCREEN = nil
					-- end
				end
            end
        end
    end
end)

CreateThread(function()
	local timers = {};
	while true do
		local players = ESX.GetPlayers();
		local count = 0;
		Wait(60*1000*2);; -- Wait(60*1000*3);
		for i=1, #players, 1 do
			local xPlayer = ESX.GetPlayerFromId(players[i]);
			if (xPlayer) then
				if (not timers[xPlayer.identifier]) then
					timers[xPlayer.identifier] = GetGameTimer();
				elseif (GetGameTimer() - timers[xPlayer.identifier] >= 60*1000*15) then -- 60*1000*15
					count = count + 1;
					timers[xPlayer.identifier] = GetGameTimer();
				end
			end
		end
	end
end);

CreateThread(function()
	while true do
		Wait(5 * 1000 * 60);
		local players = ESX.GetPlayers();
		if (#players > 0) then
			for i = 1, #players do
				local xPlayer = ESX.GetPlayerFromId(players[i]);
				if (xPlayer) then
					local hasBeenPromt = xPlayer.get('hasBeenPromt');
					if (not hasBeenPromt) then
						local bank = xPlayer.getAccount("bank");
						if (bank) then
							if (bank.money <= -20000) then
								xPlayer.set('hasBeenPromt', true);
								xPlayer.showNotification("Vous êtes endetté, vous devez aller régler vos dettes avant d'être débité de 3500~g~$~s~.\nDécouvert autorisé: -20000~g~$~s~\nDécouvert actuel: " .. bank.money .. "~g~$~s~");
							end
						end
					else
						xPlayer.set('hasBeenPromt', false);
						local bank = xPlayer.getAccount("bank");
						if (bank) then
							if (bank.money <= -20000) then
								local cash = xPlayer.getAccount("cash");
								if (cash) then
									if (cash.money >= 3500) then
										xPlayer.removeAccountMoney("cash", 3500);
										xPlayer.showNotification("Vous avez été débiter de 3500~g~ par la banque suite à vos dettes.");
									end
								end
							end
						end
					end
				end
			end
		end
	end
end);