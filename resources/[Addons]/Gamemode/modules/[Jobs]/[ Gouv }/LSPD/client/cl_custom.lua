
local openCustomMenu = false

local PoliceCustom = {
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


function OpenLSPDCustom()
    local mainMenu = RageUI.CreateMenu('', 'Custom de la voiture')
    mainMenu.Closable = false

    subMenuColour = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuRoues = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuClassiques = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuCustoms = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuExtra = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    PoliceCustom.Vehicle = GetVehiclePedIsIn(PlayerPedId())
    Wait(150)
    PoliceCustom.ColourPrimarySecondaryColourJantes = {}
    PoliceCustom.ColourIntDashNacrage = {}
    PoliceCustom.JantesPrincipales = {}
    PoliceCustom.JantesArrieres = {}
    PoliceCustom.MaxLivery = {}
    PoliceCustom.MaxKlaxon = {}
    PoliceCustom.CoulorPhares = {}
    for i = 1, 160, 1 do 
        table.insert(PoliceCustom.ColourPrimarySecondaryColourJantes, i) 
    end 
    for i = 1, 158, 1 do 
        table.insert(PoliceCustom.ColourIntDashNacrage, i) 
    end
    for i = 1, GetNumVehicleMods(PoliceCustom.Vehicle, 23) + 1, 1 do
        table.insert(PoliceCustom.JantesPrincipales, i) 
    end
    for i = 1, GetNumVehicleMods(PoliceCustom.Vehicle, 24) + 1, 1 do
        table.insert(PoliceCustom.JantesArrieres, i) 
    end
    for i = 1, GetVehicleLiveryCount(PoliceCustom.Vehicle), 1 do
        table.insert(PoliceCustom.MaxLivery, i) 
    end
    for i = 1, 59, 1 do 
        table.insert(PoliceCustom.MaxKlaxon, i) 
    end
    for i = 1, 12, 1 do 
        table.insert(PoliceCustom.CoulorPhares, i)
    end

    SetVehicleModKit(PoliceCustom.Vehicle, 0)

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
            RageUI.List("Primaire", PoliceCustom.ColourPrimarySecondaryColourJantes, PoliceCustom.DefaultPrimaireColour, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultPrimaireColour = Index

                    local primaire, secondaire = GetVehicleColours(PoliceCustom.Vehicle)
                    ClearVehicleCustomPrimaryColour(PoliceCustom.Vehicle)
                    SetVehicleColours(PoliceCustom.Vehicle, PoliceCustom.DefaultPrimaireColour, secondaire)

                    local primaire, secondaire = GetVehicleColours(PoliceCustom.Vehicle)
                end,
            })
            RageUI.List("Secondaire", PoliceCustom.ColourPrimarySecondaryColourJantes, PoliceCustom.DefaultSecondaireColour, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultSecondaireColour = Index

                local primaire, secondaire = GetVehicleColours(PoliceCustom.Vehicle)
                    ClearVehicleCustomSecondaryColour(PoliceCustom.Vehicle)
                    SetVehicleColours(PoliceCustom.Vehicle, primaire, PoliceCustom.DefaultSecondaireColour)

                    local primaire, secondaire = GetVehicleColours(PoliceCustom.Vehicle)
                end,
            })
            RageUI.List("Intérieurs", PoliceCustom.ColourIntDashNacrage, PoliceCustom.DefaultInteriorColour, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultInteriorColour = Index

                    SetVehicleInteriorColour(PoliceCustom.Vehicle, PoliceCustom.DefaultInteriorColour)
                end,
            })
            RageUI.List("Tableau de bord", PoliceCustom.ColourIntDashNacrage, PoliceCustom.DefaultDashboardColour, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultDashboardColour = Index

                    if GetFollowVehicleCamViewMode() ~= 4 then
                        SetFollowVehicleCamViewMode(4)
                    end
                    SetVehicleDashboardColour(PoliceCustom.Vehicle, PoliceCustom.DefaultDashboardColour)
                end,
            })
            RageUI.List("Nacrage", PoliceCustom.ColourIntDashNacrage, PoliceCustom.DefaultNacrageColour, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultNacrageColour = Index

                    local _, nacrage = GetVehicleExtraColours(PoliceCustom.Vehicle)
                    SetVehicleExtraColours(PoliceCustom.Vehicle, PoliceCustom.DefaultNacrageColour, nacrage)
                end,
            })
        end)

        RageUI.IsVisible(subMenuRoues, function()
            RageUI.List("Type de roues", {"Sport", "Muscle", "Lowrider", "SUV", "Offroad", "Tuner", "Moto", "High end", "Bespokes Originals", "Bespokes Smokes"}, PoliceCustom.DefaultTypeRouesColour, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultTypeRouesColour = Index
                    PoliceCustom.DefaultJantesPrincipales = 1

                    SetVehicleWheelType(PoliceCustom.Vehicle, PoliceCustom.DefaultTypeRouesColour - 1)

                    PoliceCustom.JantesLoadPrincipales = {}
                    PoliceCustom.JantesLoadArrieres = {}
                    for i = 1, GetNumVehicleMods(PoliceCustom.Vehicle, 23) + 1, 1 do
                        table.insert(PoliceCustom.JantesLoadPrincipales, i) 
                    end
                    PoliceCustom.JantesPrincipales = PoliceCustom.JantesLoadPrincipales
                end,
            })
            RageUI.List("Jantes principales", PoliceCustom.JantesPrincipales, PoliceCustom.DefaultJantesPrincipales, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultJantesPrincipales = Index

                    SetVehicleMod(PoliceCustom.Vehicle, 23, PoliceCustom.DefaultJantesPrincipales - 2, GetVehicleModVariation(PoliceCustom.Vehicle, 23))
                end,
            })
            RageUI.List("Couleurs des jantes", PoliceCustom.ColourPrimarySecondaryColourJantes, PoliceCustom.DefaultColourJantes, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultColourJantes = Index

                    local extraJantes = GetVehicleExtraColours(PoliceCustom.Vehicle)
                    SetVehicleExtraColours(PoliceCustom.Vehicle, extraJantes, PoliceCustom.DefaultColourJantes - 1)
                end,
            })
        end)

        RageUI.IsVisible(subMenuClassiques, function()
            RageUI.List("Klaxon", PoliceCustom.MaxKlaxon, PoliceCustom.DefaultKlaxon, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultKlaxon = Index

                    SetVehicleMod(PoliceCustom.Vehicle, 14, PoliceCustom.DefaultKlaxon - 2, false)
                end,
            })
            RageUI.List("Teinte des vitres", {"Normal", "Black", "Smoke Black", "Simple Smoke", "Stock", "Limo"}, PoliceCustom.DefaultTeinteVitres, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultTeinteVitres = Index

                    SetVehicleWindowTint(PoliceCustom.Vehicle, PoliceCustom.DefaultTeinteVitres - 1)
                end,
            })
            RageUI.Checkbox("Phares xenons", false, PoliceCustom.DefaultPharesXenons, {}, {
                onChecked = function()
                    ToggleVehicleMod(PoliceCustom.Vehicle, 22, true)
                    PoliceCustom.PricePharesXenons = 350
                end,
                onUnChecked = function()
                    ToggleVehicleMod(PoliceCustom.Vehicle, 22, false)
                    PoliceCustom.PricePharesXenons = 0
                end,

                onSelected = function(Index)
                    PoliceCustom.DefaultPharesXenons = Index
                end
            })
            RageUI.List("Types de plaques", {"Default", "Sa Black", "Sa Blue", "Sa White", "Simple White", "NY White"}, PoliceCustom.DefaultTypesPlaques, nil, {}, true, {
                onListChange = function(Index)
                    PoliceCustom.DefaultTypesPlaques = Index

                    SetVehicleNumberPlateTextIndex(PoliceCustom.Vehicle, PoliceCustom.DefaultTypesPlaques - 1)
                end,
            })
            if json.encode(PoliceCustom.MaxLivery) ~= "[]" then
                RageUI.List("Livery", PoliceCustom.MaxLivery, PoliceCustom.DefaultLivery, nil, {}, true, {
                    onListChange = function(Index)
                        PoliceCustom.DefaultLivery = Index

                        SetVehicleLivery(PoliceCustom.Vehicle, PoliceCustom.DefaultLivery - 2)
                    end,
                })
            else
                RageUI.Button("Livery", nil, {}, false, {})
            end
            if IsToggleModOn(PoliceCustom.Vehicle, 22) then
                RageUI.List("Couleur des phares", PoliceCustom.CoulorPhares, PoliceCustom.DefaultColourPhares, nil, {}, true, {
                    onListChange = function(Index)
                        PoliceCustom.DefaultColourPhares = Index

                        SetVehicleXenonLightsColour(PoliceCustom.Vehicle, PoliceCustom.DefaultColourPhares - 1)
                    end,
                })
            else
                RageUI.Button("Couleur des phares", nil, {}, false, {})
            end
        end)

        RageUI.IsVisible(subMenuCustoms, function()
            if GetNumVehicleMods(PoliceCustom.Vehicle, 0) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 0)) then
                    RageUI.List("Aileron", GetModObjects(PoliceCustom.Vehicle, 0), PoliceCustom.DefaultAileron, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultAileron = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 0, PoliceCustom.DefaultAileron - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 1) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 1)) then
                    RageUI.List("Pare-choc avant", GetModObjects(PoliceCustom.Vehicle, 1), PoliceCustom.DefaultParechocAvant, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultParechocAvant = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 1, PoliceCustom.DefaultParechocAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 2) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 2)) then
                    RageUI.List("Pare-choc arriére", GetModObjects(PoliceCustom.Vehicle, 2), PoliceCustom.DefaultParechocArriere, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultParechocArriere = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 2, PoliceCustom.DefaultParechocArriere - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 3) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 3)) then
                    RageUI.List("Carrosserie", GetModObjects(PoliceCustom.Vehicle, 3), PoliceCustom.DefaultCarrosserie, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultCarrosserie = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 3, PoliceCustom.DefaultCarrosserie - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 4) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 4)) then
                    RageUI.List("Echappement", GetModObjects(PoliceCustom.Vehicle, 4), PoliceCustom.DefaultEchappement, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultEchappement = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 4, PoliceCustom.DefaultEchappement - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 5) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 5)) then
                    RageUI.List("Cadre", GetModObjects(PoliceCustom.Vehicle, 5), PoliceCustom.DefaultCadre, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultCadre = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 5, PoliceCustom.DefaultCadre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 6) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 6)) then
                    RageUI.List("Calandre", GetModObjects(PoliceCustom.Vehicle, 6), PoliceCustom.DefaultCalandre, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultCalandre = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 6, PoliceCustom.DefaultCalandre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 7) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 7)) then
                    RageUI.List("Capot", GetModObjects(PoliceCustom.Vehicle, 7), PoliceCustom.DefaultCapot, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultCapot = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 7, PoliceCustom.DefaultCapot - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 8) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 8)) then
                    RageUI.List("Autocollant gauche", GetModObjects(PoliceCustom.Vehicle, 8), PoliceCustom.DefaultAutocollantGauche, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultAutocollantGauche = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 8, PoliceCustom.DefaultAutocollantGauche - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 9) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 9)) then
                    RageUI.List("Autocollant droit", GetModObjects(PoliceCustom.Vehicle, 9), PoliceCustom.DefaultAutocollantDroit, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultAutocollantDroit = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 9, PoliceCustom.DefaultAutocollantDroit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 10) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 10)) then
                    RageUI.List("Toit", GetModObjects(PoliceCustom.Vehicle, 10), PoliceCustom.DefaultToit, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultToit = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 10, PoliceCustom.DefaultToit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 25) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 25)) then
                    RageUI.List("Support de plaque", GetModObjects(PoliceCustom.Vehicle, 25), PoliceCustom.DefaultSupportPlaque, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultSupportPlaque = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 25, PoliceCustom.DefaultSupportPlaque - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 26) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 26)) then
                    RageUI.List("Plaque avant", GetModObjects(PoliceCustom.Vehicle, 26), PoliceCustom.DefaultPlaqueAvant, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultPlaqueAvant = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 26, PoliceCustom.DefaultPlaqueAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 28) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 28)) then
                    RageUI.List("Figurine", GetModObjects(PoliceCustom.Vehicle, 28), PoliceCustom.DefaultFigurine, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultFigurine = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 28, PoliceCustom.DefaultFigurine - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 29) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 29)) then
                    RageUI.List("Tableau de bord motif", GetModObjects(PoliceCustom.Vehicle, 29), PoliceCustom.DefaultDashboardMotif, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultDashboardMotif = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 29, PoliceCustom.DefaultDashboardMotif - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 30) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 30)) then
                    RageUI.List("Cadran", GetModObjects(PoliceCustom.Vehicle, 30), PoliceCustom.DefaultCadran, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultCadran = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 30, PoliceCustom.DefaultCadran - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 31) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 31)) then
                    RageUI.List("Haut parleur portes", GetModObjects(PoliceCustom.Vehicle, 31), PoliceCustom.DefaultHautParleurPortes, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultHautParleurPortes = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 31, PoliceCustom.DefaultHautParleurPortes - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 32) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 32)) then
                    RageUI.List("Motif sieges", GetModObjects(PoliceCustom.Vehicle, 32), PoliceCustom.DefaultMotifSieges, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultMotifSieges = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 32, PoliceCustom.DefaultMotifSieges - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 33) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 33)) then
                    RageUI.List("Volant", GetModObjects(PoliceCustom.Vehicle, 33), PoliceCustom.DefaultVolant, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultVolant = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 33, PoliceCustom.DefaultVolant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 34) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 34)) then
                    RageUI.List("Levier", GetModObjects(PoliceCustom.Vehicle, 34), PoliceCustom.DefaultLevier, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultLevier = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 34, PoliceCustom.DefaultLevier - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 35) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 35)) then
                    RageUI.List("Logo custom", GetModObjects(PoliceCustom.Vehicle, 35), PoliceCustom.DefaultLogoCustom, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultLogoCustom = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 35, PoliceCustom.DefaultLogoCustom - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 36) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 36)) then
                    RageUI.List("Haut parleur vitre", GetModObjects(PoliceCustom.Vehicle, 36), PoliceCustom.DefaultHautParleurVitre, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultHautParleurVitre = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 36, PoliceCustom.DefaultHautParleurVitre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 37) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 37)) then
                    RageUI.List("Haut parleur coffre", GetModObjects(PoliceCustom.Vehicle, 37), PoliceCustom.DefaultHautParleurCoffre, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultHautParleurCoffre = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 37, PoliceCustom.DefaultHautParleurCoffre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 38) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 38)) then
                    RageUI.List("Hydrolique", GetModObjects(PoliceCustom.Vehicle, 38), PoliceCustom.DefaultHydrolique, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultHydrolique = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 38, PoliceCustom.DefaultHydrolique - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 39) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 39)) then
                    RageUI.List("Moteur", GetModObjects(PoliceCustom.Vehicle, 39), PoliceCustom.DefaultVisualMoteur, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultVisualMoteur = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 39, PoliceCustom.DefaultVisualMoteur - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 40) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 40)) then
                    RageUI.List("Filtres é air", GetModObjects(PoliceCustom.Vehicle, 40), PoliceCustom.DefaultFiltresAir, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultFiltresAir = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 40, PoliceCustom.DefaultFiltresAir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 41) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 41)) then
                    RageUI.List("Entretoises", GetModObjects(PoliceCustom.Vehicle, 41), PoliceCustom.DefaultEntretoises, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultEntretoises = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 41, PoliceCustom.DefaultEntretoises - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 42) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 42)) then
                    RageUI.List("Couverture", GetModObjects(PoliceCustom.Vehicle, 42), PoliceCustom.DefaultCouverture, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultCouverture = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 42, PoliceCustom.DefaultCouverture - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 43) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 43)) then
                    RageUI.List("Antenne", GetModObjects(PoliceCustom.Vehicle, 43), PoliceCustom.DefaultAntenne, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultAntenne = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 43, PoliceCustom.DefaultAntenne - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 45) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 45)) then
                    RageUI.List("Reservoir", GetModObjects(PoliceCustom.Vehicle, 45), PoliceCustom.DefaultReservoir, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultReservoir = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 45, PoliceCustom.DefaultReservoir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 46) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 46)) then
                    RageUI.List("Fenétre", GetModObjects(PoliceCustom.Vehicle, 46), PoliceCustom.DefaultFenetre, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultFenetre = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 46, PoliceCustom.DefaultFenetre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(PoliceCustom.Vehicle, 48) > 0 then
                if not GetMitrailVeh(GetModObjects(PoliceCustom.Vehicle, 48)) then
                    RageUI.List("Stickers", GetModObjects(PoliceCustom.Vehicle, 48), PoliceCustom.DefaultStyle, nil, {}, true, {
                        onListChange = function(Index)
                            PoliceCustom.DefaultStyle = Index

                            SetVehicleMod(PoliceCustom.Vehicle, 48, PoliceCustom.DefaultStyle - 2, false)
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
    'LSPDscorcher',
    'nkcruiser',
    'nkbuffalos',
    'nkstx',
    'nktorrence',
    'code3bmw',
    'nkscout',
    'nkfugitive',
    'nkgranger2',
    'lspdbuffsumk',
    'lspdbuffalostxum',
    'poltaxi',
    'LSPDbus',
    'riot',
    'nkcaracara2',
    'nkcoquette',
    'nkomnisegt',
}

CreateThread(function()
	while true do
		local Timer = 800

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' and ESX.PlayerData.job.grade >= 0 then
            local plycrdjob = GetEntityCoords(PlayerPedId())
            local CustomPoliceCoords = vector3(436.9609, -956.3065, 23.94)
            local dist = #(CustomPoliceCoords - plycrdjob)
            
            if (dist < 10) then
                Timer = 0
                DrawMarker(20, 436.9609, -956.3065, 23.94, 0, 0, 0, 0, nil, nil, 1.0, 1.0, 1.0, 255, 0, 0, 170, 0, 1, 0, 0, nil, nil, 0)
                
                if (dist < 2 and not openCustomMenu) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
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
                                OpenLSPDCustom()
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
