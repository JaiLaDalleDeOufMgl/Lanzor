

---@author Razzway

---@type function _Server:toDiscord
function _Server:toDiscord(name, message, color)
    date_local1 = os.date('%Hh%M & %Ss', os.time())
    local date_local = date_local1
    local DiscordWebHook = _ServerConfig.param.wehbook

    local embeds = {
        {
            ["title"]= message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
                ["text"]= "Heure : " ..date_local.. "",
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end