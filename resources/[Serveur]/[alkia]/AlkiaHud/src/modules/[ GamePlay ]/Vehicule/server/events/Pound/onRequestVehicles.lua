RegisterNetEvent('Gamemode:Pound:RequestVehicles')
AddEventHandler('Gamemode:Pound:RequestVehicles', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = 0", {
            ["@owner"] = xPlayer.getIdentifier()
        }, function(vehicles)
            local playerVeh = {}

            if (#vehicles > 0) then
                for i=1, #vehicles do
                    if (vehicles[i]) then
                        local mods = json.decode(vehicles[i].vehicle)

                        if (mods) then

                            playerVeh[#playerVeh + 1] = {
                                type = vehicles[i].type,
                                plate = vehicles[i].plate,
                                model = mods.model,
                                stored = vehicles[i].stored
                            }

                        end
                    end
                end
            end
            TriggerClientEvent('Gamemode:Pound:ReceiveVehicles', xPlayer.source, playerVeh)
        end)
    end
end)