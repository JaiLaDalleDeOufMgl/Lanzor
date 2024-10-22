exports("getWeight", function(licence)
    return MOD_inventory.InventoryCache.player[licence]:getInventoryWeight()
end)