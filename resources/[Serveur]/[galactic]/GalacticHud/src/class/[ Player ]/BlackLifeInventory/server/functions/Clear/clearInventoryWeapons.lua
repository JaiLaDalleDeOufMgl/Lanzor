function _GamemodeInventory:clearAllInventoryWeapons(perma)
    RemoveAllPedWeapons(GetPlayerPed(self.class.source))

    local WeaponDelete = {}

    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].type == "weapons") then
            if (not MOD_inventory:getWeaponIsPerma(self.inventoryItems[i].name)) then
                table.insert(WeaponDelete, self.inventoryItems[i])

                self.inventoryItems[i] = "empty"
            else
                if (perma) then
                    table.insert(WeaponDelete, self.inventoryItems[i])

                    self.inventoryItems[i] = "empty"
                end
            end
        end
    end

    for i=1, #self.inventoryItems['weapons'], 1 do
        if (self.inventoryItems['weapons'][i].type == "weapons") then
            if (not MOD_inventory:getWeaponIsPerma(self.inventoryItems['weapons'][i].name)) then
                table.insert(WeaponDelete, self.inventoryItems['weapons'][i])

                self.inventoryItems['weapons'][i] = "empty"
            else
                if (perma) then
                    table.insert(WeaponDelete, self.inventoryItems['weapons'][i])

                    self.inventoryItems['weapons'][i] = "empty"
                end
            end
        end
    end

    self:updateInventory()


    return WeaponDelete
end