RegisterNetEvent('Gamemode:Labos:RemoveMembre')
AddEventHandler('Gamemode:Labos:RemoveMembre', function(license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab:RemoveMembre(license)
    end
end)