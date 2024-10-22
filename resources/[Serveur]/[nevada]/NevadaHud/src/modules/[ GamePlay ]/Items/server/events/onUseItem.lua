RegisterNetEvent("Gamemode:Inventory:InvUseItem")
AddEventHandler("Gamemode:Inventory:InvUseItem", function(index, Weapons, ammo)
    local _src = source
    local index = tonumber(index)
    local xPlayer = ESX.GetPlayerFromId(_src)
    
    if (xPlayer) then
        local PlayerInventory = xPlayer.getInventory()
        local TargetItem = PlayerInventory[index]

        if (Weapons) then
            TargetItem = PlayerInventory['weapons'][index]
        end

        MOD_Items:useItem(xPlayer.source, TargetItem.name, TargetItem.args, TargetItem.id, ammo)
    end
end)