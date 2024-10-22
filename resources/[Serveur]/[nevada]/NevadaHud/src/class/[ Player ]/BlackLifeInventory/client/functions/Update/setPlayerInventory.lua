function _GamemodeInventory:setPlayerInventory(data, clothes, weight, maxWeight)
    self.inventoryStatic = {
        weight = weight,
        maxWeight = maxWeight
    }

    if (data.weapons) then
        self.inventoryWeapons = data.weapons
        data.weapons = nil
    end

    self.inventoryClothes = clothes
    
    self.inventoryItems = data

    self:setPlayerInventoryUi()
end