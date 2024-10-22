function _GamemodeGangBuilder:GetPlayerGradeByLicense(license, accesName)
    for identifier, membre in pairs(self.membres) do
        if (identifier == license) then
            if (membre.isOwner) then return true end

            if (next(self.grades) == nil) then return false end

            return self.grades[membre.grade][accesName] or false
        end
    end

    return false
end