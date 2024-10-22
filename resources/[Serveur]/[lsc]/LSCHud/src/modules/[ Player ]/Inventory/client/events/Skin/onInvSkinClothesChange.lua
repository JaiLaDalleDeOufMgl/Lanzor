MOD_inventory.ClohtesOnAnim = false

RegisterNetEvent('Gamemode:Inventory:InvSkinClothesChange')
AddEventHandler('Gamemode:Inventory:InvSkinClothesChange', function(data, reset, animation, saveSkin)
    if (animation) then
        MOD_inventory.ClohtesOnAnim = true

        local lib, anim = 'clothingtie', 'try_tie_neutral_a'
        ESX.Streaming.RequestAnimDict(lib, function()
            TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
        end)
        Wait(2500)
        ClearPedTasks(PlayerPedId())

        MOD_inventory.ClohtesOnAnim = false
    end

    MOD_inventory.ClohtesOnAnim = false

    if (reset) then
        for key, index in pairs(data) do
            local ResetIndex = Gamemode.enums.Player.defaultClothes[key]

            TriggerEvent('skinchanger:change', key, ResetIndex)
        end
    else
        for key, index in pairs(data) do
            TriggerEvent('skinchanger:change', tostring(key), tonumber(index))
        end
    end

    if (saveSkin) then
        TriggerEvent("skinchanger:getSkin", function(skin)
            TriggerServerEvent("esx_skin:save", skin)
        end)
    end
end)