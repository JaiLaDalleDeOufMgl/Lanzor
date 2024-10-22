function _GamemodeZones:addZoneToClient(source)
    TriggerClientEvent('Gamemode:Zones:AddZone', source, self:minify())
end