local NUIFocus = false
local playerInGF = false

RegisterNetEvent("gunfight:SendNUIMessage")
AddEventHandler("gunfight:SendNUIMessage", function(data)
    SendNUIMessage(data)
end)

RegisterNetEvent("gunfight:RegisterNUICallback")
AddEventHandler("gunfight:RegisterNUICallback", function(name, cb)
    RegisterNUICallback(name, cb)
end)

Citizen.CreateThread(function()
    TriggerEvent("gunfight:RegisterNUICallback", "close", function()
        TriggerEvent("gunfight:close")
    end)
end)

RegisterNetEvent("gunfight:setNUIFocus")
AddEventHandler("gunfight:setNUIFocus", function(toggle)
    NUIFocus = toggle
    SetNuiFocus(false, toggle)
end)

RegisterNetEvent('Piwel_GFZone:Sharing:SetPlayerInGF')
AddEventHandler('Piwel_GFZone:Sharing:SetPlayerInGF', function(bool)
    playerInGF = bool
    if not bool then
        TriggerEvent('gunfight:SendNUIMessage', {
            action = "setLeaderboard", 
            opacity = "0"
        })
    end
end)

RegisterCommand('+gfclassement', function()
    if not playerInGF then return end
    TriggerEvent('gunfight:SendNUIMessage', {
        action = "setLeaderboard", 
        opacity = "100"
    })
end, false)

RegisterCommand('-gfclassement', function()
    if not playerInGF then return end
    TriggerEvent('gunfight:SendNUIMessage', {
        action = "setLeaderboard", 
        opacity = "0"
    })
end, false)
RegisterKeyMapping('+gfclassement', '[Zone GF] Afficher le leaderboard', 'keyboard', "capital")