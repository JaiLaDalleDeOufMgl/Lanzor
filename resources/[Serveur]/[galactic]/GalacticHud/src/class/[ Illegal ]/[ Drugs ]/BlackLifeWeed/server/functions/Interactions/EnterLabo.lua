function _GamemodeDrugWeed:EnterLabo(source, accesList, memberList)
    self.plotManag:addZoneToClient(source)
    self.securityManag:addZoneToClient(source)

    TriggerClientEvent('Gamemode:Labo:EnterLabo', source, 'weed', accesList, memberList, self.plotList)
end