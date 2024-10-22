function GamemodeSociety:UpdateEmployee(identifier, grade)
    if (self.employees[identifier]) then

        local player = ESX.GetPlayerFromIdentifier(identifier)

        if (player) then
            if (grade) then
                player.setJob(self.name, grade)
            else
                player.setJob("unemployed", 0)
            end
        else
            MySQL.Async.execute("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
                ["@job"] = grade and self.name or "unemployed",
                ["@job_grade"] = grade or 0,
                ["@identifier"] = identifier
            });
        end

        if (grade) then
            self.employees[identifier].grade = self:GetGradesLabel(grade)
            self.employees[identifier].grade_level = grade
        else
            self.employees[identifier] = nil
        end
    end
end