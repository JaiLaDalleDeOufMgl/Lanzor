---@return void
function _GamemodeHud:SetRadioFreq(string)

    sendUIMessage({
        event = 'SetRadioFreq',
        RadioFreq = string
    })

end