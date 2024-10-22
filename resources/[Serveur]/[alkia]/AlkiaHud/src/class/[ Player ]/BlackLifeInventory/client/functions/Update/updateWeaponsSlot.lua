function _GamemodeInventory:updateWeaponsSlot(InvData, WeaponsData, weight, maxWeight)
    self.inventoryStatic = {
        weight = weight,
        maxWeight = maxWeight
    }

    self.inventoryItems[InvData.index] = InvData.data
    self.inventoryWeapons[WeaponsData.index] = WeaponsData.data

    self:setPlayerInventoryUi()
end