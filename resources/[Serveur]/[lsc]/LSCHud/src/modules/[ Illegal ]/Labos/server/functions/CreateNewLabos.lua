function MOD_Labos:CreateNewLabos(owner, _type, enterCoords)
    local laboId = math.random(999, 9999)..math.random(999, 9999)
    
    local NewLabos = MOD_Labos:AddLabos(laboId, owner, _type, enterCoords)

    MySQL.Async.execute(
        'INSERT INTO labos (id, owner, type, enterCoords, players, accesList, drugsData) VALUES (@id, @owner, @type, @enterCoords, @players, @accesList, @drugsData)',
        {
            ['@id'] = NewLabos.id,
            ['@owner'] = NewLabos.owner,
            ['@type'] = NewLabos.type,
            ['@enterCoords'] = json.encode(NewLabos.enterCoords),
            ['@players'] = json.encode({}),
            ['@accesList'] = json.encode({}),
            ['@drugsData'] = json.encode({}),
        }
    )
    
    return (NewLabos)
end