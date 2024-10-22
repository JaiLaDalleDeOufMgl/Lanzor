function _GamemodeInventory:moveInvToClothes(from, to, count)
    to = 'clothes_'..to

    local fromItem = json.decode(json.encode(self.inventoryItems[from]))
    local toItem = json.decode(json.encode(self.inventoryClothes[to]))

    local ItemInfo_FROM = MOD_Items:getItem(fromItem.name)

    if (toItem == nil) then
        self.inventoryItems[from] = "empty"
        self.inventoryClothes[to] = fromItem

        TriggerClientEvent('Gamemode:Inventory:InvSkinClothesChange', self.class.source, fromItem.args, false, true, true)

        self:updateClothesSlot(from, self.inventoryItems[from], to, self.inventoryClothes[to]) 
        self:syncToPlayers()

        return true
    end
end