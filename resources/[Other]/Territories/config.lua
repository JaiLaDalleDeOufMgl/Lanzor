CONFIG = {}

CONFIG.TERRITOIRES = {
    ["Paleto Forest"] = {
        POS = vector3(-476.5741, 5514.3809, 80.0025), -- La position au centre du territoire
        RADIUS = 100.0,  -- La largeur du territoire depuis le centre (un cercle)
        --
        WEAPONS_NPC = {MODEL = 'g_m_m_chicold_01'},
        WEAPONS_NPC_POS = vector4(-470.9728, 5519.7700, 79.9178, 312.3119),
        --
        SELLER_NPC = {MODEL = 'a_m_m_trampbeac_01', Scena = "WORLD_HUMAN_SMOKING"},
        SELL_POS = { -- La position de vente de la drogue (la position du PED)
            [1] = vector4(-465.1855, 5525.5273, 79.1687, 267.6184),
            [2] = vector4(-453.6454, 5500.6934, 81.8432, 224.2583),
            [3] = vector4(-504.8980, 5515.3032, 73.9357, 47.2759),
            [4] = vector4(-491.1849, 5534.7881, 75.1604, 283.0374),
            [5] = vector4(-470.5721, 5539.9458, 77.1579, 355.0170),
            [6] = vector4(-481.8058, 5517.0000, 80.0003, 20.1250),
        },
        DRUG_PRICES = {
            [1] = {name = 'weed_pooch', label = "Pochons de Weed", price = 275, points_gagner = 9},
            [2] = {name = 'coke_pooch', label = "Pochons de Cocaine", price = 375, points_gagner = 11},
            [3] = {name = 'meth_pooch', label = "Pochons de Meth", price = 450, points_gagner = 15},
            [4] = {name = 'opium_pooch', label = "Pochons d'Opium", price = 550, points_gagner = 18},
            [5] = {name = 'pooch_ketamine', label = "Pochons de Kétamine", price = 900, points_gagner = 21},
            [6] = {name = 'xylazine_pooch', label = "Pochons de Xylazine", price = 1350, points_gagner = 26},
        },
        SELL_TIME = 2000, -- Combien de temps prend la vente
        -- NE PAS TOUCHER
        CURRENT_SELLER_POS = nil,
        OWNED_BY = nil,
        CREWS_POINTS = {},
        ARMES = {
            -- Armes
            {label = 'SNS', hash = "WEAPON_SNSPISTOL", price = 200000, points_retirer = 1000, type = "weapon"},
            {label = 'BERETTA', hash = "WEAPON_PISTOL", price = 300000, points_retirer = 2000, type = "weapon"},
            {label = 'Cran d\'arrêt', hash = "WEAPON_SWITCHBLADE", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Couteau simple', hash = "WEAPON_KNIFE", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Bouteille cassée', hash = "WEAPON_BOTTLE", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Club de golf', hash = "WEAPON_GOLFCLUB", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Batte de baseball', hash = "WEAPON_BAT", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Marteau', hash = "WEAPON_HAMMER", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Poing américain', hash = "WEAPON_KNUCKLE", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Machette', hash = "WEAPON_MACHETE", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'clé anglaise', hash = "WEAPON_WRENCH", price = 25000, points_retirer = 18, type = "weapon"},
            {label = 'Poing américain', hash = "WEAPON_KNUCKLE", price = 25000, points_retirer = 18, type = "weapon"},
            -- Items
            {label = 'Menottes', hash = "handcuff", price = 100000, points_retirer = 100, type = "item"},
            {label = 'Kevlar', hash = "kevlar", price = 75000, points_retirer = 50, type = "item"},
        }
    },
    ["Vinewood Boulevard"] = {
        POS = vector3(455.6350, 280.7108, 103.0186), -- La position au centre du territoire
        RADIUS = 150.0,  -- La largeur du territoire depuis le centre (un cercle)
        --
        WEAPONS_NPC = {MODEL = 'g_m_m_chicold_01'},
        WEAPONS_NPC_POS = vector4(478.5706, 258.9094, 103.1676, 62.0226),
        --
        SELLER_NPC = {MODEL = 'a_m_m_tramp_01', Scena = "WORLD_HUMAN_SMOKING"},
        SELL_POS = { -- La position de vente de la drogue (la position du PED)
            [1] = vector4(508.8596, 272.6514, 103.0561, 68.7086),
            [2] = vector4(475.9390, 266.9789, 103.0830, 330.5210),
            [3] = vector4(448.9591, 278.2351, 103.0595, 17.4133),
            [4] = vector4(439.6188, 299.4130, 103.0198, 165.3624),
            [5] = vector4(419.5919, 275.6662, 102.8927, 118.5312),
            [6] = vector4(405.8962, 289.6901, 102.9877, 314.8864),
        },
        DRUG_PRICES = {
            [1] = {name = 'weed_pooch', label = "Pochons de Weed", price = 275, points_gagner = 9},
            [2] = {name = 'coke_pooch', label = "Pochons de Cocaine", price = 375, points_gagner = 11},
            [3] = {name = 'meth_pooch', label = "Pochons de Meth", price = 450, points_gagner = 15},
            [4] = {name = 'opium_pooch', label = "Pochons d'Opium", price = 550, points_gagner = 18},
            [5] = {name = 'pooch_ketamine', label = "Pochons de Kétamine", price = 900, points_gagner = 21},
            [6] = {name = 'xylazine_pooch', label = "Pochons de Xylazine", price = 1350, points_gagner = 26},
        },
        SELL_TIME = 2000, -- Combien de temps prend la vente
        -- NE PAS TOUCHER
        CURRENT_SELLER_POS = nil,
        OWNED_BY = nil,
        CREWS_POINTS = {},
        ARMES = {
            -- Armes
            {label = 'SNS', hash = "WEAPON_SNSPISTOL", price = 200000, points_retirer = 1000, type = "weapon"},
            {label = 'BERETTA', hash = "WEAPON_PISTOL", price = 300000, points_retirer = 2000, type = "weapon"},
            -- Items
            {label = 'Carte Fleeca', hash = "id_card_f", price = 20000, points_retirer = 50, type = "item"},
            {label = 'Menottes', hash = "handcuff", price = 100000, points_retirer = 100, type = "item"},
            {label = 'Kevlar', hash = "kevlar", price = 75000, points_retirer = 50, type = "item"},
        }
    },
    ["Fête Foraine"] = {
        POS = vector3(-1660.1489, -1023.1735, 13.0178), -- La position au centre du territoire
        RADIUS = 150.0,  -- La largeur du territoire depuis le centre (un cercle)
        --
        WEAPONS_NPC = {MODEL = 'g_m_m_chicold_01'},
        WEAPONS_NPC_POS = vector4(-1634.6517, -1042.3112, 13.1520, 148.6342),
        --
        SELLER_NPC = {MODEL = 'a_f_y_topless_01', Scena = "WORLD_HUMAN_SMOKING"},
        SELL_POS = { -- La position de vente de la drogue (la position du PED)
            [1] = vector4(-1654.5609, -1032.8993, 13.1530, 24.4134),
            [2] = vector4(-1671.7303, -995.2729, 7.1413, 141.6599),
            [3] = vector4(-1682.4519, -1021.3486, 5.4895, 329.9834),
            [4] = vector4(-1675.9139, -1026.4819, 13.0174, 217.5058),
            [5] = vector4(-1640.6680, -1045.5027, 13.1520, 337.4962),
            [6] = vector4(-1630.4579, -1053.4958, 13.1526, 52.2731),
        },
        DRUG_PRICES = {
            [1] = {name = 'weed_pooch', label = "Pochons de Weed", price = 275, points_gagner = 9},
            [2] = {name = 'coke_pooch', label = "Pochons de Cocaine", price = 375, points_gagner = 11},
            [3] = {name = 'meth_pooch', label = "Pochons de Meth", price = 450, points_gagner = 15},
            [4] = {name = 'opium_pooch', label = "Pochons d'Opium", price = 550, points_gagner = 18},
            [5] = {name = 'pooch_ketamine', label = "Pochons de Kétamine", price = 900, points_gagner = 21},
            [6] = {name = 'xylazine_pooch', label = "Pochons de Xylazine", price = 1350, points_gagner = 26},
        },
        SELL_TIME = 2000, -- Combien de temps prend la vente
        -- NE PAS TOUCHER
        CURRENT_SELLER_POS = nil,
        OWNED_BY = nil,
        CREWS_POINTS = {},
        ARMES = {
            -- Armes
            {label = 'SNS', hash = "WEAPON_SNSPISTOL", price = 200000, points_retirer = 1000, type = "weapon"},
            {label = 'BERETTA', hash = "WEAPON_PISTOL", price = 300000, points_retirer = 2000, type = "weapon"},
            -- Items
            {label = 'Menottes', hash = "handcuff", price = 100000, points_retirer = 100, type = "item"},
            {label = 'Kevlar', hash = "kevlar", price = 75000, points_retirer = 50, type = "item"},
        }
    },
    ["Grand Senora Desert"] = {
        POS = vector3(2409.1052, 3102.4785, 48.1529), -- La position au centre du territoire
        RADIUS = 110.0,  -- La largeur du territoire depuis le centre (un cercle)
        --
        WEAPONS_NPC = {MODEL = 'g_m_m_chicold_01'},
        WEAPONS_NPC_POS = vector4(2399.9199, 3081.3052, 49.0949, 3.7133),
        --
        SELLER_NPC = {MODEL = 'a_m_m_hillbilly_01', Scena = "WORLD_HUMAN_SMOKING"},
        SELL_POS = { -- La position de vente de la drogue (la position du PED)
            [1] = vector4(2354.6587, 3067.5825, 48.2027, 319.3498),
            [2] = vector4(2374.9385, 3069.0171, 48.1528, 248.4535),
            [3] = vector4(2393.9771, 3073.2537, 48.1530, 46.2837),
            [4] = vector4(2385.8726, 3096.2463, 48.1601, 302.2762),
            [5] = vector4(2404.8311, 3117.1262, 48.1708, 150.2019),
            [6] = vector4(2420.9382, 3104.3994, 48.1530, 111.5213),
        },
        DRUG_PRICES = {
            [1] = {name = 'weed_pooch', label = "Pochons de Weed", price = 275, points_gagner = 9},
            [2] = {name = 'coke_pooch', label = "Pochons de Cocaine", price = 375, points_gagner = 11},
            [3] = {name = 'meth_pooch', label = "Pochons de Meth", price = 450, points_gagner = 15},
            [4] = {name = 'opium_pooch', label = "Pochons d'Opium", price = 550, points_gagner = 18},
            [5] = {name = 'pooch_ketamine', label = "Pochons de Kétamine", price = 900, points_gagner = 21},
            [6] = {name = 'xylazine_pooch', label = "Pochons de Xylazine", price = 1350, points_gagner = 26},
        },
        SELL_TIME = 2000, -- Combien de temps prend la vente
        -- NE PAS TOUCHER
        CURRENT_SELLER_POS = nil,
        OWNED_BY = nil,
        CREWS_POINTS = {},
        ARMES = {
            -- Armes
            {label = 'CALIBRE 50', hash = "WEAPON_PISTOL50", price = 500000, points_retirer = 3000, type = "weapon"},
            {label = 'BERETTA', hash = "WEAPON_PISTOL", price = 300000, points_retirer = 2000, type = "weapon"},
            -- Items
            {label = 'Menottes', hash = "handcuff", price = 100000, points_retirer = 100, type = "item"},
            {label = 'Kevlar', hash = "kevlar", price = 75000, points_retirer = 50, type = "item"},
        }
    },
    ["Chantier Paleto"] = {
        POS = vector3(53.6205, 6543.0093, 31.3326), -- La position au centre du territoire
        RADIUS = 75.0,  -- La largeur du territoire depuis le centre (un cercle)
        --
        WEAPONS_NPC = {MODEL = 'g_m_m_chicold_01'},
        WEAPONS_NPC_POS = vector4(34.1541, 6515.5889, 31.5483, 122.4688),
        --
        SELLER_NPC = {MODEL = 'a_m_m_trampbeac_01', Scena = "WORLD_HUMAN_SMOKING"},
        SELL_POS = { -- La position de vente de la drogue (la position du PED)
            [1] = vector4(56.2493, 6539.9780, 31.5974, 77.8355),
            [2] = vector4(55.4176, 6524.8535, 31.4709, 1.6491),
            [3] = vector4(39.3111, 6519.1479, 33.8722, 11.1599),
            [4] = vector4(39.5818, 6553.4365, 31.4265, 265.4561),
            [5] = vector4(58.9282, 6557.9077, 29.8821, 251.6792),
            [6] = vector4(70.4651, 6569.2593, 28.4366, 98.4567),
        },
        DRUG_PRICES = {
            [1] = {name = 'weed_pooch', label = "Pochons de Weed", price = 275, points_gagner = 9},
            [2] = {name = 'coke_pooch', label = "Pochons de Cocaine", price = 375, points_gagner = 11},
            [3] = {name = 'meth_pooch', label = "Pochons de Meth", price = 450, points_gagner = 15},
            [4] = {name = 'opium_pooch', label = "Pochons d'Opium", price = 550, points_gagner = 18},
            [5] = {name = 'pooch_ketamine', label = "Pochons de Kétamine", price = 900, points_gagner = 21},
            [6] = {name = 'xylazine_pooch', label = "Pochons de Xylazine", price = 1350, points_gagner = 26},
        },
        SELL_TIME = 2000, -- Combien de temps prend la vente
        -- NE PAS TOUCHER
        CURRENT_SELLER_POS = nil,
        OWNED_BY = nil,
        CREWS_POINTS = {},
        ARMES = {
            -- Armes
            {label = 'SNS', hash = "WEAPON_SNSPISTOL", price = 200000, points_retirer = 1000, type = "weapon"},
            {label = 'BERETTA', hash = "WEAPON_PISTOL", price = 300000, points_retirer = 2000, type = "weapon"},
            -- Items
            {label = 'Menottes', hash = "handcuff", price = 100000, points_retirer = 100, type = "item"},
            {label = 'Kevlar', hash = "kevlar", price = 75000, points_retirer = 50, type = "item"},
        }
    },
    ["Mirror Park"] = {
        POS = vector3(1145.5359, -656.2181, 56.8555), -- La position au centre du territoire
        RADIUS = 68.0,  -- La largeur du territoire depuis le centre (un cercle)
        --
        WEAPONS_NPC = {MODEL = 'g_m_m_chicold_01'},
        WEAPONS_NPC_POS = vector4(1135.1648, -663.8149, 57.0826, 106.0979),
        --
        SELLER_NPC = {MODEL = 'a_m_m_soucent_03', Scena = "WORLD_HUMAN_SMOKING"},
        SELL_POS = { -- La position de vente de la drogue (la position du PED)
            [1] = vector4(1124.7463, -647.2480, 56.7115, 297.3045),
            [2] = vector4(1144.2257, -642.9001, 56.8609, 303.0575),
            [3] = vector4(1145.1844, -673.7883, 57.0732, 328.2390),
            [4] = vector4(1144.5980, -704.7587, 56.6896, 187.7217),
            [5] = vector4(1176.3234, -711.7021, 59.3056, 324.1720),
            [6] = vector4(1170.1937, -670.8774, 60.9459, 50.5124),
        },
        DRUG_PRICES = {
            [1] = {name = 'weed_pooch', label = "Pochons de Weed", price = 275, points_gagner = 9},
            [2] = {name = 'coke_pooch', label = "Pochons de Cocaine", price = 375, points_gagner = 11},
            [3] = {name = 'meth_pooch', label = "Pochons de Meth", price = 450, points_gagner = 15},
            [4] = {name = 'opium_pooch', label = "Pochons d'Opium", price = 550, points_gagner = 18},
            [5] = {name = 'pooch_ketamine', label = "Pochons de Kétamine", price = 900, points_gagner = 21},
            [6] = {name = 'xylazine_pooch', label = "Pochons de Xylazine", price = 1350, points_gagner = 26},
        },
        SELL_TIME = 2000, -- Combien de temps prend la vente
        -- NE PAS TOUCHER
        CURRENT_SELLER_POS = nil,
        OWNED_BY = nil,
        CREWS_POINTS = {},
        ARMES = {
            -- Armes
            {label = 'SNS', hash = "WEAPON_SNSPISTOL", price = 50000, points_retirer = 1000, type = "weapon"},
            {label = 'UZI', hash = "WEAPON_MICROSMG", price = 1000000, points_retirer = 2000, type = "weapon"},
            -- Items
            {label = 'Menottes', hash = "handcuff", price = 100000, points_retirer = 100, type = "item"},
            {label = 'Kevlar', hash = "kevlar", price = 75000, points_retirer = 50, type = "item"},
        }
    },
}