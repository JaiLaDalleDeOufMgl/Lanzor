
local openCustomMenu = false

local FbiCustom = {
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


function OpenFIBCustom()
    local mainMenu = RageUI.CreateMenu('', 'Custom de la voiture')
    mainMenu.Closable = false

    subMenuColour = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuRoues = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuClassiques = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuCustoms = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuExtra = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    FbiCustom.Vehicle = GetVehiclePedIsIn(PlayerPedId())
    Wait(150)
    FbiCustom.ColourPrimarySecondaryColourJantes = {}
    FbiCustom.ColourIntDashNacrage = {}
    FbiCustom.JantesPrincipales = {}
    FbiCustom.JantesArrieres = {}
    FbiCustom.MaxLivery = {}
    FbiCustom.MaxKlaxon = {}
    FbiCustom.CoulorPhares = {}
    for i = 1, 160, 1 do 
        table.insert(FbiCustom.ColourPrimarySecondaryColourJantes, i) 
    end 
    for i = 1, 158, 1 do 
        table.insert(FbiCustom.ColourIntDashNacrage, i) 
    end
    for i = 1, GetNumVehicleMods(FbiCustom.Vehicle, 23) + 1, 1 do
        table.insert(FbiCustom.JantesPrincipales, i) 
    end
    for i = 1, GetNumVehicleMods(FbiCustom.Vehicle, 24) + 1, 1 do
        table.insert(FbiCustom.JantesArrieres, i) 
    end
    for i = 1, GetVehicleLiveryCount(FbiCustom.Vehicle), 1 do
        table.insert(FbiCustom.MaxLivery, i) 
    end
    for i = 1, 59, 1 do 
        table.insert(FbiCustom.MaxKlaxon, i) 
    end
    for i = 1, 12, 1 do 
        table.insert(FbiCustom.CoulorPhares, i)
    end

    SetVehicleModKit(FbiCustom.Vehicle, 0)

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
            RageUI.List("Primaire", FbiCustom.ColourPrimarySecondaryColourJantes, FbiCustom.DefaultPrimaireColour, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultPrimaireColour = Index

                    local primaire, secondaire = GetVehicleColours(FbiCustom.Vehicle)
                    ClearVehicleCustomPrimaryColour(FbiCustom.Vehicle)
                    SetVehicleColours(FbiCustom.Vehicle, FbiCustom.DefaultPrimaireColour, secondaire)

                    local primaire, secondaire = GetVehicleColours(FbiCustom.Vehicle)
                end,
            })
            RageUI.List("Secondaire", FbiCustom.ColourPrimarySecondaryColourJantes, FbiCustom.DefaultSecondaireColour, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultSecondaireColour = Index

                local primaire, secondaire = GetVehicleColours(FbiCustom.Vehicle)
                    ClearVehicleCustomSecondaryColour(FbiCustom.Vehicle)
                    SetVehicleColours(FbiCustom.Vehicle, primaire, FbiCustom.DefaultSecondaireColour)

                    local primaire, secondaire = GetVehicleColours(FbiCustom.Vehicle)
                end,
            })
            RageUI.List("Intérieurs", FbiCustom.ColourIntDashNacrage, FbiCustom.DefaultInteriorColour, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultInteriorColour = Index

                    SetVehicleInteriorColour(FbiCustom.Vehicle, FbiCustom.DefaultInteriorColour)
                end,
            })
            RageUI.List("Tableau de bord", FbiCustom.ColourIntDashNacrage, FbiCustom.DefaultDashboardColour, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultDashboardColour = Index

                    if GetFollowVehicleCamViewMode() ~= 4 then
                        SetFollowVehicleCamViewMode(4)
                    end
                    SetVehicleDashboardColour(FbiCustom.Vehicle, FbiCustom.DefaultDashboardColour)
                end,
            })
            RageUI.List("Nacrage", FbiCustom.ColourIntDashNacrage, FbiCustom.DefaultNacrageColour, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultNacrageColour = Index

                    local _, nacrage = GetVehicleExtraColours(FbiCustom.Vehicle)
                    SetVehicleExtraColours(FbiCustom.Vehicle, FbiCustom.DefaultNacrageColour, nacrage)
                end,
            })
        end)

        RageUI.IsVisible(subMenuRoues, function()
            RageUI.List("Type de roues", {"Sport", "Muscle", "Lowrider", "SUV", "Offroad", "Tuner", "Moto", "High end", "Bespokes Originals", "Bespokes Smokes"}, FbiCustom.DefaultTypeRouesColour, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultTypeRouesColour = Index
                    FbiCustom.DefaultJantesPrincipales = 1

                    SetVehicleWheelType(FbiCustom.Vehicle, FbiCustom.DefaultTypeRouesColour - 1)

                    FbiCustom.JantesLoadPrincipales = {}
                    FbiCustom.JantesLoadArrieres = {}
                    for i = 1, GetNumVehicleMods(FbiCustom.Vehicle, 23) + 1, 1 do
                        table.insert(FbiCustom.JantesLoadPrincipales, i) 
                    end
                    FbiCustom.JantesPrincipales = FbiCustom.JantesLoadPrincipales
                end,
            })
            RageUI.List("Jantes principales", FbiCustom.JantesPrincipales, FbiCustom.DefaultJantesPrincipales, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultJantesPrincipales = Index

                    SetVehicleMod(FbiCustom.Vehicle, 23, FbiCustom.DefaultJantesPrincipales - 2, GetVehicleModVariation(FbiCustom.Vehicle, 23))
                end,
            })
            RageUI.List("Couleurs des jantes", FbiCustom.ColourPrimarySecondaryColourJantes, FbiCustom.DefaultColourJantes, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultColourJantes = Index

                    local extraJantes = GetVehicleExtraColours(FbiCustom.Vehicle)
                    SetVehicleExtraColours(FbiCustom.Vehicle, extraJantes, FbiCustom.DefaultColourJantes - 1)
                end,
            })
        end)

        RageUI.IsVisible(subMenuClassiques, function()
            RageUI.List("Klaxon", FbiCustom.MaxKlaxon, FbiCustom.DefaultKlaxon, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultKlaxon = Index

                    SetVehicleMod(FbiCustom.Vehicle, 14, FbiCustom.DefaultKlaxon - 2, false)
                end,
            })
            RageUI.List("Teinte des vitres", {"Normal", "Black", "Smoke Black", "Simple Smoke", "Stock", "Limo"}, FbiCustom.DefaultTeinteVitres, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultTeinteVitres = Index

                    SetVehicleWindowTint(FbiCustom.Vehicle, FbiCustom.DefaultTeinteVitres - 1)
                end,
            })
            RageUI.Checkbox("Phares xenons", false, FbiCustom.DefaultPharesXenons, {}, {
                onChecked = function()
                    ToggleVehicleMod(FbiCustom.Vehicle, 22, true)
                    FbiCustom.PricePharesXenons = 350
                end,
                onUnChecked = function()
                    ToggleVehicleMod(FbiCustom.Vehicle, 22, false)
                    FbiCustom.PricePharesXenons = 0
                end,

                onSelected = function(Index)
                    FbiCustom.DefaultPharesXenons = Index
                end
            })
            RageUI.List("Types de plaques", {"Default", "Sa Black", "Sa Blue", "Sa White", "Simple White", "NY White"}, FbiCustom.DefaultTypesPlaques, nil, {}, true, {
                onListChange = function(Index)
                    FbiCustom.DefaultTypesPlaques = Index

                    SetVehicleNumberPlateTextIndex(FbiCustom.Vehicle, FbiCustom.DefaultTypesPlaques - 1)
                end,
            })
            if json.encode(FbiCustom.MaxLivery) ~= "[]" then
                RageUI.List("Livery", FbiCustom.MaxLivery, FbiCustom.DefaultLivery, nil, {}, true, {
                    onListChange = function(Index)
                        FbiCustom.DefaultLivery = Index

                        SetVehicleLivery(FbiCustom.Vehicle, FbiCustom.DefaultLivery - 2)
                    end,
                })
            else
                RageUI.Button("Livery", nil, {}, false, {})
            end
            if IsToggleModOn(FbiCustom.Vehicle, 22) then
                RageUI.List("Couleur des phares", FbiCustom.CoulorPhares, FbiCustom.DefaultColourPhares, nil, {}, true, {
                    onListChange = function(Index)
                        FbiCustom.DefaultColourPhares = Index

                        SetVehicleXenonLightsColour(FbiCustom.Vehicle, FbiCustom.DefaultColourPhares - 1)
                    end,
                })
            else
                RageUI.Button("Couleur des phares", nil, {}, false, {})
            end
        end)

        RageUI.IsVisible(subMenuCustoms, function()
            if GetNumVehicleMods(FbiCustom.Vehicle, 0) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 0)) then
                    RageUI.List("Aileron", GetModObjects(FbiCustom.Vehicle, 0), FbiCustom.DefaultAileron, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultAileron = Index

                            SetVehicleMod(FbiCustom.Vehicle, 0, FbiCustom.DefaultAileron - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 1) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 1)) then
                    RageUI.List("Pare-choc avant", GetModObjects(FbiCustom.Vehicle, 1), FbiCustom.DefaultParechocAvant, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultParechocAvant = Index

                            SetVehicleMod(FbiCustom.Vehicle, 1, FbiCustom.DefaultParechocAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 2) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 2)) then
                    RageUI.List("Pare-choc arriére", GetModObjects(FbiCustom.Vehicle, 2), FbiCustom.DefaultParechocArriere, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultParechocArriere = Index

                            SetVehicleMod(FbiCustom.Vehicle, 2, FbiCustom.DefaultParechocArriere - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 3) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 3)) then
                    RageUI.List("Carrosserie", GetModObjects(FbiCustom.Vehicle, 3), FbiCustom.DefaultCarrosserie, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultCarrosserie = Index

                            SetVehicleMod(FbiCustom.Vehicle, 3, FbiCustom.DefaultCarrosserie - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 4) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 4)) then
                    RageUI.List("Echappement", GetModObjects(FbiCustom.Vehicle, 4), FbiCustom.DefaultEchappement, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultEchappement = Index

                            SetVehicleMod(FbiCustom.Vehicle, 4, FbiCustom.DefaultEchappement - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 5) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 5)) then
                    RageUI.List("Cadre", GetModObjects(FbiCustom.Vehicle, 5), FbiCustom.DefaultCadre, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultCadre = Index

                            SetVehicleMod(FbiCustom.Vehicle, 5, FbiCustom.DefaultCadre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 6) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 6)) then
                    RageUI.List("Calandre", GetModObjects(FbiCustom.Vehicle, 6), FbiCustom.DefaultCalandre, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultCalandre = Index

                            SetVehicleMod(FbiCustom.Vehicle, 6, FbiCustom.DefaultCalandre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 7) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 7)) then
                    RageUI.List("Capot", GetModObjects(FbiCustom.Vehicle, 7), FbiCustom.DefaultCapot, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultCapot = Index

                            SetVehicleMod(FbiCustom.Vehicle, 7, FbiCustom.DefaultCapot - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 8) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 8)) then
                    RageUI.List("Autocollant gauche", GetModObjects(FbiCustom.Vehicle, 8), FbiCustom.DefaultAutocollantGauche, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultAutocollantGauche = Index

                            SetVehicleMod(FbiCustom.Vehicle, 8, FbiCustom.DefaultAutocollantGauche - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 9) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 9)) then
                    RageUI.List("Autocollant droit", GetModObjects(FbiCustom.Vehicle, 9), FbiCustom.DefaultAutocollantDroit, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultAutocollantDroit = Index

                            SetVehicleMod(FbiCustom.Vehicle, 9, FbiCustom.DefaultAutocollantDroit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 10) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 10)) then
                    RageUI.List("Toit", GetModObjects(FbiCustom.Vehicle, 10), FbiCustom.DefaultToit, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultToit = Index

                            SetVehicleMod(FbiCustom.Vehicle, 10, FbiCustom.DefaultToit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 25) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 25)) then
                    RageUI.List("Support de plaque", GetModObjects(FbiCustom.Vehicle, 25), FbiCustom.DefaultSupportPlaque, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultSupportPlaque = Index

                            SetVehicleMod(FbiCustom.Vehicle, 25, FbiCustom.DefaultSupportPlaque - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 26) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 26)) then
                    RageUI.List("Plaque avant", GetModObjects(FbiCustom.Vehicle, 26), FbiCustom.DefaultPlaqueAvant, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultPlaqueAvant = Index

                            SetVehicleMod(FbiCustom.Vehicle, 26, FbiCustom.DefaultPlaqueAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 28) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 28)) then
                    RageUI.List("Figurine", GetModObjects(FbiCustom.Vehicle, 28), FbiCustom.DefaultFigurine, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultFigurine = Index

                            SetVehicleMod(FbiCustom.Vehicle, 28, FbiCustom.DefaultFigurine - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 29) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 29)) then
                    RageUI.List("Tableau de bord motif", GetModObjects(FbiCustom.Vehicle, 29), FbiCustom.DefaultDashboardMotif, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultDashboardMotif = Index

                            SetVehicleMod(FbiCustom.Vehicle, 29, FbiCustom.DefaultDashboardMotif - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 30) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 30)) then
                    RageUI.List("Cadran", GetModObjects(FbiCustom.Vehicle, 30), FbiCustom.DefaultCadran, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultCadran = Index

                            SetVehicleMod(FbiCustom.Vehicle, 30, FbiCustom.DefaultCadran - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 31) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 31)) then
                    RageUI.List("Haut parleur portes", GetModObjects(FbiCustom.Vehicle, 31), FbiCustom.DefaultHautParleurPortes, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultHautParleurPortes = Index

                            SetVehicleMod(FbiCustom.Vehicle, 31, FbiCustom.DefaultHautParleurPortes - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 32) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 32)) then
                    RageUI.List("Motif sieges", GetModObjects(FbiCustom.Vehicle, 32), FbiCustom.DefaultMotifSieges, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultMotifSieges = Index

                            SetVehicleMod(FbiCustom.Vehicle, 32, FbiCustom.DefaultMotifSieges - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 33) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 33)) then
                    RageUI.List("Volant", GetModObjects(FbiCustom.Vehicle, 33), FbiCustom.DefaultVolant, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultVolant = Index

                            SetVehicleMod(FbiCustom.Vehicle, 33, FbiCustom.DefaultVolant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 34) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 34)) then
                    RageUI.List("Levier", GetModObjects(FbiCustom.Vehicle, 34), FbiCustom.DefaultLevier, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultLevier = Index

                            SetVehicleMod(FbiCustom.Vehicle, 34, FbiCustom.DefaultLevier - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 35) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 35)) then
                    RageUI.List("Logo custom", GetModObjects(FbiCustom.Vehicle, 35), FbiCustom.DefaultLogoCustom, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultLogoCustom = Index

                            SetVehicleMod(FbiCustom.Vehicle, 35, FbiCustom.DefaultLogoCustom - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 36) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 36)) then
                    RageUI.List("Haut parleur vitre", GetModObjects(FbiCustom.Vehicle, 36), FbiCustom.DefaultHautParleurVitre, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultHautParleurVitre = Index

                            SetVehicleMod(FbiCustom.Vehicle, 36, FbiCustom.DefaultHautParleurVitre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 37) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 37)) then
                    RageUI.List("Haut parleur coffre", GetModObjects(FbiCustom.Vehicle, 37), FbiCustom.DefaultHautParleurCoffre, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultHautParleurCoffre = Index

                            SetVehicleMod(FbiCustom.Vehicle, 37, FbiCustom.DefaultHautParleurCoffre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 38) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 38)) then
                    RageUI.List("Hydrolique", GetModObjects(FbiCustom.Vehicle, 38), FbiCustom.DefaultHydrolique, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultHydrolique = Index

                            SetVehicleMod(FbiCustom.Vehicle, 38, FbiCustom.DefaultHydrolique - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 39) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 39)) then
                    RageUI.List("Moteur", GetModObjects(FbiCustom.Vehicle, 39), FbiCustom.DefaultVisualMoteur, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultVisualMoteur = Index

                            SetVehicleMod(FbiCustom.Vehicle, 39, FbiCustom.DefaultVisualMoteur - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 40) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 40)) then
                    RageUI.List("Filtres é air", GetModObjects(FbiCustom.Vehicle, 40), FbiCustom.DefaultFiltresAir, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultFiltresAir = Index

                            SetVehicleMod(FbiCustom.Vehicle, 40, FbiCustom.DefaultFiltresAir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 41) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 41)) then
                    RageUI.List("Entretoises", GetModObjects(FbiCustom.Vehicle, 41), FbiCustom.DefaultEntretoises, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultEntretoises = Index

                            SetVehicleMod(FbiCustom.Vehicle, 41, FbiCustom.DefaultEntretoises - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 42) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 42)) then
                    RageUI.List("Couverture", GetModObjects(FbiCustom.Vehicle, 42), FbiCustom.DefaultCouverture, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultCouverture = Index

                            SetVehicleMod(FbiCustom.Vehicle, 42, FbiCustom.DefaultCouverture - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 43) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 43)) then
                    RageUI.List("Antenne", GetModObjects(FbiCustom.Vehicle, 43), FbiCustom.DefaultAntenne, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultAntenne = Index

                            SetVehicleMod(FbiCustom.Vehicle, 43, FbiCustom.DefaultAntenne - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 45) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 45)) then
                    RageUI.List("Reservoir", GetModObjects(FbiCustom.Vehicle, 45), FbiCustom.DefaultReservoir, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultReservoir = Index

                            SetVehicleMod(FbiCustom.Vehicle, 45, FbiCustom.DefaultReservoir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 46) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 46)) then
                    RageUI.List("Fenétre", GetModObjects(FbiCustom.Vehicle, 46), FbiCustom.DefaultFenetre, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultFenetre = Index

                            SetVehicleMod(FbiCustom.Vehicle, 46, FbiCustom.DefaultFenetre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(FbiCustom.Vehicle, 48) > 0 then
                if not GetMitrailVeh(GetModObjects(FbiCustom.Vehicle, 48)) then
                    RageUI.List("Stickers", GetModObjects(FbiCustom.Vehicle, 48), FbiCustom.DefaultStyle, nil, {}, true, {
                        onListChange = function(Index)
                            FbiCustom.DefaultStyle = Index

                            SetVehicleMod(FbiCustom.Vehicle, 48, FbiCustom.DefaultStyle - 2, false)
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
    'cat',
    'lspdbuffsumk',
    'roadrunner2',
    'lspdbuffalostxum',
    'apoliceu9',
    'usssvan2',
    'apoliceu14',
    'poltaxi',
    'mule4',
    'LSPDumkscoutgnd',
    'apoliceu15',
    'police4'
}

CreateThread(function()
	while true do
		local Timer = 800

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fib' and ESX.PlayerData.job.grade >= 0 then
            local plycrdjob = GetEntityCoords(PlayerPedId())
            local CustomFbiCoords = vector3(2521.01, -456.44, 92.99)
            local dist = #(CustomFbiCoords - plycrdjob)
            

            if (dist < 10) then
                Timer = 0
                DrawMarker(20, 2521.01, -456.44, 92.99, 0, 0, 0, 0, nil, nil, 1.0, 1.0, 1.0, 255, 0, 0, 170, 0, 1, 0, 0, nil, nil, 0)
                
                if (dist < 2 and not openCustomMenu) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le custom")
                    if IsControlJustPressed(1,51) then
                        CreateThread(function()
                            local IsVeh = false
                            for i=1, #ListVeh do
                                local vehicleModel = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
                                local Name = GetDisplayNameFromVehicleModel(vehicleModel)

                                print(string.lower(ListVeh[i]), string.lower(Name))
                                if (string.lower(ListVeh[i]) == string.lower(Name)) then
                                    IsVeh = true
                                end
                            end

                            if (IsVeh) then
                                openCustomMenu = true
                                OpenFIBCustom()
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
