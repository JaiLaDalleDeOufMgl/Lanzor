function _GamemodeInventory:removeWeaponSystem(weaponName)
    RemoveAllPedWeapons(GetPlayerPed(self.class.source))

    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].name == weaponName) then
            if (self.inventoryItems[i].args.antiActions) then
                self.inventoryItems[i] = "empty"
            end
        end
    end

    for i=1, #self.inventoryItems['weapons'], 1 do
        if (self.inventoryItems['weapons'][i].name == weaponName) then
            if (self.inventoryItems['weapons'][i].args.antiActions) then
                self.inventoryItems['weapons'][i] = "empty"
            end
        end
    end

    self:updateInventory()
end