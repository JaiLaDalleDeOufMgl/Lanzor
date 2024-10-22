RegisterNUICallback('nui:Gamemode:Inventory:Settings', function(settings)
    MOD_inventory.class:setSettingsInventory(settings)
end)


RegisterNUICallback('nui:Gamemode:Inventory:InvMoveInside', function(data)
    TriggerServerEvent('Gamemode:Inventory:InvMoveInside', data)
end)


RegisterNUICallback('nui:Gamemode:Inventory:InvMoveToMain', function(data)
    TriggerServerEvent('Gamemode:Inventory:InvMoveToMain', data)
end)
RegisterNUICallback('nui:Gamemode:Inventory:InvMoveToSecond', function(data)
    TriggerServerEvent('Gamemode:Inventory:InvMoveToSecond', data)
end)


RegisterNUICallback('nui:Gamemode:Inventory:InvMoveInstantToMain', function(data)

end)
RegisterNUICallback('nui:Gamemode:Inventory:InvMoveInstantToSecond', function(data)

end)


RegisterNUICallback('nui:Gamemode:Inventory:InvMoveToWeapons', function(data)
    TriggerServerEvent('Gamemode:Inventory:InvMoveToWeapons', data)
end)
RegisterNUICallback('nui:Gamemode:Inventory:MoveWeaponsToInv', function(data)
    TriggerServerEvent('Gamemode:Inventory:MoveWeaponsToInv', data)
end)
RegisterNUICallback('nui:Gamemode:Inventory:MoveWeaponsInside', function(data)
    TriggerServerEvent('Gamemode:Inventory:MoveWeaponsInside', data)
end)


RegisterNUICallback('nui:Gamemode:Inventory:InvUseItem', function(index)
    if (MOD_inventory.class.inventoryItems[index].type == "weapons") then
        if (not exports['Gamemode']:checkIfPlayerIsInSafeZone()) then
            TriggerServerEvent('Gamemode:Inventory:InvUseItem', index, false)
        end
    else
        TriggerServerEvent('Gamemode:Inventory:InvUseItem', index)
    end
end)
RegisterNUICallback('nui:Gamemode:Inventory:InvGiveItem', function(data)
    MOD_inventory.class:closeInventory()
    MOD_inventory.class:loadGiveItem(data)
end)
RegisterNUICallback('nui:Gamemode:Inventory:InvDeleteItem', function(data)
    TriggerServerEvent('Gamemode:Inventory:InvDeleteItem', data)
end)



------ CLOTHES
RegisterNUICallback('nui:Gamemode:Inventory:InvMoveToClothes', function(data)
    if (MOD_inventory.ClohtesOnAnim) then return end

    TriggerServerEvent('Gamemode:Inventory:InvMoveToClothes', data)
end)

RegisterNUICallback('nui:Gamemode:Inventory:InvMoveClothesToMain', function(data)
    if (MOD_inventory.ClohtesOnAnim) then return end

    TriggerServerEvent('Gamemode:Inventory:InvMoveClothesToMain', data)
end)
RegisterNUICallback('nui:Gamemode:Inventory:InvMoveClothesToSecond', function(data)
    TriggerServerEvent('Gamemode:Inventory:InvMoveClothesToSecond', data)
end)