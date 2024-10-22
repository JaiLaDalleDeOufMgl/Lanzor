RegisterNetEvent('Gamemode:Inventory:InvMoveInside')
AddEventHandler('Gamemode:Inventory:InvMoveInside', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if (data.inventoryType == 'main') then
        MOD_inventory.InventoryCache.player[xPlayer.identifier]:moveItemInside(data.index, data.droppedTo, data.count)
    elseif (data.inventoryType == 'second') then
        MOD_inventory:getSecondInventoryData(xPlayer.SecondInvData):moveItemInside(data.index, data.droppedTo, data.count)
    end

end)