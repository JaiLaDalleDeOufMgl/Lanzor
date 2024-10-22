---@return void
function _GamemodeHud:SetSpeedoMeterVisible(bool)

    sendUIMessage({
        ShowSpeedoMeter = bool
    })

    self.StateSpeedoMeter = bool

end