exports("getWeaponsById", function(licence, id)
    return MOD_inventory.InventoryCache.player[licence]:getWeaponsById(id)
end)