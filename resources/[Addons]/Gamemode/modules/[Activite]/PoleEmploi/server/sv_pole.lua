
RegisterNetEvent('Gamemode:Setjob', function(label,name)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source);
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(-268.81, -956.35, 31.22)) > 10.0 then 
        TriggerEvent("tF:Protect", source, '(Gamemode:Setjob)');
        return
    end
    Wait(2000);
    for i = 1, #FreeJobConfig.Libre do
        if (name == FreeJobConfig.Libre[i].name) then
            xPlayer.setJob(name, 0);
            TriggerClientEvent("esx:showNotification", source, "Désormais, votre métier est : "..exports.Tree:serveurConfig().Serveur.color..label);
            break;
        end
    end
end)

RegisterNetEvent('Gamemode:Chomeur', function(job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if #(GetEntityCoords(GetPlayerPed(source))-vector3(-268.81, -956.35, 31.22)) > 10.0 then 
        TriggerEvent("tF:Protect", source, '(Gamemode:Chomeur)');
        return
    end
    Wait(2000)
    xPlayer.setJob("unemployed", 0)  
end)

RegisterNetEvent('Gamemode:RecolteJardinier', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = "plante"
    if not (xPlayer) then return end
    local inventaire = xPlayer.getInventoryItem(item)
    local limiteitem = 22
    local canDo = false;
    local coords = GetEntityCoords(GetPlayerPed(source));

    if #(coords - vector3(2933.42, 4691.32, 50.75)) > 75 then 
        DropPlayer(source, "Action impossible ! (Gamemode:RecolteJardinier)") 
    end 
    for i = 1, #FreeJobConfig.JardinierRecolte do
        local distance = #(coords - vector3(FreeJobConfig.JardinierRecolte[i].x, FreeJobConfig.JardinierRecolte[i].y, FreeJobConfig.JardinierRecolte[i].z));
        if (distance < 15.0) then
            canDo = true;
            break;
        end
    end
    
    if not (canDo) then
        xPlayer.showNotification("Vous ne pouvez pas faire ça maintenant");
        TriggerClientEvent('Jardinier:stop', source);
        return;
    end

    xPlayer.addInventoryItem(item, 1);
    TriggerClientEvent('esx:showNotification', source, "~g~Récolte en cours...");
end)

RegisterNetEvent('Gamemode:VenteJardinier', function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not (xPlayer) then return end
    local item = "plante"
    local plante = 1
    local inventaire = xPlayer.getInventoryItem(item)
    local canDo = false;
    local coords = GetEntityCoords(GetPlayerPed(source));

    for i = 1, #FreeJobConfig.Jardinier do
        if #(coords - vector3(1724.557, 4641.883789, 42.875)) > 50 then 
            DropPlayer(source, "Action impossible ! (VenteJardinier)") 
        end 
        local distance = #(coords - vector3(FreeJobConfig.Jardinier[i].x, FreeJobConfig.Jardinier[i].y, FreeJobConfig.Jardinier[i].z));
        if (distance < 15.0) then
            canDo = true;
            break;
        end
    end

    if not (canDo) then
        xPlayer.showNotification("Vous ne pouvez pas faire ça maintenant");
        TriggerClientEvent('JustGod:BonToutou', source);
        return;
    end
    
    if (inventaire) then
        local PriceJardinier = math.random(10, 40)
        xPlayer.removeInventoryItem(item, 1)
        xPlayer.addAccountMoney('cash', PriceJardinier)
        TriggerClientEvent('esx:showNotification', source, "Vous avez gagner "..PriceJardinier.."~g~$")
    else 
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Vous n'avez plus de plantes à vendre")
        TriggerClientEvent('JustGod:BonToutou', source);
    end
end)