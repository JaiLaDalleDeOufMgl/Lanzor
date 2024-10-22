exports("getInventoryItem", function(licence, name)
    return MOD_inventory.InventoryCache.player[licence]:getInventoryItem(name)
end)