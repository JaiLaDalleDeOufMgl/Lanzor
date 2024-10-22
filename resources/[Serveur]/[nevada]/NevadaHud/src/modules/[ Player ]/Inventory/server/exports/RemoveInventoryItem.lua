exports("removeInventoryItem", function(licence, name, count, extra)
    MOD_inventory.InventoryCache.player[licence]:removeInventoryItem(name, count, extra)
end)