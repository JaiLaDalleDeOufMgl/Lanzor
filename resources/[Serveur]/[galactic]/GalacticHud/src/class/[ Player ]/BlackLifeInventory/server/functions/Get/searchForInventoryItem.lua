function _GamemodeInventory:searchForInventoryItem(name)
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].name == name) then
            local Item = {
                data = self.inventoryItems[i],
                index = i 
            }
            return (Item)
        end
    end
end