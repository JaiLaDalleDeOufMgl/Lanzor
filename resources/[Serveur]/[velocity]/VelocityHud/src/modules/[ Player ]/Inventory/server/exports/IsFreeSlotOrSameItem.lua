exports("isFreeSlotOrSameItem", function(licence, droppedTo, name)
    return MOD_inventory.InventoryCache.player[licence]:isFreeSlotOrSameItem(droppedTo, name)
end)