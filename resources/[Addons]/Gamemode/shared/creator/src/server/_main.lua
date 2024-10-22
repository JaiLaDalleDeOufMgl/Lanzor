

---@author Razzway
---@version 3.0

local CreatorSecurity = {}
local registering = {};


RegisterServerEvent(_Prefix..":setBuckets")
AddEventHandler(_Prefix..":setBuckets", function(bool)
    local _src = source
    if bool then SetPlayerRoutingBucket(_src, _src+1) else SetPlayerRoutingBucket(_src, 0) end
end)

RegisterServerEvent(_Prefix..':identity:setIdentity')
AddEventHandler(_Prefix..':identity:setIdentity', function(playerInfo)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    if #(coords - vector3(-774.95, 318.24, 195.86-0.9)) > 20 then
        TriggerEvent("tF:Protect", source, '(identity:setIdentity)');
        return
    end
    CreatorSecurity[source] = {
        isSafe = true
    }

    local GetItemPlayer = xPlayer.getInventoryItem('idcard')
    if (not GetItemPlayer) then
        xPlayer.addInventoryItem('idcard', 1, { antiActions = 'idCard' })
    end

    MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `height` = @height, `dateofbirth` = @dateofbirth, `sex` = @sex WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier,
        ['@firstname'] = playerInfo.firstname,
        ['@lastname'] = playerInfo.name,
        ['@height'] = playerInfo.height,
        ['@dateofbirth'] = playerInfo.birthday,
        ['@sex'] = playerInfo.sex,
    })
    if (CreatorConfig.consoleLogs) then
        -- print(("Le joueur ^3%s^7 a créé son identité ^3-->^7 [ Prénom : ^5%s^7 | Nom : ^6%s^7 | Taille : ^2%s^7 | Anniv : ^1%s^7 | Sexe : ^4%s^7 ]"):format(GetPlayerName(xPlayer.source), playerInfo.firstname, playerInfo.name, playerInfo.height, playerInfo.birthday, playerInfo.sex))
    end
    if (_ServerConfig.enableLogs) then
        logs:sendToDiscord(_ServerConfig.wehbook.identity, __["razzway_logs"], __["identity_logs_title"], (__["player_identity"]):format(GetPlayerName(xPlayer.source), __["line_separator"], playerInfo.firstname, playerInfo.name, playerInfo.height, playerInfo.birthday, playerInfo.sex), _ServerConfig.color.cyan)
    end
end)

ESX.AddGroupCommand("register", "admin", function(src, args, xPlayer)
    local target = ESX.GetPlayerFromId(args[1]);
    if (src == args[1]) then
        if (src ~= 0) then
            target = xPlayer;
        else
            -- print("Cette commande ne peut pas être utilisée depuis la console.");
            return;
        end
    else
        target = ESX.GetPlayerFromId(args[1]);
    end
    if (target) then
        registering[target.source] = true;
        MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `height` = @height, `dateofbirth` = @dateofbirth, `sex` = @sex WHERE identifier = @identifier', {
            ['@identifier'] = target.identifier,
            ['@firstname'] = nil,
            ['@lastname'] = nil,
            ['@height'] = nil,
            ['@dateofbirth'] = nil,
            ['@sex'] = nil,
        });
        --SendWebhookForRegister("Identity", ("Le staff **%s** [**%s**] a register l'identité de **%s** [**%s**]"):format(xPlayer.getName(), xPlayer.identifier, target.getName(), target.identifier));
        SendLogs("Register", exports.Tree:serveurConfig().Serveur.label.." | Register", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) a register l'identité de **"..target.name.."** (***"..target.identifier.."***)", exports.Tree:serveurConfig().Logs.Register)
        SetEntityCoords(GetPlayerPed(target.source), -774.95, 318.24, 195.86-0.9);
        target.triggerEvent("JustGod:RegisterPlayerIdentity");
    end
end, {
    help = "Recrée l'identité d'un joueur", 
    params = {
	{name = "playerId", help = "ID du joueur"},
}});

AddEventHandler('register:skin:bot', function(target)
    if (target) then
        registering[target.source] = true;

        MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `height` = @height, `dateofbirth` = @dateofbirth, `sex` = @sex WHERE identifier = @identifier', {
            ['@identifier'] = target.identifier,
            ['@firstname'] = nil,
            ['@lastname'] = nil,
            ['@height'] = nil,
            ['@dateofbirth'] = nil,
            ['@sex'] = nil,
        });

        --SendWebhookForRegister("Identity", ("Le staff **%s** [**%s**] a register l'identité de **%s** [**%s**]"):format(xPlayer.getName(), xPlayer.identifier, target.getName(), target.identifier));
        SetEntityCoords(GetPlayerPed(target.source), -774.95, 318.24, 195.86-0.9);
        target.triggerEvent("JustGod:RegisterPlayerIdentity");
    end
