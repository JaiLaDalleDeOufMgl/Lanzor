AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local lastSociety = MOD_Society:getSocietyByName(lastJob.name)
    local society = MOD_Society:getSocietyByName(job.name)

    if (society and xPlayer) then
        if (lastSociety) then
            lastSociety:RemoveEmployee(xPlayer.identifier, false)
        end

        society:AddEmployee(xPlayer, job);

        society:UpdateBossEvent("Gamemode:Society:ReceiveEmployees", society:GetEmployees())
    end
end)