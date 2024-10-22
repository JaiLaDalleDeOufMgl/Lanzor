function MOD_inventory:openPlayerFouilleStaff(xPlayer, playerId)
    local tPlayer = ESX.GetPlayerFromId(playerId)

    local SelectPlayerInv = MOD_inventory:getInventoryPlayerByLicense(tPlayer.identifier)

    if (SelectPlayerInv) then
        SelectPlayerInv:updateSecondInventory(xPlayer.source)
        SelectPlayerInv:addPlayer(xPlayer.source)
        
        xPlayer.set('SecondInvData', SelectPlayerInv)
    end
end