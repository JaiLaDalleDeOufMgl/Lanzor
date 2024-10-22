exports("saveInventory", function(licence)
    return MOD_inventory.InventoryCache.player[licence]:saveInventory()
end)