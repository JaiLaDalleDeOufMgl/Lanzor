---@return void
function _GamemodeHud:SetRadioUse(bool)

    sendUIMessage({
        event = 'SetRadioUse',
        RadioUse = bool
    })

end