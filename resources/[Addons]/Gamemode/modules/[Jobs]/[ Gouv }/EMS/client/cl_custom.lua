
local openCustomMenu = false

local AmbulanceCustom = {
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


function OpenEMSCustom()
    local mainMenu = RageUI.CreateMenu('', 'Custom de la voiture')
    mainMenu.Closable = false

    subMenuColour = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuRoues = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuClassiques = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuCustoms = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")
    subMenuExtra = RageUI.CreateSubMenu(mainMenu, " ", "Que voulez-vous faire ?")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    AmbulanceCustom.Vehicle = GetVehiclePedIsIn(PlayerPedId())
    Wait(150)
    AmbulanceCustom.ColourPrimarySecondaryColourJantes = {}
    AmbulanceCustom.ColourIntDashNacrage = {}
    AmbulanceCustom.JantesPrincipales = {}
    AmbulanceCustom.JantesArrieres = {}
    AmbulanceCustom.MaxLivery = {}
    AmbulanceCustom.MaxKlaxon = {}
    AmbulanceCustom.CoulorPhares = {}
    for i = 1, 160, 1 do 
        table.insert(AmbulanceCustom.ColourPrimarySecondaryColourJantes, i) 
    end 
    for i = 1, 158, 1 do 
        table.insert(AmbulanceCustom.ColourIntDashNacrage, i) 
    end
    for i = 1, GetNumVehicleMods(AmbulanceCustom.Vehicle, 23) + 1, 1 do
        table.insert(AmbulanceCustom.JantesPrincipales, i) 
    end
    for i = 1, GetNumVehicleMods(AmbulanceCustom.Vehicle, 24) + 1, 1 do
        table.insert(AmbulanceCustom.JantesArrieres, i) 
    end
    for i = 1, GetVehicleLiveryCount(AmbulanceCustom.Vehicle), 1 do
        table.insert(AmbulanceCustom.MaxLivery, i) 
    end
    for i = 1, 59, 1 do 
        table.insert(AmbulanceCustom.MaxKlaxon, i) 
    end
    for i = 1, 12, 1 do 
        table.insert(AmbulanceCustom.CoulorPhares, i)
    end

    SetVehicleModKit(AmbulanceCustom.Vehicle, 0)

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
            RageUI.List("Primaire", AmbulanceCustom.ColourPrimarySecondaryColourJantes, AmbulanceCustom.DefaultPrimaireColour, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultPrimaireColour = Index

                    local primaire, secondaire = GetVehicleColours(AmbulanceCustom.Vehicle)
                    ClearVehicleCustomPrimaryColour(AmbulanceCustom.Vehicle)
                    SetVehicleColours(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultPrimaireColour, secondaire)

                    local primaire, secondaire = GetVehicleColours(AmbulanceCustom.Vehicle)
                end,
            })
            RageUI.List("Secondaire", AmbulanceCustom.ColourPrimarySecondaryColourJantes, AmbulanceCustom.DefaultSecondaireColour, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultSecondaireColour = Index

                local primaire, secondaire = GetVehicleColours(AmbulanceCustom.Vehicle)
                    ClearVehicleCustomSecondaryColour(AmbulanceCustom.Vehicle)
                    SetVehicleColours(AmbulanceCustom.Vehicle, primaire, AmbulanceCustom.DefaultSecondaireColour)

                    local primaire, secondaire = GetVehicleColours(AmbulanceCustom.Vehicle)
                end,
            })
            RageUI.List("Intérieurs", AmbulanceCustom.ColourIntDashNacrage, AmbulanceCustom.DefaultInteriorColour, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultInteriorColour = Index

                    SetVehicleInteriorColour(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultInteriorColour)
                end,
            })
            RageUI.List("Tableau de bord", AmbulanceCustom.ColourIntDashNacrage, AmbulanceCustom.DefaultDashboardColour, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultDashboardColour = Index

                    if GetFollowVehicleCamViewMode() ~= 4 then
                        SetFollowVehicleCamViewMode(4)
                    end
                    SetVehicleDashboardColour(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultDashboardColour)
                end,
            })
            RageUI.List("Nacrage", AmbulanceCustom.ColourIntDashNacrage, AmbulanceCustom.DefaultNacrageColour, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultNacrageColour = Index

                    local _, nacrage = GetVehicleExtraColours(AmbulanceCustom.Vehicle)
                    SetVehicleExtraColours(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultNacrageColour, nacrage)
                end,
            })
        end)

        RageUI.IsVisible(subMenuRoues, function()
            RageUI.List("Type de roues", {"Sport", "Muscle", "Lowrider", "SUV", "Offroad", "Tuner", "Moto", "High end", "Bespokes Originals", "Bespokes Smokes"}, AmbulanceCustom.DefaultTypeRouesColour, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultTypeRouesColour = Index
                    AmbulanceCustom.DefaultJantesPrincipales = 1

                    SetVehicleWheelType(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultTypeRouesColour - 1)

                    AmbulanceCustom.JantesLoadPrincipales = {}
                    AmbulanceCustom.JantesLoadArrieres = {}
                    for i = 1, GetNumVehicleMods(AmbulanceCustom.Vehicle, 23) + 1, 1 do
                        table.insert(AmbulanceCustom.JantesLoadPrincipales, i) 
                    end
                    AmbulanceCustom.JantesPrincipales = AmbulanceCustom.JantesLoadPrincipales
                end,
            })
            RageUI.List("Jantes principales", AmbulanceCustom.JantesPrincipales, AmbulanceCustom.DefaultJantesPrincipales, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultJantesPrincipales = Index

                    SetVehicleMod(AmbulanceCustom.Vehicle, 23, AmbulanceCustom.DefaultJantesPrincipales - 2, GetVehicleModVariation(AmbulanceCustom.Vehicle, 23))
                end,
            })
            RageUI.List("Couleurs des jantes", AmbulanceCustom.ColourPrimarySecondaryColourJantes, AmbulanceCustom.DefaultColourJantes, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultColourJantes = Index

                    local extraJantes = GetVehicleExtraColours(AmbulanceCustom.Vehicle)
                    SetVehicleExtraColours(AmbulanceCustom.Vehicle, extraJantes, AmbulanceCustom.DefaultColourJantes - 1)
                end,
            })
        end)

        RageUI.IsVisible(subMenuClassiques, function()
            RageUI.List("Klaxon", AmbulanceCustom.MaxKlaxon, AmbulanceCustom.DefaultKlaxon, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultKlaxon = Index

                    SetVehicleMod(AmbulanceCustom.Vehicle, 14, AmbulanceCustom.DefaultKlaxon - 2, false)
                end,
            })
            RageUI.List("Teinte des vitres", {"Normal", "Black", "Smoke Black", "Simple Smoke", "Stock", "Limo"}, AmbulanceCustom.DefaultTeinteVitres, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultTeinteVitres = Index

                    SetVehicleWindowTint(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultTeinteVitres - 1)
                end,
            })
            RageUI.Checkbox("Phares xenons", false, AmbulanceCustom.DefaultPharesXenons, {}, {
                onChecked = function()
                    ToggleVehicleMod(AmbulanceCustom.Vehicle, 22, true)
                    AmbulanceCustom.PricePharesXenons = 350
                end,
                onUnChecked = function()
                    ToggleVehicleMod(AmbulanceCustom.Vehicle, 22, false)
                    AmbulanceCustom.PricePharesXenons = 0
                end,

                onSelected = function(Index)
                    AmbulanceCustom.DefaultPharesXenons = Index
                end
            })
            RageUI.List("Types de plaques", {"Default", "Sa Black", "Sa Blue", "Sa White", "Simple White", "NY White"}, AmbulanceCustom.DefaultTypesPlaques, nil, {}, true, {
                onListChange = function(Index)
                    AmbulanceCustom.DefaultTypesPlaques = Index

                    SetVehicleNumberPlateTextIndex(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultTypesPlaques - 1)
                end,
            })
            if json.encode(AmbulanceCustom.MaxLivery) ~= "[]" then
                RageUI.List("Livery", AmbulanceCustom.MaxLivery, AmbulanceCustom.DefaultLivery, nil, {}, true, {
                    onListChange = function(Index)
                        AmbulanceCustom.DefaultLivery = Index

                        SetVehicleLivery(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultLivery - 2)
                    end,
                })
            else
                RageUI.Button("Livery", nil, {}, false, {})
            end
            if IsToggleModOn(AmbulanceCustom.Vehicle, 22) then
                RageUI.List("Couleur des phares", AmbulanceCustom.CoulorPhares, AmbulanceCustom.DefaultColourPhares, nil, {}, true, {
                    onListChange = function(Index)
                        AmbulanceCustom.DefaultColourPhares = Index

                        SetVehicleXenonLightsColour(AmbulanceCustom.Vehicle, AmbulanceCustom.DefaultColourPhares - 1)
                    end,
                })
            else
                RageUI.Button("Couleur des phares", nil, {}, false, {})
            end
        end)

        RageUI.IsVisible(subMenuCustoms, function()
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 0) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 0)) then
                    RageUI.List("Aileron", GetModObjects(AmbulanceCustom.Vehicle, 0), AmbulanceCustom.DefaultAileron, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultAileron = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 0, AmbulanceCustom.DefaultAileron - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 1) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 1)) then
                    RageUI.List("Pare-choc avant", GetModObjects(AmbulanceCustom.Vehicle, 1), AmbulanceCustom.DefaultParechocAvant, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultParechocAvant = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 1, AmbulanceCustom.DefaultParechocAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 2) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 2)) then
                    RageUI.List("Pare-choc arriére", GetModObjects(AmbulanceCustom.Vehicle, 2), AmbulanceCustom.DefaultParechocArriere, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultParechocArriere = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 2, AmbulanceCustom.DefaultParechocArriere - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 3) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 3)) then
                    RageUI.List("Carrosserie", GetModObjects(AmbulanceCustom.Vehicle, 3), AmbulanceCustom.DefaultCarrosserie, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultCarrosserie = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 3, AmbulanceCustom.DefaultCarrosserie - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 4) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 4)) then
                    RageUI.List("Echappement", GetModObjects(AmbulanceCustom.Vehicle, 4), AmbulanceCustom.DefaultEchappement, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultEchappement = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 4, AmbulanceCustom.DefaultEchappement - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 5) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 5)) then
                    RageUI.List("Cadre", GetModObjects(AmbulanceCustom.Vehicle, 5), AmbulanceCustom.DefaultCadre, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultCadre = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 5, AmbulanceCustom.DefaultCadre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 6) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 6)) then
                    RageUI.List("Calandre", GetModObjects(AmbulanceCustom.Vehicle, 6), AmbulanceCustom.DefaultCalandre, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultCalandre = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 6, AmbulanceCustom.DefaultCalandre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 7) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 7)) then
                    RageUI.List("Capot", GetModObjects(AmbulanceCustom.Vehicle, 7), AmbulanceCustom.DefaultCapot, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultCapot = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 7, AmbulanceCustom.DefaultCapot - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 8) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 8)) then
                    RageUI.List("Autocollant gauche", GetModObjects(AmbulanceCustom.Vehicle, 8), AmbulanceCustom.DefaultAutocollantGauche, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultAutocollantGauche = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 8, AmbulanceCustom.DefaultAutocollantGauche - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 9) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 9)) then
                    RageUI.List("Autocollant droit", GetModObjects(AmbulanceCustom.Vehicle, 9), AmbulanceCustom.DefaultAutocollantDroit, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultAutocollantDroit = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 9, AmbulanceCustom.DefaultAutocollantDroit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 10) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 10)) then
                    RageUI.List("Toit", GetModObjects(AmbulanceCustom.Vehicle, 10), AmbulanceCustom.DefaultToit, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultToit = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 10, AmbulanceCustom.DefaultToit - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 25) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 25)) then
                    RageUI.List("Support de plaque", GetModObjects(AmbulanceCustom.Vehicle, 25), AmbulanceCustom.DefaultSupportPlaque, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultSupportPlaque = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 25, AmbulanceCustom.DefaultSupportPlaque - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 26) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 26)) then
                    RageUI.List("Plaque avant", GetModObjects(AmbulanceCustom.Vehicle, 26), AmbulanceCustom.DefaultPlaqueAvant, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultPlaqueAvant = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 26, AmbulanceCustom.DefaultPlaqueAvant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 28) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 28)) then
                    RageUI.List("Figurine", GetModObjects(AmbulanceCustom.Vehicle, 28), AmbulanceCustom.DefaultFigurine, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultFigurine = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 28, AmbulanceCustom.DefaultFigurine - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 29) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 29)) then
                    RageUI.List("Tableau de bord motif", GetModObjects(AmbulanceCustom.Vehicle, 29), AmbulanceCustom.DefaultDashboardMotif, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultDashboardMotif = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 29, AmbulanceCustom.DefaultDashboardMotif - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 30) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 30)) then
                    RageUI.List("Cadran", GetModObjects(AmbulanceCustom.Vehicle, 30), AmbulanceCustom.DefaultCadran, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultCadran = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 30, AmbulanceCustom.DefaultCadran - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 31) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 31)) then
                    RageUI.List("Haut parleur portes", GetModObjects(AmbulanceCustom.Vehicle, 31), AmbulanceCustom.DefaultHautParleurPortes, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultHautParleurPortes = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 31, AmbulanceCustom.DefaultHautParleurPortes - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 32) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 32)) then
                    RageUI.List("Motif sieges", GetModObjects(AmbulanceCustom.Vehicle, 32), AmbulanceCustom.DefaultMotifSieges, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultMotifSieges = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 32, AmbulanceCustom.DefaultMotifSieges - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 33) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 33)) then
                    RageUI.List("Volant", GetModObjects(AmbulanceCustom.Vehicle, 33), AmbulanceCustom.DefaultVolant, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultVolant = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 33, AmbulanceCustom.DefaultVolant - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 34) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 34)) then
                    RageUI.List("Levier", GetModObjects(AmbulanceCustom.Vehicle, 34), AmbulanceCustom.DefaultLevier, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultLevier = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 34, AmbulanceCustom.DefaultLevier - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 35) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 35)) then
                    RageUI.List("Logo custom", GetModObjects(AmbulanceCustom.Vehicle, 35), AmbulanceCustom.DefaultLogoCustom, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultLogoCustom = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 35, AmbulanceCustom.DefaultLogoCustom - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 36) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 36)) then
                    RageUI.List("Haut parleur vitre", GetModObjects(AmbulanceCustom.Vehicle, 36), AmbulanceCustom.DefaultHautParleurVitre, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultHautParleurVitre = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 36, AmbulanceCustom.DefaultHautParleurVitre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 37) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 37)) then
                    RageUI.List("Haut parleur coffre", GetModObjects(AmbulanceCustom.Vehicle, 37), AmbulanceCustom.DefaultHautParleurCoffre, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultHautParleurCoffre = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 37, AmbulanceCustom.DefaultHautParleurCoffre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 38) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 38)) then
                    RageUI.List("Hydrolique", GetModObjects(AmbulanceCustom.Vehicle, 38), AmbulanceCustom.DefaultHydrolique, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultHydrolique = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 38, AmbulanceCustom.DefaultHydrolique - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 39) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 39)) then
                    RageUI.List("Moteur", GetModObjects(AmbulanceCustom.Vehicle, 39), AmbulanceCustom.DefaultVisualMoteur, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultVisualMoteur = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 39, AmbulanceCustom.DefaultVisualMoteur - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 40) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 40)) then
                    RageUI.List("Filtres é air", GetModObjects(AmbulanceCustom.Vehicle, 40), AmbulanceCustom.DefaultFiltresAir, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultFiltresAir = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 40, AmbulanceCustom.DefaultFiltresAir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 41) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 41)) then
                    RageUI.List("Entretoises", GetModObjects(AmbulanceCustom.Vehicle, 41), AmbulanceCustom.DefaultEntretoises, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultEntretoises = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 41, AmbulanceCustom.DefaultEntretoises - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 42) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 42)) then
                    RageUI.List("Couverture", GetModObjects(AmbulanceCustom.Vehicle, 42), AmbulanceCustom.DefaultCouverture, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultCouverture = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 42, AmbulanceCustom.DefaultCouverture - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 43) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 43)) then
                    RageUI.List("Antenne", GetModObjects(AmbulanceCustom.Vehicle, 43), AmbulanceCustom.DefaultAntenne, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultAntenne = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 43, AmbulanceCustom.DefaultAntenne - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 45) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 45)) then
                    RageUI.List("Reservoir", GetModObjects(AmbulanceCustom.Vehicle, 45), AmbulanceCustom.DefaultReservoir, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultReservoir = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 45, AmbulanceCustom.DefaultReservoir - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 46) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 46)) then
                    RageUI.List("Fenétre", GetModObjects(AmbulanceCustom.Vehicle, 46), AmbulanceCustom.DefaultFenetre, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultFenetre = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 46, AmbulanceCustom.DefaultFenetre - 2, false)
                        end,
                    })
                end
            end
            if GetNumVehicleMods(AmbulanceCustom.Vehicle, 48) > 0 then
                if not GetMitrailVeh(GetModObjects(AmbulanceCustom.Vehicle, 48)) then
                    RageUI.List("Stickers", GetModObjects(AmbulanceCustom.Vehicle, 48), AmbulanceCustom.DefaultStyle, nil, {}, true, {
                        onListChange = function(Index)
                            AmbulanceCustom.DefaultStyle = Index

                            SetVehicleMod(AmbulanceCustom.Vehicle, 48, AmbulanceCustom.DefaultStyle - 2, false)
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
    'nkambulan',
    'nkcaracara2',
    'nklandstlkr',
    'nkballer7em',
    'nkgranger2e',
    'nkstxems'
}

CreateThread(function()
	while true do
		local Timer = 800

        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' and ESX.PlayerData.job.grade >= 0 then
            local plycrdjob = GetEntityCoords(PlayerPedId())
            local CustomPoliceCoords = vector3(-1846.64, -387.76, 40.73)
            local dist = #(CustomPoliceCoords - plycrdjob)
            
            if (dist < 10) then
                Timer = 0
                DrawMarker(20, -1846.64, -387.76, 40.73, 0, 0, 0, 0, nil, nil, 1.0, 1.0, 1.0, 255, 0, 0, 170, 0, 1, 0, 0, nil, nil, 0)
                
                if (dist < 2 and not openCustomMenu) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                    if IsControlJustPressed(1,51) then
                        CreateThread(function()

                            local IsVeh = false
                            for i=1, #ListVeh do
                                local vehicleModel = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
                                local Name = GetDisplayNameFromVehicleModel(vehicleModel)

                                print(Name)

                                if (string.lower(ListVeh[i]) == string.lower(Name)) then
                                    IsVeh = true
                                end
                            end

                            if (IsVeh) then
                                openCustomMenu = true
                                OpenEMSCustom()
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
