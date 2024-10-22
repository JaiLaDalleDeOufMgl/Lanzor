RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    MOD_inventory.class:setPlayerInventory(xPlayer.inventory, xPlayer.clothes, xPlayer.weight, xPlayer.maxWeight)

    -- TriggerEvent("eventName", ...)
end)