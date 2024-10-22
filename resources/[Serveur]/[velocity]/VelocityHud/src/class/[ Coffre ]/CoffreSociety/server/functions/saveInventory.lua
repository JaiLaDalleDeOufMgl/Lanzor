function _GamemodeCoffreSociety:saveInventory()
    MySQL.Async.execute('UPDATE societies_storage SET inventory = @inventory WHERE name = @name', {
        name = self.jobName,
        inventory = json.encode(MOD_inventory.InventoryCache.society[self.jobName]:saveInventory())
    })
end