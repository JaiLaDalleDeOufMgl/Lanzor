function _GamemodeInventory:moveInvToWeapons(from, to, count)
    local fromItem = json.decode(json.encode(self.inventoryItems[from]))
    local toItem = json.decode(json.encode(self.inventoryItems['weapons'][to]))


    local ItemInfo_FROM = MOD_Items:getItem(fromItem.name)

    if (toItem == "empty") then
        self.inventoryItems[from] = "empty"
        self.inventoryItems['weapons'][to] = fromItem

        self:updateWeaponsSlot(from, self.inventoryItems[from], to, self.inventoryItems['weapons'][to]) 

        return true
    end

    return false

end