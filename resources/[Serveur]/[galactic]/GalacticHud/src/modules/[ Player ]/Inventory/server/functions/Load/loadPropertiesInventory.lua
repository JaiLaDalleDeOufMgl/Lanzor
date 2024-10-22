function MOD_inventory:loadPropertiesInventory(nameProperties, data, slots, maxweight, class)
    MOD_inventory.InventoryCache.properties[nameProperties] = _GamemodeInventory('properties', data, nil, slots, maxweight, class)

    return (MOD_inventory.InventoryCache.properties[nameProperties])
end