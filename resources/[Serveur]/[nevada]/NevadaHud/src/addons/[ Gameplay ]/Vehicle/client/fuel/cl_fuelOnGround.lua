CreateThread(function()
    while true do
        if wastingFuel then
            local cost = 0

            local PlayerMoney = 0

            local moneyPromise = promise.new()
            ESX.TriggerServerCallback("Gamemode:Fuel:GetPlayerMoney", function(money)
                PlayerMoney = money
                moneyPromise:resolve()
            end)
            Citizen.Await(moneyPromise)

            if (PlayerMoney > 0) then
                while wastingFuel do
                    cost = cost + (2.0 * Gamemode.enums.Vehicle.Fuel.fuelCostMultiplier) - math.random(0, 100) / 100

                    if PlayerMoney < cost - 1.0 then
                        wastingFuel = false
                        break
                    end
    
                    SendNUIMessage({
                        event = 'FuelUpdate',
                        cost = string.format("%.2f", cost),
                        tank = "0.0"
                    })
    
                    Wait(800)
                end
    
                if cost ~= 0 then
                    TriggerServerEvent("Gamemode:Fuel:PayFuelVehicle", (cost - 1))
                    cost = 0
                end
            end
        end

        Wait(1000)
    end
end)