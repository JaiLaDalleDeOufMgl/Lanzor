function _GamemodeInventory:saveInventory()
    local saveItems = {}

    if (self.type == "player") then
        saveItems.main = {}
        for i=1, #self.inventoryItems, 1 do
            if self.inventoryItems[i] ~= "empty" then
                if (not self:getItemIsSecure(self.inventoryItems[i], true)) then
                    table.insert(saveItems.main, {
                        name = self.inventoryItems[i].name,
                        count = self.inventoryItems[i].count,
                        slot = i,
                        label = self.inventoryItems[i].label,
                        type = self.inventoryItems[i].type,

                        id = self.inventoryItems[i].id or nil,
                        args = self.inventoryItems[i].args or nil,
                    })
                end
            end
        end

        saveItems.weapons = {}
        for i=1, #self.inventoryItems['weapons'], 1 do
            if (self.inventoryItems['weapons'][i] ~= "empty") then
                if (not self:getItemIsSecure(self.inventoryItems['weapons'][i], true)) then
                    table.insert(saveItems.weapons, {
                        name = self.inventoryItems['weapons'][i].name,
                        count = self.inventoryItems['weapons'][i].count,
                        slot = i,
                        label = self.inventoryItems['weapons'][i].label,
                        type = self.inventoryItems['weapons'][i].type,

                        id = self.inventoryItems['weapons'][i].id or nil,
                        args = self.inventoryItems['weapons'][i].args or nil,
                    })
                end
            end
        end
    else
        for i=1, #self.inventoryItems, 1 do
            if self.inventoryItems[i] ~= "empty" then
                table.insert(saveItems, {
                    name = self.inventoryItems[i].name,
                    count = self.inventoryItems[i].count,
                    slot = i,
                    label = self.inventoryItems[i].label,
                    type = self.inventoryItems[i].type,

                    id = self.inventoryItems[i].id or nil,
                    args = self.inventoryItems[i].args or nil,
                })
            end
        end
    end

    return (saveItems)
end