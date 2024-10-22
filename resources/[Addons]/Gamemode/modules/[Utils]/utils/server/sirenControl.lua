---

--- Create at [03/11/2022] 11:20:15

--- File name [sirenControl]
---
local sirenControl = {}
sirenControl.config = {
    vehicle = {
        "riot",
        "ambulance",
        "emsstalker",
        "ambulance2",
        "polalamor",
        "polalamor2",
        "polbisonr",
        "polbuffalor",
        "polbuffalor2",
        "polcarar",
        "polcoquetter",
        "poldmntr",
        "polfugitiver",
        "rmodrs6police",
        "polgresleyr",
        "polscoutr",
        "polspeedor",
        "polstalkerr",
        "polstanierr",
        "poltorencer", --
        "apoliceu14",
        "apoliceu15",
        "apoliceu9",
        "lspdbuffalostxum",
        "lspdbuffsumk",
        "cat",
        "halfback",
        "hazard2",
        "inaugural2",
        "roadrunner",
        "roadrunner2",
        "ussssuv2",
        "usssvan2",
        "watchtower2",
        "police6f",
        "polalamo",
        "polalamonew",
        "polthrust",
        "lspdcara",
        "police2b",
        "LSPDbus",
        "LSPDraiden",
        "LSPDscorcher",
        "LSPDtorrence",
        "LSPDumkscoutgnd",
        "LSPDumktorrence",

        "nkstx",
        "nkomnisegt",
        "nkgranger2",
        "nkfugitive",
        "nkcaracara2",
        "nkcoquette",
    },
    playerLoad = {}
}

RegisterNetEvent("SirenControl:Request:LoadConfig", function()
    local _src = source

    local xPlayer = ESX.GetPlayerFromId(_src)
    if (xPlayer ~= nil) then
        if (sirenControl.config.playerLoad[_src] == nil) then
            sirenControl.config.playerLoad[_src] = true
        else
            return
        end

        xPlayer.triggerEvent("SirenControl:LoadConfig", {
            vehicle = sirenControl.config.vehicle
        })
    end
end)

RegisterNetEvent("SirenControl:Active", function(selectedState)
    local playerSrc = source
    local playerPed = GetPlayerPed(playerSrc)

    local selectedSiren = 0
    if (selectedState == true) then
        selectedSiren = 0
    elseif (selectedState == false) then
        selectedSiren = 1
    end

    if (playerPed == 0 or not DoesEntityExist(playerPed) or tonumber(selectedSiren) == nil) then
        return
    end

    local playerVehicle = GetVehiclePedIsIn(playerPed, false)
    if (playerVehicle == 0) then
        return
    end

    local vehicleModel = GetEntityModel(playerVehicle)
    local findModel = false
    for i = 1, #sirenControl.config.vehicle do
        local currentModel = GetHashKey(sirenControl.config.vehicle[i])
        if (currentModel == vehicleModel) then
            findModel = true
        end
    end

    if (not findModel) then
        return
    end

    local vehicleSirensState = IsVehicleSirenOn(playerVehicle)
    if (vehicleSirensState == 1) then
        TriggerClientEvent("SirenControl:ManageState", -1, NetworkGetNetworkIdFromEntity(playerVehicle), selectedSiren)
    end
end)