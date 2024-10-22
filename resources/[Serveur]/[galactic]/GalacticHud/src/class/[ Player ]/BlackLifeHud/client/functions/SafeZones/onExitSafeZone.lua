---@return void
function _GamemodeHud:onExitSafeZone(time)

    sendUIMessage({
        event = 'ExitSafeZone',
        time = time
    })

end