local pnjGelEnabled = false
local pnjGelCoords
local waitingTime = 1000*5
local pnjOnCooldown

local JobServiceGamemode = {
    ['fib'] = true,
    ['bcso'] = true,
    ['police'] = true,
}

RegisterCommand("arretpnj", function(source)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
    local jobWhitelist = xPlayer.job.name
    local plySrc = source
    local plyPed = GetPlayerPed(plySrc)

    local currentTimer = GetGameTimer();
    if JobServiceGamemode[jobWhitelist] then
        if (not pnjGelEnabled) then
            if (pnjOnCooldown == nil) then
                pnjOnCooldown = (currentTimer + waitingTime)
            elseif (pnjOnCooldown ~= nil and pnjOnCooldown > currentTimer) then
                return xPlayer.showNotification("Merci d'attendre avant de refaire la commande")
            end        
        end

        pnjGelEnabled = not pnjGelEnabled
        pnjGelCoords = GetEntityCoords(plyPed, false)

        if pnjGelEnabled then
            xPlayer.showNotification("Arrêt des PNJ activé dans la zone.")
        else
            xPlayer.showNotification("Arrêt des PNJ désactivé dans la zone.")
        end

        TriggerClientEvent("GelPNJ", -1, pnjGelEnabled, {
            x = pnjGelCoords.x,
            y = pnjGelCoords.y,
            z = pnjGelCoords.z
        })
    else
        xPlayer.showNotification("Vous n'avez pas accès à cela")
    end

end)