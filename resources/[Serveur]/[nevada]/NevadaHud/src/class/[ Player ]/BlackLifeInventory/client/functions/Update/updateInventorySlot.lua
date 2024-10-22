function _GamemodeInventory:updateInventorySlot(fromData, toData, weight, maxWeight)
    self.inventoryStatic = {
        weight = weight,
        maxWeight = maxWeight
    }
    
    self.inventoryItems[fromData.index] = fromData.data
    if (toData) then
        self.inventoryItems[toData.index] = toData.data
    end

    self:setPlayerInventoryUi()
end