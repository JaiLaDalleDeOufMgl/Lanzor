exports("getInventory", function(licence)
    return MOD_inventory.InventoryCache.player[licence].inventoryItems
end)