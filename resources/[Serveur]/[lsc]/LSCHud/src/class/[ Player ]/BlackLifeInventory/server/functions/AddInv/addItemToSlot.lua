function _GamemodeInventory:addItemToSlot(slot, count, itemObj)
    if (not self.inventoryItems[slot]) then return end

    if (self.inventoryItems[slot] == "empty") then
        self.inventoryItems[slot] = itemObj
        self.inventoryItems[slot].count = count
    elseif (self.inventoryItems[slot].name == itemObj.name) then
        self.inventoryItems[slot].count = (self.inventoryItems[slot].count + count)
    end

    self:updatePlayerSlot(slot, self.inventoryItems[slot])
    self:syncToPlayers()
end