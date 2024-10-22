RegisterNetEvent('Gamemode:Inventory:InvMoveToClothes')
AddEventHandler('Gamemode:Inventory:InvMoveToClothes', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (data.inventoryType == 'main') then
        MOD_inventory.InventoryCache.player[xPlayer.identifier]:moveInvToClothes(data.index, data.droppedTo, data.count)
    elseif (data.inventoryType == 'second') then

    end
end)