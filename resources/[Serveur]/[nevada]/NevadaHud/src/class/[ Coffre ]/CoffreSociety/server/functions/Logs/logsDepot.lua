function _GamemodeCoffreSociety:logsDepot(source, xPlayer, itemName, itemId, itemCount)
    local IdShow = ""
    if (itemId ~= nil and type(itemId) ~= 'boolean') then
        IdShow = ' ( '..itemId..' )'
    end

    local local_date = os.date('%H:%M:%S', os.time())
    local link = exports.Tree:serveurConfig().Logs.ChestLogsDepot
    local content = {
        {
            ["title"] = "**Dépot Item(s) :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                { name = "- Item déposé :", value = itemName.." x"..itemCount..IdShow },
                { name = "- Entreprise / Gang :", value = self.jobName },
            },
            ["type"]  = "rich",
            ["color"] = 65280,
            ["footer"] =  {
            ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Society", embeds = content}), { ['Content-Type'] = 'application/json' })
end