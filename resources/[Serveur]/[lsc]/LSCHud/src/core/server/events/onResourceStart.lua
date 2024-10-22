local function Initialize(callback)
    local ItemsLoaded = promise.new()

    MOD_Items:load(function() 
        ItemsLoaded:resolve() 
    end)

    Citizen.Await(ItemsLoaded)

    callback()
end

AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    print("^5"..exports.Tree:serveurConfig().Serveur.label.." | ^2"..exports.Tree:serveurConfig().Serveur.label.."Hud is ready !")

    Initialize(function()
        TriggerEvent('Gamemode:IsReady')
    end)
end)