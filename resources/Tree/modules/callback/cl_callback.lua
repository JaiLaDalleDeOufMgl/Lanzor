Tree.ClientCallbacks = {}
Tree.ClientResponseCallbacks = {}
Tree.CurrentRequestId = Tree.CurrentRequestId or 0

--- @param name string Le nom du callback client à enregistrer.
--- @param cb function La fonction de callback à associer au nom donné.
Tree.RegisterClientCallback = function(name, cb)
    Tree.ClientCallbacks[name] = cb
end

--- @param name string Le nom du callback client à déclencher.
--- @param cb function La fonction de callback à exécuter une fois le callback client terminé.
--- @param ... Les arguments à passer à la fonction de callback.
Tree.TriggerClientCallback = function(name, cb, ...)
    if Tree.ClientCallbacks[name] then
        Tree.ClientCallbacks[name](cb, ...)
    else
        Tree.Console.Error(('Client callback ^5"%s"^0 does not exist.'):format(name))
    end
end

--- @param name string Le nom du callback serveur à déclencher.
--- @param cb function La fonction de callback à associer au callback serveur.
--- @param ... Les arguments à passer au callback serveur.
Tree.TriggerServerCallback = function(name, cb, ...)
    local requestId = Tree.CurrentRequestId
    Tree.ClientResponseCallbacks[requestId] = cb
    TriggerServerEvent('Tree:triggerServerCallback', name, requestId, ...)

    if Tree.CurrentRequestId < 65535 then
        Tree.CurrentRequestId = Tree.CurrentRequestId + 1
    else
        Tree.CurrentRequestId = 0
    end
end

RegisterNetEvent('Tree:serverCallback')
AddEventHandler('Tree:serverCallback', function(requestId, ...)
    if Tree.ClientResponseCallbacks[requestId] then
        Tree.ClientResponseCallbacks[requestId](...)
        Tree.ClientResponseCallbacks[requestId] = nil
    else
        Tree.Console.Error(('Client response callback for requestId ^5"%s"^0 does not exist.'):format(requestId))
    end
end)

RegisterNetEvent('Tree:triggerClientCallback')
AddEventHandler('Tree:triggerClientCallback', function(name, requestId, ...)
    Tree.TriggerClientCallback(name, function(...)
        TriggerServerEvent('Tree:clientCallbackResponse', requestId, ...)
    end, ...)
end)

RegisterNetEvent('Tree:clientCallbackResponse')
AddEventHandler('Tree:clientCallbackResponse', function(requestId, ...)
    if Tree.ClientResponseCallbacks[requestId] then
        Tree.ClientResponseCallbacks[requestId](...)
        Tree.ClientResponseCallbacks[requestId] = nil
    else
        Tree.Console.Error(('Client response callback for requestId ^5"%s"^0 does not exist.'):format(requestId))
    end
end)