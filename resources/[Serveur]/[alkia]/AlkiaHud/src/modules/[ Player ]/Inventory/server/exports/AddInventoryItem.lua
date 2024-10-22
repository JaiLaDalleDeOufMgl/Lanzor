exports("addInventoryItem", function(licence, name, count, extra, bypass)
    MOD_inventory.InventoryCache.player[licence]:addInventoryItem(name, count, extra, bypass)
end)