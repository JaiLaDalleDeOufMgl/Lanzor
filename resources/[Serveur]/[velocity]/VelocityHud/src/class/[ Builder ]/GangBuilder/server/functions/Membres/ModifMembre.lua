function _GamemodeGangBuilder:ModifMembre(license, name)
    self.membres[license].grade = name

    self:UpdateEvent("Gamemode:GangBuilder:ReceiveMembres", self.membres)

    self:SaveOnBdd()
end