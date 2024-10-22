function _GamemodeInventory:StartkeyUtils()
    RegisterKeyMapping('+inventory', "Ouvrir/Fermer l'inventaire", 'keyboard', 'TAB')
    RegisterCommand("+inventory", function()
        MOD_inventory.class:toggleInventory()
    end)


    RegisterKeyMapping('ShortInv1', 'Raccourci inventaire (1)', 'keyboard', '1')
    RegisterKeyMapping('ShortInv2', 'Raccourci inventaire (2)', 'keyboard', '2')
    RegisterKeyMapping('ShortInv3', 'Raccourci inventaire (3)', 'keyboard', '3')
    RegisterKeyMapping('ShortInv4', 'Raccourci inventaire (4)', 'keyboard', '4')
    RegisterKeyMapping('ShortInv5', 'Raccourci inventaire (5)', 'keyboard', '5')


    CreateThread(function()
        local AntiSpan = 0

        for i=1, 5 do
            RegisterCommand('ShortInv'..i, function()
                if (AntiSpan < 3) then
                    CreateThread(function()
                        AntiSpan +=1
    
                        SetTimeout(1000, function()
                            AntiSpan = (AntiSpan - 1)
                        end)
                    end)
    
                    InvUseShort(i)
                end
            end)
        end
    end)


    function InvUseShort(index)
        local Inventory = MOD_inventory.class.inventoryWeapons
    
        for slot, item in pairs(Inventory) do
            if (slot == index) and (item ~= "empty") and (not exports['Gamemode']:checkIfPlayerIsInSafeZone()) then
                
                -- TriggerServerEvent('Gamemode:Inventory:InvUseItem', index, true, GetWeaponAmmoInv())
                TriggerServerEvent('Gamemode:Inventory:InvUseItem', index, true)
            
            end
        end
    end
end