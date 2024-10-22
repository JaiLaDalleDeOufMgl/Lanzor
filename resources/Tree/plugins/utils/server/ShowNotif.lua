CreateThread(function()
    while true do 
        Wait(Tree.Math.minutesToMS(10))
        TriggerClientEvent("esx:showNotification", -1, "Le /afk est désormais disponible au parking centrale !")
    end
end)