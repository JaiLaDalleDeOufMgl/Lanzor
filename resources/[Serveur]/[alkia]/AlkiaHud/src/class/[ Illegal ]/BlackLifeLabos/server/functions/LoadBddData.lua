function _GamemodeLabos:LoadBddData(data)
    self.AccesList = json.decode(data.accesList)
    self.memberList = json.decode(data.memberList)

    self.Drug:LoadDrugData(json.decode(data.drugsData))
end