function GamemodeSociety:SendLogsDiscord(local_date, link, content)
    PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Jobs", embeds = content}), { ['Content-Type'] = 'application/json' })
end