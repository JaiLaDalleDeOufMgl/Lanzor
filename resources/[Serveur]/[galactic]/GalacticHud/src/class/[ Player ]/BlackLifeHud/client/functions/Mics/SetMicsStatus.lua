---@return void
function _GamemodeHud:SetMicStatus(bool)

    sendUIMessage({
        event = 'SetMicStatus',
        MicStatus = bool
    })

end