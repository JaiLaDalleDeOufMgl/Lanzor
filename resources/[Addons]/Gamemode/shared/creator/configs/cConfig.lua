

---@author Razzway
---@version 3.0
---@class CreatorConfig
CreatorConfig = {
    getESX = "esx:getSharedObject", --> Trigger de déclaration ESX | Défaut : esx:getSharedObject
    consoleLogs = true, --> Activer/Désactiver les print dans la console
    serverName = exports.Tree:serveurConfig().Serveur.label,
    afterMessage = true, --> Message de bienvenue après la création

    use = {calif = true}, --> Si vous utilisez la base calif : true | Sinon si ESX normal : false

    events = { --> Vos events & préfix d'events (si base calif, rajouter votre préfix | exemple : ::{korioz#0110}::
        showNotification = "esx:showNotification", --> Calif = ::{korioz#0110}::esx:showNotification
        skinchanger = "skinchanger", --> Calif = ::{korioz#0110}::skinchanger
        skin = "esx_skin", --> Calif = ::{korioz#0110}::esx_skin
    },

    starterPack = {
        enable = false, --> Activer/Désactiver le système de starterPack
        legal = { --> Configuration du pack legal
            ["cash"] = 5000,
            ["bank"] = 30000,
        },
        illegal = { --> Configuration du pack illegal
            ["bank"] = 10000,
            ["black_money"] = 5000,
            ["weapon"] = "weapon_pistol",
        },
    },

    afterSpawn = { --> Lieu de spawn possible après la création du perso
        {name = 'Ville', pos = vector3(-1015.27, -1514.93, 6.51), head = 124.97}, 
        --{name = 'Aéroport', pos = vector3(-1037.82, -2737.85, 20.36), head = 330.81},
        --{name = 'Sandy Shores', pos = vector3(1841.15, 3669.22, 33.87), head = 208.88}
        --{name = 'Exemple', pos = vector3(0, 0, 0), head = 0.0}
    },

    firstSpawn = { --> Premier lieu de spawn du joueur lors de la création
        pos = vector3(-774.95, 318.24, 195.86-0.9),
        heading = 89.96,
    },
    cloakRoom = { --> Une fois l'identité validé, le lieu où l'on change l'apparence
        pos = vector3(-763.23, 330.84, 199.48-1),
        heading = 178.67,
    },
    kitchen = { --> Une fois le personnage validé, le lieu où l'on choisit son kit de départ
        pos = vector3(-776.85, 325.81, 196.08-1),
        heading = 308.63,
    },
    lift = { --> Lieu où l'on choisit l'endroit de spawn du personnage
        pos = vector3(-775.78, 314.45, 195.88-1),
        heading = 331.69,
    },

    outfit = { --> Configuration des tenues prédéfinies
        {label = "Tenue détente",
            clothes = {
                ["male"] = {
                    bags_1 = 0, bags_2 = 0,
                    tshirt_1 = 15, tshirt_2 = 0,
                    torso_1 = 26, torso_2 = 0,
                    arms = 5,
                    pants_1 = 20, pants_2 = 0,
                    shoes_1 = 39, shoes_2 = 0,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = -1, helmet_2 = 0,
                    chain_1 = 0, chain_2 = 0,
                    decals_1 = 0, decals_2 = 0,
                },
                ["female"] = {
                    bags_1 = 0, bags_2 = 0,
                    tshirt_1 = 14, tshirt_2 = 0,
                    torso_1 = 44, torso_2 = 0,
                    arms = 6,
                    pants_1 = 20, pants_2 = 0,
                    shoes_1 = 64, shoes_2 = 0,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = -1, helmet_2 = 0,
                    glasses_1 = -1, glasses_2 = 0,
                    chain_1 = 0, chain_2 = 0,
                    decals_1 = 0, decals_2 = 0,
                }, 
            },
        },
        {label = "Tenue d'affaires",
            clothes = {
                ["male"] = {
                    bags_1 = 0, bags_2 = 0,
                    tshirt_1 = 15, tshirt_2 = 0,
                    torso_1 = 433, torso_2 = 0,
                    arms = 4,
                    pants_1 = 125, pants_2 = 3,
                    shoes_1 = 198, shoes_2 = 0,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = -1, helmet_2 = 0,
                    chain_1 = 0, chain_2 = 0,
                    decals_1 = 0, decals_2 = 0,
                },
                ["female"] = {
                    bags_1 = 0, bags_2 = 0,
                    tshirt_1 = 14, tshirt_2 = 0,
                    torso_1 = 75, torso_2 = 0,
                    arms = 6,
                    pants_1 = 85, pants_2 = 0,
                    shoes_1 = 66, shoes_2 = 0,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = -1, helmet_2 = 0,
                    glasses_1 = -1, glasses_2 = 0,
                    chain_1 = 0, chain_2 = 0,
                    decals_1 = 0, decals_2 = 0,
                },
            },
        },
    },
}

_Client = _Client or {};
_Client.open = {};
_Prefix = "creator";
Render = {};
arrow = "~c~→~s~ ";