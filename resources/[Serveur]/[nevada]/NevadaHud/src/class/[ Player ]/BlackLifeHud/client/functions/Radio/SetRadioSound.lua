---@return void
function _GamemodeHud:SetRadioSound(sound, valume)

    sendUIMessage({
        event = 'SetRadioSound',
        dataSound = {
            sound = sound,
            volume = valume
        }
    })

end