function _GamemodeInventory:setSecondInventory(data, invName, weight, maxWeight)
    self.SecondInventoryStatic = {
        invName = invName,
        weight = weight,
        maxWeight = maxWeight
    }

    self.SecondInventoryItems = data

    self.SecondInventoryOpen = true

    self:setPlayerInventoryUi()
end