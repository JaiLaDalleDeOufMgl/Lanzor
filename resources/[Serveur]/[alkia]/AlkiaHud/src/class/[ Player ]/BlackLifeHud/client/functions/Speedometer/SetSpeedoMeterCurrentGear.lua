---@return void
function _GamemodeHud:GetVehicleCurrentGear(value)

    if (value == 0) then
        value = 'R'
    end

    sendUIMessage({
        event = 'SetValueGear',
        value = value
    })

end