eSociety = {
    OpenMenuBoss = "Ouvrir la gestion de l'entreprise",
    OpenMenuCoffre = "Ouvrir le coffre de l'entreprise",

    DefaultMoney = 0,
    DefaultDirtyMoney = 0,

    Zones = {
        ["police"] = {
            pos = vector3(467.69, -975.65, 35.88),
            name = "police",
            label = "Los Santos Police Departement",

            coffre = true,
            coffreInfos = {
                pos = vector3(470.38, -980.49, 35.88),
                maxSlots = 150,
                maxWeight = 5000,
            },

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["bcso"] = {
            pos = vector3(1824.481, 3688.098, 39.127),
            name = "bcso",
            label = "Blaine County Sheriff Office",
            
            coffre = true,
            coffreInfos = {
                pos = vector3(1833.47, 3660.92, 30.31),
                maxSlots = 150,
                maxWeight = 5000,
            },

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["gouv"] = {
            pos = vector3(-383.80, 1076.23, 334.89),
            name = "gouv",
            label = "Gouvernement",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["label"] = {
            pos = vector3(481.87, -96.83, 63.15),
            name = "label",
            label = "RA Records",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["realestateagent"] = {
            pos = vector3(-709.87, 268.13, 83.10),
            name = "realestateagent",
            label = "Agent Immobilier",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["journalist"] = {
            pos = vector3(-596.62, -929.42, 32.52),
            name = "journalist",
            label = "Weazel News",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["ambulance"] = {
            pos = vector3(-1851.48, -334.84, 49.45),
            name = "ambulance",
            label = "Los Santos EMS",

            coffre = true,
            coffreInfos = {
                pos = vector3(-1848.96, -336.67, 49.45),
                maxSlots = 150,
                maxWeight = 5000,
            },

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["cardealer"] = {
            pos = vector3(-806.88, -205.54, 41.85),
            name = "cardealer",
            label = "Los Santos Concessionaire",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },
        
        ["boatseller"] = {
            pos = vector3(-743.25, -1338.8, 1.6),
            name = "boatseller",
            label = "Los Santos Concessionaire Bateau",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["planeseller"] = {
            pos = vector3(-948.5, -2935.2, 13.9),
            name = "planeseller",
            label = "Los Santos Concession Aéronautique",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["mecano"] = {
            pos = vector3(-194.91, -1315.60, 31.30),
            name = "mecano",
            label = "Mécano",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["mecano2"] = {
            pos = vector3(-347.383, -132.918, 42.036),
            name = "mecano2",
            label = "LS Custom",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["avocat"] = {
            pos = vector3(-569.52, -337.92, 35.15),
            name = "avocat",
            label = "Avocat",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["unicorn"] = {
            pos = vector3(113.280, -1320.920, 24.716),
            name = "unicorn",
            label = "Vanilla Unicorn",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["tequilala"] = {
            pos = vector3(-572.254, 286.541, 79.176),
            name = "tequilala",
            label = "Tequilala",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["burgershot"] = {
            pos = vector3(-1192.176, -903.399, 13.998),
            name = "burgershot",
            label = "BurgerShot",

            coffre = true,
            coffreInfos = {
                pos = vector3(-1202.19, -897.49, 13.88),
                maxSlots = 150,
                maxWeight = 5000,
            },

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["bahamas"] = {
            pos = vector3(-800.1793, -1221.5900, 11.3912),
            name = "bahamas",
            label = "Malibu",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        
        ["bahamas2"] = {
            pos = vector3(-1370.3101806641, -627.27239990234, 30.358413696289),
            name = "bahamas2",
            label = "Bahamas",
            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },

        ["taxi"] = {
            pos = vector3(-1602.101, -838.104, 10.272),
            name = "taxi",
            label = "Taxi",

            logs = {
                money = exports.Tree:serveurConfig().Logs.BossMenuMoneyLogs
            }
        },
        
    },
}

return eSociety