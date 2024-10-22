---@return void
function _GamemodeHud:SetHudVisible(bool)

    sendUIMessage({
        ShowHud = bool
    })

    self.StateHud = bool

end