Tree.Custom = {}

Tree.Coins_ = {
    Price = 0,
    PriceExtra = 60,              -- 0.6 euros
    PricePrimary = 150,           -- 1.5 euros
    PriceSecondary = 115,         -- 1.2 euros
    PriceInterieurs = 90,         -- 0.9 euros
    PriceDashboard = 60,          -- 0.6 euros
    PriceNacrage = 45,            -- 0.45 euros
    PriceJantesPrincipales = 120, -- 1.2 euros
    PriceWheelColor = 30,         -- 0.3 euros
    PriceKlaxon = 15,             -- 0.15 euros
    PricePharesXenons = 70,       -- 0.75 euros
    PricePlateIndex = 10,         -- 0.15 euros
    PriceLivery = 100,            -- 1.05 euros
    PriceColorPhares = 4,         -- 0.45 euros
    PriceAileron = 90,            -- 0.9 euros
    PriceParechocAvant = 120,     -- 1.2 euros
    PriceParechocArriere = 120,   -- 1.2 euros
    PriceCarrosserie = 150,       -- 1.5 euros
    PriceEchappement = 75,        -- 0.75 euros
    PriceCadre = 60,              -- 0.6 euros
    PriceCalandre = 60,           -- 0.6 euros
    PriceCapot = 90,              -- 0.9 euros
    PriceAutocollantGauche = 30,  -- 0.3 euros
    PriceAutocollantDroit = 30,   -- 0.3 euros
    PriceToit = 90,               -- 0.9 euros
    PriceSupportPlaque = 15,      -- 0.15 euros
    PricePlaqueAvant = 15,        -- 0.15 euros
    PriceFigurine = 15,           -- 0.15 euros
    PriceDashboardMotif = 45,     -- 0.45 euros
    PriceCadran = 30,             -- 0.3 euros
    PriceHautParleurPortes = 60,  -- 0.6 euros
    PriceMotifSieges = 45,        -- 0.45 euros
    PriceVolant = 60,             -- 0.6 euros
    PriceLevier = 30,             -- 0.3 euros
    PriceLogo = 15,               -- 0.15 euros
    PriceHautParleurVitre = 60,   -- 0.6 euros
    PriceHautParleurCoffre = 60,  -- 0.6 euros
    PriceHydrolique = 90,         -- 0.9 euros
    PriceVisualMoteur = 105,      -- 1.05 euros
    PriceFiltresAir = 45,         -- 0.45 euros
    PriceEntretoises = 0,         -- 0.45 euros
    PriceCouverture = 0,          -- 0.3 euros
    PriceAntenne = 0,             -- 0.15 euros
    PriceReservoir = 0,           -- 0.6 euros
    PriceFenetre = 0,             -- 0.45 euros
    PriceStyle = 0,               -- 0.75 euros
    PriceSuspension = 0,          -- 0.9 euros
    PriceTransmission = 0,        -- 1.05 euros
    PriceMoteur = 0,              -- 1.5 euros
    PriceFrein = 1.2,             -- 1.2 euros
    PriceTurbo = 1.35             -- 1.35 euros

}

local CustomCoins = {
    Pos = { {
        pos = vector3(-219.9385, -1342.9546, 31.4133),
        job = "mecano",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-219.9478, -1337.4071, 31.4223),
        job = "mecano",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-202.9828, -1340.8479, 31.3996),
        job = "mecano",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-202.9216, -1336.7473, 31.3996),
        job = "mecano",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-333.0874, -132.7575, 39.0096),
        job = "mecano2",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-312.5800, -125.0531, 39.1688),
        job = "mecano2",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-313.1994, -134.7802, 39.0097),
        job = "mecano2",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-317.1739, -145.2002, 39.0115),
        job = "mecano2",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    }, {
        pos = vector3(-320.9934, -156.2785, 39.0097),
        job = "mecano2",
        notif = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au " .. exports.Tree:serveurConfig().Serveur.color ..
            "Benny's~s~.",
        size = 90.0
    } },

    DefaultPrimaireColour = 1,
    DefaultSecondaireColour = 1,
    DefaultInteriorColour = 1,
    DefaultDashboardColour = 1,
    DefaultNacrageColour = 1,
    DefaultTypeRouesColour = 1,
    DefaultJantesPrincipales = 1,
    DefaultColourJantes = 1,
    DefaultKlaxon = 1,
    DefaultTeinteVitres = 1,
    DefaultTypesPlaques = 1,
    DefaultLivery = 1,
    DefaultColourPhares = 1,
    DefaultFrein = 1,
    DefaultMoteur = 1,
    DefaultTransmission = 1,
    DefaultSuspension = 1,

    DefaultAileron = 1,
    DefaultParechocAvant = 1,
    DefaultParechocArriere = 1,
    DefaultCarrosserie = 1,
    DefaultEchappement = 1,
    DefaultCadre = 1,
    DefaultCalandre = 1,
    DefaultCapot = 1,
    DefaultAutocollantGauche = 1,
    DefaultAutocollantDroit = 1,
    DefaultToit = 1,
    DefaultSupportPlaque = 1,
    DefaultPlaqueAvant = 1,
    DefaultFigurine = 1,
    DefaultDashboardMotif = 1,
    DefaultCadran = 1,
    DefaultHautParleurPortes = 1,
    DefaultMotifSieges = 1,
    DefaultVolant = 1,
    DefaultLevier = 1,
    DefaultLogoCustom = 1,
    DefaultHautParleurVitre = 1,
    DefaultHautParleurCoffre = 1,
    DefaultHydrolique = 1,
    DefaultVisualMoteur = 1,
    DefaultFiltresAir = 1,
    DefaultEntretoises = 1,
    DefaultCouverture = 1,
    DefaultAntenne = 1,
    DefaultStyle = 1,
    DefaultFenetre = 1,
    DefaultReservoir = 1,

    Price = 0,
    PriceExtra = 0,
    PricePrimary = 0,
    PriceSecondary = 0,
    PriceInterieurs = 0,
    PriceDashboard = 0,
    PriceNacrage = 0,
    PriceJantesPrincipales = 0,
    PriceWheelColor = 0,
    PriceKlaxon = 0,
    PricePharesXenons = 0,
    PricePlateIndex = 0,
    PriceLivery = 0,
    PriceColorPhares = 0,
    PriceAileron = 0,
    PriceParechocAvant = 0,
    PriceParechocArriere = 0,
    PriceCarrosserie = 0,
    PriceEchappement = 0,
    PriceCadre = 0,
    PriceCalandre = 0,
    PriceCapot = 0,
    PriceAutocollantGauche = 0,
    PriceAutocollantDroit = 0,
    PriceToit = 0,
    PriceSupportPlaque = 0,
    PricePlaqueAvant = 0,
    PriceFigurine = 0,
    PriceDashboardMotif = 0,
    PriceCadran = 0,
    PriceHautParleurPortes = 0,
    PriceMotifSieges = 0,
    PriceVolant = 0,
    PriceLevier = 0,
    PriceLogo = 0,
    PriceHautParleurVitre = 0,
    PriceHautParleurCoffre = 0,
    PriceHydrolique = 0,
    PriceVisualMoteur = 0,
    PriceFiltresAir = 0,
    PriceEntretoises = 0,
    PriceCouverture = 0,
    PriceAntenne = 0,
    PriceReservoir = 0,
    PriceFenetre = 0,
    PriceStyle = 0,
    PriceSuspension = 0,
    PriceTransmission = 0,
    PriceMoteur = 0,
    PriceFrein = 0,
    PriceTurbo = 0,

    ExtraList = { {
        id = 1,
        index = 1
    }, {
        id = 2,
        index = 1
    }, {
        id = 3,
        index = 1
    }, {
        id = 4,
        index = 1
    }, {
        id = 5,
        index = 1
    }, {
        id = 6,
        index = 1
    }, {
        id = 7,
        index = 1
    }, {
        id = 8,
        index = 1
    }, {
        id = 9,
        index = 1
    }, {
        id = 10,
        index = 1
    }, {
        id = 11,
        index = 1
    }, {
        id = 12,
        index = 1
    }, {
        id = 13,
        index = 1
    }, {
        id = 14,
        index = 1
    }, {
        id = 15,
        index = 1
    }, {
        id = 16,
        index = 1
    }, {
        id = 17,
        index = 1
    }, {
        id = 18,
        index = 1
    }, {
        id = 19,
        index = 1
    }, {
        id = 20,
        index = 1
    } }
}

