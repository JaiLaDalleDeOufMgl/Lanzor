exports("removeInventoryItemAtSlot", function(licence, slot, count)
    return MOD_inventory.InventoryCache.player[licence]:removeInventoryItemAtSlot(slot, count)
end)