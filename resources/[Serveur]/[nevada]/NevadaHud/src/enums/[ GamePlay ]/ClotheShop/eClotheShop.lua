eClotheShop = {
    Blips = {
        label = "Magasin de vêtement",
        sprite = 73,
        display = 4,
        Scale = 0.6,
        color = 5,
        range = true,
    },

    Prices = {
        ["clothes_haut"] = 100,
        ["clothes_pants"] = 200,
        ["clothes_shoes"] = 100,
        ["clothes_glasses"] = 50,
        ["clothes_mask"] = 10,
        ["clothes_cap"] = 30,
        ["clothes_bag"] = 500,
        ["clothes_ring"] = 100,
        ["clothes_watch"] = 150,
        -- ["clothes_gilletshot"] = { ["shoes_1"] = 0, ["shoes_2"] = 0 },
        ["clothes_chain"] = 200,
        ["clothes_earring"] = 100,

        ["MakeTenue"] = 2000
    },

    Zones = {
        ['main'] = {
            { pos = vector3(72.8544, -1396.9847, 29.6736) }, -- 1
            { pos = vector3(-711.41, -149.73, 37.41) }, -- 2
            { pos = vector3(-164.82, -306.04, 39.73) }, -- 3
            { pos = vector3(428.3115, -802.4881, 29.7886) }, -- 4 
            { pos = vector3(-826.9643, -1073.1176, 11.6256) }, -- 5
            { pos = vector3(-1448.32, -235.54, 49.81) }, -- 6
            { pos = vector3(9.1931, 6513.5654, 32.1753) }, -- 7
            { pos = vector3(124.86, -224.00, 54.55) }, -- 8
            { pos = vector3(1696.1396, 4826.9521, 42.3605) }, -- 9
            { pos = vector3(615.20, 2763.25, 42.08) }, -- 10
            { pos = vector3(1192.7694, 2713.0786, 38.5201) }, -- 11
            { pos = vector3(-1192.29, -768.28, 17.32) }, -- 12
            { pos = vector3(-3171.34, 1043.46, 20.86) }, -- 13
            { pos = vector3(-1105.9469, 2709.7502, 19.4053) }, -- 14
            { pos = vector3(4489.9785, -4452.6455, 4.1962) }, -- 15 (Cayo)
        },

        ['glasses'] = { --> Point d'intéraction avec les lunettes
            { pos = vector3(80.3787, -1388.0022, 29.3758) }, -- 1
            { pos = vector3(-700.92, -157.01, 37.41) }, -- 2
            { pos = vector3(-166.08, -293.73, 39.73) }, -- 3
            { pos = vector3(420.9389, -810.6310, 29.4909) }, -- 4
            { pos = vector3(-815.9789, -1075.2529, 11.3279) }, -- 5
            { pos = vector3(-1451.37, -247.36, 49.82) }, -- 6
            { pos = vector3(-1.7470, 6512.8413, 31.8777) }, -- 7
            { pos = vector3(118.45, -223.66, 54.55) }, -- 8
            { pos = vector3(1689.7335, 4817.8926, 42.0629) }, -- 9
            { pos = vector3(621.24, 2765.65, 42.08) }, -- 10
            { pos = vector3(1201.4263, 2705.4951, 38.2224) }, -- 11
            { pos = vector3(-1186.99, -772.20, 17.33) }, -- 12
            { pos = vector3(-3177.98, 1044.44, 20.86) }, -- 13
            { pos = vector3(-1103.12, 2714.75, 19.11) }, -- 14
            { pos = vector3(4496.3794, -4453.5767, 4.2380) }, -- 15 (Cayo)
        },

        ['helmet'] = { --> Point d'intéraction avec les casques
            { pos = vector3(80.35, -1399.87, 29.37) }, -- 1
            { pos = vector3(-710.71, -162.19, 37.41) }, -- 2
            { pos = vector3(-155.65, -297.36, 39.73) }, -- 3
            { pos = vector3(420.56, -799.13, 29.49) }, -- 4
            { pos = vector3(-826.07, -1081.37, 11.33) }, -- 5
            { pos = vector3(-1459.78, -239.65, 49.79) }, -- 6
            { pos = vector3(6.71, 6520.87, 31.88) }, -- 7
            { pos = vector3(131.41, -211.93, 54.55) }, -- 8
            { pos = vector3(1687.98, 4829.10, 42.06) }, -- 9
            { pos = vector3(613.99, 2750.02, 42.08) }, -- 10
            { pos = vector3(1189.52, 2705.19, 38.22) }, -- 11
            { pos = vector3(-1204.33, -774.87, 17.31) }, -- 12
            { pos = vector3(-3164.35, 1054.94, 20.86) }, -- 13
            { pos = vector3(-1103.41, 2702.16, 19.11) }, -- 14
            { pos = vector3(4489.3335, -4455.3193, 4.2458) }, -- 15 (Cayo)
        },

        ['ears'] = { --> Point d'intéraction avec les oreilles
            { pos = vector3(78.57, -1390.91, 29.37) }, -- 1
            { pos = vector3(-715.28, -151.36, 37.41) }, -- 2
            { pos = vector3(-161.07, -308.10, 39.73) }, -- 3
            { pos = vector3(422.48, -808.20, 29.49) }, -- 4
            { pos = vector3(-819.18, -1075.20, 11.33) }, -- 5
            { pos = vector3(-1450.34, -231.84, 49.80) }, -- 6
            { pos = vector3(1.24, 6513.32, 31.88) }, -- 7
            { pos = vector3(123.78, -215.36, 54.55) }, -- 8
            { pos = vector3(1691.11, 4820.48, 42.06) }, -- 9
            { pos = vector3(619.48, 2756.07, 42.08) }, -- 10
            { pos = vector3(1198.60, 2707.13, 38.22) }, -- 11
            { pos = vector3(-1195.93, -776.05, 17.32) }, -- 12
            { pos = vector3(-3172.12, 1052.07, 20.86) }, -- 13
            { pos = vector3(-1097.80, 2709.66, 19.11) }, -- 14
            { pos = vector3(4500.7163, -4456.7773, 4.2141) }, -- 15 (Cayo)
        },

        ['chain'] = { --> Point d'intéraction avec les chaines
            { pos = vector3(76.9652, -1400.0835, 29.3759) }, -- 1
            { pos = vector3(-707.81, -153.03, 37.41) }, -- 2
            { pos = vector3(-164.62, -301.32, 39.73) }, -- 3
            { pos = vector3(424.0119, -799.3690, 29.4910) }, -- 4
            { pos = vector3(-827.5060, -1078.3385, 11.3279) }, -- 5
            { pos = vector3(-1449.83, -239.32, 49.81) }, -- 6
            { pos = vector3(9.2045, 6518.6929, 31.8777) }, -- 7
            { pos = vector3(127.25, -218.21, 54.55) }, -- 8
            { pos = vector3(1691.3740, 4829.5142, 42.0629) }, -- 9
            { pos = vector3(615.24, 2757.12, 42.08) }, -- 10
            { pos = vector3(1189.6593, 2708.6377, 38.2224) }, -- 11
            { pos = vector3(-1197.31, -771.90, 17.31) }, -- 12
            { pos = vector3(-3168.89, 1049.15, 20.86) }, -- 13
            { pos = vector3(-1105.5660, 2704.7312, 19.1077) }, -- 14
            { pos = vector3(4492.4468, -4459.7739, 4.2281) }, -- 15 (Cayo)
        },
    }
}

return eClotheShop