function _GamemodeInventory:moveItemInside(from, to, count)
    local fromItem = json.decode(json.encode(self.inventoryItems[from]))
    local toItem = json.decode(json.encode(self.inventoryItems[to]))


    if not fromItem or not fromItem.count or not toItem then
        -- print('Item is not exist in the inventory. Event: moveItemInside')
        return
    end

    local ItemInfo_FROM = MOD_Items:getItem(fromItem.name)
    local ItemInfo_TO = MOD_Items:getItem(toItem.name)

    if (not ItemInfo_FROM and fromItem ~= 'empty') or (not ItemInfo_TO and toItem ~= 'empty') then
        -- print('Item is not exist in the system')
        return
    end

    if not count or count > fromItem.count then count = fromItem.count end
    
    if toItem.name == fromItem.name and (not ItemInfo_TO.unique or not ItemInfo_FROM.unique) then
        if count == fromItem.count then
            self.inventoryItems[to].count = self.inventoryItems[to].count + count
            self.inventoryItems[from] = "empty"
            
            self:updatePlayerSlot(from, self.inventoryItems[from], to, self.inventoryItems[to]) 
            self:syncToPlayers()

            return true
        else
            self.inventoryItems[to].count = self.inventoryItems[to].count + count
            self.inventoryItems[from].count = self.inventoryItems[from].count - count

            self:updatePlayerSlot(from, self.inventoryItems[from], to, self.inventoryItems[to]) 
            self:syncToPlayers()

            return true
        end
    elseif toItem ~= "empty" and fromItem ~= "empty" and toItem.name ~= fromItem.name then
        self.inventoryItems[to] = fromItem
        self.inventoryItems[from] = toItem

        self:updatePlayerSlot(from, self.inventoryItems[from], to, self.inventoryItems[to]) 
        self:syncToPlayers()

        return true
    elseif toItem == "empty" then
        if count == fromItem.count then
            self.inventoryItems[to] = fromItem
            self.inventoryItems[from] = "empty"

            self:updatePlayerSlot(from, self.inventoryItems[from], to, self.inventoryItems[to]) 
            self:syncToPlayers()

            return true
        else
            self.inventoryItems[to] = fromItem
            self.inventoryItems[to].count = count
            self.inventoryItems[from].count = self.inventoryItems[from].count - count
        
            self:updatePlayerSlot(from, self.inventoryItems[from], to, self.inventoryItems[to]) 
            self:syncToPlayers()

            return true
        end
    end

end