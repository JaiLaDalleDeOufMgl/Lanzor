exports("addItemToSlot", function(licence, droppedTo, count, seconditem)
    MOD_inventory.InventoryCache.player[licence]:addItemToSlot(droppedTo, count, seconditem)
end)