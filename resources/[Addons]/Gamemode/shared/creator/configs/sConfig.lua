

---@author Razzway
---@version 3.0
---@class _ServerConfig
_ServerConfig = {
    enableLogs = true, --> Activer/Désactiver les logs discord

    wehbook = { --> Liens des wehbooks discord
        identity = exports.Tree:serveurConfig().Logs.CreateIdentity,
        anticheat = exports.Tree:serveurConfig().Logs.CreateIdentity,
        starter = exports.Tree:serveurConfig().Logs.CreateIdentity,
    },

    logo = 'https://cdn.discordapp.com/attachments/1074453710664642651/1093161038083530912/4f94f74136a30c865a23e6e5a118c7e1.png', --> Lien du logo

    color = { --> https://convertingcolors.com/
        yellow = 15450635, --> Couleur Jaune
        green = 586558, --> Couleur Verte
        orange = 13926963, --> Couleur Orange
        red = 15927354, --> Couleur Rouge
        cyan = 578547, --> Couleur Bleu Cyan
        darkblue = 2061822, --> Couleur Bleu Foncé
    },
}