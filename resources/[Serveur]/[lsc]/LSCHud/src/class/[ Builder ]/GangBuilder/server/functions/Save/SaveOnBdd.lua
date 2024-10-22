function _GamemodeGangBuilder:SaveOnBdd()

    MySQL.Async.execute("UPDATE GangBuilder SET grades = @grades, membres = @membres WHERE id = @id", {
        ["@id"] = self.id,
        ["@grades"] = json.encode(self.grades),
        ["@membres"] = json.encode(self:MembreTemplate()),
    })

end