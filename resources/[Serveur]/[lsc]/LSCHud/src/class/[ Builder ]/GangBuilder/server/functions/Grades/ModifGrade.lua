function _GamemodeGangBuilder:ModifGrade(gradeName, accesName, state)
    local gradeName = string.lower(gradeName)

    self.grades[gradeName][accesName] = state

    self:UpdateEvent("Gamemode:GangBuilder:ReceiveGrades", self.grades)

    self:SaveOnBdd()
end