function GamemodeSociety:IsPlayerBoss(xPlayer)
    if (xPlayer and type(xPlayer) == "table") then
        if (xPlayer.job == nil) then
            return
        end

        if (xPlayer.job.name == self.name) then
            return xPlayer.job.grade_name == "boss"
        end
    end

    return false
end