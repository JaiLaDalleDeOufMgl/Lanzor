function _GamemodeInventory:addInventoryItem(name, count, args, bypass)
    local ItemInfo = MOD_Items:getItem(name)

    if (ItemInfo == nil) then
        print("This Item not exist", name)
        return false
    end
    if (count < 0) then
        print("Negatif count")
        return false
    end

    local NewSeight = (ItemInfo.weight * count) + self.weight
    if (ItemInfo.weight ~= 0 and not bypass and NewSeight >= self.maxweight) then
        local xPlayer = ESX.GetPlayerFromId(self.class.source)
        xPlayer.showNotification("Vous n'avez plus de place !")
        return
    end

    if (not ItemInfo.unique) then
        if (args ~= nil) then return false end

        local HasItem = self:searchForInventoryItem(name)

        if (HasItem) then
            self.inventoryItems[HasItem.index].count = tonumber(HasItem.data.count + count)

            self:updatePlayerSlot(HasItem.index, self.inventoryItems[HasItem.index])
            self:syncToPlayers()

            return true
        else
            local AvailableSlot = self:availableSlot()
            if (AvailableSlot) then
                self.inventoryItems[AvailableSlot] = {
                    id = false,
                    name = name,
                    count = tonumber(count),
                    type = ItemInfo.type,
                    label = ItemInfo.label
                }

                self:updatePlayerSlot(AvailableSlot, self.inventoryItems[AvailableSlot])
                self:syncToPlayers()

                return true
            else
                local xPlayer = ESX.GetPlayerFromId(self.class.source)
                xPlayer.showNotification("Vous n'avez plus de place !")
                return false
            end
        end
    else
        if (args == nil) then return false end

        local AvailableSlot = self:availableSlot()
        if (AvailableSlot) then
            self.inventoryItems[AvailableSlot] = {
                id = tostring(math.random(1000, 9999)) .. "-" .. tostring(math.random(1000, 9999)),
                name = name,
                count = 1,
                type = ItemInfo.type,
                label = ItemInfo.label,
                args = args
            }

            self:updatePlayerSlot(AvailableSlot, self.inventoryItems[AvailableSlot])
            self:syncToPlayers()

            return true
        else
            local xPlayer = ESX.GetPlayerFromId(self.class.source)
            xPlayer.showNotification("Vous n'avez plus de place !")
            return false
        end
    end
end
