RegisterNetEvent('Gamemode:Inventory:ClosePlayerInventory')
AddEventHandler('Gamemode:Inventory:ClosePlayerInventory', function()
    MOD_inventory.class:closeInventory()
end)

exports("CloseInventory", function()
    MOD_inventory.class:closeInventory()
end)