RegisterNetEvent('Gamemode:Inventory:UpdateClothesSlot')
AddEventHandler('Gamemode:Inventory:UpdateClothesSlot', function(InvData, ClothesData, weight, maxWeight)
    MOD_inventory.class:updateClothesSlot(InvData, ClothesData, weight, maxWeight)
end)