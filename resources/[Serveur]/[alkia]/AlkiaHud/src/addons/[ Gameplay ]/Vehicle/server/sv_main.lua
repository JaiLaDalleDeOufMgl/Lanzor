RegisterNetEvent('Gamemode:Fuel:PayFuelVehicle')
AddEventHandler('Gamemode:Fuel:PayFuelVehicle', function(cost)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        local playerMoney = xPlayer.getAccount("cash");

        local HaveMoney = (playerMoney.money >= cost)

        if (HaveMoney) then
            xPlayer.removeAccountMoney("cash", cost)
            
            xPlayer.showNotification("Vous avez payer ".. cost .. " d'essense")
        else
            xPlayer.showNotification("Vous n'avez pas assez d'argent")
        end
    end
end)


ESX.RegisterServerCallback("Gamemode:Fuel:GetPlayerMoney", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        local playerMoney = xPlayer.getAccount("cash");

        cb(playerMoney.money)
    end
end)