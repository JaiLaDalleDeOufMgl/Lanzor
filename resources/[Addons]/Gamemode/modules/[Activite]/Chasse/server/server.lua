local playerChasse = {}

ESX.RegisterServerCallback("Chasse:check", function(source, cb, lastPos)
    if #(GetEntityCoords(GetPlayerPed(source)) - lastPos) > 1.5 then  
        TriggerEvent("tF:Protect", source, '(Chasse:check)');
        return
    end
    if playerChasse[source] then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("Chasse:start", function(lastPos, chasse)
    local source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local dist = #(GetEntityCoords(GetPlayerPed(source))-vector3(-567.27972412109,5253.1845703125,70.466697692871))
    if xPlayer then
        if dist > 15.0 then
            TriggerEvent("tF:Protect", source, "(Chasse:start) : 24") 
            return 
        end
        playerChasse[source] = true
        itemName = string.upper("weapon_musket")
        xPlayer.addWeapon(itemName, 255, { antiActions = 'hunting', removeReboot = true })


        SendLogs(1752220,"Chasse - Start","**"..GetPlayerName(source).."** vient de commencer à chasser \n **License** : "..xPlayer.identifier,"https://discord.com/api/webhooks/1266364410750828618/1DZp0uiR2tSv6V9FQZp5MFpsAiODi2K85Yi-efyqVhJBU0UE_PWq6AxHcVBgaDAczMRB")
        TriggerClientEvent("Chasse:returnStart", source, chasse)
    end
end)

RegisterServerEvent("Chasse:stop")
AddEventHandler("Chasse:stop", function(message, lastPos, chasse)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local dist = #(GetEntityCoords(GetPlayerPed(source))-vector3(-567.27972412109,5253.1845703125,70.466697692871))
    if xPlayer then
        if playerChasse[source] then
            xPlayer.removeWeaponSystem(string.lower("weapon_musket"))
            playerChasse[source] = false
            TriggerClientEvent("Chasse:returnStop", source, chasse, message)
            SendLogs(1752220,"Chasse - Stop","**"..GetPlayerName(source).."** vient d'arrêter la chasse \n **License** : "..xPlayer.identifier,"https://discord.com/api/webhooks/1266364410750828618/1DZp0uiR2tSv6V9FQZp5MFpsAiODi2K85Yi-efyqVhJBU0UE_PWq6AxHcVBgaDAczMRB")
        end
    end
end)

AddEventHandler('playerDropped', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.removeWeaponSystem("WEAPON_MUSKET")
    end
end)


RegisterNetEvent("Chasse:addItem", function(itemName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(-567.27972412109,5253.1845703125,70.466697692871)) > 500.0 then
        xPlayer.showNotification("~r~Vous n'êtes pas dans la zone de chasse")
        return
    end
        if itemName == "viande_1" or itemName == "viande_2" then
            if xPlayer.canCarryItem(itemName, 1) then
                TriggerClientEvent("esx:showNotification", source, "Bien, Vous avez ramassé ~r~x1 viande~s~ !")
                SendLogs(1752220,"Chasse - Ajout","**"..GetPlayerName(source).."** vient de gagner 1x "..ESX.GetItemLabel(itemName).." \n **License** : "..xPlayer.identifier,"https://discord.com/api/webhooks/1230687995850653738/8y_shGQr-Mm_Lj1Rluvbhd9CY9WYFvex_1N-0Hla7Osem4rPl0XIoVq4MwSAs17vTcow")
                xPlayer.addInventoryItem(itemName, 1)
            else
                TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez de place sur vous pour récupérer la viande")
            end

        else
            TriggerEvent("tF:Protect", source, '(Chasse:addItem)');
        end
end)