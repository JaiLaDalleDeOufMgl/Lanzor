function _GamemodeInventory:updateWeaponsSlot(indexInv, InvData, indexWeapons, WeaponsData)
    self:reloadWeight()

    local InvData = { index = indexInv, data = InvData }
    local WeaponsData = { index = indexWeapons, data = WeaponsData }
    
    if (self.type == 'player') then
        TriggerClientEvent('Gamemode:Inventory:UpdateWeaponsSlot', self.class.source, InvData, WeaponsData, self.weight, self.maxweight)
    end
end