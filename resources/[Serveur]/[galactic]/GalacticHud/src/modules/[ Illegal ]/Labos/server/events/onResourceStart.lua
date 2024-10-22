AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    Wait(1000)
    
    local PlayerEntity = GetPlayerPed(9)
    SetEntityCoords(PlayerEntity, 168.316482543945, -1299.217529296875, 29.3641357421875)


    CreateThread(function()
        local GetLabosInBdd = MySQL.Sync.fetchAll('SELECT * FROM labos')

        for i=1, #GetLabosInBdd do
            local CoordsLabo = json.decode(GetLabosInBdd[i].enterCoords)

            local Labo = MOD_Labos:AddLabos(tonumber(GetLabosInBdd[i].id), GetLabosInBdd[i].owner, GetLabosInBdd[i].type, vector3(CoordsLabo.x, CoordsLabo.y, CoordsLabo.z), GetLabosInBdd[i])
            Labo:LoadBddData(GetLabosInBdd[i])
        end
    end)
end)



---- A DELETE
--RegisterCommand('createNewLabo', function(source, args)
    --local PlayerCoords = GetEntityCoords(GetPlayerPed(source))
    --MOD_Labos:CreateNewLabos(args[1], args[2], vector3(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z))  
--end)