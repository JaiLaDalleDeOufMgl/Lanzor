

AddVehicle = function(identifier, vehicle)
    if vehiclesPlayers[identifier] == nil then return end
    if vehicle == nil then return end

    local players = ESX.GetPlayers()
    table.insert(vehiclesPlayers[identifier], {plate = vehicle.plate, data = vehicle.data, stored = 0, fourriere = 0})
    for i = 1, #players do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer then
            local playerIdentifier = xPlayer.identifier
            if identifier == playerIdentifier then
                TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez reçu un véhicule ayant la plaque "..exports.Tree:serveurConfig().Serveur.color..""..vehicle.data.plate.."~s~ !")
                TriggerClientEvent("fGarage:returnMyVehicles", xPlayer.source, vehiclesPlayers[identifier])
            end
        end
    end
end

RemoveVehicle = function(identifier, vehicle)
    if vehiclesPlayers[identifier] == nil then return end
    if vehicle == nil then return end
    local players = ESX.GetPlayers()
    table.remove(vehiclesPlayers[identifier], vehicle)
    for i = 1, #players do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer then
            local playerIdentifier = xPlayer.identifier
            if identifier == playerIdentifier then
                TriggerClientEvent("fGarage:returnMyVehicles", xPlayer.source, vehiclesPlayers[identifier])
            end
        end
    end
end

VehicleUpValue = function(identifier, vehicle, stored, fourriere, data)
    if vehiclesPlayers[identifier] == nil then return end
    if vehicle == nil then return end
    local players = ESX.GetPlayers()

    vehiclesPlayers[identifier][vehicle].stored = stored
    vehiclesPlayers[identifier][vehicle].fourriere = fourriere
    
    if data then
        vehiclesPlayers[identifier][vehicle].data = data
    end

    for i = 1, #players do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer then
            local playerIdentifier = xPlayer.identifier
            if identifier == playerIdentifier then
                TriggerClientEvent("fGarage:returnMyVehicles", xPlayer.source, vehiclesPlayers[identifier])
            end
        end
    end
end

GetVehicles = function(identifier)
    if vehiclesPlayers[identifier] == nil then return  end
    return vehiclesPlayers[identifier]
end

PlayerIsOwnedVehicle = function(identifier, plate)
    for k,v in pairs(GetVehicles(identifier)) do
        if v.data.plate == plate then
            return true
        end
    end

    return false
end

generatePlate = function(identifier)
    local plate = string.upper(GetRandomLetter(3)..GetRandomNumber(3))
    return plate
end