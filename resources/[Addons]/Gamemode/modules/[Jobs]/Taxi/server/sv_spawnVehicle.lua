---

--- Create at [31/10/2022] 12:18:01

--- File name [spawnVehicle]
---

RegisterNetEvent("Taxi:Spawn:Vehicle", function()
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)
    if (not xPlayer) then
        return
    end

    local playerJob = xPlayer.getJob()
    if (playerJob ~= nil and playerJob.name ~= "taxi") then
        return --[[BAN : Not in job]]
    end

    xPlayer.showNotification("Vous avez ~g~sorti~s~ un "..exports.Tree:serveurConfig().Serveur.color.."véhicule~s~.")
end)