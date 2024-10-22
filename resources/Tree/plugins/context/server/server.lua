ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Permission = {
    fondateur = true,
},

ESX.RegisterServerCallback("tree:context:checkPerm", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Permission[xPlayer.getGroup()] then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("tree:context:deleteVehicle", function(NetID)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then 
        return 
    end
    if Permission[xPlayer.getGroup()] then
        local entity = NetworkGetEntityFromNetworkId(NetID)
        if DoesEntityExist(entity) then
            DeleteEntity(entity)
            xPlayer.showNotification("~g~Véhicule supprimé.")
        end
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela.")
    end
end)

RegisterNetEvent("tree:context:deletePed", function(NetID)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then 
        return 
    end
    if Permission[xPlayer.getGroup()] then
        local entity = NetworkGetEntityFromNetworkId(NetID)
        if DoesEntityExist(entity) then
            DeleteEntity(entity)
            xPlayer.showNotification("~g~Ped supprimé.")
        end
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela.")
    end
end)

RegisterNetEvent("tree:context:freezeVehicle", function(NetID)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if Permission[xPlayer.getGroup()] then
        local entity = NetworkGetEntityFromNetworkId(NetID)
        if DoesEntityExist(entity) then
            FreezeEntityPosition(entity, not IsEntityPositionFrozen(entity))
            xPlayer.showNotification("~g~Véhicule "..(IsEntityPositionFrozen(entity) and "unfreeze" or "freeze")..".")
        end
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela.")
    end
end)

RegisterNetEvent("tree:context:teleport", function(coords)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if Permission[xPlayer.getGroup()] then
        SetEntityCoords(GetPlayerPed(_source), coords.x, coords.y, coords.z)
        xPlayer.showNotification("~g~Téléportation effectuée.")
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela.")
    end
end)

RegisterNetEvent("tree:context:bring", function(coords, player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if Permission[xPlayer.getGroup()] then
        SetEntityCoords(GetPlayerPed(player), coords.x, coords.y, coords.z)
        xPlayer.showNotification("~g~Téléportation effectuée.")
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela.")
    end
end)

RegisterNetEvent("tree:context:freezePlayer", function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if Permission[xPlayer.getGroup()] then
        FreezeEntityPosition(GetPlayerPed(player), not IsEntityPositionFrozen(GetPlayerPed(player)))
        xPlayer.showNotification("~g~Joueur "..(IsEntityPositionFrozen(GetPlayerPed(player)) and "unfreeze" or "freeze")..".")
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela.")
    end
end)