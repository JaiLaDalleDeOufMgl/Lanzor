function _GamemodeInventory:updateWeaponsInsideSlot(indexFrom, fromData, indexTo, toData)
    self:reloadWeight()

    local FromDataSend = { index = indexFrom, data = fromData }
    local ToDataSend

    if (indexTo or toData) then
        ToDataSend = { index = indexTo, data = toData }
    else
        ToDataSend = false
    end

    if (self.type == 'player') then
        TriggerClientEvent('Gamemode:Inventory:UpdateWeaponsInsideSlot', self.class.source, FromDataSend, ToDataSend, self.weight, self.maxweight)
    end
end