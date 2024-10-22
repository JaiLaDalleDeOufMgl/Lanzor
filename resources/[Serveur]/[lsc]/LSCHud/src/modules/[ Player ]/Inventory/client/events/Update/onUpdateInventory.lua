local FirstUpdate = true
RegisterNetEvent('Gamemode:Inventory:UpdatePlayerInventory')
AddEventHandler('Gamemode:Inventory:UpdatePlayerInventory', function(data, clothes, weight, maxWeight)
    MOD_inventory.class:setPlayerInventory(data, clothes, weight, maxWeight)
    
    if (FirstUpdate) then
        TriggerEvent('Gamemode:PlayerHasBeenLoadedSkin')
        FirstUpdate = false
    end
end)