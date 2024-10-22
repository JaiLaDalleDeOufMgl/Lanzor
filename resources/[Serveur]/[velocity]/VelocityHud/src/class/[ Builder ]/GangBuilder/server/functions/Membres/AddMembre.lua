function _GamemodeGangBuilder:AddMembre(xPlayer, job)
    local MembreOwner = false

    if (job.grade == 1) then MembreOwner = true end

    self.membres[xPlayer.getIdentifier()] = {
        identifier = xPlayer.getIdentifier(),
        firstname = xPlayer.getFirstName(),
        lastname = xPlayer.getLastName(),

        isOwner = MembreOwner,
        grade = "default"
    }

    self:UpdateEvent("Gamemode:GangBuilder:ReceiveMembres", self.membres)

    self:SaveOnBdd()
end