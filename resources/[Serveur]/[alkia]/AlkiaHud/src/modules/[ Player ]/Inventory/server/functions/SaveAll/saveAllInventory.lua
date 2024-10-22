function MOD_inventory:saveAllInventory()
    -- for key,vehicle in pairs(MOD_inventory.InventoryCache.vehicule) do
    --     MySQL.Async.execute('UPDATE trunk_inventory SET items = @items WHERE vehiclePlate = @plate', {
    --         plate = vehicle.class.plate,
    --         items = json.encode(vehicle:saveInventory())
    --     })
    -- end
    
    -- for key, society in pairs(MOD_inventory.InventoryCache.society) do
    --     MySQL.Async.execute('UPDATE societies_storage SET inventory = @inventory WHERE name = @name', {
    --         name = society.vehicle.jobName,
    --         inventory = json.encode(society:saveInventory())
    --     })
    -- end
    
    -- for key, coffreBuilder in pairs(MOD_inventory.InventoryCache.coffrebuilder) do
    --     MySQL.Async.execute('UPDATE chestbuilder SET items = @items WHERE id = @id', {
    --         id = coffreBuilder.class.idCoffre,
    --         items = json.encode(coffreBuilder:saveInventory())
    --     })
    -- end

    -- for key, properties in pairs(MOD_inventory.InventoryCache.properties) do
    --     MySQL.Async.execute('UPDATE properties_list SET data = @data WHERE name = @name', {
    --         name = properties.class.propertiesName,
    --         data = json.encode(properties:saveInventory())
    --     })
    -- end
end