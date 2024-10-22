function _GamemodeCoffreGang:saveInventory()
    MySQL.Async.execute('UPDATE GangBuilder SET inventory = @inventory WHERE name = @name', {
        name = self.jobName,
        inventory = json.encode(MOD_inventory.InventoryCache.gang[self.jobName]:saveInventory())
    })
end