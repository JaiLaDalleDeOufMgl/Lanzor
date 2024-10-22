function MOD_CoffreBuilder:openCoffreBuilderById(xPlayer, coffreId)
    local SelectCoffreBuilder = MOD_CoffreBuilder:GetCoffreBuilderById(coffreId)


    -- local VehDistWithCoffre = #(SelectCoffreBuilder.coordsCoffre - GetEntityCoords(GetPlayerPed(xPlayer.source)))
    -- if (VehDistWithCoffre > 5.0) then
    --     return
    -- end


    SelectCoffreBuilder.inventoryClass:updateSecondInventory(xPlayer.source)
    SelectCoffreBuilder.inventoryClass:addPlayer(xPlayer.source)
    
    xPlayer.set('SecondInvData', SelectCoffreBuilder)
end