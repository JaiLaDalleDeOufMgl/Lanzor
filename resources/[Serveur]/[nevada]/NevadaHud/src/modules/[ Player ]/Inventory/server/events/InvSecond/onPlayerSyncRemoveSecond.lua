RegisterNetEvent('Gamemode:Inventory:PlayerSyncRemoveSecond')
AddEventHandler('Gamemode:Inventory:PlayerSyncRemoveSecond', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local SecondInvData = xPlayer.get('SecondInvData')
    if (SecondInvData == nil) then return end
    if (next(SecondInvData) == nil) then return end



    if (SecondInvData.type == "player") then
        local tTarget = ESX.GetPlayerFromId(SecondInvData.class.source)
        local InvPlayer = MOD_inventory:getInventoryPlayerByLicense(tTarget.identifier)

        InvPlayer:removePlayer(source)
        xPlayer.set('SecondInvData', nil)
    else
        SecondInvData.inventoryClass:removePlayer(source)
        xPlayer.set('SecondInvData', nil)
    end
end)