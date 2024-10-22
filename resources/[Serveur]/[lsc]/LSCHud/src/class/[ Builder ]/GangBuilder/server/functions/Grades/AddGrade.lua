function _GamemodeGangBuilder:AddGrade(gradeName)
    local gradeLabel = gradeName
    local gradeName = string.lower(gradeName)

    if (not self.grades[gradeName]) then
        self.grades[gradeName] = {
            label = gradeLabel,
            grades = Gamemode.enums.GangBuilder.DefaultGradeAcces
        }
    end

    self:UpdateEvent("Gamemode:GangBuilder:ReceiveGrades", self.grades)

    self:SaveOnBdd()
end