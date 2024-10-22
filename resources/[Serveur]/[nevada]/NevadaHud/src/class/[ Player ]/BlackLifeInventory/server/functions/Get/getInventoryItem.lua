function _GamemodeInventory:getInventoryItem(name)
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].name == name) then
            return self.inventoryItems[i]
        end
    end

    return false
end