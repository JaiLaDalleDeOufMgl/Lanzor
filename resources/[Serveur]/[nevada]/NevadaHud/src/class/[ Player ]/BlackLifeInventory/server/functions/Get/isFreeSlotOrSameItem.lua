function _GamemodeInventory:isFreeSlotOrSameItem(slot, name)
    local ItemInfos = MOD_Items:getItem(name)
    if (not ItemInfos) then return end

    if (self.inventoryItems[slot] == "empty") then
        return true
    elseif (self.inventoryItems[slot].name == name and not ItemInfos.unique) then
        return true
    end

    return false
end