function _GamemodeInventory:LoadFilterType()
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i] ~= "empty") then
            for k=1, #ConfigGamemodeHud.filterItem['weapons'] do
                local ItemName = ConfigGamemodeHud.filterItem['weapons'][k]
                if (self.inventoryItems[i].name == ItemName) then
                    self.inventoryItems[i].filterType = 'weapons'
                end
            end
            for k=1, #ConfigGamemodeHud.filterItem['foods'] do
                local ItemName = ConfigGamemodeHud.filterItem['foods'][k]
                if (self.inventoryItems[i].name == ItemName) then
                    self.inventoryItems[i].filterType = 'foods'
                end
            end
            for k=1, #ConfigGamemodeHud.filterItem['clothes'] do
                local ItemName = ConfigGamemodeHud.filterItem['clothes'][k]
                if (self.inventoryItems[i].name == ItemName) then
                    self.inventoryItems[i].filterType = 'clothes'
                end
            end
        end
    end
end