end)


RegisterServerEvent('finallyCreator')
AddEventHandler('finallyCreator', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not source then return end
    if CreatorSecurity[source] and CreatorSecurity[source].isSafe == true then
        if (not registering[source]) then
            xPlayer.addAccountMoney('cash', 12500);
            xPlayer.addAccountMoney('bank', 12500);
        end
        registering[source] = nil;
        CreatorSecurity[source] = {
            isSafe = false
        }
    else
        TriggerEvent("tF:Protect", source, '(finallyCreator)');
        return
    end
end)

---@class Cardinal
Cardinal = {};
Cardinal.sizeProtect = 30

--[[RegisterServerEvent(_Prefix..":starter:setToPlayer")
AddEventHandler(_Prefix..":starter:setToPlayer", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pCoords = GetEntityCoords(GetPlayerPed(source))
    local interactionPos = CreatorConfig.kitchen.pos
    if CreatorConfig.starterPack.enable then
        if (type) == "legal" then
            if #(pCoords-interactionPos) < (Cardinal.sizeProtect) then
                if (CreatorConfig.use.calif) then
                    xPlayer.addAccountMoney('cash', CreatorConfig.starterPack.legal["cash"])
                    xPlayer.addAccountMoney('bank', CreatorConfig.starterPack.legal["bank"])
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), __["choose_legal_kit"])
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), (__["reward_kit_legal"]):format(CreatorConfig.starterPack.legal["cash"], CreatorConfig.starterPack.legal["bank"]))
                else
                    xPlayer.addMoney(CreatorConfig.starterPack.legal["cash"])
                    xPlayer.addAccountMoney('bank', CreatorConfig.starterPack.legal["bank"])
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), __["choose_legal_kit"])
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), (__["reward_kit_legal"]):format(CreatorConfig.starterPack.legal["cash"], CreatorConfig.starterPack.legal["bank"]))
                end
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.starter, __["razzway_logs"], __["starter_logs_title"], (__["starter_logs_message"]):format("Kit legal", GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.green)
                end
            else
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.anticheat, __["razzway_logs"], __["anticheat_logs_title"], (__["anticheat_logs_message"]):format(GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.red)
                end
                DropPlayer(xPlayer.source, (__["cheat_detect"]):format(GetCurrentResourceName()))
            end
        end
        if (type) == "illegal" then
            if #(pCoords-interactionPos) < (Cardinal.sizeProtect) then
                if (CreatorConfig.use.calif) then
                    xPlayer.addAccountMoney('dirtycash', CreatorConfig.starterPack.illegal["black_money"])
                    xPlayer.addAccountMoney('bank', CreatorConfig.starterPack.illegal["bank"])
                    xPlayer.addWeapon(CreatorConfig.starterPack.illegal["weapon"], 255)
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), __["choose_illegal_kit"])
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), (__["reward_kit_illegal"]):format(CreatorConfig.starterPack.illegal["black_money"], CreatorConfig.starterPack.illegal["bank"], CreatorConfig.starterPack.illegal["weapon"]))
                else
                    xPlayer.addAccountMoney('black_money', CreatorConfig.starterPack.illegal["black_money"])
                    xPlayer.addAccountMoney('bank', CreatorConfig.starterPack.illegal["bank"])
                    xPlayer.addWeapon(CreatorConfig.starterPack.illegal["weapon"], 255)
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), __["choose_illegal_kit"])
                    TriggerClientEvent(CreatorConfig.events.showNotification, (xPlayer.source), (__["reward_kit_illegal"]):format(CreatorConfig.starterPack.illegal["black_money"], CreatorConfig.starterPack.illegal["bank"], CreatorConfig.starterPack.illegal["weapon"]))
                end
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.starter, __["razzway_logs"], __["starter_logs_title"], (__["starter_logs_message"]):format("Kit illegal", GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.yellow)
                end
            else
                if (_ServerConfig.enableLogs) then
                    logs:sendToDiscord(_ServerConfig.wehbook.anticheat, __["razzway_logs"], __["anticheat_logs_title"], (__["anticheat_logs_message"]):format(GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.red)
                end
                DropPlayer(xPlayer.source, (__["cheat_detect"]):format(GetCurrentResourceName()))
            end
        end
    else
        if (_ServerConfig.enableLogs) then
            logs:sendToDiscord(_ServerConfig.wehbook.anticheat, __["razzway_logs"], __["anticheat_logs_title"], (__["anticheat_logs_message"]):format(GetPlayerName(xPlayer.source), PLAYER_IP, PLAYER_STEAMHEX, PLAYER_DISCORD), _ServerConfig.color.red)
        end
        DropPlayer(xPlayer.source, (__["cheat_detect"]):format(GetCurrentResourceName()))
    end
end)]]