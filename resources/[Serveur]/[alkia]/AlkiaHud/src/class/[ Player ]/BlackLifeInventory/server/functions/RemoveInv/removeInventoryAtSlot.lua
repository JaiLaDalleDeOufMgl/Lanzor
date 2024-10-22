function _GamemodeInventory:removeInventoryItemAtSlot(slot, count)
    if self.inventoryItems[slot] ~= "empty" then
        local item = self.inventoryItems[slot]

        if (MOD_inventory:getWeaponIsPerma(item.name)) then return end
        if (MOD_inventory:getItemSecurActions(item)) then return end ---GET ITEM IS PROTECTED

        item.count = (item.count - count)

        if item.count < 1 then
            self.inventoryItems[slot] = "empty"
        end

        self:updatePlayerSlot(slot, self.inventoryItems[slot])
        self:syncToPlayers()

        return true
    end
end