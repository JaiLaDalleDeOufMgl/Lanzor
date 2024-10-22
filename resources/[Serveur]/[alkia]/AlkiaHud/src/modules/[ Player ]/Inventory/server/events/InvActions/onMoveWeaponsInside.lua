RegisterNetEvent('Gamemode:Inventory:MoveWeaponsInside')
AddEventHandler('Gamemode:Inventory:MoveWeaponsInside', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (data.inventoryType == 'weapons') then
        MOD_inventory.InventoryCache.player[xPlayer.identifier]:moveWeaponsInside(data.index, data.droppedTo, data.count)
    end
end)