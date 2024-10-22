function _GamemodeCoffreProperties:saveInventory()
    MySQL.Async.execute('UPDATE properties_list SET data = @data WHERE name = @name', {
        name = self.propertiesName,
        data = json.encode(MOD_inventory.InventoryCache.properties[self.propertiesName]:saveInventory())
    })
end