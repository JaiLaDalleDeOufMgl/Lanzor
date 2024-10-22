function GamemodeSociety:SetSalary(gradeLevel, salary)
    for level, gradeData in pairs(self.grades) do
        if (gradeData.grade == gradeLevel) then
            self.grades[level].salary = salary

            MySQL.Async.execute("UPDATE job_grades SET salary=@salary WHERE job_name=@job_name AND grade=@grade", {
                ["@job_name"] = self.name,
                ["@grade"] = gradeLevel,
                ["@salary"] = tonumber(salary)
            })

            break
        end
    end
end