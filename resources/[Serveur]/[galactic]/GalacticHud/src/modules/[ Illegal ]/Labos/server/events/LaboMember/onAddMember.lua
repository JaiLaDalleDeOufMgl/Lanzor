RegisterNetEvent('Gamemode:Labos:AddMember')
AddEventHandler('Gamemode:Labos:AddMember', function(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        Lab:AddMember(targetId)
    end
end)