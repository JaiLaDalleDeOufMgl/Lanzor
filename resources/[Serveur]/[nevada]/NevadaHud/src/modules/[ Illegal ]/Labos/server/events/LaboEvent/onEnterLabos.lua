AddEventHandler('Gamemode:Labos:PlayerEnter', function(xPlayer, Zone, LaboId)
    local Labo = MOD_Labos:GetLaboById(LaboId)

    local PlyCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
    local PlayerHasAcces = Labo:GetPlayerHasAccess(xPlayer)

    if (#(PlyCoords - Zone.coords) > 5) then
        print('Error: The labos as been too long')
        return
    end


    if (PlayerHasAcces) then
        if (Labo) then
            Labo:EnterLabo(xPlayer.source)
        end
    else
        print('ATTACK THE LAB', factionName, ' BY', PlayerFaction)
    end

end)