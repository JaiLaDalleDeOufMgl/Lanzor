Tree.ServerCallbacks = {}
Tree.ClientResponseCallbacks = {}
Tree.CurrentRequestId = Tree.CurrentRequestId or 0

--- @param name string Le nom du callback serveur à enregistrer.
--- @param cb function La fonction de callback à associer au nom donné.
Tree.RegisterServerCallback = function(name, cb)
    Tree.ServerCallbacks[name] = cb
end

--- @param name string Le nom du callback serveur à déclencher.
--- @param requestId number L'identifiant de requête associé à ce callback.
--- @param source number L'identifiant du joueur source pour le callback.
--- @param cb function La fonction de callback à exécuter une fois le callback serveur terminé.
--- @param ... Les arguments à passer à la fonction de callback.
Tree.TriggerServerCallback = function(name, requestId, source, cb, ...)
    if Tree.ServerCallbacks[name] then
        Tree.ServerCallbacks[name](source, cb, ...)
    else
        Tree.Console.Error(('Server callback ^5"%s"^0 does not exist.'):format(name))
    end
end

--- @param playerId number L'identifiant du joueur à qui envoyer le callback client.
--- @param name string Le nom du callback client à déclencher.
--- @param cb function La fonction de callback à exécuter une fois le callback client terminé.
--- @param ... Les arguments à passer à la fonction de callback.
Tree.TriggerClientCallback = function(playerId, name, cb, ...)
    local requestId = Tree.CurrentRequestId
    Tree.ClientResponseCallbacks[requestId] = cb
    TriggerClientEvent('Tree:triggerClientCallback', playerId, name, requestId, ...)
    if Tree.CurrentRequestId < 65535 then
        Tree.CurrentRequestId = Tree.CurrentRequestId + 1
    else
        Tree.CurrentRequestId = 0
    end
end

RegisterServerEvent('Tree:triggerServerCallback')
AddEventHandler('Tree:triggerServerCallback', function(name, requestId, ...)
    local playerId = source
    Tree.TriggerServerCallback(name, requestId, playerId, function(...)
        TriggerClientEvent('Tree:serverCallback', playerId, requestId, ...)
    end, ...)
end)

RegisterServerEvent('Tree:triggerClientCallback')
AddEventHandler('Tree:triggerClientCallback', function(playerId, name, requestId, ...)
    TriggerClientEvent('Tree:triggerClientCallback', playerId, name, requestId, ...)
end)

RegisterServerEvent('Tree:clientCallbackResponse')
AddEventHandler('Tree:clientCallbackResponse', function(requestId, ...)
    if Tree.ClientResponseCallbacks[requestId] then
        Tree.ClientResponseCallbacks[requestId](...)
        Tree.ClientResponseCallbacks[requestId] = nil
    else
        Tree.Console.Error(('Client response callback for requestId ^5"%s"^0 does not exist.'):format(requestId))
    end
end)
