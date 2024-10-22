function MOD_Items:getCanUse(itemName)
    return MOD_Items.ItemsCache[itemName].isUsable
end