CustomCoins.openedMenu = false
CustomCoins.mainMenu = Tree.Menu.CreateMenu(" ", "Benny's")
CustomCoins.subMenuColour = Tree.Menu.CreateSubMenu(CustomCoins.mainMenu, " ", "Benny's")
CustomCoins.subMenuRoues = Tree.Menu.CreateSubMenu(CustomCoins.mainMenu, " ", "Benny's")
CustomCoins.subMenuClassiques = Tree.Menu.CreateSubMenu(CustomCoins.mainMenu, " ", "Benny's")
CustomCoins.subMenuCustoms = Tree.Menu.CreateSubMenu(CustomCoins.mainMenu, " ", "Benny's")
CustomCoins.subMenuPerf = Tree.Menu.CreateSubMenu(CustomCoins.mainMenu, " ", "Benny's")
CustomCoins.subMenuExtra = Tree.Menu.CreateSubMenu(CustomCoins.mainMenu, " ", "Benny's")
CustomCoins.subMenuModification = Tree.Menu.CreateSubMenu(CustomCoins.mainMenu, " ", "Benny's")

CustomCoins.mainMenu.Closable = false

function ResetAll()
    CustomCoins.openedMenu = false
    CustomCoins.Price = 0
    CustomCoins.PriceExtra = 0
    CustomCoins.PricePrimary = 0
    CustomCoins.PriceSecondary = 0
    CustomCoins.PriceInterieurs = 0
    CustomCoins.PriceDashboard = 0
    CustomCoins.PriceNacrage = 0
    CustomCoins.PriceJantesPrincipales = 0
    CustomCoins.PriceWheelColor = 0
    CustomCoins.PriceKlaxon = 0
    CustomCoins.PricePharesXenons = 0
    CustomCoins.PricePlateIndex = 0
    CustomCoins.PriceLivery = 0
    CustomCoins.PriceColorPhares = 0
    CustomCoins.PriceAileron = 0
    CustomCoins.PriceParechocAvant = 0
    CustomCoins.PriceParechocArriere = 0
    CustomCoins.PriceCarrosserie = 0
    CustomCoins.PriceEchappement = 0
    CustomCoins.PriceCadre = 0
    CustomCoins.PriceCalandre = 0
    CustomCoins.PriceCapot = 0
    CustomCoins.PriceAutocollantGauche = 0
    CustomCoins.PriceAutocollantDroit = 0
    CustomCoins.PriceToit = 0
    CustomCoins.PriceSupportPlaque = 0
    CustomCoins.PricePlaqueAvant = 0
    CustomCoins.PriceFigurine = 0
    CustomCoins.PriceDashboardMotif = 0
    CustomCoins.PriceCadran = 0
    CustomCoins.PriceHautParleurPortes = 0
    CustomCoins.PriceMotifSieges = 0
    CustomCoins.PriceVolant = 0
    CustomCoins.PriceLevier = 0
    CustomCoins.PriceLogo = 0
    CustomCoins.PriceHautParleurVitre = 0
    CustomCoins.PriceHautParleurCoffre = 0
    CustomCoins.PriceHydrolique = 0
    CustomCoins.PriceVisualMoteur = 0
    CustomCoins.PriceFiltresAir = 0
    CustomCoins.PriceEntretoises = 0
    CustomCoins.PriceCouverture = 0
    CustomCoins.PriceAntenne = 0
    CustomCoins.PriceReservoir = 0
    CustomCoins.PriceFenetre = 0
    CustomCoins.PriceStyle = 0
    CustomCoins.PriceSuspension = 0
    CustomCoins.PriceTransmission = 0
    CustomCoins.PriceMoteur = 0
    CustomCoins.PriceFrein = 0
    CustomCoins.PriceTurbo = 0
end

