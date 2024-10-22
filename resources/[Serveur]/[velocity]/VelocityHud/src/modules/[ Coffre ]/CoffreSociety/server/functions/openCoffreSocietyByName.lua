function MOD_CoffreSociety:openCoffreSocietysByName(xPlayer, jobName)
    local SelectSocietyTrunk = MOD_CoffreSociety:GetSocietyCoffreByJobName(jobName)

    -- local VehDistWithCoffre = #(CoordsCoffre - GetEntityCoords(GetPlayerPed(xPlayer.source)))
    -- if (VehDistWithCoffre > 5.0) then
    --     return
    -- end

    SelectSocietyTrunk.inventoryClass:updateSecondInventory(xPlayer.source)
    SelectSocietyTrunk.inventoryClass:addPlayer(xPlayer.source)
    
    xPlayer.set('SecondInvData', SelectSocietyTrunk)
end