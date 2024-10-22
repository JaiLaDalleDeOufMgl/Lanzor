RegisterNetEvent('Gamemode:Labos:RemoveAcces')
AddEventHandler('Gamemode:Labos:RemoveAcces', function(accesName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab:RemoveAcces(accesName)
    end
end)