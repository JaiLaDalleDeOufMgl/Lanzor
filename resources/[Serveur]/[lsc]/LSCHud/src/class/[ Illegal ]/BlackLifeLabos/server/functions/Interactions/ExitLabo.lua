function _GamemodeLabos:ExitLabo(source)
    self.bucket:RemoveFromBucket(source, "player")

    for index, PlySrc in pairs(self.ListPlayerOnLabo) do
        if (PlySrc == source) then 
            table.remove(self.ListPlayerOnLabo, index)
        end
    end

    local PlayerEntity = GetPlayerPed(source)
    local coordsLabo = self.enterZone.coords
    SetEntityCoords(PlayerEntity, coordsLabo.x, coordsLabo.y, coordsLabo.z)

    self.exitZone:removeZoneToClient(source)
    
    self.Drug:ExitLabo(source)
end