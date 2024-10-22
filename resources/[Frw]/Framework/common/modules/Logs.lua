ESX.Logs = {
    ---@param message string
    ["Info"] = function (message, ...)
        exports[exports.Tree:serveurConfig().Serveur.hudScript]:Info(message, ...);
    end,

    ---@param message string
    ["Warn"] = function (message, ...)
        exports[exports.Tree:serveurConfig().Serveur.hudScript]:Warn(message, ...);
    end,

    ---@param message string
    ["Error"] = function (message, ...)
        exports[exports.Tree:serveurConfig().Serveur.hudScript]:Error(message, ...);
    end,

    ---@param message string
    ["Success"] = function (message, ...)
        exports[exports.Tree:serveurConfig().Serveur.hudScript]:Success(message, ...);
    end
};