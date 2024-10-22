---@return void
function _GamemodeHud:SetRadioStatus(bool)

    sendUIMessage({
        event = 'SetRadioStatus',
        RadioStatus = bool
    })

end