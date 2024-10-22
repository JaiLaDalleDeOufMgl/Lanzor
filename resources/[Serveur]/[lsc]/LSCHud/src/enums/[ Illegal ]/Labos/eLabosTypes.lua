eLabosTypes = {}

eLabosTypes.weed = {
    name = "weed", label = "Laboratoire de Weed",

    ['enter'] = {
        onInteract = function()
            print("ENTER WEED")
        end
    },
    ['exit'] = {
        coords = vector3(1065.76, -3183.51, -39.16),
        onInteract = function()
            print("EXIT WEED")
        end
    },

    ['procces'] = {
        GrowInfos = {
            LifeHitPlantNoWater = 1, --- ONLY SECONDES

            WaterHitPlant = 0.5, --- ONLY SECONDES
            WaterAddOnPlant = 25
        },

        Drying = {
            CountWeedRecolt = 2,

            TimeDryingWeed = { min = 30, max = 60 }, --In Secondes

            Variety = {
                ['weed_head_candy'] = {
                    itemRecolt = 'weed_ounce_candy',
                    object = "candy_weed_dry",
                },
                ['weed_head_mac10'] = {
                    itemRecolt = 'weed_ounce_mac10',
                    object = "mac_weed_dry"
                },
                ['weed_head_og'] = {
                    itemRecolt = 'weed_ounce_og',
                    object = "og_weed_dry"
                },
                ['weed_head_rain'] = {
                    itemRecolt = 'weed_ounce_rain',
                    object = "rain_weed_dry"
                },
                ['weed_head_tropical'] = {
                    itemRecolt = 'weed_ounce_tropical',
                    object = "tropic_weed_dry"
                }
            }
        },

        Variety = {
            ['candy'] = {
                item = { seed = "seed_candy", recolt = "weed_head_candy" },
                variety = "candy",
                object = { small = "candy_weed_small", med = "candy_weed_med_a", medXL = "candy_weed_med_b", large = "candy_weed_lrg_a", largeXL = "candy_weed_lrg_b" },

                TimeGrow = { min = 1, max = 2 },   --In Minutes
                TimeBoostGrowWithFertilizer = 15,   --In Pourcent

                PlantRecolt = { min = 5, max = 10 },
                PlantRecoltWithFertilizer = { min = 10, max = 15 },
            },
            ['mac10'] = {
                item = { seed = "seed_mac10", recolt = "weed_head_mac10" },
                variety = "mac10",
                object = { small = "mac_weed_small", med = "mac_weed_med_a", medXL = "mac_weed_med_b", large = "mac_weed_lrg_a", largeXL = "mac_weed_lrg_b" },

                TimeGrow = { min = 1, max = 2 },   --In Minutes
                TimeBoostGrowWithFertilizer = 15,   --In Pourcent

                PlantRecolt = { min = 5, max = 10 },
                PlantRecoltWithFertilizer = { min = 10, max = 15 },
            },
            ['og'] = {
                item = { seed = "seed_og", recolt = "weed_head_og" },
                variety = "og",
                object = { small = "og_weed_small", med = "og_weed_med_a", medXL = "og_weed_med_b", large = "og_weed_lrg_a", largeXL = "og_weed_lrg_b" },

                TimeGrow = { min = 1, max = 2 },   --In Minutes
                TimeBoostGrowWithFertilizer = 15,   --In Pourcent
                
                PlantRecolt = { min = 5, max = 10 },
                PlantRecoltWithFertilizer = { min = 10, max = 15 },
            },
            ['rainbow'] = {
                item = { seed = "seed_rainbow", recolt = "weed_head_rain" },
                variety = "rainbow",
                object = { small = "rain_weed_small", med = "rain_weed_med_a", medXL = "rain_weed_med_b", large = "rain_weed_lrg_a", largeXL = "rain_weed_lrg_b" },

                TimeGrow = { min = 1, max = 2 },   --In Minutes
                TimeBoostGrowWithFertilizer = 15,   --In Pourcent
                
                PlantRecolt = { min = 5, max = 10 },
                PlantRecoltWithFertilizer = { min = 10, max = 15 },
            },
            ['tropical'] = {
                item = { seed = "seed_tropical", recolt = "weed_head_tropical" },
                variety = "tropical",
                object = { small = "tropic_weed_small", med = "tropic_weed_med_a", medXL = "tropic_weed_med_b", large = "tropic_weed_lrg_a", largeXL = "tropic_weed_lrg_b" },

                TimeGrow = { min = 1, max = 2 },   --In Minutes
                TimeBoostGrowWithFertilizer = 15,   --In Pourcent
                
                PlantRecolt = { min = 5, max = 10 },
                PlantRecoltWithFertilizer = { min = 10, max = 15 },
            },
        },

        ['placePot'] = {
            object = "pot_weed_s_v_t",
            state = "placePot",
            HelpText = "Appuyer sur E pour remplir le pot de terre",
            action = function(sizePlot, indexPlot, indexPot)
                local playerPed = PlayerPedId()
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, false)
                Wait(5000)
                ClearPedTasks(playerPed)

                TriggerServerEvent('Gamemode:Labo:Weed:PlaceGrassOnPot', sizePlot, indexPlot, indexPot)
            end
        },
        ['potGraas'] = {
            object = "pot_weed_s_t_t",
            state = "potGraas",
            HelpText = "Appuyer sur E pour planter la graine de weed dans le pot",
            action = function(sizePlot, indexPlot, indexPot)
                MOD_Weed:OnSelectSeedReady(function(seedVariety)
                    if (not seedVariety) then return end

                    local playerPed = PlayerPedId()
                    TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
                    Wait(5000)
                    ClearPedTasks(playerPed)

                    TriggerServerEvent('Gamemode:Labo:Weed:PlaceSeedOnPot', sizePlot, indexPlot, indexPot, seedVariety)
                end)
            end
        },
        ['potInGrow'] = {
            state = "potInGrow",
            HelpText = "Appuyer sur E pour ouvrir la gestion de la plante",
            action = function(sizePlot, indexPlot, indexPot)
                TriggerEvent('Gamemode:Labos:Weed:OpenManagePlant', sizePlot, indexPlot, indexPot)
            end
        },
        ['potRecolt'] = {
            state = "potRecolt",
            HelpText = "Appuyer sur E pour récolté les tête de weed",
            action = function(sizePlot, indexPlot, indexPot)
                local playerPed = PlayerPedId()
                TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_PARKING_METER', 0, false)
                Wait(5000)
                ClearPedTasks(playerPed)

                TriggerServerEvent('Gamemode:Labos:Weed:RecoltWeedOnPot', sizePlot, indexPlot, indexPot)
            end
        }
    },

    ['plotManagement'] = {
        coords = vector3(1060.1253, -3182.09, -39.1648),

        PlotList = {
            ['small'] = {
                [1] = {
                    name = "Petite Parcelle N°1",
                    plotInfo = vector3(1060.98, -3193.42, -39.5),
                    camera = {  coords = vector4(1060.04, -3193.7, -37.1, 267.02),  rotate = -36.0 },
                    PotList = {
                        [1] = vector3(1061.98, -3192.26, -39.06),
                        [2] = vector3(1062.14, -3194.57, -39.06),
                        [3] = vector3(1064.24, -3194.57, -39.06),
                        [4] = vector3(1064.06, -3192.21, -39.06)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1063.07, -3193.5, -37, 90.0)
                    }
                },
                [2] = {
                    name = "Petite Parcelle N°2",
                    plotInfo = vector3(1061.35, -3197.93, -39.5),
                    camera = {  coords = vector4(1059.59, -3198.08, -37.1, 267.02),  rotate = -36.0 },
                    PotList = {
                        [1] = vector3(1064.38, -3196.80, -39.09),
                        [2] = vector3(1062.08, -3196.80, -39.09),
                        [3] = vector3(1062.08, -3199.80, -39.09),
                        [4] = vector3(1064.38, -3199.80, -39.09)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1063.26, -3197.9, -37, 90.0)
                    }
                },
                [3] = {
                    name = "Petite Parcelle N°3",
                    plotInfo = vector3(1056.37, -3191.36, -39.11),
                    camera = {  coords = vector4(1056.51, -3193.29, -37.1, 358.5),  rotate = -36.0 },
                    PotList = {
                        [1] = vector3(1057.36, -3190.83, -39.13),
                        [2] = vector3(1055.22, -3190.83, -39.13),
                        [3] = vector3(1055.22, -3188.61, -39.13),
                        [4] = vector3(1057.36, -3188.61, -39.13)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1059.26, -3193.9, -37, 90.0)
                    }
                },
                [4] = {
                    name = "Petite Parcelle N°4",
                    plotInfo = vector3(1053.38, -3196.01, -39.5),
                    camera = {  coords = vector4(1055.90, -3195.78, -36.4, 85.6),  rotate = -36.0 },
                    PotList = {
                        [1] = vector3(1052.47, -3194.93, -39.11),
                        [2] = vector3(1052.47, -3197.01, -39.11),
                        [3] = vector3(1050.33, -3194.93, -39.11),
                        [4] = vector3(1050.33, -3197.01, -39.11)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1056.26, -3196.9, -37, 90.0)
                    }
                },
                [5] = {
                    name = "Petite Parcelle N°5",
                    plotInfo = vector3(1053.38, -3200.63, -39.5),
                    camera = {  coords = vector4(1055.90, -3200.56, -36.41, 85.6),  rotate = -35.0 },
                    PotList = {
                        [1] = vector3(1052.47, -3201.63, -39.11),
                        [2] = vector3(1052.47, -3199.63, -39.11),
                        [3] = vector3(1050.33, -3201.63, -39.11),
                        [4] = vector3(1050.33, -3199.63, -39.11)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1056.26, -3200.9, -37, 90.0)
                    }
                },
                [6] = {
                    name = "Petite Parcelle N°6",
                    plotInfo = vector3(1053.38, -3205.49, -39.5),
                    camera = {  coords = vector4(1055.90, -3205.05, -36.29, 85.6),  rotate = -35.0 },
                    PotList = {
                        [1] = vector3(1052.47, -3206.69, -39.11),
                        [2] = vector3(1052.47, -3204.34, -39.11),
                        [3] = vector3(1050.33, -3204.34, -39.11),
                        [4] = vector3(1050.33, -3206.69, -39.11)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1056.26, -3205.9, -37, 90.0)
                    }
                }
                
            },
            ['big'] = {
                [1] = {
                    name = "Grande Parcelle N°1",
                    plotInfo = vector3(1057.70, -3197.27, -39.5),
                    camera = {  coords = vector4(1057.62, -3196.53, -36.16, 179.63),  rotate = -35.0 },
                    PotList = {
                        [1] = vector3(1058.78, -3197.90, -39.069),
                        [2] = vector3(1058.78, -3200.90, -39.069),
                        [3] = vector3(1058.78, -3202.90, -39.069),
                        [4] = vector3(1056.78, -3197.90, -39.069),
                        --[5] = vector3(1056.78, -3200.90, -39.069),
                        --[6] = vector3(1056.78, -3202.90, -39.069)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1060.70, -3197.27, -37, 90.0)
                    }
                },
                [2] = {
                    name = "Grande Parcelle N°2",
                    plotInfo = vector3(1063.40, -3201.50, -39.5),
                    camera = {  coords = vector4(1063.40, -3200.85, -36.16, 179.87),  rotate = -35.0 },
                    PotList = {
                        [1] = vector3(1061.98, -3192.268, -39.069),
                        [2] = vector3(1062.14, -3194.57, -39.069),
                        [3] = vector3(1064.24, -3194.57, -39.069),
                        [4] = vector3(1064.06, -3192.21, -39.069)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1066.40, -3201.50, -37, 90.0)
                    }
                },
                [3] = {
                    name = "Grande Parcelle N°3",
                    plotInfo = vector3(1059.83, -3206.12, -39.5),
                    camera = {  coords = vector4(1060.60, -3206.23, -36.16, 85.37),  rotate = -35.0 },
                    PotList = {
                        [1] = vector3(1061.98, -3192.26, -39.069),
                        [2] = vector3(1062.14, -3194.57, -39.069),
                        [3] = vector3(1064.24, -3194.57, -39.069),
                        [4] = vector3(1064.06, -3192.21, -39.069)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1062.07, -3206.12, -37, 90.0)
                    }
                },
                [4] = {
                    name = "Grande Parcelle N°4",
                    plotInfo = vector3(1051.98, -3192.98, -39.5),
                    camera = {  coords = vector4(1051.1, -3195.9, -36.68, 1.73),  rotate = -35.0 },
                    PotList = {
                        [1] = vector3(1061.98, -3192.26, -39.069),
                        [2] = vector3(1062.14, -3194.57, -39.069),
                        [3] = vector3(1064.24, -3194.57, -39.069),
                        [4] = vector3(1064.06, -3192.21, -39.069)
                    },

                    LampObject = "bkr_prop_grow_lamp_02b",
                    LampList = {
                        [1] = vector4(1054.42, -3192.98, -37, 90.0)
                    }
                }

            }
        }
    },

    ['securityManagement'] = {
        coords = vector3(1044.606, -3194.8815, -38.1575)
    }
}

return eLabosTypes