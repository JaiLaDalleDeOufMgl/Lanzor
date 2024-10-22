function MOD_inventory:loadGangInventory(jobName, inventory, slots, maxweight, class)
    self.InventoryCache.gang[jobName] = _GamemodeInventory('coffregang', inventory, nil, slots, maxweight, class)

    return (self.InventoryCache.gang[jobName])
end