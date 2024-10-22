function GamemodeSociety:IsOfflinePlayerBoss(playerData)
    for _, gradeData in pairs(self.grades) do
        if (gradeData.name == "boss") then
            if (gradeData.grade == playerData["job_grade"]) then
                return true
            end
        end
    end

    return false
end