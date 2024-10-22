function _GamemodeInventory:getAccount(accountName)
    for i=1, #self.inventoryItems, 1 do
        if (self.inventoryItems[i].type == "accounts" and self.inventoryItems[i].name == accountName) then
            return { name = accountName, money = self.inventoryItems[i].count }
        end
    end

    return { name = accountName, money = 0 }
end