function _GamemodeZones:removeZoneToClient(source)
    TriggerClientEvent('Gamemode:Zones:RemoveZone', source, self.id)
end