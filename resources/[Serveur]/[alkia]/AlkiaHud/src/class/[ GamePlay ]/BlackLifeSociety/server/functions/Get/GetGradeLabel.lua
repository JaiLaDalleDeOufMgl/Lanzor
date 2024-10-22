function GamemodeSociety:GetGradeLabel(grade)
    for _, gradeData in pairs(self.grades) do
        if (gradeData.grade == grade) then
            return gradeData.label
        end
    end
end