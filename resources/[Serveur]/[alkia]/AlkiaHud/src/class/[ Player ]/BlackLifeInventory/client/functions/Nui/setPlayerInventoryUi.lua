function _GamemodeInventory:setPlayerInventoryUi()
    self:LoadFilterType()

    sendUIMessage({
        event = 'UpdatePlayerInventory',
        inventory = {
            static = self.inventoryStatic,
            main = self.inventoryItems,
            weapons = self.inventoryWeapons,
            clothes = self.inventoryClothes,
        },
    })

    sendUIMessage({
        event = 'UpdateSecondInventory',
        secondInventory = {
            SecondInventory = self.SecondInventoryItems,
            SecondInventoryStatic = self.SecondInventoryStatic
        }
    })

end