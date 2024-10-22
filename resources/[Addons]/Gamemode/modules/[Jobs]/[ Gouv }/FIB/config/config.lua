FBI = {
    Vehicules = {
        {name = "cat", label = "Granger", minimum_grade = 0},
        {name = "lspdbuffsumk", label = "Buffalo 1", minimum_grade = 1},--
        {name = "roadrunner2", label = "Vapid Sandking", minimum_grade = 5},
        {name = "lspdbuffalostxum", label = "Buffalo 2", minimum_grade = 2},--
        {name = "apoliceu9", label = "Oracle Banalisé", minimum_grade = 2},
        {name = "usssvan2", label = "Speedo", minimum_grade = 3},
        {name = "apoliceu14", label = "Buffalo banalisé", minimum_grade = 3},--
        {name = "", label = "Ambulance Banalisé SOON", minimum_grade = 4},
        {name = "poltaxi", label = "Taxi Banalisé", minimum_grade = 4},
        {name = "mule4", label = "Mule Tactique", minimum_grade = 5},
        {name = "LSPDumkscoutgnd", label = "Explorer", minimum_grade = 5},--
        {name = "apoliceu15", label = "Schafter banalisé", minimum_grade = 2},

        {name = "police4", label = "Police stanier", minimum_grade = 1},
    },

    wlcustom = {
        [GetHashKey("lspdbuffsumk")] = true,
        [GetHashKey("lspdbuffalostxum")] = true,
        [GetHashKey("cat")] = true,
        [GetHashKey("LSPDumkscoutgnd")] = true,
        --
        [GetHashKey("usssvan2")] = true,
        [GetHashKey("roadrunner2")] = true,
        [GetHashKey("lcumkroamer2")] = true,
        [GetHashKey("mule4")] = true,
        [GetHashKey("apoliceu14")] = true,
        [GetHashKey("apoliceu9")] = true,
        [GetHashKey("apoliceu15")] = true,
    },

    Tenues = {
        ["Gilet-1"] = {
            male = {
                ['bproof_1'] = 71,   ['bproof_2'] = 0,
            },
            female = {
                ['bproof_1'] = 71,   ['bproof_2'] = 0,
            }
        },
        ["Gilet-2"] = {
            male = {
                ['bproof_1'] = 92,   ['bproof_2'] = 0,
            },
            female = {
                ['bproof_1'] = 93,   ['bproof_2'] = 0,
            }
        },
        [1] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Consultant Fédéral",
            minimum_grade = 0,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
        [2] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Agent Aspirant",
            minimum_grade = 1,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
        [3] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Agent Fédéral",
            minimum_grade = 2,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
        [4] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Agent Spécial",
            minimum_grade = 3,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
        [5] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Agent Spécial Superviseur",
            minimum_grade = 4,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
        [6] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Agent Spécial en Charge",
            minimum_grade = 5,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
        [7] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Agent Spécial de Coordination",
            minimum_grade = 6,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
        [8] = {
            label = "S'équiper de la tenue :"..exports.Tree:serveurConfig().Serveur.color.."Directeur d'Agence",
            minimum_grade = 7,
            male = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 435,   ['torso_2'] = 0,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 4,
                ['pants_1'] = 105,   ['pants_2'] = 0,
                ['shoes_1'] = 10,   ['shoes_2'] = 0,
                ['chain_1'] = 143,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
                ['bproof_1'] = 30,   ['bproof_2'] = 0,
            },
            female = {
                ['tshirt_1'] = 366,  ['tshirt_2'] = 0,
                ['torso_1'] = 869,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 3,
                ['pants_1'] = 325,   ['pants_2'] = 0,
                ['shoes_1'] = 25,   ['shoes_2'] = 0,
                ['chain_1'] = 0,    ['chain_2'] = 0,
                ['bags_1'] = 0,     ['bags_2'] = 0,
            }
        },
    },
}