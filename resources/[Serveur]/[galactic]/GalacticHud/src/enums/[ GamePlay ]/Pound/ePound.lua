ePound = {
    PoundMenu = "E pour ouvrir la fourrières",

    Prices = {
        ['SpawnVehicle'] = 10000
    },

    ZonesMarker = {
        ["MenuVehicle"] = { drawDistance = 10.0, RadiusInteraction = 1.0 },
        ["DeleteVehicle"] = { drawDistance = 10.0, RadiusInteraction = 3.0 }
    },

    GangBlips = {
        label = "[Fourrières] Gang",
        sprite = 67,
        color = 76
    },
    GangZones = {
        {
            ["Menu"] = { x = 120.3433, y = 6625.924, z = 31.95438 },
            ["Spawn"] = { x = 146.7289, y = 6625.81, z = 31.72639, heading = 223.731 }
        },

        {
            ["Menu"] = { x = 484.04, y = -1319.47, z = 29.20 },
            ["Spawn"] = { x = 493.82, y = -1331.89, z = 29.33, heading = 341.75 }
        },
    },


    Blips = {
        ["car"] = {
            label = "[Fourrières] Vehicules",
            sprite = 67,
            color = 31
        },
        ["plane"] = {
            label = "[Fourrières] Avions",
            sprite = 64,
            color = 31
        },
        ["boat"] = {
            label = "[Fourrières] Bateaux",
            sprite = 427,
            color = 31
        }
    },


    Zones = {
        --Pound_LosSantos
        {
            ["type"] = "car",
            ["Menu"] = { x = 374.42, y = -1620.68, z = 29.29 },
            ["Spawn"] = { x = 391.74, y = -1619.0, z = 29.29, heading = 318.34 }
        },

        --Pound_Sandy
        {
            ["type"] = "car",
            ["Menu"] = { x = 1644.10, y = 3808.20, z = 35.09 },
            ["Spawn"] = { x = 1627.84, y = 3788.45, z = 33.77, heading = 308.53 }
        },

        --Pound_Paleto
        {
            ["type"] = "car",
            ["Menu"] = { x = -223.6, y = 6243.37, z = 31.49 },
            ["Spawn"] = { x = -230.88, y = 6255.89, z = 30.49, heading = 136.5 }
        },

        --Pound_Concess
        {
            ["type"] = "car",
            ["Menu"] = { x = -866.7601, y = -2367.3723, z = 14.0244 },
            ["Spawn"] = { x = -866.9598, y = -2348.2925, z = 13.9557, heading = 189.3175 }
        },

        --Pound_LifeInvader
        {
            ["type"] = "car",
            ["Menu"] = { x = -1151.388, y = -205.2902, z = 37.95996 },
            ["Spawn"] = { x = -1148.734, y = -219.0661, z = -219.0661, heading = 198.97 }
        },


        -- [BOAT]

        -- LS Dock
        {
            ["type"] = "boat",
            ["Menu"] = { x = -795.87, y = -1511.31, z = 1.59 },
            ["Spawn"] = { x = -795.072509765625, y = -1502.3209228515626, z = -0.4263916015625, heading = 104.88188934326 },
        },

        -- Sandy Dock
        {
            ["type"] = "boat",
            ["Menu"] = { x = 1338.94, y = 4225.45, z = 33.91 },
            ["Spawn"] = { x = 1334.61, y = 4264.68, z = 29.86, heading = 87.0 },
        },

        -- Paleto Dock
        {
            ["type"] = "boat",
            ["Menu"] = { x = -278.21, y = 6620.71, z = 7.5 },
            ["Spawn"] = { x = -290.46, y = 6622.72, z = -0.47477427124977, heading = 52.0 },
        },

        -- Cayo Perico Dock
        {
            ["type"] = "boat",
            ["Menu"] = { x = 4906.80, y = -5172.02, z = 2.477 },
            ["Spawn"] = { x = 4893.5341796875, y = -5168.3471679688, z = -0.4263916015625, heading = 337.32284545898 },
        },

        -- Roxwood Dock
        {
            ["type"] = "boat",
            ["Menu"] = { x = -986.81, y = 6542.99, z = 1.8876 },
            ["Spawn"] = { x = -985.0256, y = 6548.688, z = -0.3190742, heading = 91.48 },
        },

        -- [PLANE]
        -- LS
        {
            ["type"] = "plane",
            ["Menu"] = { x = -1254.21, y = -3401.60, z = 13.94 },
            ["Spawn"] = { x = -1275.4285888672, y = -3388.3779296875, z = 13.9296875, heading = 331.65353393555 }
        },

        -- Sandy
        {
            ["type"] = "plane",
            ["Menu"] = { x = 1742.41, y = 3300.02, z = 41.22 },
            ["Spawn"] = { x = 1707.7846679688, y = 3254.2680664062, z = 41.024169921875, heading = 102.04724884033 }
        },

        -- Cayo Perico
        {
            ["type"] = "plane",
            ["Menu"] = { x = 4443.55, y = -4480.67, z = 4.30 },
            ["Spawn"] = { x = 4483.8989257812, y = -4493.419921875, z = 4.1904296875, heading = 102.04724884033 }
        }
    }
}

return ePound
