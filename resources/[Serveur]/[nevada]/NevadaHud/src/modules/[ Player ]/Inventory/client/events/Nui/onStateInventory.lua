AddEventHandler('Gamemode:Innventory:InventoryState', function(bool)
    MOD_inventory.class:setInventoryVisible(bool)
end)