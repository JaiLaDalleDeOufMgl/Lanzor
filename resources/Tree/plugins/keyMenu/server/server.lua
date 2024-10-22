
local ESX = getFramework()

ESX.RegisterServerCallback("Tree:MenuKeys:requestOwnedVehicles", function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end 
    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner", {
        ["@owner"] = xPlayer.identifier
    }, function(result)
        if result then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RegisterNetEvent("Tree:MenuKeys:GiveKey", function(currentKeys, target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end
    local xTarget = ESX.GetPlayerFromId(target)

    if xTarget then
        MySQL.Async.execute("UPDATE owned_vehicles SET lend = @lend WHERE plate = @plate", {
            ["@lend"] = 1,
            ["@plate"] = currentKeys
        }, function(result)
            if result then
                xPlayer.showNotification("~g~Vous avez prêté vos clés à "..xTarget.name..".")
                xTarget.showNotification("~g~Vous avez reçu les clés du véhicule "..currentKeys..".")
            else
                xPlayer.showNotification("~r~Une erreur est survenue.")
            end
        end)

    end

end)
