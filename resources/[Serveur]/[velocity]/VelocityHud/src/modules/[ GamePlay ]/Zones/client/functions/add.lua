function MOD_Zones:add(zone)
    zone.helpText = (zone.helpText or "Default Help Text")

    self.list[zone.id] = zone
end