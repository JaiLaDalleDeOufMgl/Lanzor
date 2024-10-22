function _GamemodeInventory:reloadWeight()
    self.weight = 0

    for i=1, #self.inventoryItems, 1 do
        local d = self.inventoryItems[i]

        if (d.name ~= nil) then
            local ItemInfos = MOD_Items:getItem(d.name)

            if (ItemInfos == nil) then
                print('PB', d.name)
            end

            self.weight += (ItemInfos.weight * d.count)
        end
    end
    
    if (self.type == 'player') then
        for i=1, #self.inventoryItems['weapons'], 1 do
            local d = self.inventoryItems['weapons'][i]

            if (d.name ~= nil) then
                local ItemInfos = MOD_Items:getItem(d.name)

                self.weight += (ItemInfos.weight * d.count)
            end
        end
    end

end