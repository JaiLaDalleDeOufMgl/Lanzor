exports("setWeaponsAmmoById", function(licence, id, ammo)
    MOD_inventory.InventoryCache.player[licence]:setWeaponsAmmoById(id, ammo)
end)