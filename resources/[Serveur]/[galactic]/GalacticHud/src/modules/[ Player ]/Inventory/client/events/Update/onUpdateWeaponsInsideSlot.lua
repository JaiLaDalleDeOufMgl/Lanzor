RegisterNetEvent('Gamemode:Inventory:UpdateWeaponsInsideSlot')
AddEventHandler('Gamemode:Inventory:UpdateWeaponsInsideSlot', function(FromData, ToData, weight, maxWeight)
    MOD_inventory.class:updateWeaponsInsideSlot(FromData, ToData, weight, maxWeight)
end)