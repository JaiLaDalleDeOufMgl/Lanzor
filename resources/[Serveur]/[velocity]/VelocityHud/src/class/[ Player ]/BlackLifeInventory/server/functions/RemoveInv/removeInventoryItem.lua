function _GamemodeInventory:removeInventoryItem(name, count, itemid)
    local ItemInfo = MOD_Items:getItem(name)

    if (ItemInfo == nil) then print("This Item not exist", name) return false end
    if (count < 0) then print("Negatif count") return false end

    if (itemid) then
        print("REMOVE ITEM UNIQUE BY ID")
    else
        local Remaining = tonumber(count)
        local ItemCount = self:getItemCount(name)
        local SlotItem

        if (ItemCount < 1) then
            return false
        end

        for i=1, #self.inventoryItems, 1 do
            if (self.inventoryItems[i].name == name and Remaining > 0) then
                if (self.inventoryItems[i].count < Remaining) then
                    Remaining = (Remaining - self.inventoryItems[i].count)

                    self.inventoryItems[i] = "empty"
                elseif (self.inventoryItems[i].count >= Remaining) then
                    self.inventoryItems[i].count = (self.inventoryItems[i].count - Remaining)
                    if (self.inventoryItems[i].count < 1) then
                        self.inventoryItems[i] = "empty"
                    end

                    Remaining = 0
                end

                SlotItem = i
            end
        end

        self:updatePlayerSlot(SlotItem, self.inventoryItems[SlotItem]) 
        self:syncToPlayers()

        if (Remaining < 1) then
            return true
        end
    end
end