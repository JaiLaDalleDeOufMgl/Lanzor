RegisterNetEvent('Gamemode:Inventory:UpdateWeaponsSlot')
AddEventHandler('Gamemode:Inventory:UpdateWeaponsSlot', function(InvData, WeaponsData, weight, maxWeight)
    MOD_inventory.class:updateWeaponsSlot(InvData, WeaponsData, weight, maxWeight)
end)