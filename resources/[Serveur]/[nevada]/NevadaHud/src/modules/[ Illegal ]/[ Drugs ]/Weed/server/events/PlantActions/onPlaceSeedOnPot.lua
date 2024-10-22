RegisterNetEvent('Gamemode:Labo:Weed:PlaceSeedOnPot')
AddEventHandler('Gamemode:Labo:Weed:PlaceSeedOnPot', function(plotSize, plotIndex, potIndex, seedVariety)
    local xPlayer = ESX.GetPlayerFromId(source)
    local PlyCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))

    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab.Drug:PlaceSeedOnWeedPot(plotSize, plotIndex, potIndex, seedVariety)
    end
end)