function _GamemodeInventory:moveWeaponsToInv(from, to, count)
    local fromItem = json.decode(json.encode(self.inventoryItems['weapons'][from]))
    local toItem = json.decode(json.encode(self.inventoryItems[to]))

    if (not fromItem or not fromItem.count or not toItem) then
        -- print('^5[GamemodeHud] ^1This item is not exist in the inventory. Event: moveWeaponsToInv. ^7')
    end

    local ItemInfo_FROM = MOD_Items:getItem(fromItem.name)
    local ItemInfo_TO = MOD_Items:getItem(toItem.name)

    if (not ItemInfo_FROM and fromItem ~= "empty") or (not ItemInfo_TO and toItem ~= "empty") then
        -- print('^5[GamemodeHud] ^1Item is not exist in the system. ^7')
        return
    end

    if (toItem == "empty") then
        self.inventoryItems['weapons'][from] = "empty"
        self.inventoryItems[to] = fromItem

        self:updateWeaponsSlot(to, self.inventoryItems[to], from, self.inventoryItems['weapons'][from])
        self:syncToPlayers()

        return true
    end

    return false

end