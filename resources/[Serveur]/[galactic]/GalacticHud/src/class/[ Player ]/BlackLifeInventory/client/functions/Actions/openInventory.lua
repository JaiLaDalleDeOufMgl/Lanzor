function _GamemodeInventory:openInventory(bool, func)
    if (bool) then func() end

    SetTimecycleModifier("hud_def_blur")

    if (self.settings.PedEnable) then
        self:CreatePedScreen(true)
    end

    self:SetKeepInputMode(true)
    DisplayRadar(false)

    self:setInventoryVisible(true)
    SetNuiFocus(true, true)

end