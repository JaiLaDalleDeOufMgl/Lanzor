exports("getAccount", function(licence, accountName)
    return MOD_inventory.InventoryCache.player[licence]:getAccount(accountName)
end)