function MOD_CoffreGang:openCoffreGangByName(xPlayer, jobName)
    local GangTrunk = MOD_CoffreGang:GetGangCoffreByJobName(jobName)

    GangTrunk.inventoryClass:updateSecondInventory(xPlayer.source)
    GangTrunk.inventoryClass:addPlayer(xPlayer.source)
    
    xPlayer.set('SecondInvData', GangTrunk)
end