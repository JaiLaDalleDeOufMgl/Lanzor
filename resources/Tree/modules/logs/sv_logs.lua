Tree.Logs = {}

local colors = {
    ["red"] = 16711680,
    ["green"] = 65280,
    ["blue"] = 255,
    ["yellow"] = 16776960,
    ["orange"] = 16753920,
    ["purple"] = 8388736,
    ["cyan"] = 65535,
    ["pink"] = 16761035,
    ["white"] = 16777215,
    ["black"] = 0
}

function Tree.Logs.send(title, message, color, webhookURL)
    local connect = {
        {
            ["color"] = colors[color],
            ["title"] = "**".. title .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Tree Logs (JaiFaim & Kabyle)",
            },
        }
    }
    PerformHttpRequest(webhookURL, function(err, text, headers) end, 'POST', json.encode({username = "FiveM Logs", embeds = connect}), { ['Content-Type'] = 'application/json' })
end