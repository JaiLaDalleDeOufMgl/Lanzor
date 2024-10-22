function _GamemodeGangBuilder:RegisterInBdd()
    local SQL = MySQL.Sync.fetchAll('INSERT INTO GangBuilder (name, label, posGarage, posSpawnVeh, posDeleteVeh, posCoffre, posBoss, vehicules, inventory, grades, membres) VALUES (@name, @label, @posGarage, @posSpawnVeh, @posDeleteVeh, @posCoffre, @posBoss, @vehicules, @inventory, @grades, @membres)', {
        ["name"] = self.name, 
        ["label"] = self.label,

        ["posGarage"] = json.encode(self.posGarage.coords),
        ["posSpawnVeh"] = json.encode(self.posSpawnVeh),
        ["posDeleteVeh"] = json.encode(self.posDeleteVeh.coords),
        ["posCoffre"] = json.encode(self.posCoffre.coords),
        ["posBoss"] = json.encode(self.posBoss.coords),

        ["vehicules"] = json.encode(self.vehicles or {}),
        ["inventory"] = json.encode({}),

        ["grades"] = json.encode({}),
        ["membres"] = json.encode({}),
    })

    MySQL.Sync.fetchAll('INSERT INTO jobs (name, label, societyType) VALUES (@name, @label, @societyType)', {
        ["name"] = self.societies.name, 
        ["label"] = self.societies.label,

        ["societyType"] = 2,
    })

    for _, grade in pairs(self.societies.grades) do
        MySQL.Async.execute("INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {

            ['@job_name'] = self.societies.name,
            ['@grade'] = grade.grade,
            ['@name'] = grade.name,
            ['@label'] = grade.label,
            ['@salary'] = 0,
            ['@skin_male'] = json.encode({}),
            ['@skin_female'] = json.encode({})
        });
    end
    
    TriggerEvent("esx:SocietyAdded", self.societies, 2);

    self.id = SQL.insertId

    return (self)
end