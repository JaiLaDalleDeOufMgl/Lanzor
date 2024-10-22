function MOD_Items:useItem(source, itemName, args, id, ammo)
    if (MOD_Items:getCanUse(itemName)) then
        MOD_Items.ItemsCache[itemName].usable.callback(source, args, id, ammo)
    end
end