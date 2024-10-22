RegisterNetEvent("Gamemode:GangBuilder:CreateNewGang")
AddEventHandler("Gamemode:GangBuilder:CreateNewGang", function(gangData)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (MOD_GangBuilder:GetPlayerHasAccesAdmin(xPlayer)) then
        return
    end

    MOD_GangBuilder:createNewGang(gangData.name, gangData.label, gangData.posGarage, gangData.posSpawnVeh, gangData.posDeleteVeh, gangData.posCoffre, gangData.posBoss)
end)