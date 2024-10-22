
local openCustomMenu = false

local BcsoCustom = {
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

    ExtraList = {
        { id = 1, index = 1 },
        { id = 2, index = 1 },
        { id = 3, index = 1 },
        { id = 4, index = 1 },
        { id = 5, index = 1 },
        { id = 6, index = 1 },
        { id = 7, index = 1 },
        { id = 8, index = 1 },
        { id = 9, index = 1 },
        { id = 10, index = 1 },
        { id = 11, index = 1 },
        { id = 12, index = 1 },
        { id = 13, index = 1 },
        { id = 14, index = 1 },
        { id = 15, index = 1 },
        { id = 16, index = 1 },
        { id = 17, index = 1 },
        { id = 18, index = 1 },
        { id = 19, index = 1 },
        { id = 20, index = 1 },
    },
}

function GetModObjects(veh, mod)
	local int = {"Default"}
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

function GetMitrailVeh(TableCustoms)
    local mitraill = false

    for k, v in pairs(TableCustoms) do
        if string.match(v, "Mitraill") or string.match(v, "Gun") then
            mitraill = true
        end
    end
    return mitraill
end


function OpenBcsoCustom()
    local mainMenu = RageUI.CreateMenu('', 'Custom de la voiture')
    mainMenu.Closable = false

    subMenuColour = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuRoues = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuClassiques = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuCustoms = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuExtra = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    BcsoCustom.Vehicle = GetVehiclePedIsIn(PlayerPedId())
    Wait(150)
    BcsoCustom.ColourPrimarySecondaryColourJantes = {}
    BcsoCustom.ColourIntDashNacrage = {}
    BcsoCustom.JantesPrincipales = {}
    BcsoCustom.JantesArrieres = {}
    BcsoCustom.MaxLivery = {}
    BcsoCustom.MaxKlaxon = {}
    BcsoCustom.CoulorPhares = {}
    for i = 1, 160, 1 do 
        table.insert(BcsoCustom.ColourPrimarySecondaryColourJantes, i) 
    end 
    for i = 1, 158, 1 do 
        table.insert(BcsoCustom.ColourIntDashNacrage, i) 
    end
    for i = 1, GetNumVehicleMods(BcsoCustom.Vehicle, 23) + 1, 1 do
        table.insert(BcsoCustom.JantesPrincipales, i) 
    end
    for i = 1, GetNumVehicleMods(BcsoCustom.Vehicle, 24) + 1, 1 do
        table.insert(BcsoCustom.JantesArrieres, i) 
    end
    for i = 1, GetVehicleLiveryCount(BcsoCustom.Vehicle), 1 do
        table.insert(BcsoCustom.MaxLivery, i) 
    end
    for i = 1, 59, 1 do 
        table.insert(BcsoCustom.MaxKlaxon, i) 
    end
    for i = 1, 12, 1 do 
        table.insert(BcsoCustom.CoulorPhares, i)
    end

    SetVehicleModKit(BcsoCustom.Vehicle, 0)

    Wait(150)

    while openCustomMenu do

        RageUI.IsVisible(mainMenu, function()

            RageUI.Button("Peinture", nil, {RightLabel = "→"}, true, {}, subMenuColour)
            RageUI.Button("Roues", nil, {RightLabel = "→"}, true, {}, subMenuRoues)
            RageUI.Button("Classiques", nil, {RightLabel = "→"}, true, {}, subMenuClassiques)
            RageUI.Button("Customs", nil, {RightLabel = "→"}, true, {}, subMenuCustoms)
            RageUI.Button("Extras", nil, {RightLabel = "→"}, true, {}, subMenuExtra)

            RageUI.Button("FERMER", nil, {RightLabel = "→"}, true, {
                
                onSelected = function()
                    openCustomMenu = false
                end
            })
        end)


        RageUI.IsVisible(subMenuColour, function()
            RageUI.List("Primaire", BcsoCustom.ColourPrimarySecondaryColourJantes, BcsoCustom.DefaultPrimaireColour, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultPrimaireColour = Index

                    local primaire, secondaire = GetVehicleColours(BcsoCustom.Vehicle)
                    ClearVehicleCustomPrimaryColour(BcsoCustom.Vehicle)
                    SetVehicleColours(BcsoCustom.Vehicle, BcsoCustom.DefaultPrimaireColour, secondaire)

                    local primaire, secondaire = GetVehicleColours(BcsoCustom.Vehicle)
                end,
            })
            RageUI.List("Secondaire", BcsoCustom.ColourPrimarySecondaryColourJantes, BcsoCustom.DefaultSecondaireColour, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultSecondaireColour = Index

                local primaire, secondaire = GetVehicleColours(BcsoCustom.Vehicle)
                    ClearVehicleCustomSecondaryColour(BcsoCustom.Vehicle)
                    SetVehicleColours(BcsoCustom.Vehicle, primaire, BcsoCustom.DefaultSecondaireColour)

                    local primaire, secondaire = GetVehicleColours(BcsoCustom.Vehicle)
                end,
            })
            RageUI.List("Intérieurs", BcsoCustom.ColourIntDashNacrage, BcsoCustom.DefaultInteriorColour, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultInteriorColour = Index

                    SetVehicleInteriorColour(BcsoCustom.Vehicle, BcsoCustom.DefaultInteriorColour)
                end,
            })
            RageUI.List("Tableau de bord", BcsoCustom.ColourIntDashNacrage, BcsoCustom.DefaultDashboardColour, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultDashboardColour = Index

                    if GetFollowVehicleCamViewMode() ~= 4 then
                        SetFollowVehicleCamViewMode(4)
                    end
                    SetVehicleDashboardColour(BcsoCustom.Vehicle, BcsoCustom.DefaultDashboardColour)
                end,
            })
            RageUI.List("Nacrage", BcsoCustom.ColourIntDashNacrage, BcsoCustom.DefaultNacrageColour, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultNacrageColour = Index

                    local _, nacrage = GetVehicleExtraColours(BcsoCustom.Vehicle)
                    SetVehicleExtraColours(BcsoCustom.Vehicle, BcsoCustom.DefaultNacrageColour, nacrage)
                end,
            })
        end)

        RageUI.IsVisible(subMenuRoues, function()
            RageUI.List("Type de roues", {"Sport", "Muscle", "Lowrider", "SUV", "Offroad", "Tuner", "Moto", "High end", "Bespokes Originals", "Bespokes Smokes"}, BcsoCustom.DefaultTypeRouesColour, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultTypeRouesColour = Index
                    BcsoCustom.DefaultJantesPrincipales = 1

                    SetVehicleWheelType(BcsoCustom.Vehicle, BcsoCustom.DefaultTypeRouesColour - 1)

                    BcsoCustom.JantesLoadPrincipales = {}
                    BcsoCustom.JantesLoadArrieres = {}
                    for i = 1, GetNumVehicleMods(BcsoCustom.Vehicle, 23) + 1, 1 do
                        table.insert(BcsoCustom.JantesLoadPrincipales, i) 
                    end
                    BcsoCustom.JantesPrincipales = BcsoCustom.JantesLoadPrincipales
                end,
            })
            RageUI.List("Jantes principales", BcsoCustom.JantesPrincipales, BcsoCustom.DefaultJantesPrincipales, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultJantesPrincipales = Index

                    SetVehicleMod(BcsoCustom.Vehicle, 23, BcsoCustom.DefaultJantesPrincipales - 2, GetVehicleModVariation(BcsoCustom.Vehicle, 23))
                end,
            })
            RageUI.List("Couleurs des jantes", BcsoCustom.ColourPrimarySecondaryColourJantes, BcsoCustom.DefaultColourJantes, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultColourJantes = Index

                    local extraJantes = GetVehicleExtraColours(BcsoCustom.Vehicle)
                    SetVehicleExtraColours(BcsoCustom.Vehicle, extraJantes, BcsoCustom.DefaultColourJantes - 1)
                end,
            })
        end)

        RageUI.IsVisible(subMenuClassiques, function()
            RageUI.List("Klaxon", BcsoCustom.MaxKlaxon, BcsoCustom.DefaultKlaxon, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultKlaxon = Index

                    SetVehicleMod(BcsoCustom.Vehicle, 14, BcsoCustom.DefaultKlaxon - 2, false)
                end,
            })
            RageUI.List("Teinte des vitres", {"Normal", "Black", "Smoke Black", "Simple Smoke", "Stock", "Limo"}, BcsoCustom.DefaultTeinteVitres, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultTeinteVitres = Index

                    SetVehicleWindowTint(BcsoCustom.Vehicle, BcsoCustom.DefaultTeinteVitres - 1)
                end,
            })
            RageUI.Checkbox("Phares xenons", false, BcsoCustom.DefaultPharesXenons, {}, {
                onChecked = function()
                    ToggleVehicleMod(BcsoCustom.Vehicle, 22, true)
                    BcsoCustom.PricePharesXenons = 350
                end,
                onUnChecked = function()
                    ToggleVehicleMod(BcsoCustom.Vehicle, 22, false)
                    BcsoCustom.PricePharesXenons = 0
                end,

                onSelected = function(Index)
                    BcsoCustom.DefaultPharesXenons = Index
                end
            })
            RageUI.List("Types de plaques", {"Default", "Sa Black", "Sa Blue", "Sa White", "Simple White", "NY White"}, BcsoCustom.DefaultTypesPlaques, nil, {}, true, {
                onListChange = function(Index)
                    BcsoCustom.DefaultTypesPlaques = Index

                    SetVehicleNumberPlateTextIndex(BcsoCustom.Vehicle, BcsoCustom.DefaultTypesPlaques - 1)
                end,
            })
            if json.encode(BcsoCustom.MaxLivery) ~= "[]" then
                RageUI.List("Livery", BcsoCustom.MaxLivery, BcsoCustom.DefaultLivery, nil, {}, true, {
                    onListChange = function(Index)
                        BcsoCustom.DefaultLivery = Index

                        SetVehicleLivery(BcsoCustom.Vehicle, BcsoCustom.DefaultLivery - 2)
                    end,
                })
            else
                RageUI.Button("Livery", nil, {}, false, {})
            end
            if IsToggleModOn(BcsoCustom.Vehicle, 22) then
                RageUI.List("Couleur des phares", BcsoCustom.CoulorPhares, BcsoCustom.DefaultColourPhares, nil, {}, true, {
                    onListChange = function(Index)
                        BcsoCustom.DefaultColourPhares = Index

                        SetVehicleXenonLightsColour(BcsoCustom.Vehicle, BcsoCustom.DefaultColourPhares - 1)
                    end,
                })
            else
                RageUI.Button("Couleur des phares", nil, {}, false, {})
            end
        end)

        RageUI.IsVisible(subMenuCustoms, function()
            if GetNumVehicleMods(BcsoCustom.Vehicle, 0) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 0)) then
                    RageUI.List("Aileron", GetModObjects(BcsoCustom.Vehicle, 0), BcsoCustom.DefaultAileron, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultAileron = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 0, BcsoCustom.DefaultAileron - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 1) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 1)) then
                    RageUI.List("Pare-choc avant", GetModObjects(BcsoCustom.Vehicle, 1), BcsoCustom.DefaultParechocAvant, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultParechocAvant = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 1, BcsoCustom.DefaultParechocAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 2) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 2)) then
                    RageUI.List("Pare-choc arriére", GetModObjects(BcsoCustom.Vehicle, 2), BcsoCustom.DefaultParechocArriere, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultParechocArriere = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 2, BcsoCustom.DefaultParechocArriere - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 3) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 3)) then
                    RageUI.List("Carrosserie", GetModObjects(BcsoCustom.Vehicle, 3), BcsoCustom.DefaultCarrosserie, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultCarrosserie = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 3, BcsoCustom.DefaultCarrosserie - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 4) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 4)) then
                    RageUI.List("Echappement", GetModObjects(BcsoCustom.Vehicle, 4), BcsoCustom.DefaultEchappement, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultEchappement = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 4, BcsoCustom.DefaultEchappement - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 5) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 5)) then
                    RageUI.List("Cadre", GetModObjects(BcsoCustom.Vehicle, 5), BcsoCustom.DefaultCadre, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultCadre = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 5, BcsoCustom.DefaultCadre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 6) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 6)) then
                    RageUI.List("Calandre", GetModObjects(BcsoCustom.Vehicle, 6), BcsoCustom.DefaultCalandre, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultCalandre = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 6, BcsoCustom.DefaultCalandre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 7) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 7)) then
                    RageUI.List("Capot", GetModObjects(BcsoCustom.Vehicle, 7), BcsoCustom.DefaultCapot, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultCapot = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 7, BcsoCustom.DefaultCapot - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 8) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 8)) then
                    RageUI.List("Autocollant gauche", GetModObjects(BcsoCustom.Vehicle, 8), BcsoCustom.DefaultAutocollantGauche, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultAutocollantGauche = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 8, BcsoCustom.DefaultAutocollantGauche - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 9) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 9)) then
                    RageUI.List("Autocollant droit", GetModObjects(BcsoCustom.Vehicle, 9), BcsoCustom.DefaultAutocollantDroit, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultAutocollantDroit = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 9, BcsoCustom.DefaultAutocollantDroit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 10) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 10)) then
                    RageUI.List("Toit", GetModObjects(BcsoCustom.Vehicle, 10), BcsoCustom.DefaultToit, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultToit = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 10, BcsoCustom.DefaultToit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 25) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 25)) then
                    RageUI.List("Support de plaque", GetModObjects(BcsoCustom.Vehicle, 25), BcsoCustom.DefaultSupportPlaque, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultSupportPlaque = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 25, BcsoCustom.DefaultSupportPlaque - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 26) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 26)) then
                    RageUI.List("Plaque avant", GetModObjects(BcsoCustom.Vehicle, 26), BcsoCustom.DefaultPlaqueAvant, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultPlaqueAvant = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 26, BcsoCustom.DefaultPlaqueAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 28) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 28)) then
                    RageUI.List("Figurine", GetModObjects(BcsoCustom.Vehicle, 28), BcsoCustom.DefaultFigurine, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultFigurine = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 28, BcsoCustom.DefaultFigurine - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 29) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 29)) then
                    RageUI.List("Tableau de bord motif", GetModObjects(BcsoCustom.Vehicle, 29), BcsoCustom.DefaultDashboardMotif, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultDashboardMotif = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 29, BcsoCustom.DefaultDashboardMotif - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 30) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 30)) then
                    RageUI.List("Cadran", GetModObjects(BcsoCustom.Vehicle, 30), BcsoCustom.DefaultCadran, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultCadran = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 30, BcsoCustom.DefaultCadran - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 31) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 31)) then
                    RageUI.List("Haut parleur portes", GetModObjects(BcsoCustom.Vehicle, 31), BcsoCustom.DefaultHautParleurPortes, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultHautParleurPortes = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 31, BcsoCustom.DefaultHautParleurPortes - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 32) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 32)) then
                    RageUI.List("Motif sieges", GetModObjects(BcsoCustom.Vehicle, 32), BcsoCustom.DefaultMotifSieges, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultMotifSieges = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 32, BcsoCustom.DefaultMotifSieges - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 33) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 33)) then
                    RageUI.List("Volant", GetModObjects(BcsoCustom.Vehicle, 33), BcsoCustom.DefaultVolant, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultVolant = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 33, BcsoCustom.DefaultVolant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 34) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 34)) then
                    RageUI.List("Levier", GetModObjects(BcsoCustom.Vehicle, 34), BcsoCustom.DefaultLevier, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultLevier = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 34, BcsoCustom.DefaultLevier - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 35) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 35)) then
                    RageUI.List("Logo custom", GetModObjects(BcsoCustom.Vehicle, 35), BcsoCustom.DefaultLogoCustom, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultLogoCustom = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 35, BcsoCustom.DefaultLogoCustom - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 36) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 36)) then
                    RageUI.List("Haut parleur vitre", GetModObjects(BcsoCustom.Vehicle, 36), BcsoCustom.DefaultHautParleurVitre, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultHautParleurVitre = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 36, BcsoCustom.DefaultHautParleurVitre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 37) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 37)) then
                    RageUI.List("Haut parleur coffre", GetModObjects(BcsoCustom.Vehicle, 37), BcsoCustom.DefaultHautParleurCoffre, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultHautParleurCoffre = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 37, BcsoCustom.DefaultHautParleurCoffre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 38) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 38)) then
                    RageUI.List("Hydrolique", GetModObjects(BcsoCustom.Vehicle, 38), BcsoCustom.DefaultHydrolique, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultHydrolique = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 38, BcsoCustom.DefaultHydrolique - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 39) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 39)) then
                    RageUI.List("Moteur", GetModObjects(BcsoCustom.Vehicle, 39), BcsoCustom.DefaultVisualMoteur, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultVisualMoteur = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 39, BcsoCustom.DefaultVisualMoteur - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 40) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 40)) then
                    RageUI.List("Filtres é air", GetModObjects(BcsoCustom.Vehicle, 40), BcsoCustom.DefaultFiltresAir, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultFiltresAir = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 40, BcsoCustom.DefaultFiltresAir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 41) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 41)) then
                    RageUI.List("Entretoises", GetModObjects(BcsoCustom.Vehicle, 41), BcsoCustom.DefaultEntretoises, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultEntretoises = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 41, BcsoCustom.DefaultEntretoises - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 42) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 42)) then
                    RageUI.List("Couverture", GetModObjects(BcsoCustom.Vehicle, 42), BcsoCustom.DefaultCouverture, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultCouverture = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 42, BcsoCustom.DefaultCouverture - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 43) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 43)) then
                    RageUI.List("Antenne", GetModObjects(BcsoCustom.Vehicle, 43), BcsoCustom.DefaultAntenne, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultAntenne = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 43, BcsoCustom.DefaultAntenne - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 45) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 45)) then
                    RageUI.List("Reservoir", GetModObjects(BcsoCustom.Vehicle, 45), BcsoCustom.DefaultReservoir, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultReservoir = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 45, BcsoCustom.DefaultReservoir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 46) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 46)) then
                    RageUI.List("Fenétre", GetModObjects(BcsoCustom.Vehicle, 46), BcsoCustom.DefaultFenetre, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultFenetre = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 46, BcsoCustom.DefaultFenetre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(BcsoCustom.Vehicle, 48) > 0 then
                if not GetMitrailVeh(GetModObjects(BcsoCustom.Vehicle, 48)) then
                    RageUI.List("Stickers", GetModObjects(BcsoCustom.Vehicle, 48), BcsoCustom.DefaultStyle, nil, {}, true, {
                        onListChange = function(Index)
                            BcsoCustom.DefaultStyle = Index

                            SetVehicleMod(BcsoCustom.Vehicle, 48, BcsoCustom.DefaultStyle - 2, false)
                        end,
                    })
                end
            end
        end)

        RageUI.IsVisible(subMenuExtra, function()
            if extraTable == nil then extraTable = {} end
            for i= 1, 20 do
                if DoesExtraExist(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                    if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                        RageUI.Button("Extra #"..i, nil, {RightLabel = "❌"}, true, {
                            onSelected = function()
                                if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                    extraTable[i] = true
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                else
                                    extraTable[i] = false
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                end
                            end
                        })
                    else
                        RageUI.Button("Extra #"..i, nil, {RightLabel = "✅"}, true, {
                            onSelected = function()
                                if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                    extraTable[i] = true
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                else
                                    extraTable[i] = false
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                end
                            end
                        })
                    end
                end
            end
        end)


        Wait(0)
    end
end


local ListVeh = {

    'SHERIFF2',

    'scorcher',
    'polstanierr',
    'poltorencer',
    'polstalkerr',
    'verus',
    'polfugitiver',
    'polalamor2',
    'polgresleyr',
    'polbuffalor',
    'polscoutr',
    'polbisonr',
    'polcarar',
    'lspdbuffsumk',
    'lspdbuffalostxum',
    'apoliceu14',
    'polspeedor',
    'polbuffalor2',
    'poldmntr',
    'polcoquetter',
}

CreateThread(function()
	while true do
		local Timer = 800

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bcso' and ESX.PlayerData.job.grade >= 0 then
            local plycrdjob = GetEntityCoords(PlayerPedId())
            local CustomBcsoCoords = vector3(1850.35, 3688.23, 34.00)
            local dist = #(CustomBcsoCoords - plycrdjob)
            
            if (dist < 10) then
                Timer = 0
                DrawMarker(20, 1850.35, 3688.23, 34.00, 0, 0, 0, 0, nil, nil, 1.0, 1.0, 1.0, 255, 0, 0, 170, 0, 1, 0, 0, nil, nil, 0)
                
                if (dist < 2 and not openCustomMenu) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acceder au custom")
                    if IsControlJustPressed(1,51) then
                        CreateThread(function()
                            local IsVeh = false
                            for i=1, #ListVeh do
                                local vehicleModel = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
                                local Name = GetDisplayNameFromVehicleModel(vehicleModel)

                                if (string.lower(ListVeh[i]) == string.lower(Name)) then
                                    IsVeh = true
                                end
                            end

                            if (IsVeh) then
                                openCustomMenu = true
                                OpenBcsoCustom()
                            end
                        end)
                    end
                end
            else
                if openCustomMenu then 
                    openCustomMenu = false
                    RageUI.CloseAll()
                end
            end
        end

        Wait(Timer)
    end
end)
