function MOD_Zones:DeleteZone(zoneId)
    if (not self:exist(zoneId)) then print("Error: Trying delete invalid ZoneId: "..zoneId) return end

    MOD_Zones.list[zoneId] = nil

    TriggerClientEvent('Gamemode:Zones:RemoveZone', -1, zoneId)

    return
end