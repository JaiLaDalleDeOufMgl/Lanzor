Gamemode:onGamemodeReady(function()
    local GangBuilderList = MySQL.Sync.fetchAll('SELECT * FROM GangBuilder')

    for i=1, #GangBuilderList do
        local Gang = _GamemodeGangBuilder(false, {
            id = GangBuilderList[i].id,
            name = GangBuilderList[i].name, 
            label = GangBuilderList[i].label, 
            posGarage = json.decode(GangBuilderList[i].posGarage), 
            posSpawnVeh = json.decode(GangBuilderList[i].posSpawnVeh),
            posDeleteVeh = json.decode(GangBuilderList[i].posDeleteVeh),
            posCoffre = json.decode(GangBuilderList[i].posCoffre),
            posBoss = json.decode(GangBuilderList[i].posBoss),
            vehicules = json.decode(GangBuilderList[i].vehicules),
            inventory = json.decode(GangBuilderList[i].inventory),

            grades = json.decode(GangBuilderList[i].grades),
            membres = json.decode(GangBuilderList[i].membres),
        })

        if (MOD_GangBuilder.list[Gang.id] == nil) then
            MOD_GangBuilder.list[Gang.id] = Gang
        end
    end
end)