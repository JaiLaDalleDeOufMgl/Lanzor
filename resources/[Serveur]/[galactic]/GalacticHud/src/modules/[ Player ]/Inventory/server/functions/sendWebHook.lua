function MOD_inventory:sendWebHook(name, content, WeebHook)
    PerformHttpRequest(WeebHook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = content}), { ['Content-Type'] = 'application/json' })
end