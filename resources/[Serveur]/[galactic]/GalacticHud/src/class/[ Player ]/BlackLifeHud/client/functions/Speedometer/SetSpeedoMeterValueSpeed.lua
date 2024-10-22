---@return void
function _GamemodeHud:SetSpeedoMeterValueSpeed(value)

    if(value < 100 and value > 10) then
        value = '0'..tostring(value)
    elseif (value < 10) then
        value = '00'..tostring(value)
    end

    sendUIMessage({
        event = 'SetValueSpeed',
        value = value
    })

end