function MOD_inventory:getSecondInventoryData(SecondData)
    if (SecondData == nil) then return end

    if (SecondData.type == "player") then
        return MOD_inventory.InventoryCache.player[SecondData.class.identifier]
    else
        if (SecondData.inventoryClass.type == "vehicule") then
            return MOD_inventory.InventoryCache.vehicule[SecondData.plate]
        elseif (SecondData.inventoryClass.type == "properties") then
            return MOD_inventory.InventoryCache.properties[SecondData.propertiesName]
        elseif (SecondData.inventoryClass.type == "coffrebuilder") then
            return MOD_inventory.InventoryCache.coffrebuilder[SecondData.idCoffre]
        elseif (SecondData.inventoryClass.type == "coffresociety") then
            return MOD_inventory.InventoryCache.society[SecondData.jobName]
        elseif (SecondData.inventoryClass.type == "coffregang") then
            return MOD_inventory.InventoryCache.gang[SecondData.jobName]
        end
    end
end