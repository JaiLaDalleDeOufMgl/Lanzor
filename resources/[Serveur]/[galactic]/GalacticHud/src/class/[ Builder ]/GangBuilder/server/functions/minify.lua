function _GamemodeGangBuilder:minify()
    return {
        id = self.id,
        name = self.name,
        label = self.label,
        
        posGarage = self.posGarage,
        posSpawnVeh = self.posSpawnVeh,
        posDeleteVeh = self.posDeleteVeh,
        posCoffre = self.posCoffre,
        posBoss = self.posBoss,
    }
end