RegisterNetEvent('tree:getPlayerRadius', function(radius, message)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    TriggerServerEvent('tree:sendMessageInZone', playerCoords, radius, message)
end)

RegisterNetEvent("tree:sendScaleform", function(message)
    ESX.Scaleform.ShowFreemodeMessage("~r~Annonce Zone~s~", message, 5)
end)