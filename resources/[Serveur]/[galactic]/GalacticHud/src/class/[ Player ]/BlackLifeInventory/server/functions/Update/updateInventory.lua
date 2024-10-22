function _GamemodeInventory:updateInventory()
    self:reloadWeight()

    TriggerClientEvent('Gamemode:Inventory:UpdatePlayerInventory', self.class.source, self.inventoryItems, self.inventoryClothes, self.weight, self.maxweight)

end