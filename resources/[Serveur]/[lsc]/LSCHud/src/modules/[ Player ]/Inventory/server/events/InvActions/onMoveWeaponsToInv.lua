RegisterNetEvent('Gamemode:Inventory:MoveWeaponsToInv')
AddEventHandler('Gamemode:Inventory:MoveWeaponsToInv', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (data.inventoryType == 'main') then
        MOD_inventory.InventoryCache.player[xPlayer.identifier]:moveWeaponsToInv(data.index, data.droppedTo, data.count)
    end
end)