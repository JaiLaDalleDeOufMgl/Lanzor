function MOD_Zones:AddZone(coords, handler, requireJob, interactDistance, helpText, notSendCl)
    local NewZoneId = #MOD_Zones.list + 1

    if (MOD_Zones.list[NewZoneId]) then print("Error: This zone already exists") return end

    MOD_Zones.list[NewZoneId] = _GamemodeZones(NewZoneId, coords, handler, requireJob, interactDistance, helpText, notSendCl)

    if (not MOD_Zones.list[NewZoneId].notSendCl) then
        TriggerClientEvent('Gamemode:Zones:AddZone', -1, MOD_Zones.list[NewZoneId]:minify())
    end

    return (MOD_Zones.list[NewZoneId])
end