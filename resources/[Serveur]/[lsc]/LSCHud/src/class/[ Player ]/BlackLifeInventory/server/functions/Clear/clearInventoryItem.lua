function _GamemodeInventory:clearInventoryItem()
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].type == "item") then
            self.inventoryItems[i] = "empty"
        end
    end

    self:updateInventory()
end