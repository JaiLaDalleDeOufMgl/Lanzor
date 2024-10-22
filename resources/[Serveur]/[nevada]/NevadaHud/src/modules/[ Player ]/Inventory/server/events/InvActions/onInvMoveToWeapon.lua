RegisterNetEvent('Gamemode:Inventory:InvMoveToWeapons')
AddEventHandler('Gamemode:Inventory:InvMoveToWeapons', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (data.inventoryType == 'main') then
        MOD_inventory.InventoryCache.player[xPlayer.identifier]:moveInvToWeapons(data.index, data.droppedTo, data.count)
    end

end)