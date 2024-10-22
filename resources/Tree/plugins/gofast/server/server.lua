local inGoFast = false
local TimeoutGoFast = {}
local lastGoFast = {}
local goFastCount = {}
local cooldownTime = 24 * 60 * 60
local maxGoFast = 2 

RegisterNetEvent("Tree:GoFast:Start", function(selectedVehicle)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if not goFastCount[xPlayer.identifier] then
        goFastCount[xPlayer.identifier] = 0
    end
    local currentTime = os.time()
    if lastGoFast[xPlayer.identifier] and (currentTime - lastGoFast[xPlayer.identifier]) < cooldownTime then
        local remainingTime = cooldownTime - (currentTime - lastGoFast[xPlayer.identifier])
        local hoursRemaining = math.floor(remainingTime / 3600)
        local minutesRemaining = math.floor((remainingTime % 3600) / 60)
        xPlayer.showNotification("~r~Vous devez attendre encore " .. hoursRemaining .. " heures et " .. minutesRemaining .. " minutes avant de pouvoir refaire un GoFast.")
        return
    end
    if goFastCount[xPlayer.identifier] >= maxGoFast then
        lastGoFast[xPlayer.identifier] = currentTime
        goFastCount[xPlayer.identifier] = 0 
        xPlayer.showNotification("~r~Vous avez atteint la limite de GoFast, attendez 24 heures pour en refaire.")
        return
    end

    if inGoFast then
        xPlayer.showNotification("~r~Vous avez déjà un GoFast en cours.")
        return
    end
    inGoFast = true
    TimeoutGoFast[xPlayer.identifier] = true
    goFastCount[xPlayer.identifier] = goFastCount[xPlayer.identifier] + 1
    local vehicle = CreateVehicle(selectedVehicle.model, SharedGoFast.spawnVehicle, SharedGoFast.spawnVehicle, true, false)
    TaskWarpPedIntoVehicle(GetPlayerPed(_source), vehicle, -1)
    SetVehicleNumberPlateText(vehicle, "GOFAST")
    TriggerClientEvent("Tree:GoFast:Delivery", _source, vehicle)
end)

RegisterNetEvent("Tree:DeleteVehicle", function(vehicle)
    DeleteEntity(vehicle)
end)

RegisterNetEvent("Tree:GoFast:Finish", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if not inGoFast then
        return
    end
    inGoFast = false
    xPlayer.addAccountMoney('dirtycash', SharedGoFast.finishMoney)
    xPlayer.showNotification("Vous avez reçu ~r~"..SharedGoFast.finishMoney.."$~s~ pour la livraison.")
end)

