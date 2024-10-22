---@return void
function _GamemodeHud:AddNotification(title, message, level, timer)

    local data = {
        title = title, 
        message = message,
        notifLevel = level,
        timer = timer
    }

    sendUIMessage({
        event = 'AddPlayerNotification',
        notification = data
    })

end