function GetModObjects(veh, mod)
    local int = { "Default" }
    for i = 0, tonumber(GetNumVehicleMods(veh, mod)) - 1 do
        local toBeInserted = i
        local labelName = GetModTextLabel(veh, mod, i)
        if labelName ~= nil then
            local name = tostring(GetLabelText(labelName))
            if name ~= "NULL" then
                toBeInserted = name
            end
        end
        int[#int + 1] = toBeInserted
    end

    return int
end

function DrawTextPrice(Text, Justi, havetext)
    SetTextFont(4)
    SetTextScale(1.1, 1.1)
    SetTextColour(255, 255, 255, 255)
    SetTextJustification(0)
    SetTextEntry("STRING")
    if havetext then
        SetTextWrap(0.5, 0.6)
    end
    AddTextComponentString(Text)
    DrawText(0.5, 0.90)
end

function Tree.Custom.MenuCustomization()
    if not CustomCoins.openedMenu then
        CustomCoins.Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        CustomCoins.Prop = ESX.Game.GetVehicleProperties(CustomCoins.Vehicle)
        Wait(150)
        CustomCoins.ColourPrimarySecondaryColourJantes = {}
        CustomCoins.ColourIntDashNacrage = {}
        CustomCoins.JantesPrincipales = {}
        CustomCoins.JantesArrieres = {}
        CustomCoins.MaxLivery = {}
        CustomCoins.MaxKlaxon = {}
        CustomCoins.CoulorPhares = {}
        for i = 1, 160, 1 do
            table.insert(CustomCoins.ColourPrimarySecondaryColourJantes, i)
        end
        for i = 1, 158, 1 do
            table.insert(CustomCoins.ColourIntDashNacrage, i)
        end
        for i = 1, GetNumVehicleMods(CustomCoins.Vehicle, 23) + 1, 1 do
            table.insert(CustomCoins.JantesPrincipales, i)
        end
        for i = 1, GetNumVehicleMods(CustomCoins.Vehicle, 24) + 1, 1 do
            table.insert(CustomCoins.JantesArrieres, i)
        end
        for i = 1, GetVehicleLiveryCount(CustomCoins.Vehicle), 1 do
            table.insert(CustomCoins.MaxLivery, i)
        end
        for i = 1, 59, 1 do
            table.insert(CustomCoins.MaxKlaxon, i)
        end
        for i = 1, 12, 1 do
            table.insert(CustomCoins.CoulorPhares, i)
        end
        if IsToggleModOn(CustomCoins.Vehicle, 22) then
            CustomCoins.DefaultPharesXenons = true
        else
            CustomCoins.DefaultPharesXenons = false
        end
        if IsToggleModOn(CustomCoins.Vehicle, 18) then
            CustomCoins.DefaultTurbo = true
        else
            CustomCoins.DefaultTurbo = false
        end
        SetVehicleModKit(CustomCoins.Vehicle, 0)
        Wait(150)
        CustomCoins.openedMenu = true
        Tree.Menu.Visible(CustomCoins.mainMenu, true)
        CreateThread(function()
            while CustomCoins.openedMenu do
                CustomCoins.Price = CustomCoins.PriceExtra + CustomCoins.PricePrimary + CustomCoins.PriceSecondary +
                    CustomCoins.PriceInterieurs + CustomCoins.PriceDashboard + CustomCoins.PriceNacrage +
                    CustomCoins.PriceJantesPrincipales + CustomCoins.PriceWheelColor +
                    CustomCoins.PriceKlaxon + CustomCoins.PricePharesXenons + CustomCoins.PricePlateIndex +
                    CustomCoins.PriceLivery + CustomCoins.PriceColorPhares + CustomCoins.PriceAileron +
                    CustomCoins.PriceParechocAvant + CustomCoins.PriceParechocArriere +
                    CustomCoins.PriceCarrosserie + CustomCoins.PriceEchappement + CustomCoins.PriceCadre +
                    CustomCoins.PriceCalandre + CustomCoins.PriceCapot + CustomCoins.PriceAutocollantGauche +
                    CustomCoins.PriceAutocollantDroit + CustomCoins.PriceToit +
                    CustomCoins.PriceSupportPlaque + CustomCoins.PricePlaqueAvant +
                    CustomCoins.PriceFigurine + CustomCoins.PriceDashboardMotif + CustomCoins.PriceCadran +
                    CustomCoins.PriceHautParleurPortes + CustomCoins.PriceMotifSieges +
                    CustomCoins.PriceVolant + CustomCoins.PriceLevier + CustomCoins.PriceLogo +
                    CustomCoins.PriceHautParleurVitre + CustomCoins.PriceHautParleurCoffre +
                    CustomCoins.PriceHydrolique + CustomCoins.PriceVisualMoteur +
                    CustomCoins.PriceFiltresAir + CustomCoins.PriceEntretoises + CustomCoins.PriceCouverture +
                    CustomCoins.PriceAntenne + CustomCoins.PriceReservoir + CustomCoins.PriceFenetre +
                    CustomCoins.PriceStyle + CustomCoins.PriceSuspension + CustomCoins.PriceTransmission +
                    CustomCoins.PriceMoteur + CustomCoins.PriceFrein + CustomCoins.PriceTurbo
                if CustomCoins.Price > 0 then
                end
                Tree.Menu.IsVisible(CustomCoins.mainMenu, function()
                    Tree.Menu.Button("Peinture", nil, {
                        RightLabel = "→"
                    }, true, {}, CustomCoins.subMenuColour)
                    Tree.Menu.Button("Roues", nil, {
                        RightLabel = "→"
                    }, true, {}, CustomCoins.subMenuRoues)
                    Tree.Menu.Button("Classiques", nil, {
                        RightLabel = "→"
                    }, true, {}, CustomCoins.subMenuClassiques)
                    Tree.Menu.Button("Customs", nil, {
                        RightLabel = "→"
                    }, true, {}, CustomCoins.subMenuCustoms)
                    Tree.Menu.Button("Performances", nil, {
                        RightLabel = "→"
                    }, true, {}, CustomCoins.subMenuPerf)
                    Tree.Menu.Button("Extra", nil, {
                        RightLabel = "→"
                    }, true, {}, CustomCoins.subMenuExtra)
                    Tree.Menu.Button("Valider les modifications", nil, {
                        RightLabel = "→"
                    }, true, {}, CustomCoins.subMenuModification)
                end)
                Tree.Menu.IsVisible(CustomCoins.subMenuModification, function()
                    if CustomCoins.Price > 0 then
                        Tree.Menu.Button("Valider les modifications", nil, {
                            RightLabel = "~r~" .. Tree.Func_.CoinsToRound(CustomCoins.Price),
                            RightBadge = Tree.Menu.BadgeStyle.GoldMedal
                        }, true, {
                            onSelected = function()
                                TriggerServerEvent("Tree:Get:Coins", CustomCoins.Price);
                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                FreezeEntityPosition(vehicle, false)
                            end
                        })
                    end
                    Tree.Menu.Button("Annuler les modifications", nil, {
                        RightLabel = "→"
                    }, true, {
                        onSelected = function()
                            CustomCoins.openedMenu = false
                            Tree.Menu.CloseAll()
                            Tree.Func_.SetVehicleProperties(CustomCoins.Vehicle, CustomCoins.Prop)
                            ResetAll()
                            ESX.ShowNotification("Vous avez " ..
                                exports.Tree:serveurConfig().Serveur.color ..
                                "annuler~s~ toutes " ..
                                exports.Tree:serveurConfig().Serveur.color .. "les modifications~s~.")
                            FactureJob = nil
                            banana = nil
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            FreezeEntityPosition(vehicle, false)
                        end
                    })
                    if CustomCoins.PriceExtra > 0 then
                        Tree.Menu.Button("Extra", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceExtra
                        }, true, {})
                    end
                    if CustomCoins.PricePrimary > 0 then
                        Tree.Menu.Button("Primaire", nil, {
                            RightLabel = "~r~" .. CustomCoins.PricePrimary
                        }, true, {})
                    end
                    if CustomCoins.PriceSecondary > 0 then
                        Tree.Menu.Button("Secondaire", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceSecondary
                        }, true, {})
                    end
                    if CustomCoins.PriceInterieurs > 0 then
                        Tree.Menu.Button("Intérieurs", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceInterieurs
                        }, true, {})
                    end
                    if CustomCoins.PriceDashboard > 0 then
                        Tree.Menu.Button("Tableau de bord", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceDashboard
                        }, true, {})
                    end
                    if CustomCoins.PriceNacrage > 0 then
                        Tree.Menu.Button("Nacrage", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceNacrage
                        }, true, {})
                    end
                    if CustomCoins.PriceJantesPrincipales > 0 then
                        Tree.Menu.Button("Jantes principales", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceJantesPrincipales
                        }, true, {})
                    end
                    if CustomCoins.PriceWheelColor > 0 then
                        Tree.Menu.Button("Couleurs des jantes", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceWheelColor
                        }, true, {})
                    end
                    if CustomCoins.PriceKlaxon > 0 then
                        Tree.Menu.Button("Klaxon", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceKlaxon
                        }, true, {})
                    end
                    if CustomCoins.PricePharesXenons > 0 then
                        Tree.Menu.Button("Phares xenons", nil, {
                            RightLabel = "~r~" .. CustomCoins.PricePharesXenons
                        }, true, {})
                    end
                    if CustomCoins.PricePlateIndex > 0 then
                        Tree.Menu.Button("Types de plaques", nil, {
                            RightLabel = "~r~" .. CustomCoins.PricePlateIndex
                        }, true, {})
                    end
                    if CustomCoins.PriceLivery > 0 then
                        Tree.Menu.Button("Livery", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLivery
                        }, true, {})
                    end
                    if CustomCoins.PriceColorPhares > 0 then
                        Tree.Menu.Button("Couleur des phares", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceColorPhares
                        }, true, {})
                    end
                    if CustomCoins.PriceAileron > 0 then
                        Tree.Menu.Button("Aileron", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceAileron
                        }, true, {})
                    end
                    if CustomCoins.PriceParechocAvant > 0 then
                        Tree.Menu.Button("Pare-choc avant", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceParechocAvant
                        }, true, {})
                    end
                    if CustomCoins.PriceParechocArriere > 0 then
                        Tree.Menu.Button("Pare-choc arriére", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceParechocArriere
                        }, true, {})
                    end
                    if CustomCoins.PriceCarrosserie > 0 then
                        Tree.Menu.Button("Carrosserie", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceCarrosserie
                        }, true, {})
                    end
                    if CustomCoins.PriceEchappement > 0 then
                        Tree.Menu.Button("Echappement", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceEchappement
                        }, true, {})
                    end
                    if CustomCoins.PriceCadre > 0 then
                        Tree.Menu.Button("Cadre", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceCadre
                        }, true, {})
                    end
                    if CustomCoins.PriceCalandre > 0 then
                        Tree.Menu.Button("Calandre", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceCalandre
                        }, true, {})
                    end
                    if CustomCoins.PriceCapot > 0 then
                        Tree.Menu.Button("PriceCapot", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceCapot
                        }, true, {})
                    end
                    if CustomCoins.PriceAutocollantGauche > 0 then
                        Tree.Menu.Button("Autocollant gauche", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceAutocollantGauche
                        }, true, {})
                    end
                    if CustomCoins.PriceAutocollantDroit > 0 then
                        Tree.Menu.Button("Autocollant droit", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceAutocollantDroit
                        }, true, {})
                    end
                    if CustomCoins.PriceToit > 0 then
                        Tree.Menu.Button("Toit", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceToit
                        }, true, {})
                    end
                    if CustomCoins.PriceSupportPlaque > 0 then
                        Tree.Menu.Button("Support de plaque", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceSupportPlaque
                        }, true, {})
                    end
                    if CustomCoins.PricePlaqueAvant > 0 then
                        Tree.Menu.Button("Plaque avant", nil, {
                            RightLabel = "~r~" .. CustomCoins.PricePlaqueAvant
                        }, true, {})
                    end
                    if CustomCoins.PriceFigurine > 0 then
                        Tree.Menu.Button("Figurine", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceFigurine
                        }, true, {})
                    end
                    if CustomCoins.PriceDashboardMotif > 0 then
                        Tree.Menu.Button("Tableau de bord motif", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceDashboardMotif
                        }, true, {})
                    end
                    if CustomCoins.PriceCadran > 0 then
                        Tree.Menu.Button("Cadran", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceCadran
                        }, true, {})
                    end
                    if CustomCoins.PriceHautParleurPortes > 0 then
                        Tree.Menu.Button("Haut parleur portes", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceHautParleurPortes
                        }, true, {})
                    end
                    if CustomCoins.PriceMotifSieges > 0 then
                        Tree.Menu.Button("Motif Sieges", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceMotifSieges
                        }, true, {})
                    end
                    if CustomCoins.PriceVolant > 0 then
                        Tree.Menu.Button("Volant", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceVolant
                        }, true, {})
                    end
                    if CustomCoins.PriceLevier > 0 then
                        Tree.Menu.Button("Levier", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLevier
                        }, true, {})
                    end
                    if CustomCoins.PriceLogo > 0 then
                        Tree.Menu.Button("Logo custom", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLogo
                        }, true, {})
                    end
                    if CustomCoins.PriceHautParleurVitre > 0 then
                        Tree.Menu.Button("Haut parleur vitre", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceHautParleurVitre
                        }, true, {})
                    end
                    if CustomCoins.PriceHautParleurCoffre > 0 then
                        Tree.Menu.Button("Haut parleur coffre", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceHautParleurCoffre
                        }, true, {})
                    end

                    if CustomCoins.PriceLevier > 0 then
                        Tree.Menu.Button("Levier", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLevier
                        }, true, {})
                    end
                    if CustomCoins.PriceLevier > 0 then
                        Tree.Menu.Button("Levier", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLevier
                        }, true, {})
                    end
                    if CustomCoins.PriceLevier > 0 then
                        Tree.Menu.Button("Levier", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLevier
                        }, true, {})
                    end
                    if CustomCoins.PriceLevier > 0 then
                        Tree.Menu.Button("Levier", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLevier
                        }, true, {})
                    end

                    if CustomCoins.PriceHydrolique > 0 then
                        Tree.Menu.Button("Hydrolique", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceHydrolique
                        }, true, {})
                    end
                    if CustomCoins.PriceVisualMoteur > 0 then
                        Tree.Menu.Button("Moteur", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceVisualMoteur
                        }, true, {})
                    end
                    if CustomCoins.PriceFiltresAir > 0 then
                        Tree.Menu.Button("Filtres é Air", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceFiltresAir
                        }, true, {})
                    end
                    if CustomCoins.PriceLevier > 0 then
                        Tree.Menu.Button("Levier", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceLevier
                        }, true, {})
                    end
                    if CustomCoins.PriceEntretoises > 0 then
                        Tree.Menu.Button("Entretoises", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceEntretoises
                        }, true, {})
                    end

                    if CustomCoins.PriceCouverture > 0 then
                        Tree.Menu.Button("Couverture", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceCouverture
                        }, true, {})
                    end
                    if CustomCoins.PriceAntenne > 0 then
                        Tree.Menu.Button("Antenne", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceAntenne
                        }, true, {})
                    end
                    if CustomCoins.PriceReservoir > 0 then
                        Tree.Menu.Button("Reservoir", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceReservoir
                        }, true, {})
                    end
                    if CustomCoins.PriceFenetre > 0 then
                        Tree.Menu.Button("Fenétre", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceFenetre
                        }, true, {})
                    end
                    if CustomCoins.PriceEntretoises > 0 then
                        Tree.Menu.Button("Entretoises", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceEntretoises
                        }, true, {})
                    end
                    if CustomCoins.PriceStyle > 0 then
                        Tree.Menu.Button("Stickers", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceStyle
                        }, true, {})
                    end
                    if CustomCoins.PriceSuspension > 0 then
                        Tree.Menu.Button("Suspension", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceSuspension
                        }, true, {})
                    end
                    if CustomCoins.PriceTransmission > 0 then
                        Tree.Menu.Button("Transmission", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceTransmission
                        }, true, {})
                    end
                    if CustomCoins.PriceMoteur > 0 then
                        Tree.Menu.Button("Moteur", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceMoteur
                        }, true, {})
                    end
                    if CustomCoins.PriceFrein > 0 then
                        Tree.Menu.Button("Frein", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceFrein
                        }, true, {})
                    end
                    if CustomCoins.PriceTurbo > 0 then
                        Tree.Menu.Button("Turbo", nil, {
                            RightLabel = "~r~" .. CustomCoins.PriceTurbo
                        }, true, {})
                    end
                end)
                Tree.Menu.IsVisible(CustomCoins.subMenuColour, function()
                    Tree.Menu.List("Primaire", CustomCoins.ColourPrimarySecondaryColourJantes,
                        CustomCoins.DefaultPrimaireColour, nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultPrimaireColour = Index

                                local primaire, secondaire = GetVehicleColours(CustomCoins.Vehicle)
                                ClearVehicleCustomPrimaryColour(CustomCoins.Vehicle)
                                SetVehicleColours(CustomCoins.Vehicle, CustomCoins.DefaultPrimaireColour, secondaire)

                                local primaire, secondaire = GetVehicleColours(CustomCoins.Vehicle)
                                if CustomCoins.Prop.color1 == primaire then
                                    CustomCoins.PricePrimary = 0
                                else
                                    CustomCoins.PricePrimary = Tree.Coins_.PricePrimary
                                end
                            end
                        })
                    Tree.Menu.List("Secondaire", CustomCoins.ColourPrimarySecondaryColourJantes,
                        CustomCoins.DefaultSecondaireColour, nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultSecondaireColour = Index

                                local primaire, secondaire = GetVehicleColours(CustomCoins.Vehicle)
                                ClearVehicleCustomSecondaryColour(CustomCoins.Vehicle)
                                SetVehicleColours(CustomCoins.Vehicle, primaire, CustomCoins.DefaultSecondaireColour)

                                local primaire, secondaire = GetVehicleColours(CustomCoins.Vehicle)
                                if CustomCoins.Prop.color2 == secondaire then
                                    CustomCoins.PriceSecondary = 0
                                else
                                    CustomCoins.PriceSecondary = Tree.Coins_.PriceSecondary
                                end
                            end
                        })
                    Tree.Menu.List("Intérieurs", CustomCoins.ColourIntDashNacrage, CustomCoins.DefaultInteriorColour, nil,
                        {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultInteriorColour = Index

                                SetVehicleInteriorColour(CustomCoins.Vehicle, CustomCoins.DefaultInteriorColour)

                                if CustomCoins.Prop.InteriorColor == GetVehicleInteriorColor(CustomCoins.Vehicle) then
                                    CustomCoins.PriceInterieurs = 0
                                else
                                    CustomCoins.PriceInterieurs = Tree.Coins_.PriceInterieurs
                                end
                            end
                        })
                    Tree.Menu.List("Tableau de bord", CustomCoins.ColourIntDashNacrage,
                        CustomCoins.DefaultDashboardColour,
                        nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultDashboardColour = Index

                                if GetFollowVehicleCamViewMode() ~= 4 then
                                    SetFollowVehicleCamViewMode(4)
                                end
                                SetVehicleDashboardColour(CustomCoins.Vehicle, CustomCoins.DefaultDashboardColour)

                                if CustomCoins.Prop.dashboardColour == GetVehicleDashboardColor(CustomCoins.Vehicle) then
                                    CustomCoins.PriceDashboard = 0
                                else
                                    CustomCoins.PriceDashboard = Tree.Coins_.PriceDashboard
                                end
                            end
                        })
                    Tree.Menu.List("Nacrage", CustomCoins.ColourIntDashNacrage, CustomCoins.DefaultNacrageColour, nil, {},
                        true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultNacrageColour = Index

                                local _, nacrage = GetVehicleExtraColours(CustomCoins.Vehicle)
                                SetVehicleExtraColours(CustomCoins.Vehicle, CustomCoins.DefaultNacrageColour, nacrage)

                                local pearlescentColor, _ = GetVehicleExtraColours(CustomCoins.Vehicle)
                                if CustomCoins.Prop.pearlescentColor == pearlescentColor then
                                    CustomCoins.PriceNacrage = 0
                                else
                                    CustomCoins.PriceNacrage = Tree.Coins_.PriceNacrage
                                end
                            end
                        })
                end)
                Tree.Menu.IsVisible(CustomCoins.subMenuRoues, function()
                    Tree.Menu.List("Type de roues", { "Sport", "Muscle", "Lowrider", "SUV", "Offroad", "Tuner", "Moto",
                            "High end", "Bespokes Originals", "Bespokes Smokes" },
                        CustomCoins.DefaultTypeRouesColour, nil, {}, true, {
                            onListChange = function(Index)
                                if Index < 1 or Index > 10 then
                                    print("Index out of range")
                                    return
                                end

                                CustomCoins.DefaultTypeRouesColour = Index
                                CustomCoins.DefaultJantesPrincipales = 1
                                if CustomCoins.Vehicle then
                                    local wheelType = CustomCoins.DefaultTypeRouesColour - 1
                                    if wheelType >= 0 then
                                        SetVehicleWheelType(CustomCoins.Vehicle, wheelType)
                                    end
                                else
                                    print("Vehicle is not defined")
                                end

                                CustomCoins.JantesLoadPrincipales = {}
                                CustomCoins.JantesLoadArrieres = {}

                                local numMods = GetNumVehicleMods(CustomCoins.Vehicle, 23) or 0
                                for i = 1, numMods + 1 do
                                    table.insert(CustomCoins.JantesLoadPrincipales, i)
                                end

                                if Tree.Coins_ and Tree.Coins_.JantesPrincipales then
                                    CustomCoins.JantesPrincipales = Tree.Coins_.JantesPrincipales
                                else
                                    print("Tree.Coins_.JantesPrincipales is not defined")
                                end
                            end
                        })

                    Tree.Menu.List("Jantes principales", CustomCoins.JantesPrincipales,
                        CustomCoins.DefaultJantesPrincipales, nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultJantesPrincipales = Index

                                SetVehicleMod(CustomCoins.Vehicle, 23, CustomCoins.DefaultJantesPrincipales - 2,
                                    GetVehicleModVariation(CustomCoins.Vehicle, 23))

                                if CustomCoins.Prop.modFrontWheels == GetVehicleMod(CustomCoins.Vehicle, 23) then
                                    CustomCoins.PriceJantesPrincipales = 0
                                else
                                    CustomCoins.PriceJantesPrincipales = Tree.Coins_.PriceJantesPrincipales
                                end
                            end
                        })
                    Tree.Menu.List("Couleurs des jantes", CustomCoins.ColourPrimarySecondaryColourJantes,
                        CustomCoins.DefaultColourJantes, nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultColourJantes = Index

                                local extraJantes = GetVehicleExtraColours(CustomCoins.Vehicle)
                                SetVehicleExtraColours(CustomCoins.Vehicle, extraJantes,
                                    CustomCoins.DefaultColourJantes - 1)

                                local _, wheelColor = GetVehicleExtraColours(CustomCoins.Vehicle)

                                if CustomCoins.Prop.wheelColor == wheelColor then
                                    CustomCoins.PriceWheelColor = 0
                                else
                                    CustomCoins.PriceWheelColor = Tree.Coins_.PriceWheelColor
                                end
                            end
                        })
                end)
                Tree.Menu.IsVisible(CustomCoins.subMenuClassiques, function()
                    Tree.Menu.List("Klaxon", CustomCoins.MaxKlaxon, CustomCoins.DefaultKlaxon, nil, {}, true, {
                        onListChange = function(Index)
                            CustomCoins.DefaultKlaxon = Index

                            SetVehicleMod(CustomCoins.Vehicle, 14, CustomCoins.DefaultKlaxon - 2, false)

                            if CustomCoins.Prop.modHorns == GetVehicleMod(CustomCoins.Vehicle, 14) then
                                CustomCoins.PriceKlaxon = 0
                            else
                                CustomCoins.PriceKlaxon = Tree.Coins_.PriceKlaxon
                            end
                        end
                    })
                    Tree.Menu.List("Teinte des vitres",
                        { "Normal", "Black", "Smoke Black", "Simple Smoke", "Stock", "Limo" },
                        CustomCoins.DefaultTeinteVitres, nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultTeinteVitres = Index

                                SetVehicleWindowTint(CustomCoins.Vehicle, CustomCoins.DefaultTeinteVitres - 1)

                                if CustomCoins.Prop.windowTint + 1 == GetVehicleWindowTint(CustomCoins.Vehicle) then
                                    CustomCoins.PriceKlaxon = 0
                                else
                                    CustomCoins.PriceKlaxon = Tree.Coins_.PriceKlaxon
                                end
                            end
                        })
                    Tree.Menu.Checkbox("Phares xenons", false, CustomCoins.DefaultPharesXenons, {}, {
                        onChecked = function()
                            ToggleVehicleMod(CustomCoins.Vehicle, 22, true)
                            CustomCoins.PricePharesXenons = 350
                        end,
                        onUnChecked = function()
                            ToggleVehicleMod(CustomCoins.Vehicle, 22, false)
                            CustomCoins.PricePharesXenons = 0
                        end,

                        onSelected = function(Index)
                            CustomCoins.DefaultPharesXenons = Index
                        end
                    })
                    Tree.Menu.List("Types de plaques",
                        { "Default", "Sa Black", "Sa Blue", "Sa White", "Simple White", "NY White" },
                        CustomCoins.DefaultTypesPlaques, nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultTypesPlaques = Index

                                SetVehicleNumberPlateTextIndex(CustomCoins.Vehicle, CustomCoins.DefaultTypesPlaques - 1)

                                if CustomCoins.Prop.plateIndex == GetVehicleNumberPlateTextIndex(CustomCoins.Vehicle) then
                                    CustomCoins.PricePlateIndex = 0
                                else
                                    CustomCoins.PricePlateIndex = Tree.Coins_.PricePlateIndex
                                end
                            end
                        })
                    if json.encode(CustomCoins.MaxLivery) ~= "[]" then
                        Tree.Menu.List("Livery", CustomCoins.MaxLivery, CustomCoins.DefaultLivery, nil, {}, true, {
                            onListChange = function(Index)
                                CustomCoins.DefaultLivery = Index

                                SetVehicleLivery(CustomCoins.Vehicle, CustomCoins.DefaultLivery - 2)

                                if CustomCoins.Prop.modLivery == CustomCoins.DefaultLivery - 2 then
                                    CustomCoins.PriceLivery = 0
                                else
                                    CustomCoins.PriceLivery = Tree.Coins_.PriceLivery
                                end
                            end
                        })
                    else
                        Tree.Menu.Button("Livery", nil, {}, false, {})
                    end
                    if IsToggleModOn(CustomCoins.Vehicle, 22) then
                        Tree.Menu.List("Couleur des phares", CustomCoins.CoulorPhares, CustomCoins.DefaultColourPhares,
                            nil, {}, true, {
                                onListChange = function(Index)
                                    if Index < 1 or Index > #CustomCoins.CoulorPhares then
                                        print("Index out of range")
                                        return
                                    end
                                    CustomCoins.DefaultColourPhares = Index

                                    if CustomCoins.Vehicle then
                                        SetVehicleXenonLightsColour(CustomCoins.Vehicle,
                                            CustomCoins.DefaultColourPhares - 1)
                                    else
                                        print("Vehicle is not defined")
                                    end

                                    if CustomCoins.DefaultColourPhares - 1 == 0 then
                                        CustomCoins.PriceColorPhares = 0
                                    else
                                        if LsCuTree and LsCuTree.Coins_stoms and LsCuTree.Coins_stoms.PriceColorPhares then
                                            CustomCoins.PriceColorPhares = LsCuTree.Coins_stoms.PriceColorPhares
                                        else
                                            print("Coins_stoms or PriceColorPhares is not defined")
                                        end
                                    end
                                end
                            })
                    else
                        Tree.Menu.Button("Couleur des phares", nil, {}, false, {})
                    end
                end)

                Tree.Menu.IsVisible(CustomCoins.subMenuCustoms, function()
                    if GetNumVehicleMods(CustomCoins.Vehicle, 0) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 0)) then
                            Tree.Menu.List("Aileron", GetModObjects(CustomCoins.Vehicle, 0), CustomCoins.DefaultAileron,
                                nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultAileron = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 0, CustomCoins.DefaultAileron - 2, false)

                                        if CustomCoins.Prop.modSpoilers == GetVehicleMod(CustomCoins.Vehicle, 0) then
                                            CustomCoins.PriceAileron = 0
                                        else
                                            CustomCoins.PriceAileron = Tree.Coins_.PriceAileron
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 1) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 1)) then
                            Tree.Menu.List("Pare-choc avant", GetModObjects(CustomCoins.Vehicle, 1),
                                CustomCoins.DefaultParechocAvant, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultParechocAvant = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 1, CustomCoins.DefaultParechocAvant - 2, false)

                                        if CustomCoins.Prop.modFrontBumper == GetVehicleMod(CustomCoins.Vehicle, 1) then
                                            CustomCoins.PriceParechocAvant = 0
                                        else
                                            CustomCoins.PriceParechocAvant = Tree.Coins_.PriceParechocAvant
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 2) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 2)) then
                            Tree.Menu.List("Pare-choc arriére", GetModObjects(CustomCoins.Vehicle, 2),
                                CustomCoins.DefaultParechocArriere, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultParechocArriere = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 2, CustomCoins.DefaultParechocArriere - 2,
                                            false)

                                        if CustomCoins.Prop.modRearBumper == GetVehicleMod(CustomCoins.Vehicle, 2) then
                                            CustomCoins.PriceParechocArriere = 0
                                        else
                                            CustomCoins.PriceParechocArriere = Tree.Coins_.PriceParechocArriere
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 3) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 3)) then
                            Tree.Menu.List("Carrosserie", GetModObjects(CustomCoins.Vehicle, 3),
                                CustomCoins.DefaultCarrosserie, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultCarrosserie = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 3, CustomCoins.DefaultCarrosserie - 2, false)

                                        if CustomCoins.Prop.modSideSkirt == GetVehicleMod(CustomCoins.Vehicle, 3) then
                                            CustomCoins.PriceCarrosserie = 0
                                        else
                                            CustomCoins.PriceCarrosserie = Tree.Coins_.PriceCarrosserie
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 4) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 4)) then
                            Tree.Menu.List("Echappement", GetModObjects(CustomCoins.Vehicle, 4),
                                CustomCoins.DefaultEchappement, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultEchappement = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 4, CustomCoins.DefaultEchappement - 2, false)

                                        if CustomCoins.Prop.modExhaust == GetVehicleMod(CustomCoins.Vehicle, 4) then
                                            CustomCoins.PriceEchappement = 0
                                        else
                                            CustomCoins.PriceEchappement = Tree.Coins_.PriceEchappement
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 5) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 5)) then
                            Tree.Menu.List("Cadre", GetModObjects(CustomCoins.Vehicle, 5), CustomCoins.DefaultCadre, nil,
                                {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultCadre = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 5, CustomCoins.DefaultCadre - 2, false)

                                        if CustomCoins.Prop.modFrame == GetVehicleMod(CustomCoins.Vehicle, 5) then
                                            CustomCoins.PriceCadre = 0
                                        else
                                            CustomCoins.PriceCadre = Tree.Coins_.PriceCadre
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 6) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 6)) then
                            Tree.Menu.List("Calandre", GetModObjects(CustomCoins.Vehicle, 6), CustomCoins
                                .DefaultCalandre,
                                nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultCalandre = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 6, CustomCoins.DefaultCalandre - 2, false)

                                        if CustomCoins.Prop.modGrille == GetVehicleMod(CustomCoins.Vehicle, 6) then
                                            CustomCoins.PriceCalandre = 0
                                        else
                                            CustomCoins.PriceCalandre = Tree.Coins_.PriceCalandre
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 7) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 7)) then
                            Tree.Menu.List("Capot", GetModObjects(CustomCoins.Vehicle, 7), CustomCoins.DefaultCapot, nil,
                                {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultCapot = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 7, CustomCoins.DefaultCapot - 2, false)

                                        if CustomCoins.Prop.modHood == GetVehicleMod(CustomCoins.Vehicle, 7) then
                                            CustomCoins.PriceCapot = 0
                                        else
                                            CustomCoins.PriceCapot = Tree.Coins_.PriceCapot
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 8) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 8)) then
                            Tree.Menu.List("Autocollant gauche", GetModObjects(CustomCoins.Vehicle, 8),
                                CustomCoins.DefaultAutocollantGauche, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultAutocollantGauche = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 8, CustomCoins.DefaultAutocollantGauche - 2,
                                            false)

                                        if CustomCoins.Prop.modFender == GetVehicleMod(CustomCoins.Vehicle, 8) then
                                            CustomCoins.PriceAutocollantGauche = 0
                                        else
                                            CustomCoins.PriceAutocollantGauche = Tree.Coins_.PriceAutocollantGauche
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 9) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 9)) then
                            Tree.Menu.List("Autocollant droit", GetModObjects(CustomCoins.Vehicle, 9),
                                CustomCoins.DefaultAutocollantDroit, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultAutocollantDroit = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 9, CustomCoins.DefaultAutocollantDroit - 2,
                                            false)

                                        if CustomCoins.Prop.modRightFender == GetVehicleMod(CustomCoins.Vehicle, 9) then
                                            CustomCoins.PriceAutocollantDroit = 0
                                        else
                                            CustomCoins.PriceAutocollantDroit = Tree.Coins_.PriceAutocollantDroit
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 10) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 10)) then
                            Tree.Menu.List("Toit", GetModObjects(CustomCoins.Vehicle, 10), CustomCoins.DefaultToit, nil,
                                {},
                                true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultToit = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 10, CustomCoins.DefaultToit - 2, false)

                                        if CustomCoins.Prop.modRightFender == GetVehicleMod(CustomCoins.Vehicle, 10) then
                                            CustomCoins.PriceToit = 0
                                        else
                                            CustomCoins.PriceToit = Tree.Coins_.PriceToit
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 25) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 25)) then
                            Tree.Menu.List("Support de plaque", GetModObjects(CustomCoins.Vehicle, 25),
                                CustomCoins.DefaultSupportPlaque, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultSupportPlaque = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 25, CustomCoins.DefaultSupportPlaque - 2,
                                            false)

                                        if CustomCoins.Prop.modPlateHolder == GetVehicleMod(CustomCoins.Vehicle, 25) then
                                            CustomCoins.PriceSupportPlaque = 0
                                        else
                                            CustomCoins.PriceSupportPlaque = Tree.Coins_.PriceSupportPlaque
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 26) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 26)) then
                            Tree.Menu.List("Plaque avant", GetModObjects(CustomCoins.Vehicle, 26),
                                CustomCoins.DefaultPlaqueAvant, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultPlaqueAvant = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 26, CustomCoins.DefaultPlaqueAvant - 2, false)

                                        if CustomCoins.Prop.modVanityPlate == GetVehicleMod(CustomCoins.Vehicle, 26) then
                                            CustomCoins.PricePlaqueAvant = 0
                                        else
                                            CustomCoins.PriceSupportPlaque = Tree.Coins_.PriceSupportPlaque
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 28) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 28)) then
                            Tree.Menu.List("Figurine", GetModObjects(CustomCoins.Vehicle, 28),
                                CustomCoins.DefaultFigurine,
                                nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultFigurine = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 28, CustomCoins.DefaultFigurine - 2, false)

                                        if CustomCoins.Prop.modOrnaments == GetVehicleMod(CustomCoins.Vehicle, 28) then
                                            CustomCoins.PriceFigurine = 0
                                        else
                                            CustomCoins.PriceFigurine = Tree.Coins_.PriceFigurine
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 29) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 29)) then
                            Tree.Menu.List("Tableau de bord motif", GetModObjects(CustomCoins.Vehicle, 29),
                                CustomCoins.DefaultDashboardMotif, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultDashboardMotif = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 29, CustomCoins.DefaultDashboardMotif - 2,
                                            false)

                                        if CustomCoins.Prop.modDashboard == GetVehicleMod(CustomCoins.Vehicle, 29) then
                                            CustomCoins.PriceDashboardMotif = 0
                                        else
                                            CustomCoins.PriceDashboardMotif = Tree.Coins_.PriceDashboardMotif
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 30) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 30)) then
                            Tree.Menu.List("Cadran", GetModObjects(CustomCoins.Vehicle, 30), CustomCoins.DefaultCadran,
                                nil,
                                {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultCadran = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 30, CustomCoins.DefaultCadran - 2, false)

                                        if CustomCoins.Prop.modDial == GetVehicleMod(CustomCoins.Vehicle, 30) then
                                            CustomCoins.PriceCadran = 0
                                        else
                                            CustomCoins.PriceCadran = Tree.Coins_.PriceCadran
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 31) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 31)) then
                            Tree.Menu.List("Haut parleur portes", GetModObjects(CustomCoins.Vehicle, 31),
                                CustomCoins.DefaultHautParleurPortes, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultHautParleurPortes = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 31, CustomCoins.DefaultHautParleurPortes - 2,
                                            false)

                                        if CustomCoins.Prop.modDoorSpeaker == GetVehicleMod(CustomCoins.Vehicle, 31) then
                                            CustomCoins.PriceHautParleurPortes = 0
                                        else
                                            CustomCoins.PriceHautParleurPortes = Tree.Coins_.PriceHautParleurPortes
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 32) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 32)) then
                            Tree.Menu.List("Motif sieges", GetModObjects(CustomCoins.Vehicle, 32),
                                CustomCoins.DefaultMotifSieges, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultMotifSieges = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 32, CustomCoins.DefaultMotifSieges - 2, false)

                                        if CustomCoins.Prop.modSeats == GetVehicleMod(CustomCoins.Vehicle, 32) then
                                            CustomCoins.PriceMotifSieges = 0
                                        else
                                            CustomCoins.PriceMotifSieges = Tree.Coins_.PriceMotifSieges
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 33) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 33)) then
                            Tree.Menu.List("Volant", GetModObjects(CustomCoins.Vehicle, 33), CustomCoins.DefaultVolant,
                                nil,
                                {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultVolant = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 33, CustomCoins.DefaultVolant - 2, false)

                                        if CustomCoins.Prop.modSteeringWheel == GetVehicleMod(CustomCoins.Vehicle, 33) then
                                            CustomCoins.PriceVolant = 0
                                        else
                                            CustomCoins.PriceVolant = Tree.Coins_.PriceVolant
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 34) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 34)) then
                            Tree.Menu.List("Levier", GetModObjects(CustomCoins.Vehicle, 34), CustomCoins.DefaultLevier,
                                nil,
                                {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultLevier = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 34, CustomCoins.DefaultLevier - 2, false)

                                        if CustomCoins.Prop.modShifterLeavers == GetVehicleMod(CustomCoins.Vehicle, 34) then
                                            CustomCoins.PriceLevier = 0
                                        else
                                            CustomCoins.PriceLevier = Tree.Coins_.PriceLevier
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 35) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 35)) then
                            Tree.Menu.List("Logo custom", GetModObjects(CustomCoins.Vehicle, 35),
                                CustomCoins.DefaultLogoCustom, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultLogoCustom = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 35, CustomCoins.DefaultLogoCustom - 2, false)

                                        if CustomCoins.Prop.modAPlate == GetVehicleMod(CustomCoins.Vehicle, 35) then
                                            CustomCoins.PriceLogo = 0
                                        else
                                            CustomCoins.PriceLogo = Tree.Coins_.PriceLogo
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 36) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 36)) then
                            Tree.Menu.List("Haut parleur vitre", GetModObjects(CustomCoins.Vehicle, 36),
                                CustomCoins.DefaultHautParleurVitre, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultHautParleurVitre = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 36, CustomCoins.DefaultHautParleurVitre - 2,
                                            false)

                                        if CustomCoins.Prop.modSpeakers == GetVehicleMod(CustomCoins.Vehicle, 36) then
                                            CustomCoins.PriceHautParleurVitre = 0
                                        else
                                            CustomCoins.PriceHautParleurVitre = Tree.Coins_.PriceHautParleurVitre
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 37) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 37)) then
                            Tree.Menu.List("Haut parleur coffre", GetModObjects(CustomCoins.Vehicle, 37),
                                CustomCoins.DefaultHautParleurCoffre, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultHautParleurCoffre = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 37, CustomCoins.DefaultHautParleurCoffre - 2,
                                            false)

                                        if CustomCoins.Prop.modTrunk == GetVehicleMod(CustomCoins.Vehicle, 37) then
                                            CustomCoins.PriceHautParleurCoffre = 0
                                        else
                                            CustomCoins.PriceHautParleurCoffre = Tree.Coins_.PriceHautParleurCoffre
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 38) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 38)) then
                            Tree.Menu.List("Hydrolique", GetModObjects(CustomCoins.Vehicle, 38),
                                CustomCoins.DefaultHydrolique, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultHydrolique = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 38, CustomCoins.DefaultHydrolique - 2, false)

                                        if CustomCoins.Prop.modHydrolic == GetVehicleMod(CustomCoins.Vehicle, 38) then
                                            CustomCoins.PriceHydrolique = 0
                                        else
                                            CustomCoins.PriceHydrolique = Tree.Coins_.PriceHydrolique
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 39) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 39)) then
                            Tree.Menu.List("Moteur", GetModObjects(CustomCoins.Vehicle, 39),
                                CustomCoins.DefaultVisualMoteur, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultVisualMoteur = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 39, CustomCoins.DefaultVisualMoteur - 2, false)

                                        if CustomCoins.Prop.modEngineBlock == GetVehicleMod(CustomCoins.Vehicle, 39) then
                                            CustomCoins.PriceVisualMoteur = 0
                                        else
                                            CustomCoins.PriceVisualMoteur = Tree.Coins_.PriceVisualMoteur
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 40) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 40)) then
                            Tree.Menu.List("Filtres é air", GetModObjects(CustomCoins.Vehicle, 40),
                                CustomCoins.DefaultFiltresAir, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultFiltresAir = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 40, CustomCoins.DefaultFiltresAir - 2, false)

                                        if CustomCoins.Prop.modAirFilter == GetVehicleMod(CustomCoins.Vehicle, 40) then
                                            CustomCoins.PriceFiltresAir = 0
                                        else
                                            CustomCoins.PriceFiltresAir = Tree.Coins_.PriceFiltresAir
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 41) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 41)) then
                            Tree.Menu.List("Entretoises", GetModObjects(CustomCoins.Vehicle, 41),
                                CustomCoins.DefaultEntretoises, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultEntretoises = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 41, CustomCoins.DefaultEntretoises - 2, false)

                                        if CustomCoins.Prop.modStruts == GetVehicleMod(CustomCoins.Vehicle, 41) then
                                            CustomCoins.PriceEntretoises = 0
                                        else
                                            CustomCoins.PriceEntretoises = Tree.Coins_.PriceEntretoises
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 42) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 42)) then
                            Tree.Menu.List("Couverture", GetModObjects(CustomCoins.Vehicle, 42),
                                CustomCoins.DefaultCouverture, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultCouverture = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 42, CustomCoins.DefaultCouverture - 2, false)

                                        if CustomCoins.Prop.modArchCover == GetVehicleMod(CustomCoins.Vehicle, 42) then
                                            CustomCoins.PriceCouverture = 0
                                        else
                                            CustomCoins.PriceCouverture = Tree.Coins_.PriceCouverture
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 43) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 43)) then
                            Tree.Menu.List("Antenne", GetModObjects(CustomCoins.Vehicle, 43), CustomCoins.DefaultAntenne,
                                nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultAntenne = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 43, CustomCoins.DefaultAntenne - 2, false)

                                        if CustomCoins.Prop.modAerials == GetVehicleMod(CustomCoins.Vehicle, 43) then
                                            CustomCoins.PriceAntenne = 0
                                        else
                                            CustomCoins.PriceAntenne = Tree.Coins_.PriceAntenne
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 45) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 45)) then
                            Tree.Menu.List("Reservoir", GetModObjects(CustomCoins.Vehicle, 45),
                                CustomCoins.DefaultReservoir, nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultReservoir = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 45, CustomCoins.DefaultReservoir - 2, false)

                                        if CustomCoins.Prop.modTank == GetVehicleMod(CustomCoins.Vehicle, 45) then
                                            CustomCoins.PriceReservoir = 0
                                        else
                                            CustomCoins.PriceReservoir = Tree.Coins_.PriceReservoir
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 46) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 46)) then
                            Tree.Menu.List("Fenétre", GetModObjects(CustomCoins.Vehicle, 46), CustomCoins.DefaultFenetre,
                                nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultFenetre = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 46, CustomCoins.DefaultFenetre - 2, false)

                                        if CustomCoins.Prop.modWindows == GetVehicleMod(CustomCoins.Vehicle, 46) then
                                            CustomCoins.PriceFenetre = 0
                                        else
                                            CustomCoins.PriceFenetre = Tree.Coins_.PriceFenetre
                                        end
                                    end
                                })
                        end
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 48) > 0 then
                        if not Tree.Func_.GetMitrailVeh(GetModObjects(CustomCoins.Vehicle, 48)) then
                            Tree.Menu.List("Stickers", GetModObjects(CustomCoins.Vehicle, 48), CustomCoins.DefaultStyle,
                                nil, {}, true, {
                                    onListChange = function(Index)
                                        CustomCoins.DefaultStyle = Index

                                        SetVehicleMod(CustomCoins.Vehicle, 48, CustomCoins.DefaultStyle - 2, false)

                                        if CustomCoins.Prop.modLivery == GetVehicleMod(CustomCoins.Vehicle, 48) then
                                            CustomCoins.PriceStyle = 0
                                        else
                                            CustomCoins.PriceStyle = Tree.Coins_.PriceStyle
                                        end
                                    end
                                })
                        end
                    end
                end)
                Tree.Menu.IsVisible(CustomCoins.subMenuPerf, function()
                    if GetNumVehicleMods(CustomCoins.Vehicle, 15) > 0 then
                        Tree.Menu.List("Suspension", { "Niveau 1", "Niveau 2", "Niveau 3", "Niveau 4" },
                            CustomCoins.DefaultSuspension, nil, {}, true,
                            {
                                onListChange = function(Index)
                                    CustomCoins.DefaultSuspension = Index

                                    SetVehicleMod(CustomCoins.Vehicle, 15, CustomCoins.DefaultSuspension - 2)

                                    if CustomCoins.Prop.modSuspension == GetVehicleMod(CustomCoins.Vehicle, 15) then
                                        CustomCoins.PriceSuspension = 0
                                    else
                                        if Index == 1 then
                                            CustomCoins.PriceSuspension = Tree.Coins_.PriceSuspension
                                        elseif Index == 2 then
                                            CustomCoins.PriceSuspension = Tree.Coins_.PriceSuspension
                                        elseif Index == 3 then
                                            CustomCoins.PriceSuspension = Tree.Coins_.PriceSuspension
                                        elseif Index == 4 then
                                            CustomCoins.PriceSuspension = Tree.Coins_.PriceSuspension
                                        end
                                    end
                                end
                            })
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 13) > 0 then
                        Tree.Menu.List("Transmission", { "Niveau 1", "Niveau 2", "Niveau 3", "Niveau 4" },
                            CustomCoins.DefaultTransmission, nil, {}, true, {
                                onListChange = function(Index)
                                    CustomCoins.DefaultTransmission = Index

                                    SetVehicleMod(CustomCoins.Vehicle, 13, CustomCoins.DefaultTransmission - 2)

                                    if CustomCoins.Prop.modTransmission == GetVehicleMod(CustomCoins.Vehicle, 13) then
                                        CustomCoins.PriceTransmission = 0
                                    else
                                        if Index == 1 then
                                            CustomCoins.PriceTransmission = Tree.Coins_.PriceSuspension
                                        elseif Index == 2 then
                                            CustomCoins.PriceTransmission = Tree.Coins_.PriceSuspension
                                        elseif Index == 3 then
                                            CustomCoins.PriceTransmission = Tree.Coins_.PriceSuspension
                                        elseif Index == 4 then
                                            CustomCoins.PriceTransmission = Tree.Coins_.PriceSuspension
                                        end
                                    end
                                end
                            })
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 11) > 0 then
                        Tree.Menu.List("Moteur", { "Niveau 1", "Niveau 2", "Niveau 3", "Niveau 4" },
                            CustomCoins.DefaultMoteur, nil, {}, true, {
                                onListChange = function(Index)
                                    CustomCoins.DefaultMoteur = Index

                                    SetVehicleMod(CustomCoins.Vehicle, 11, CustomCoins.DefaultMoteur - 2)

                                    if CustomCoins.Prop.modEngine == GetVehicleMod(CustomCoins.Vehicle, 11) then
                                        CustomCoins.PriceMoteur = 0
                                    else
                                        if Index == 1 then
                                            CustomCoins.PriceMoteur = Tree.Coins_.PriceMoteur + 10
                                        elseif Index == 2 then
                                            CustomCoins.PriceMoteur = Tree.Coins_.PriceMoteur + 50
                                        elseif Index == 3 then
                                            CustomCoins.PriceMoteur = Tree.Coins_.PriceMoteur + 200
                                        elseif Index == 4 then
                                            CustomCoins.PriceMoteur = Tree.Coins_.PriceMoteur + 300
                                        end
                                    end
                                end
                            })
                    end
                    if GetNumVehicleMods(CustomCoins.Vehicle, 12) > 0 then
                        Tree.Menu.List("Frein", { "Niveau 1", "Niveau 2", "Niveau 3", "Niveau 4" },
                            CustomCoins.DefaultFrein, nil, {}, true, {
                                onListChange = function(Index)
                                    CustomCoins.DefaultFrein = Index

                                    SetVehicleMod(CustomCoins.Vehicle, 12, CustomCoins.DefaultFrein - 2)

                                    if CustomCoins.Prop.modBrakes == GetVehicleMod(CustomCoins.Vehicle, 12) then
                                        CustomCoins.PriceFrein = 0
                                    else
                                        if Index == 1 then
                                            CustomCoins.PriceFrein = Tree.Coins_.PriceFrein
                                        elseif Index == 2 then
                                            CustomCoins.PriceFrein = Tree.Coins_.PriceFrein
                                        elseif Index == 3 then
                                            CustomCoins.PriceFrein = Tree.Coins_.PriceFrein
                                        elseif Index == 4 then
                                            CustomCoins.PriceFrein = Tree.Coins_.PriceFrein
                                        end
                                    end
                                end
                            })
                    end
                    Tree.Menu.Checkbox("Turbo", false, CustomCoins.DefaultTurbo, {}, {
                        onChecked = function()
                            ToggleVehicleMod(CustomCoins.Vehicle, 18, true)
                            CustomCoins.PriceTurbo = Tree.Coins_.PriceTurbo
                        end,
                        onUnChecked = function()
                            ToggleVehicleMod(CustomCoins.Vehicle, 18, false)
                            CustomCoins.PriceTurbo = 0
                        end,
                        onSelected = function(Index)
                            CustomCoins.DefaultTurbo = Index
                        end
                    })
                end)
                Tree.Menu.IsVisible(CustomCoins.subMenuExtra, function()
                    for i = 1, #CustomCoins.ExtraList, 1 do
                        if DoesExtraExist(CustomCoins.Vehicle, CustomCoins.ExtraList[i].id) then
                            if IsVehicleExtraTurnedOn(CustomCoins.Vehicle, i) then
                                CustomCoins.ExtraList[i].index = 2
                            else
                                CustomCoins.ExtraList[i].index = 1
                            end
                            Tree.Menu.List("Extra #" .. i, { "Inactif", "Actif" }, CustomCoins.ExtraList[i].index, nil,
                                {},
                                true, {
                                    onListChange = function(Index)
                                        CustomCoins.ExtraList[i].index = Index

                                        if IsVehicleExtraTurnedOn(CustomCoins.Vehicle, i) then
                                            SetVehicleExtra(CustomCoins.Vehicle, CustomCoins.ExtraList[i].id, 1)
                                            CustomCoins.PriceExtra = Tree.Coins_.PriceExtra
                                        else
                                            SetVehicleExtra(CustomCoins.Vehicle, CustomCoins.ExtraList[i].id, 0)
                                            CustomCoins.PriceExtra = 0
                                        end
                                    end
                                })
                        end
                    end
                end)
                Wait(1)
            end
        end)
    end
