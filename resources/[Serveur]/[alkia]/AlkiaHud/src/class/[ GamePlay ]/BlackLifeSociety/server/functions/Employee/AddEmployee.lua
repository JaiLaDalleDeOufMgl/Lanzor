function GamemodeSociety:AddEmployee(xPlayer)
    local job = xPlayer.getJob()

    self.employees[xPlayer.getIdentifier()] = {
        id = xPlayer.source,
        firstname = xPlayer.getFirstName(),
        lastname = xPlayer.getLastName(),
        isBoss = self:IsPlayerBoss(xPlayer),
        identifier = xPlayer.getIdentifier(),
        grade = self:GetGradeLabel(job.grade),
        grade_level = job.grade
    }
end