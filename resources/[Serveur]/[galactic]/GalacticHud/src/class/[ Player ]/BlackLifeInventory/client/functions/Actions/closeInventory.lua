function _GamemodeInventory:closeInventory()

    SetTimecycleModifier()

    self:DeletePedScreen()
 
    self:SetKeepInputMode(false)
    DisplayRadar(true)

    self:setInventoryVisible(false)
    SetNuiFocus(false, false)

end