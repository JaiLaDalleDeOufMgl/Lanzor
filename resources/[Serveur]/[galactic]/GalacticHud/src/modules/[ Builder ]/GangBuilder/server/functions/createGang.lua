function MOD_GangBuilder:createNewGang(name, label, posGarage, posSpawnVeh, posDeleteVeh, posCoffre, posBoss)

    if (self:getGangNameExist(name)) then print('This gang name already exists .') return end

    local NewGang = _GamemodeGangBuilder(true, { 
        name = name, 
        label = label, 
        posGarage = posGarage, 
        posSpawnVeh = posSpawnVeh,
        posDeleteVeh = posDeleteVeh,
        posCoffre = posCoffre,
        posBoss = posBoss
    })
        :RegisterInBdd()

        
    MOD_GangBuilder.list[NewGang.id] = NewGang
end