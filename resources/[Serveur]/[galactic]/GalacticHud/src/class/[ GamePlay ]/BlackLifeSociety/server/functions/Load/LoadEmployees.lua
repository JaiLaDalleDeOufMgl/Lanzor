function GamemodeSociety:LoadEmployees()
    MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job", {
        ["@job"] = self.name
    }, function(employees)

        if (#employees > 0) then
            for i=1, #employees do

                self.employees[employees[i].identifier] = {
                    firstname = employees[i].firstname,
                    lastname = employees[i].lastname,
                    isBoss = self:IsOfflinePlayerBoss(employees[i]),
                    identifier = employees[i].identifier,
                    grade = self:GetGradeLabel(employees[i].job_grade),
                    grade_level = employees[i].job_grade
                }

            end
        end
    end)
end