function _GamemodeCoffreProperties:logsRetrait(source, xPlayer, itemName, itemCount)
    local local_date = os.date('%H:%M:%S', os.time())
    local link = exports.Tree:serveurConfig().Logs.ChestLogsRetrait
    local content = {
        {
            ["title"] = "**Retrait Item(s) :**",
            ["fields"] = {
                { name = "**- Date & Heure :**", value = local_date },
                { name = "- Joueur :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                { name = "- Item retiré :", value = itemName.." x"..itemCount },
                { name = "- Entreprise / Gang :", value = self.propertiesName },
            },
            ["type"]  = "rich",
            ["color"] = 16711680,
            ["footer"] =  {
            ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Properties", embeds = content}), { ['Content-Type'] = 'application/json' })
end