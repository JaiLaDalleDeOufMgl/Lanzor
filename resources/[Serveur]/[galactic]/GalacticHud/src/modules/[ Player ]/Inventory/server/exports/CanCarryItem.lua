exports("canCarryItem", function(licence, item, count)
    return MOD_inventory.InventoryCache.player[licence]:canCarryItem(item, count)
end)