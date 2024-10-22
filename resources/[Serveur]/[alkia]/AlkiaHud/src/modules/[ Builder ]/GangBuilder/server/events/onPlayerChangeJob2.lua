AddEventHandler('esx:setJob2', function(playerId, job2, lastJob2)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local lastGang = MOD_GangBuilder:getGangByName(lastJob2.name)
    local Gang = MOD_GangBuilder:getGangByName(job2.name)
    
    if (lastGang) then
        lastGang:RemoveMembre(xPlayer.identifier, lastJob2.name == "unemployed2" or false)
    end

    if (Gang) then
        Gang:AddMembre(xPlayer, job2);
    end
end)