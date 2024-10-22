---@return void
function _GamemodeHud:onEnterSafeZone(time)
    
    sendUIMessage({
        event = 'EnterSafeZone',
        time = time
    })

end