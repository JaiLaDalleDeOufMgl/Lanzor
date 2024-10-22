function _GamemodeInventory:availableSlot()
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i] == "empty") then
            return i
        end
    end
end