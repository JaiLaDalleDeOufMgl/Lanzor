function _GamemodeCoffreVehicule:saveInventory()
    if (self:getVehicleIsOwned()) then
        MySQL.Async.execute('UPDATE trunk_inventory SET items = @items WHERE vehiclePlate = @plate', {
            plate = self.plate,
            items = json.encode(MOD_inventory.InventoryCache.vehicule[self.plate]:saveInventory())
        })
    end
end