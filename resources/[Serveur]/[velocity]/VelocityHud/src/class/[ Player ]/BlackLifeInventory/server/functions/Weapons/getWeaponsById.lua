function _GamemodeInventory:getWeaponsById(id)
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].id == id) then
            return self.inventoryItems[i]
        end
    end
    
    for i=1, #self.inventoryItems['weapons'], 1 do
        if (self.inventoryItems['weapons'][i].id == id) then
            return self.inventoryItems['weapons'][i]
        end
    end

    return false
end