end

RegisterNetEvent('Tree:Get:BuyCustom')
AddEventHandler('Tree:Get:BuyCustom', function(price, bool)
    if bool == true then
        CustomCoins.openedMenu = false;
        local myCar = ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId(), false))
        TriggerServerEvent('Tree:Get:RefreshCustom', myCar);
        ESX.ShowNotification("Félicitations, la personnalisation de votre véhicule est terminée! ~r~-" .. price ..
            " Coins")
    elseif bool == false then
        CustomCoins.openedMenu = false;
        Tree.Func_.SetVehicleProperties(CustomCoins.Vehicle, CustomCoins.Prop)
        ResetAll()
        ESX.ShowNotification("Vous avez " ..
            exports.Tree:serveurConfig().Serveur.color ..
            "annuler~s~ toutes " .. exports.Tree:serveurConfig().Serveur.color .. "les modifications~s~.")
        FactureJob = nil
        banana = nil
        ESX.ShowNotification("Vous n'avez pas assez de coins.")
    end
end)

CreateThread(function()
    for k, v in pairs(SharedCustomCoins.position) do
        Tree.Function.Zone.create("PrivateMecano:" .. k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:' .. k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au Mécano privé")
                    Tree.Function.Visual.drawMarker(v)
                end)
                Tree.Function.Zone.create('PrivateMecano:press:' .. k, v, 2.5, {
                    onPress = function()
                        local playerPed = PlayerPedId()
                        if IsPedInAnyVehicle(playerPed, false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            FreezeEntityPosition(vehicle, true)
                            Tree.Custom.MenuCustomization()
                        else
                            ESX.ShowNotification("Vous devez être dans un véhicule")
                        end
                    end,
                    onExit = function()
                        Tree.Menu.CloseAll()
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        FreezeEntityPosition(vehicle, false)
                    end

                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:' .. k)
                Tree.Function.Zone.delete('PrivateMecano:press:' .. k)
            end
        })
        Tree.Function.Blips.create("Mécano privé", v, 446, 34, "Mécano privé")
    end
end)
