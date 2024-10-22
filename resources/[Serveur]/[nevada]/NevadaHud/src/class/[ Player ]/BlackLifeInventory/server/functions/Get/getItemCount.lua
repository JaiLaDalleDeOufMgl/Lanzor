function _GamemodeInventory:getItemCount(name)
    local count = 0

    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].name == name) then
            count += self.inventoryItems[i].count
        end
    end

    return count
end