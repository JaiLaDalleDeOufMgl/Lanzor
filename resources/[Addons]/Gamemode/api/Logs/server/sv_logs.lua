TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
AddEventHandler('playerDropped', function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local local_date = os.date('%H:%M:%S', os.time())
    local content = {
        {
            ["title"] = "**__Information :__**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." "..xPlayer.identifier },
                { name = '- Raison du déco :', value = reason }
            },
            ["type"]  = "rich",
            ["color"] = 2061822,
            ["footer"] =  {
                ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label.."",
            },
        }
    }
    PerformHttpRequest(exports.Tree:serveurConfig().Logs.PlayersLeave, function(err, text, headers) end, 'POST', json.encode({username = "Logs Déconnexion", embeds = content}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("playerConnecting", function ()
	local identifier
	local playerId = source
	local PcName = GetPlayerName(playerId)
	
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
			break
		end
	end
    local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Connexion au serveur :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Joueur :", value = PcName },
                    { name = "- License  :", value = "license:"..identifier },
                },
                ["type"]  = "rich",
                ["color"] = 2061822,
                ["footer"] =  {
                ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
                },
            }
        }
        PerformHttpRequest(exports.Tree:serveurConfig().Logs.PlayersJoin, function(err, text, headers) end, 'POST', json.encode({username = "Logs SHOP", embeds = content}), { ['Content-Type'] = 'application/json' })
end)