---@return void
function _GamemodeHud:SetMicState(int)

    sendUIMessage({
        event = 'SetMicState',
        MicState = int
    })

end