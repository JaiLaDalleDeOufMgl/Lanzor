function _GamemodeInventory:updateWeaponsInsideSlot(FromData, ToData, weight, maxWeight)
    self.inventoryStatic = {
        weight = weight,
        maxWeight = maxWeight
    }
    
    self.inventoryWeapons[FromData.index] = FromData.data
    if (ToData) then
        self.inventoryWeapons[ToData.index] = ToData.data
    end

    self:setPlayerInventoryUi()
end