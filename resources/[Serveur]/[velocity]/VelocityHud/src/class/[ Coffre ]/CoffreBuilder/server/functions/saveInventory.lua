function _GamemodeCoffreBuilder:saveInventory()
    MySQL.Async.execute('UPDATE chestbuilder SET items = @items WHERE id = @id', {
        id = self.idCoffre,
        items = json.encode(MOD_inventory.InventoryCache.coffrebuilder[self.idCoffre]:saveInventory())
    })
end