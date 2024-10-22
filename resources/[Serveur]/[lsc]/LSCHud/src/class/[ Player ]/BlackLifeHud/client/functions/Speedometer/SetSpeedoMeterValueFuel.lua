---@return void
function _GamemodeHud:SetSpeedoMeterValueFuel(value)

    sendUIMessage({
        event = 'SetValueFuel',
        value = value
    })

end