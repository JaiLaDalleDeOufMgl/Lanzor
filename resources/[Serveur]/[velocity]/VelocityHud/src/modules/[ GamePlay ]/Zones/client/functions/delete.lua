function MOD_Zones:delete(zoneId)
    self.list[zoneId] = nil
    self.drawing[zoneId] = nil
end