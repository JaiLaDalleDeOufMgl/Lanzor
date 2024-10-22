RegisterNetEvent('Gamemode:Inventory:OpenPlayerInventory')
AddEventHandler('Gamemode:Inventory:OpenPlayerInventory', function()
    MOD_inventory.class:openInventory()
end)

exports("OpenInventory", function(bool, func)
    MOD_inventory.class:openInventory(bool, func)
end)