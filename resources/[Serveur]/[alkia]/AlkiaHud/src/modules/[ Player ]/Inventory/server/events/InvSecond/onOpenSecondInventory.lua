RegisterNetEvent('Gamemode:Inventory:OpenSecondInventory')
AddEventHandler('Gamemode:Inventory:OpenSecondInventory', function(type, InvId, xPly)
    local xPlayer = ESX.GetPlayerFromId(source) or xPly
    
    xPlayer.set('SecondInvData', nil)

    if (xPlayer.get('SecondInvData') == nil or next(xPlayer.get('SecondInvData')) == nil) then
        if (type == "fplayeril") then
            if (xPlayer.job2.name ~= "unemployed2") then
                MOD_inventory:openPlayerFouilleIl(xPlayer, InvId)
            end
        elseif (type == "fplayerl") then
            if (xPlayer.job.name ~= "unemployed") then
                MOD_inventory:openPlayerFouilleIl(xPlayer, InvId)
            end
        elseif (type == "fplayerStaff") then
            local xGroup = xPlayer.getGroup()

            if xGroup ~= "user" then
                MOD_inventory:openPlayerFouilleStaff(xPlayer, InvId)
            end
        end

        if (type == "vehicule") then
            MOD_CoffreVehicule:openVehiculeByNetId(xPlayer, InvId)
        elseif (type == "properties") then
            MOD_CoffreProperties:openPropertiesByName(xPlayer, InvId)
        elseif (type == "coffrebuilder") then
            MOD_CoffreBuilder:openCoffreBuilderById(xPlayer, InvId)
        elseif (type == "coffresociety") then
            MOD_CoffreSociety:openCoffreSocietysByName(xPlayer, InvId)
        elseif (type == "coffregang") then
            MOD_CoffreGang:openCoffreGangByName(xPlayer, InvId)
        end

        TriggerClientEvent('Gamemode:Inventory:OpenPlayerInventory', xPlayer.source)
    end
end)