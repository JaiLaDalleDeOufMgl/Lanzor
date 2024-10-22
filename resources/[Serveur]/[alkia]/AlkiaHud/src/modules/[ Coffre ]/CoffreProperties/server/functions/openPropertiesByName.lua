function MOD_CoffreProperties:openPropertiesByName(xPlayer, propertiesName)
    local SelectPropertiesTrunk = MOD_CoffreProperties:GetPropertiesCoffreByName(propertiesName)

    SelectPropertiesTrunk.inventoryClass:updateSecondInventory(xPlayer.source)
    SelectPropertiesTrunk.inventoryClass:addPlayer(xPlayer.source)
    
    xPlayer.set('SecondInvData', SelectPropertiesTrunk)
end