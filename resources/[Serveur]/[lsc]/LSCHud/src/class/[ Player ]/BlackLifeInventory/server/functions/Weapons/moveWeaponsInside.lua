function _GamemodeInventory:moveWeaponsInside(from, to, count)
    local fromItem = json.decode(json.encode(self.inventoryItems['weapons'][from]))
    local toItem = json.decode(json.encode(self.inventoryItems['weapons'][to]))

    if not fromItem or not fromItem.count or not toItem then
        print('Item is not exist in the inventory. Event: moveWeaponsInside')
        return
    end

    local ItemInfo_FROM = MOD_Items:getItem(fromItem.name)
    local ItemInfo_TO = MOD_Items:getItem(toItem.name)

    if (not ItemInfo_FROM and fromItem ~= 'empty') or (not ItemInfo_TO and toItem ~= 'empty') then
        print('Item is not exist in the system')
        return
    end

    if not count or count > fromItem.count then count = fromItem.count end
    
    if toItem ~= "empty" and fromItem ~= "empty" then
        self.inventoryItems['weapons'][to] = fromItem
        self.inventoryItems['weapons'][from] = toItem

        self:updateWeaponsInsideSlot(from, self.inventoryItems['weapons'][from], to, self.inventoryItems['weapons'][to])
        self:syncToPlayers()

        return true
    elseif toItem == "empty" then
        self.inventoryItems['weapons'][to] = fromItem
        self.inventoryItems['weapons'][from] = "empty"

        self:updateWeaponsInsideSlot(from, self.inventoryItems['weapons'][from], to, self.inventoryItems['weapons'][to])
        self:syncToPlayers()
    end
end