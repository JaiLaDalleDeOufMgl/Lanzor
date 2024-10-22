function _GamemodeInventory:setWeaponsAmmoById(id, ammo)

    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].id == id) then
            self.inventoryItems[i].args.ammo = ammo
        end
    end
    
    for i=1, #self.inventoryItems['weapons'], 1 do
        if (self.inventoryItems['weapons'][i].id == id) then
            self.inventoryItems['weapons'][i].args.ammo = ammo
        end
    end

end