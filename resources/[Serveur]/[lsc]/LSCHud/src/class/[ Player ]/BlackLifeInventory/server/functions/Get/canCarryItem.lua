function _GamemodeInventory:canCarryItem(name, count)
    local ItemInfo = MOD_Items:getItem(name)

    if (ItemInfo ~= nil) then
        local itemWeight = ItemInfo.weight
        
        local newWeight = self.weight + (itemWeight * count)

        return newWeight <= self.maxweight
    end
end