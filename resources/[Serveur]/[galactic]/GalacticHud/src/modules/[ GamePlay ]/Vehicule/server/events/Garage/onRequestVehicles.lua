RegisterNetEvent('Gamemode:Garage:RequestVehicles')
AddEventHandler('Gamemode:Garage:RequestVehicles', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner", {
            ["@owner"] = xPlayer.getIdentifier()
        }, function(vehicles)
            local playerVeh = {}

            if (#vehicles > 0) then
                for i=1, #vehicles do
                    if (vehicles[i]) then
                        local mods = json.decode(vehicles[i].vehicle)

                        if (mods) then

                            playerVeh[#playerVeh + 1] = {
                                plate = vehicles[i].plate,
                                model = mods.model,
                                stored = vehicles[i].stored
                            }

                        end
                    end
                end
            end

            TriggerClientEvent('Gamemode:Garage:ReceiveVehicles', xPlayer.source, playerVeh)
        end)
    end
end)