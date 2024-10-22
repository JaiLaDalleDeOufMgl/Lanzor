AddEventHandler('Gamemode:Labos:PlayerExit', function(xPlayer, Zone, LaboId)
    local PlyCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))

    if (#(PlyCoords - Zone.coords) > 5) then
        print('Error: The labos as been too long')
        return
    end

    local Labo = MOD_Labos:GetLaboById(LaboId)

    if (Labo) then
        Labo:ExitLabo(xPlayer.source)
    end
end)