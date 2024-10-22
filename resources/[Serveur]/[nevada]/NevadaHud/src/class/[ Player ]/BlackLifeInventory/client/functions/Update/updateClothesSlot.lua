function _GamemodeInventory:updateClothesSlot(InvData, ClothesData, weight, maxWeight)
    self.inventoryStatic = {
        weight = weight,
        maxWeight = maxWeight
    }
    
    self.inventoryItems[InvData.index] = InvData.data
    self.inventoryClothes[ClothesData.index] = ClothesData.data

    self:setPlayerInventoryUi()
end