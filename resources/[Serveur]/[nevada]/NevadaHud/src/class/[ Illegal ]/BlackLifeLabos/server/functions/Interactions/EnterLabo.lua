function _GamemodeLabos:EnterLabo(source)
    self.bucket:AddInBucket(source, "player")

    table.insert(self.ListPlayerOnLabo, source)

    local PlayerEntity = GetPlayerPed(source)
    local coordsLabo = self.exitZone.coords
    SetEntityCoords(PlayerEntity, coordsLabo.x, coordsLabo.y, coordsLabo.z)

    self.exitZone:addZoneToClient(source)

    self.Drug:EnterLabo(source, self.AccesList, self.memberList)
end