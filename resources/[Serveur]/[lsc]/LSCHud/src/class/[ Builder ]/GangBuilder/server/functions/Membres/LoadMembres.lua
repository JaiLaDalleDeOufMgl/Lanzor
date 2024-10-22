function _GamemodeGangBuilder:LoadMembres(dataMembres)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE job2 = @job", {
        ["@job"] = self.name
    }, function(employeesData)
        if (#employeesData > 0) then

            for i = 1, #employeesData do
                local GradeLevel = employeesData[i].job2_grade
                local MembreOwner = false

                if (GradeLevel == 1) then MembreOwner = true end

                self.membres[employeesData[i].identifier] = {
                    identifier = employeesData[i].identifier,
                    firstname = employeesData[i].firstname,
                    lastname = employeesData[i].lastname,

                    isOwner = MembreOwner,
                    grade = dataMembres and dataMembres[employeesData[i].identifier]?.grade or "default"
                }
            end

            self:SaveOnBdd()
        end
    end)
end