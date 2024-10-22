function _GamemodeDrugWeed:ExitLabo(source)
    self.plotManag:removeZoneToClient(source)
    self.securityManag:removeZoneToClient(source)

    TriggerClientEvent('Gamemode:Labo:ExitLabo', source, 'weed')
end