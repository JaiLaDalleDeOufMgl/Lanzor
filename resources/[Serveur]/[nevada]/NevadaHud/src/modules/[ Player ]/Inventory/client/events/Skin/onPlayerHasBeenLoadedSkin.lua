AddEventHandler('Gamemode:PlayerHasBeenLoadedSkin', function()

    if (MOD_inventory.class.inventoryClothes["clothes_tenue"]) then
        TriggerEvent('Gamemode:Inventory:InvSkinClothesChange', MOD_inventory.class.inventoryClothes["clothes_tenue"].args, false)
    end

    local clothesList = {
        ["clothes_haut"] = { ["tshirt_1"] = 0, ["tshirt_2"] = 0, ["torso_1"] = 0, ["torso_2"] = 0, ["arms"] = 0 },
        ["clothes_pants"] = { ["pants_1"] = 0, ["pants_2"] = 0 },
        ["clothes_shoes"] = { ["shoes_1"] = 0, ["shoes_2"] = 0 },

        ["clothes_glasses"] = { ["glasses_1"] = 0, ["glasses_2"] = 0 },
        ["clothes_mask"] = { ["mask_1"] = 0, ["mask_2"] = 0 },
        ["clothes_cap"] = { ["helmet_1"] = 0, ["helmet_2"] = 0 },
        ["clothes_bag"] = { ["bags_1"] = 0, ["bags_2"] = 0 },

        -- ["clothes_ring"] = { ["shoes_1"] = 0, ["shoes_2"] = 0 },
        ["clothes_watch"] = { ["watches_1"] = 0, ["watches_2"] = 0 },
        -- ["clothes_gilletshot"] = { ["shoes_1"] = 0, ["shoes_2"] = 0 },
        ["clothes_chain"] = { ["chain_1"] = 0, ["chain_2"] = 0 },
        ["clothes_earring"] = { ["ears_1"] = 0, ["ears_2"] = 0 },
    }

    for clotheName, data in pairs(clothesList) do
        if (MOD_inventory.class.inventoryClothes[clotheName] ~= nil) then
            TriggerEvent('Gamemode:Inventory:InvSkinClothesChange', MOD_inventory.class.inventoryClothes[clotheName].args, false, false)
        else
            TriggerEvent('Gamemode:Inventory:InvSkinClothesChange', data, true, false)
        end
    end


    TriggerEvent("skinchanger:getSkin", function(skin)
        TriggerServerEvent("esx_skin:save", skin)
    end)
end)