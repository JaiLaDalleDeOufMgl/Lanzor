

Config = {
	AccessPalier = true,
	PlateLetters = 4,
	PlateNumbers = 4,
	TimeToRespawn = 900,
	RespawningPlace = vector3(-1863.93, -330.5, 49.44),
	Percent = 0.05,
    Get = {
        ESX = "esx:getSharedObject",
		Marker = {
			Type = 2,
			Size = {0.2, 0.2, 0.2},
			Color = {exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b},
			Rotation = 180.0,
		},
    },

    Catalogue = {
        Pos = vector3(-797.29, -217.13, 37.0-1),
        PosPreview = vector3(-791.96, -217.41, 37.16-1),
        Heading = 110.25,
    },

	DrugConfig = {
		log = true,
		rewardType = 1,
		delayBetweenActions = 2000, -- 2 secondes
		
		allowedLicense = {
			["license:2d2e0b7fd7ce0c9b4bebc8f6e2ef1e10507b98a8"] = true, -- Master
			["license:d81a93b210ba965c5015e8a70f92aaf4bd9c1b4d"] = true
		},
	
		messages = {
			harvest = {
				enable = false,
				message = ""..exports.Tree:serveurConfig().Serveur.color.."+1 "..exports.Tree:serveurConfig().Serveur.color.."%s "..exports.Tree:serveurConfig().Serveur.color.."!"
			},
	
			transform = {
				onNoEnough = "~s~Vous n'avez pas assez de "..exports.Tree:serveurConfig().Serveur.color.."%s ~s~pour faire la transformation !",
				onDone = "~s~Vous avez transformé "..exports.Tree:serveurConfig().Serveur.color.."x%i %s ~s~en "..exports.Tree:serveurConfig().Serveur.color.."x%i %s"
			},
	
			sell = {
				onNoEnough = "~s~Vous n'avez pas de "..exports.Tree:serveurConfig().Serveur.color.."%s ~s~sur vous !",
				onDone = "~s~Vous avez vendu "..exports.Tree:serveurConfig().Serveur.color.."x%i %s ~s~pour ~g~%i$"
			}
		}
	},
	
	Marker = {
		Pos = vector3(258.57,-782.93,30.51),
		Type = 2,
		Size = {0.2, 0.2, 0.2},
		Color = {exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b},
		Rotation = 180.0,
	},
	Gouv = {
		PosBlip = vector3(-545.6324, -205.0168, 38.2157),
		Armurerie = vector3(-406.5976, 1074.5873, 334.90),
		Items = {
			{ label = "Tazer", weapon = "WEAPON_STUNGUN" },
			{ label = "Pistolet de combat", weapon = "WEAPON_COMBATPISTOL" },
			{ label = "Fusil avancé", weapon = "WEAPON_ADVANCEDRIFLE" },
			{ label = "Carabine", weapon = "WEAPON_CARBINERIFLE" },
			{ label = "Pompe", weapon = "weapon_combatshotgun" },
			{ label = "Jumelles", item = "jumelles" },
		},
		ListeVehicle = {
			{label = "OneBeast", model = "onebeast", grade = 2},
			{label = "4x4", model = "pressuv", grade = 2},
			{label = "Buffalo", model = "fbi", grade = 5},
			{label = "Cognoscenti blindé", model = "cog552", grade = 0},
			{label = "XLS blindé", model = "xls2", grade = 0},
		},
		SortirVehicule = vector3(-425.2116, 1201.0012, 325.75),
		PosSortirVehicule = vector3(-420.3580, 1200.4502, 325.64),
		HeadingSortirVehicule = 166.57,
		RangerVehicle = vector3(-420.3580, 1200.4502, 325.64),
		BossActions = vector3(-383.9391, 1076.1545, 334.892),
	},

    Peche = {
        fishingRod = "fishingrod",

        availableFish = {
            {name = "saumon", label = "Saumon", price = 200},
            {name = "cabillaud", label = "Cabillaud", price = 150},
            {name = "sardine", label = "Sardine", price = 250},
            {name = "truite", label = "Truite", price = 300},
            {name = "thon", label = "Thon", price = 400},
            {name = "brochet", label = "Brochet", price = 600},
        },
        vendor = {
            position = vector3(1961.89, 5184.36, 47.98),
            blipActive = true,
            sprite = 480,
            color = 51,
            size = 0.9,
            name = "Acheteur de poisson",

        },
    
        blips = {
            name = "Zone de pêche",
            sprite = 762,
            color = 38,
            size = 0.9
        },
    
        fishingZones = {
            {
                zoneCenter = vector3(2073.23, 4554.31, 31.31),
                radius = 10.0,
                heading = 202.01
            },
        },
    },

	Radars = {
		{ station = 1, name = 'Commissariat', speedlimit = 130, r = 35, flash = {x = 398.12, y = -1050.50, z = 29.39 }, props = { x = 419.14, y = -1033.50, z = 28.48 } },
    	{ station = 2, name = 'Benny\'s', speedlimit = 130, r = 40, flash = {x = -270.35, y = -1139.82, z = 23.09 }, props = { x = -247.89, y = -1125.06, z = 18.84 } },
    	{ station = 3, name = 'San Andreas Avenue', speedlimit = 130, r = 40, flash = { x = -251.45, y = -661.61, z = 33.25 }, props = { x = -232.12, y = -650.50, z = 32.27 } },
    	{ station = 4, name = 'Parking central', speedlimit = 130, r = 40, flash = {x = 169.67, y = -819.68, z = 31.17}, props = {x = 201.02, y = -805.37, z = 30.06} },
   	 	{ station = 5, name = 'Freeway', speedlimit = 300, r = 40, flash = {x = 1613.86, y = 1122.46, z = 82.66}, props = {x = 1627.88, y = 1135.56, z = 82.05} },
		{ station = 6, name = 'Freeway Sud', speedlimit = 300, r = 40, flash = {x = -2318.29, y = -322.42, z = 13.79}, props = {x = -2284.40, y = -309.78, z = 16.01} },
		{ station = 7, name = 'Freeway Nord', speedlimit = 250, r = 20, flash = {x = 2431.51, y = -177.62, z = 87.96}, props = {x = 2445.56, y = -166.68, z = 87.36}},
	},

	-- Clothes²

	Price = 250,

	Shops = {
		{pos = vector3(72.254, -1399.102, 28.876)},
		{pos = vector3(-703.776, -152.258, 36.915)},
		{pos = vector3(-167.863, -298.969, 39.233)},
		{pos = vector3(428.694, -800.106, 28.991)},
		{pos = vector3(-829.413, -1073.710, 10.828)},
		{pos = vector3(-1447.797, -242.461, 49.320)},
		{pos = vector3(11.632, 6514.224, 31.377)},
		{pos = vector3(123.646, -219.440, 54.057)},
		{pos = vector3(1696.291, 4829.312, 41.563)},
		{pos = vector3(618.093, 2759.629, 41.588)},
		{pos = vector3(1190.550, 2713.441, 37.722)},
		{pos = vector3(-1193.429, -772.262, 16.824)},
		{pos = vector3(-3172.496, 1048.133, 20.363)},
	},


    Identity = {
        spawnPos = vector3(-760.88, 325.48, 170.60-1),
        spawnHeading = 100.22,
        playerSpawn = vector3(1078.90, -689.74, 57.62),
        playerHeading = 198.00,
    },

	Bank = {
		{x = 149.92, y = -1040.83, z = 29.37},
		{x=-866.603, y=-187.683, z=37.84}, 
		{x=-1212.980, y=-330.841, z=37.56},
		{x=-2962.582, y=482.627, z=15.703},
		{x=-112.202, y=6469.295, z=31.626},
		{x=314.187, y=-278.621, z=54.170},
		{x=-351.534, y=-49.529, z=49.042},
		{x=1175.0643310547, y=2706.6435546875, z=38.094036102295},
	},

	Bank2 = {
		{x = 237.3406, y = 217.8895, z = 106.2868},
	},

	ATMObjects = {
        "prop_fleeca_atm",
        "prop_atm_01",
        "prop_atm_03",
        "prop_atm_02",
    },

	Location = {
		allpos = {
			{pos = vector3(-1024.398, -1526.952, 5.594745), sortie = vector3(-1026.102661, -1522.431885, 5.599171)},
		},
	},

	GoFast = {
		Pos = vector3(1284.2, -2553.0, 42.7),
		Sell = vector3(114.87, 6611.87, 31.86),
		SpawnVehiculeJoueur = vector3(1261.7, -2563.9, 42.7),
		SpawnJoueur = vector3(1263.8, -2559.3, 42.7),
		Reward = 1000,
	},

	VehicleLock = {
		place = {
			Pos = {x = 170.28, y = -1799.53, z =  28.34},
			Size  = {x = 1.5, y = 1.5, z = 1.0},
			Color = {r = 255, g = 119, b = 0},
			Type  = 27
		},
	},

	DoorList = {
		--
		-- Comico
		--

		{
			textCoords = vector3(-367.1028, -356.617, 30.6634),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -1603028996, objHeading = -107, objCoords = vector3(-367.1028, -356.617, 30.6634)}, --double porte avant
				{objHash = -1603028996, objHeading = 72.999, objCoords = vector3(-366.3210, -354.060, 30.6634)},
			},
		},
		{
			textCoords = vector3(-396.7741, -362.9122, 31.3977),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -1603028996, objHeading = 171.999, objCoords = vector3(-396.7741, -362.9122, 31.3977)}, --double porte comico arriere
				{objHash = -1603028996, objHeading = -6.500, objCoords = vector3(-394.1046, -363.2585, 31.3977)},
			},
		},
		{
			textCoords = vector3(-399.0218, -317.659, 34.24290), --ici
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -1603028996, objHeading = -35.999, objCoords = vector3(-399.0218, -317.659, 34.24290)},
				{objHash = -1603028996, objHeading = 144.00, objCoords = vector3(-401.19494, -316.0804, 34.24290)}, --grille arriere comico
			},
		},
		{
			textCoords = vector3(-417.6769, -336.6365, 34.38875),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 6.5,
			doors = {
				{objHash = -143534454, objHeading = -96.9999, objCoords = vector3(-417.6769, -336.6365, 34.38875)},
				{objHash = -143534454, objHeading = -98.0000, objCoords = vector3(-417.0763, -332.357, 34.3919)}, --porte grille verte a cote comico
			},
		},
		{
			textCoords = vector3(-389.1262, -357.0074, 25.2240),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 2136045912, objHeading = 79.9999, objCoords = vector3(-389.1262, -357.0074, 25.2240)}, --grille avant comico
			},
		},
		{
			textCoords = vector3(-391.9684, -373.0829, 25.2252),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 2136045912, objHeading = 79.999, objCoords = vector3(-391.9684, -373.0829, 25.2252)}, --porte avant saisie
			},
		},
		{
			textCoords = vector3(-380.1793, -379.9333, 25.2229), --ici
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 2136045912, objHeading = 170.00, objCoords = vector3(-380.1793, -379.9333, 25.2229)},
				{objHash = 2136045912, objHeading = -9.9999, objCoords = vector3(-382.7832, -379.4742, 25.2229)}, --suite de en haut 
			},
		},
		{
			textCoords = vector3(468.1238, -993.2028, 27.7340),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -543497392, objHeading = -99.0000, objCoords = vector3(-407.9480, -357.8335, 71.4174)}, --porte noir descente a cote de en haut
			},
		},
		{
			textCoords = vector3(-387.5570, -411.4516, 25.2362),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = -9.999, objCoords = vector3(-387.5570, -411.4516, 25.2362)},  --porte gauche x2 suite haut
			},
		},
		{
			textCoords = vector3(-380.8143, -413.7320, 25.2363),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = 124.9999, objCoords = vector3(-380.8143, -413.7320, 25.2363)}, --cellule 1
			},
		},
		{
			textCoords = vector3(-379.2548, -417.3041, 25.2363),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = 80.00, objCoords = vector3(-379.2548, -417.3041, 25.2363)}, --cellule 2
			},
		},
		{
			textCoords = vector3(-380.922, -421.0193, 25.2363),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = 35.000, objCoords = vector3(-380.922, -421.0193, 25.2363)}, --cellule 3
			},
		},
		{
			textCoords = vector3(-395.1109, -412.3939, 25.2363),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = -144.999, objCoords = vector3(-395.1109, -412.3939, 25.2363)}, --cellule 4
			},
		},
		{
			textCoords = vector3(-396.7779, -416.0242, 25.2363),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = -100.00, objCoords = vector3(-396.7779, -416.0242, 25.2363)}, --porte en bas escalier
			},
		},
		{
			textCoords = vector3(-395.2712, -419.5800, 25.2363),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = -55.00, objCoords = vector3(-395.2712, -419.5800, 25.2363)}, --porte blinder avant cellule
			},
		},		
		{
			textCoords = vector3(-387.5570, -411.4516, 25.2362),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = -9.999, objCoords = vector3(-387.5570, -411.4516, 25.2362)}, --porte blinder avant cellule
			},
		},	
		{
			textCoords = vector3(-393.0013, -429.2707, 25.2331),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1401135549, objHeading = -100.00, objCoords = vector3(-393.0013, -429.2707, 25.2331)}, --porte blinder avant cellule
			},
		},	
		{
			textCoords = vector3(-389.3796, -421.7886, 25.2362),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1176241902, objHeading = -9.999, objCoords = vector3(-389.3796, -421.7886, 25.2362)}, --porte blinder avant cellule
			},
		},
		{
			textCoords = vector3(-390.3044, -433.0502, 25.2331),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1401135549, objHeading = -9.999, objCoords = vector3(-390.3044, -433.0502, 25.2331)}, --porte blinder avant cellule
			},
		},
		{
			textCoords = vector3(-387.41394, -428.7487, 25.2331),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 1401135549, objHeading = -9.999, objCoords = vector3(-387.41394, -428.7487, 25.2331)}, --porte blinder avant cellule
			},
		},
		{
			textCoords = vector3(-360.7810, -382.1233, 20.3324),
			authorizedJobs = {'police'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = 2136045912, objHeading = 79.99, objCoords = vector3(-360.7810, -382.1233, 20.3324)}, --porte blinder avant cellule
			},
		},



		-- Entrée unicorn
		{
			textCoords = vector3(128.608, -1298.282, 29.24),
			authorizedJobs = {'unicorn'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -1116041313, objHeading = 30.0, objCoords = vector3(128.608, -1298.282, 29.242)},
			},
		},
		
		-- Porte unicorn 1
		{
			textCoords = vector3(113.91, -1297.12, 29.27),
			authorizedJobs = {'unicorn'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 390840000, objHeading = -60.0, objCoords = vector3(113.91, -1297.12, 29.27)},
			},
		},
		-- Porte unicorn 2
		{
			textCoords = vector3(95.21, -1285.35, 29.28),
			authorizedJobs = {'unicorn'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1695461688, objHeading = -150.0, objCoords = vector3(95.21, -1285.35, 29.28)},
			},
		},

       --tekilala

		{
			textCoords = vector3(-565.1712, 276.625, 83.28626),
			authorizedJobs = {'tequilala'},
			locked = true,
			maxDistance = 2.0, 
			doors = {
				{objHash = 993120320, objHeading = -5.0, objCoords = vector3(-565.1712, 276.625, 83.28626)},      --porte avant tekilala
			},
		},
		{
			textCoords = vector3(-561.2866, 293.504, 87.7785),
			authorizedJobs = {'tequilala'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 993120320, objHeading = 175.7110, objCoords = vector3(-561.2866, 293.504, 87.7785)},     --porte arriere
			},
		},

		-- Porte BCSO principal 1
		{
			textCoords = vector3(1815.072, 3669.684, 33.711),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -108776732, objHeading = 120.21, objCoords = vector3(1815.072, 3669.684, 33.711)},
				{objHash = 868788012, objHeading = 120.21, objCoords = vector3(1813.674, 3672.077, 33.7101)},
			},
		},

		-- Porte BCSO principal 2
		{
			textCoords = vector3(1825.1016, 3681.221, 34.705),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -1550418369, objHeading = -59.7805, objCoords = vector3(1825.1016, 3681.221, 34.705)},
				{objHash = -1550418369, objHeading = 120.219, objCoords = vector3(1824.1037, 3682.935, 34.7051)},
			},
		},

		-- Porte BCSO PRINCIPAL 3 HALL
		{
			textCoords = vector3(1829.800, 3669.699, 34.705),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -1550418369, objHeading = -59.780, objCoords = vector3(1829.800, 3669.699, 34.705)},
				{objHash = -1550418369, objHeading = 120.219, objCoords = vector3(1828.802, 3671.413, 34.7051)},
			},
		},

		-- Porte BCSO reunion
		{
			textCoords = vector3(1819.0097, 3686.4050, 34.705),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -2050014543, objHeading = 30.219, objCoords = vector3(1819.0097, 3686.4050, 34.705)},
			},
		},

		-- Porte BCSO droite celle du haut
		{
			textCoords = vector3(1822.200, 3683.554, 34.7258),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 1.5,
			doors = {
				{objHash = 1492570183, objHeading = -60.052, objCoords = vector3(1822.200, 3683.554, 34.7258)},
			},
		},

		-- Porte BCSO musculation
		{
			textCoords = vector3(1838.5637, 3673.8540, 34.70514),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -2050014543, objHeading = 30.019, objCoords = vector3(1838.5637, 3673.8540, 34.70514)},
			},
		},

		-- Porte BCSO cellule 1 droite
		{
			textCoords = vector3(1828.036, 3685.300, 29.80955),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.9805, objCoords = vector3(1828.036, 3685.300, 29.80955)},
			},
		},

		-- Porte BCSO cellule groupe
		{
			textCoords = vector3(1823.48, 3687.526, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -59.7805, objCoords = vector3(1823.48, 3687.526, 29.809)},
			},
		},
		
		--Porte cellule

		{
			textCoords = vector3(1820.352, 3692.915, 29.8095),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -59.7805, objCoords = vector3(1820.352, 3692.915, 29.8095)},
			},
		},		

		-- porte cellule

		{
			textCoords = vector3(1818.339, 3693.198, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.7805, objCoords = vector3(1818.339, 3693.198, 29.809)},
			},
		},	


		-- porte cellule

		{
			textCoords = vector3(1815.339, 3691.198, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.7805, objCoords = vector3(1815.339, 3691.198, 29.809)},
			},
		},	

		{
			textCoords = vector3(1815.339, 3691.198, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.7805, objCoords = vector3(1815.339, 3691.198, 29.809)},
			},
		},	

		{
			textCoords = vector3(1816.339, 3687.198, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = 30.7805, objCoords = vector3(1816.339, 3687.198, 29.809)},
			},
		},	


		{
			textCoords = vector3(1812.503, 3689.799, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.7805, objCoords = vector3(1812.503, 3689.799, 29.809)},
			},
		},	

		{
			textCoords = vector3(1809.586, 3688.1, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.7805, objCoords = vector3(1809.339, 3688.198, 29.809)},
			},
		},	

		{
			textCoords = vector3(1808.053, 3682.745, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = 30.7805, objCoords = vector3(1808.053, 3682.745, 29.809)},
			},
		},	

		{
			textCoords = vector3(1806.668, 3686.400, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.148, objCoords = vector3(1806.668, 3686.400, 29.809)},
			},
		},	

		{
			textCoords = vector3(1805.1362, 3681.046, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = 30.364, objCoords = vector3(1805.1362, 3681.046, 29.809)},
			},
		},	

		{
			textCoords = vector3(1803.750, 3684.701, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -149.78, objCoords = vector3(1803.750, 3684.701, 29.809)},
			},
		},	

		{
			textCoords = vector3(1802.62, 3682.20, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -59.45, objCoords = vector3(1802.62, 3682.20, 29.809)},
			},
		},

		{
			textCoords = vector3(1802.62, 3682.20, 29.809),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 1291451476, objHeading = -59.45, objCoords = vector3(1802.62, 3682.20, 29.809)},
			},
		},

		{
			textCoords = vector3(1802.62, 3682.20, 29.809), --saisie
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -546449684, objHeading = -15.036, objCoords = vector3(1802.62, 3682.20, 29.809)},
			},
		},

		{
			textCoords = vector3(1828.350, 3702.692, 34.8753),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -565696197, objHeading = 29.956, objCoords = vector3(1828.350, 3702.692, 34.8753)},
				{objHash = -565696197, objHeading = 30.482, objCoords = vector3(1830.079, 3703.699, 34.8753)},
			},
		},


		{
			textCoords = vector3(1837.176, 3691.753, 34.875),
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -565696197, objHeading = -149.780, objCoords = vector3(1837.176, 3691.753, 34.875)},
				{objHash = -565696197, objHeading = -149.780, objCoords = vector3(1835.447, 3690.746, 34.875)},
			},
		},
        
		{
			textCoords = vector3(1802.62, 3682.20, 29.809), 
			authorizedJobs = {'bcso'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -1483471451, objHeading = -15.036, objCoords = vector3(1802.62, 3682.20, 29.809)},
			},
		},

        --FBI

		{
			textCoords = vector3(2515.77, -355.76, 93.99),
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -114880996, objHeading = -136.05, objCoords = vector3(2515.77, -355.76, 93.99)},
				{objHash = -2045695986, objHeading = -136.05, objCoords = vector3(2513.91, -357.57, 93.991)},
			},
		},

		{
			textCoords = vector3(2521.94, -417.38, 93.09),
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.5,
			doors = {
				{objHash = -603547852, objHeading = -44.99, objCoords = vector3(2521.94, -417.38, 93.09)},
				{objHash = 1122723068, objHeading = -44.99, objCoords = vector3(2520.09, -415.54, 93.09)},
			},
		},

		{
			textCoords = vector3(2505.62, -426.62, 115.85), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -2023754432, objHeading = -45.00, objCoords = vector3(2505.62, -426.62, 115.85)},
			},
		},

		{
			textCoords = vector3(2507.46, -335.74, 115.74), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -2023754432, objHeading = -45.17, objCoords = vector3(2507.46, -335.74, 115.74)},
			},
		},

		--cellules

		{
			textCoords = vector3(2505.88, -348.67, 105.85), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 395979613, objHeading = 44.93, objCoords = vector3(2505.88, -348.67, 105.85)},
			},
		},

		{
			textCoords = vector3(2504.24, -350.93, 105.85), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 395979613, objHeading = 134.92, objCoords = vector3(2504.24, -350.93, 105.85)},
			},
		},

		{
			textCoords = vector3(2507.03, -353.65, 105.85), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 395979613, objHeading = 134.92, objCoords = vector3(2507.03, -353.65, 105.85)},
			},
		},

		{
			textCoords = vector3(2509.61, -351.07, 105.85), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 395979613, objHeading = 134.92, objCoords = vector3(2509.61, -351.07, 105.85)},
			},
		},

		{
			textCoords = vector3(2506.87, -348.15, 105.85), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = 395979613, objHeading = 134.92, objCoords = vector3(2506.87, -348.15, 105.85)},
			},
		},

		{
			textCoords = vector3(2574.72, -326.19, 91.92),
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 5.0,
			doors = {
				{objHash = 1185512375, objHeading = -179.99, objCoords = vector3(2574.72, -326.19, 91.92)},
				{objHash = 1185512375, objHeading = 0.00, objCoords = vector3(2560.08, -325.95, 91.92)},
			},
		},

		{
			textCoords = vector3(2491.86, -303.47, 91.99), 
			authorizedJobs = {'fib'},
			locked = true,
			maxDistance = 5.0,
			doors = {
				{objHash = 569833973, objHeading = 0.39, objCoords = vector3(2491.86, -303.47, 91.99)},
			},
		},
		{
			textCoords = vector3(-230.812, -1326.999, 30.24859), 
			authorizedJobs = {'mecano'},
			locked = true,
			maxDistance = 6.0,
			doors = {
				{objHash = -48831039, objHeading = 270.0, objCoords = vector3(-230.812, -1326.999, 30.24859)},
			},
		},
		{
			textCoords = vector3(-215.7353, -1313.286, 30.45402), 
			authorizedJobs = {'mecano'},
			locked = true,
			maxDistance = 6.0,
			doors = {
				{objHash = -1453834687, objHeading = 180.00004577637, objCoords = vector3(-215.7353, -1313.286, 30.45402)},
			},
		},
		{
			textCoords = vector3(-207.7694, -1313.286, 30.45402), 
			authorizedJobs = {'mecano'},
			locked = true,
			maxDistance = 6.0,
			doors = {
				{objHash = -1453834687, objHeading = 180.01812744141, objCoords = vector3(-207.7694, -1313.286, 30.45402)},
			},
		},
		{
			textCoords = vector3(-230.6992, -1315.146, 31.45024), 
			authorizedJobs = {'mecano'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -147325430, objHeading = 270.00003051758, objCoords = vector3(-230.6992, -1315.146, 31.45024)},
			},
		},
		{
			textCoords = vector3(-226.0601, -1322.072, 31.45024), 
			authorizedJobs = {'mecano'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -147325430, objHeading = 89.999977111816, objCoords = vector3(-226.0601, -1322.072, 31.45024)},
			},
		},
		{
			textCoords = vector3(-197.4464, -1322.071, 31.46076), 
			authorizedJobs = {'mecano'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -147325430, objHeading = 89.999977111816, objCoords = vector3(-197.4464, -1322.071, 31.46076)},
			},
		},
		{
			textCoords = vector3(-197.4464, -1339.142, 31.46076), 
			authorizedJobs = {'mecano'},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -147325430, objHeading = 89.999977111816, objCoords = vector3(-197.4464, -1339.142, 31.46076)},
			},
		},
	
	},

	Bitcoin = {
		Recolte = vector3(1273.3, -1711.9, 54.7),
		Vente = vector3(606.0, -3089.3, 5.06),
		ValueVente = 120,
	},

	Tabac = {
		Recolte = vector3(2854.18, 4597.4, 47.8),
		Traitement = vector3(2341.1, 3128.5, 48.5),
		Vente = vector3(1952.4, 3842.1, 31.17),
		ValueVente = 1050,
	},

	ConfigShop = {
		Locations = {
			[1] = {
				["shelfs"] = {
					{["x"] = 26.35, ["y"] = -1347.42, ["z"] = 28.5, ["value"] = "checkout"},
					--{["x"] = 25.67, ["y"] = -1344.99, ["z"] = 28.5, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 24.44, ["y"] = -1347.34, ["z"] = 28.5, ["h"] = 270.82
				},
			},
	
			[2] = {
				["shelfs"] = {
					{["x"] = -48.37, ["y"] = -1757.93, ["z"] = 28.42, ["value"] = "checkout"},
				--	{["x"] = -47.25, ["y"] = -1756.58, ["z"] = 28.42, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -47.38, ["y"] = -1758.7, ["z"] = 28.44, ["h"] = 48.84
				},
			},
	
			[3] = {
				["shelfs"] = {
					{["x"] = -1222.26, ["y"] = -906.86, ["z"] = 11.33, ["value"] = "checkout"},
				--	{["x"] = -1224.09, ["y"] = -908.13, ["z"] = 11.33, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -1221.47, ["y"] = -907.99, ["z"] = 11.36, ["h"] = 28.09,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[4] = {
				["shelfs"] = {
					{["x"] = -1487.62, ["y"] = -378.60, ["z"] = 39.16, ["value"] = "checkout"},
				--	{["x"] = -1486.07, ["y"] = -380.21, ["z"] = 39.16, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -1486.75, ["y"] = -377.51, ["z"] = 39.18, ["h"] = 130.0,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[5] = {
				["shelfs"] = {
					{["x"] = -707.31, ["y"] = -914.66, ["z"] = 18.22, ["value"] = "checkout"},
				--	{["x"] = -707.36, ["y"] = -912.83, ["z"] = 18.22, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -706.13, ["y"] = -914.52, ["z"] = 18.24, ["h"] = 90.0
				},
			},
	
			[6] = {
				["shelfs"] = {
					{["x"] = 1135.7, ["y"] = -982.79, ["z"] = 45.42, ["value"] = "checkout"},
				--	{["x"] = 1135.3, ["y"] = -980.55, ["z"] = 45.42, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1134.27, ["y"] = -983.16, ["z"] = 45.44, ["h"] = 280.08,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[7] = {
				["shelfs"] = {
					{["x"] = 373.55, ["y"] = 325.52, ["z"] = 102.57, ["value"] = "checkout"},
				--	{["x"] = 374.17, ["y"] = 327.92, ["z"] = 102.57, ["value"] = "diverse"},
				}, 
				["cashier"] = {
					["x"] = 372.54, ["y"] = 326.38, ["z"] = 102.59, ["h"] = 257.27
				}
			},
	
			[8] = {
				["shelfs"] = {
					{["x"] = 1163.67, ["y"] = -323.92, ["z"] = 68.21, ["value"] = "checkout"},
				--	{["x"] = 1163.33, ["y"] = -322.25, ["z"] = 68.21, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1164.85, ["y"] = -323.67, ["z"] = 68.23, ["h"] = 98.12
				},
			},
	
			[9] = {
				["shelfs"] = {
					{["x"] = 2557.44, ["y"] = 382.03, ["z"] = 107.62, ["value"] = "checkout"},
				--	{["x"] = 2555.08, ["y"] = 382.18, ["z"] = 107.64, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 2557.27, ["y"] = 380.81, ["z"] = 107.64, ["h"] = 0.0
				},
			},
	
			[10] = {
				["shelfs"] = {
					{["x"] = -3039.16, ["y"] = 585.71, ["z"] = 6.91, ["value"] = "checkout"},
				--	{["x"] = -3041.03, ["y"] = 585.11, ["z"] = 6.91, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -3038.96, ["y"] = 584.53, ["z"] = 6.93, ["h"] = 0.0
				},
			},
	
			[11] = {
				["shelfs"] = {
					{["x"] = -3242.11, ["y"] = 1001.20, ["z"] = 11.83, ["value"] = "checkout"},
				--	{["x"] = -3243.89, ["y"] = 1001.32, ["z"] = 11.84, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -3242.24, ["y"] = 1000.0, ["z"] = 11.85, ["h"] = 353.5
				},
			},
	
			[12] = {
				["shelfs"] = {
					{["x"] = -2967.78, ["y"] = 391.49, ["z"] = 14.04, ["value"] = "checkout"},
				--	{["x"] = -2967.87, ["y"] = 389.3, ["z"] = 14.04, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -2966.38, ["y"] = 391.44, ["z"] = 14.06, ["h"] = 91.62,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[13] = {
				["shelfs"] = {
					{["x"] = -1820.38, ["y"] = 792.69, ["z"] = 137.11, ["value"] = "checkout"},
				--	{["x"] = -1821.55, ["y"] = 793.97, ["z"] = 137.12, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = -1819.53, ["y"] = 793.55, ["z"] = 137.11, ["h"] = 129.05,
				},
			},
	
			[14] = {
				["shelfs"] = {
					{["x"] = 547.75, ["y"] = 2671.53, ["z"] = 41.16, ["value"] = "checkout"},
				--	{["x"] = 548.08, ["y"] = 2669.36, ["z"] = 41.16, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 549.04, ["y"] = 2671.36, ["z"] = 41.18, ["h"] = 98.25
				},
			},
	
			[15] = {
				["shelfs"] = {
					{["x"] = 1165.36, ["y"] = 2709.45, ["z"] = 39.16, ["value"] = "checkout"},
				--	{["x"] = 1167.64, ["y"] = 2709.41, ["z"] = 39.16, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1165.29, ["y"] = 2710.79, ["z"] = 37.18, ["h"] = 176.18,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[16] = {
				["shelfs"] = {
					{["x"] = 2678.82, ["y"] = 3280.36, ["z"] = 54.24, ["value"] = "checkout"},
				--	{["x"] = 2676.91, ["y"] = 3281.38, ["z"] = 54.24, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 2678.1, ["y"] = 3279.4, ["z"] = 54.26, ["h"] = 331.07
				},
			},
	
			[17] = {
				["shelfs"] = {
					{["x"] = 1961.17, ["y"] = 3740.5, ["z"] = 31.34, ["value"] = "checkout"},
				--	{["x"] = 1960.18, ["y"] = 3742.21, ["z"] = 31.36, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1960.13, ["y"] = 3739.94, ["z"] = 31.36, ["h"] = 297.89
				},
			},
	
			[18] = {
				["shelfs"] = {
					{["x"] = 1393.13, ["y"] = 3605.2, ["z"] = 33.98, ["value"] = "checkout"},
					--{["x"] = 1390.93, ["y"] = 3604.4, ["z"] = 34.0, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1392.74, ["y"] = 3606.35, ["z"] = 34.0, ["h"] = 202.73,
					["hash"] = "s_m_m_linecook"
				},
			},
	
			[19] = {
				["shelfs"] = {
					{["x"] = 1697.92, ["y"] = 4924.46, ["z"] = 41.06, ["value"] = "checkout"},
				--	{["x"] = 1699.44, ["y"] = 4923.41, ["z"] = 41.06, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1697.3, ["y"] = 4923.47, ["z"] = 41.08, ["h"] = 323.98
				},
			},
	
			[20] = {
				["shelfs"] = {
					{["x"] = 1728.78, ["y"] = 6414.41, ["z"] = 34.04, ["value"] = "checkout"},
				--	{["x"] = 1729.82, ["y"] = 6416.42, ["z"] = 34.04, ["value"] = "diverse"},
				},
				["cashier"] = {
					["x"] = 1727.87, ["y"] = 6415.25, ["z"] = 34.06, ["h"] = 242.93
				},
			},
	
			[21] = {
				["shelfs"] = {
					{["x"] = 240.74, ["y"] = -899.16, ["z"] = 29.62, ["value"] = "diverse"},
				--	{["x"] = 240.74, ["y"] = -899.16, ["z"] = 29.62, ["value"] = "checkout"},
				},
				["cashier"] = {
					["x"] = 240.74, ["y"] = -889.16, ["z"] = 29.62, ["h"] = 340.47
				},
			},
		},
	
		Locales = {
			["checkout"] = "Caisse",
			["diverse"] = "Magasin",
		},
	
		Items = {
			["diverse"] = {
				{label = "Bouteille d'eau", item = "water", price = 6},
				{label = "Pain", item = "bread", price = 6},
				{label = "Téléphone", item = "phone", price = 200},
				{label = "Sac à vetement", item = "kq_outfitbag", price = 250},
			},
		},
	},

	Jobs = {
		police = {
			Blips = {
				{coords = vector3(-1076.67, -846.59, 4.88)}
			},
			Bureau = {
				{Bureau = vector3(461.0319, -981.5652, 30.1728)}
			},
			Plainte = {
				{Plainte = vector3(442.8650, -981.9692, 31.77)}
			},
			RangerVehicule = {
				{pos = vector3(454.7614, -985.3875, 23.94)}
			},
			Peds = {
				{ped = {"s_m_y_cop_01", vector3(444.0211, -982.1193, 31.77-1), 91.42}},
				{ped = {"s_m_y_cop_01", vector3(454.0694, -962.2818, 23.94-1), 178.14}},
				{ped = {"s_m_y_cop_01", vector3(470.7007, -972.1476, 23.93-1), 359.66}},
			},
			Amende = {
				["amende"] = {
					{label = 'Usage abusif du klaxon', price = 1500},
					{label = 'Franchir une ligne continue', price = 1500},
					{label = 'Circulation à contresens', price = 1500},
					{label = 'Demi-tour non autorisé', price = 1500},
					{label = 'Circulation hors-route', price = 1500},
					{label = 'Non-respect des distances de sécurité', price = 1500},
					{label = 'Arrêt dangereux / interdit', price = 1500},
					{label = 'Stationnement gênant / interdit', price = 1500},
					{label = 'Non respect  de la priorité à droite', price = 1500},
					{label = 'Non-respect à un véhicule prioritaire', price = 1500},
					{label = 'Non-respect d\'un stop', price = 1500},
					{label = 'Non-respect d\'un feu rouge', price = 1500},
					{label = 'Dépassement dangereux', price = 1500},
					{label = 'Véhicule non en état', price = 1500},
					{label = 'Conduite sans permis', price = 1500},
					{label = 'Délit de fuite', price = 1500},
					{label = 'Excès de vitesse < 5 kmh', price = 1500},
					{label = 'Excès de vitesse 5-15 kmh', price = 1500},
					{label = 'Excès de vitesse 15-30 kmh', price = 1500},
					{label = 'Excès de vitesse > 30 kmh', price = 1500},
					{label = 'Entrave de la circulation', price = 1500},
					{label = 'Dégradation de la voie publique', price = 1500},
					{label = 'Trouble à l\'ordre publique', price = 1500},
					{label = 'Entrave opération de police', price = 1500},
					{label = 'Insulte envers / entre civils', price = 1500},
					{label = 'Outrage à agent de police', price = 1500},
					{label = 'Menace verbale ou intimidation envers civil', price = 1500},
					{label = 'Menace verbale ou intimidation envers policier', price = 1500},
					{label = 'Manifestation illégale', price = 1500},
					{label = 'Tentative de corruption', price = 1500},
					{label = 'Arme blanche sortie en ville', price = 1500},
					{label = 'Arme léthale sortie en ville', price = 1500},
					{label = 'Port d\'arme non autorisé (défaut de license)', price = 1500},
					{label = 'Port d\'arme illégal', price = 1500},
					{label = 'Pris en flag lockpick', price = 1500},
					{label = 'Vol de voiture', price = 1500},
					{label = 'Vente de drogue', price = 1500},
					{label = 'Fabriquation de drogue', price = 1500},
					{label = 'Possession de drogue', price = 1500},
					{label = 'Prise d\'ôtage civil', price = 1500},
					{label = 'Prise d\'ôtage agent de l\'état', price = 1500},
					{label = 'Braquage particulier', price = 1500},
					{label = 'Braquage magasin', price = 1500},
					{label = 'Braquage de banque', price = 1500},
					{label = 'Tir sur civil', price = 1500},
					{label = 'Tir sur agent de l\'état', price = 1500},
					{label = 'Tentative de meurtre sur civil', price = 1500},
					{label = 'Tentative de meurtre sur agent de l\'état', price = 1500},
					{label = 'Meurtre sur civil', price = 1500},
					{label = 'Meurte sur agent de l\'état', price = 1500}, 
					{label = 'Escroquerie à l\'entreprise', price = 1500},
				}
			},
			Zones = {
				{
					Armurerie = vector3(470.4133, -971.1838, 23.93),
					Vestiaire = vector3(452.1750, -997.4988, 31.70),
					PosGarage = vector3(454.1903, -963.3016, 23.94),
				},
			},
			Uniforms = {
				recruit_wear = {
					male = {
								['tshirt_1'] = 90, ['tshirt_2'] = 0,
								['torso_1'] = 312, ['torso_2'] = 0,
								['decals_1'] = 0, ['decals_2'] = 0,
								['arms'] = 5,
								['pants_1'] = 137, ['pants_2'] = 0,
								['shoes_1'] = 120, ['shoes_2'] = 1,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['mask_1'] = 0, ['mask_2'] = 0,
								['bag_1'] = 72, ['bag_2'] = 1,
								['chain_1'] = 9, ['chain_2'] = 0,
								['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
								['tshirt_1'] = 302, ['tshirt_2'] = 0,
								['torso_1'] = 441, ['torso_2'] = 0,
								['decals_1'] = 191, ['decals_2'] = 0,
								['arms'] = 11,
								['pants_1'] = 197, ['pants_2'] = 0,
								['shoes_1'] = 85, ['shoes_2'] = 0,
								['helmet_1'] = -1, ['helmet_2'] = 0,
								['glasses_1'] = -1, ['glasses_2'] = 0,
								['mask_1'] = -1, ['mask_2'] = 0,
								['bag_1'] = 59, ['bag_2'] = 0,
								['chain_1'] = 0, ['chain_2'] = 0,
								['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				officer_wear = {
					male = {
						['tshirt_1'] = 91, ['tshirt_2'] = 0,
						['torso_1'] = 430, ['torso_2'] = 0,
						['decals_1'] = 20, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 136, ['pants_2'] = 0,
						['shoes_1'] = 119, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 146, ['mask_2'] = 0,
						['bag_1'] = 72, ['bag_2'] = 0,
						['chain_1'] = 8, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
			},
			female = {
				['tshirt_1'] = 302, ['tshirt_2'] = 0,
				['torso_1'] = 441, ['torso_2'] = 0,
				['decals_1'] = 191, ['decals_2'] = 0,
				['arms'] = 11,
				['pants_1'] = 197, ['pants_2'] = 0,
				['shoes_1'] = 85, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
				['glasses_1'] = -1, ['glasses_2'] = 0,
				['mask_1'] = -1, ['mask_2'] = 0,
				['bag_1'] = 59, ['bag_2'] = 0,
				['chain_1'] = 0, ['chain_2'] = 0,
				['ears_1'] = -1, ['ears_2'] = 0,
			},
				},
				sergeant_wear = {
					male = {
						['tshirt_1'] = 91, ['tshirt_2'] = 0,
						['torso_1'] = 430, ['torso_2'] = 0,
						['decals_1'] = 20, ['decals_2'] = 2,
						['arms'] = 11,
						['pants_1'] = 136, ['pants_2'] = 0,
						['shoes_1'] = 119, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 146, ['mask_2'] = 0,
						['bag_1'] = 72, ['bag_2'] = 0,
						['chain_1'] = 8, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
			},
			female = {
				['tshirt_1'] = 302, ['tshirt_2'] = 0,
				['torso_1'] = 441, ['torso_2'] = 0,
				['decals_1'] = 191, ['decals_2'] = 0,
				['arms'] = 11,
				['pants_1'] = 197, ['pants_2'] = 0,
				['shoes_1'] = 85, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
				['glasses_1'] = -1, ['glasses_2'] = 0,
				['mask_1'] = -1, ['mask_2'] = 0,
				['bag_1'] = 59, ['bag_2'] = 0,
				['chain_1'] = 0, ['chain_2'] = 0,
				['ears_1'] = -1, ['ears_2'] = 0,
			},
				},
				sergeantchief_wear = {
					male = {
						['tshirt_1'] = 91, ['tshirt_2'] = 0,
						['torso_1'] = 430, ['torso_2'] = 0,
						['decals_1'] = 20, ['decals_2'] = 3,
						['arms'] = 11,
						['pants_1'] = 136, ['pants_2'] = 0,
						['shoes_1'] = 119, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 146, ['mask_2'] = 0,
						['bag_1'] = 72, ['bag_2'] = 0,
						['chain_1'] = 8, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
			},
			female = {
				['tshirt_1'] = 302, ['tshirt_2'] = 0,
				['torso_1'] = 441, ['torso_2'] = 0,
				['decals_1'] = 191, ['decals_2'] = 0,
				['arms'] = 11,
				['pants_1'] = 197, ['pants_2'] = 0,
				['shoes_1'] = 85, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
				['glasses_1'] = -1, ['glasses_2'] = 0,
				['mask_1'] = -1, ['mask_2'] = 0,
				['bag_1'] = 59, ['bag_2'] = 0,
				['chain_1'] = 0, ['chain_2'] = 0,
				['ears_1'] = -1, ['ears_2'] = 0,
			},
				},
				intendent_wear = {
					male = {
						['tshirt_1'] = 91, ['tshirt_2'] = 0,
						['torso_1'] = 430, ['torso_2'] = 0,
						['decals_1'] = 49, ['decals_2'] = 0,
						['arms'] = 11,
						['pants_1'] = 136, ['pants_2'] = 0,
						['shoes_1'] = 119, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 146, ['mask_2'] = 0,
						['bag_1'] = 72, ['bag_2'] = 0,
						['chain_1'] = 8, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
			},
			female = {
				['tshirt_1'] = 302, ['tshirt_2'] = 0,
				['torso_1'] = 441, ['torso_2'] = 0,
				['decals_1'] = 191, ['decals_2'] = 0,
				['arms'] = 11,
				['pants_1'] = 197, ['pants_2'] = 0,
				['shoes_1'] = 85, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
				['glasses_1'] = -1, ['glasses_2'] = 0,
				['mask_1'] = -1, ['mask_2'] = 0,
				['bag_1'] = 59, ['bag_2'] = 0,
				['chain_1'] = 0, ['chain_2'] = 0,
				['ears_1'] = -1, ['ears_2'] = 0,
			},
				},
				lieutenant_wear = { -- currently the same as intendent_wear
				male = {
					['tshirt_1'] = 91, ['tshirt_2'] = 0,
					['torso_1'] = 430, ['torso_2'] = 0,
					['decals_1'] = 49, ['decals_2'] = 0,
					['arms'] = 11,
					['pants_1'] = 136, ['pants_2'] = 0,
					['shoes_1'] = 119, ['shoes_2'] = 1,
					['helmet_1'] = -1, ['helmet_2'] = 0,
					['mask_1'] = 146, ['mask_2'] = 0,
					['bag_1'] = 72, ['bag_2'] = 0,
					['chain_1'] = 8, ['chain_2'] = 0,
					['ears_1'] = -1, ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 302, ['tshirt_2'] = 0,
			['torso_1'] = 441, ['torso_2'] = 0,
			['decals_1'] = 191, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 197, ['pants_2'] = 0,
			['shoes_1'] = 85, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['glasses_1'] = -1, ['glasses_2'] = 0,
			['mask_1'] = -1, ['mask_2'] = 0,
			['bag_1'] = 59, ['bag_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = -1, ['ears_2'] = 0,
		},
				},
				chef_wear = {
					male = {
						['tshirt_1'] = 91, ['tshirt_2'] = 0,
						['torso_1'] = 430, ['torso_2'] = 0,
						['decals_1'] = 49, ['decals_2'] = 5,
						['arms'] = 11,
						['pants_1'] = 136, ['pants_2'] = 0,
						['shoes_1'] = 119, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = 146, ['mask_2'] = 0,
						['bag_1'] = 72, ['bag_2'] = 0,
						['chain_1'] = 8, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
			},
			female = {
				['tshirt_1'] = 302, ['tshirt_2'] = 0,
				['torso_1'] = 441, ['torso_2'] = 0,
				['decals_1'] = 191, ['decals_2'] = 0,
				['arms'] = 11,
				['pants_1'] = 197, ['pants_2'] = 0,
				['shoes_1'] = 85, ['shoes_2'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
				['glasses_1'] = -1, ['glasses_2'] = 0,
				['mask_1'] = -1, ['mask_2'] = 0,
				['bag_1'] = 59, ['bag_2'] = 0,
				['chain_1'] = 0, ['chain_2'] = 0,
				['ears_1'] = -1, ['ears_2'] = 0,
			},
				},
				boss_wear = { -- currently the same as chef_wear
				male = {
					['tshirt_1'] = 91, ['tshirt_2'] = 0,
					['torso_1'] = 430, ['torso_2'] = 0,
					['decals_1'] = 49, ['decals_2'] = 5,
					['arms'] = 11,
					['pants_1'] = 136, ['pants_2'] = 0,
					['shoes_1'] = 119, ['shoes_2'] = 1,
					['helmet_1'] = -1, ['helmet_2'] = 0,
					['mask_1'] = 146, ['mask_2'] = 0,
					['bag_1'] = 72, ['bag_2'] = 0,
					['chain_1'] = 8, ['chain_2'] = 0,
					['ears_1'] = -1, ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 302, ['tshirt_2'] = 0,
			['torso_1'] = 441, ['torso_2'] = 0,
			['decals_1'] = 191, ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 197, ['pants_2'] = 0,
			['shoes_1'] = 85, ['shoes_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			['glasses_1'] = -1, ['glasses_2'] = 0,
			['mask_1'] = -1, ['mask_2'] = 0,
			['bag_1'] = 59, ['bag_2'] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
			['ears_1'] = -1, ['ears_2'] = 0,
		},	},
				bullet_wear = {
					male = {
						['bproof_1'] = 44,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 16,  ['bproof_2'] = 0
					}
				},
				gilet_wear = {
					male = {
						['bproof_1'] = 44,  ['bproof_2'] = 0,
					},
					female = {
						['bproof_1'] = 16,  ['bproof_2'] = 0
					}
				},
				civil_wear = {
					male = {
						['chain_1'] = 44, ['chain_2'] = 0
					},
					female = {
						['chain_1'] = 16, ['chain_2'] = 0
					}
				},
			},

		},
		Bsco = {
			Plainte = {
				{Plainte = vector3(11817.03, 3672.35, 34.71)}
			},
			RangerVehicule = {
				{pos = vector3(1866.859, 3694.811, 33.97443)}
			},
			Peds = {
				{ped = {"s_m_y_sheriff_01", vector3(1818.734, 3673.855, 33.71232), 121.95436096191}},
			},
			Amende = {
				["amende"] = {
					{label = 'Usage abusif du klaxon', price = 1500},
					{label = 'Franchir une ligne continue', price = 1500},
					{label = 'Circulation à contresens', price = 1500},
					{label = 'Demi-tour non autorisé', price = 1500},
					{label = 'Circulation hors-route', price = 1500},
					{label = 'Non-respect des distances de sécurité', price = 1500},
					{label = 'Arrêt dangereux / interdit', price = 1500},
					{label = 'Stationnement gênant / interdit', price = 1500},
					{label = 'Non respect  de la priorité à droite', price = 1500},
					{label = 'Non-respect à un véhicule prioritaire', price = 1500},
					{label = 'Non-respect d\'un stop', price = 1500},
					{label = 'Non-respect d\'un feu rouge', price = 1500},
					{label = 'Dépassement dangereux', price = 1500},
					{label = 'Véhicule non en état', price = 1500},
					{label = 'Conduite sans permis', price = 1500},
					{label = 'Délit de fuite', price = 1500},
					{label = 'Excès de vitesse < 5 kmh', price = 1500},
					{label = 'Excès de vitesse 5-15 kmh', price = 1500},
					{label = 'Excès de vitesse 15-30 kmh', price = 1500},
					{label = 'Excès de vitesse > 30 kmh', price = 1500},
					{label = 'Entrave de la circulation', price = 1500},
					{label = 'Dégradation de la voie publique', price = 1500},
					{label = 'Trouble à l\'ordre publique', price = 1500},
					{label = 'Entrave opération de police', price = 1500},
					{label = 'Insulte envers / entre civils', price = 1500},
					{label = 'Outrage à agent de police', price = 1500},
					{label = 'Menace verbale ou intimidation envers civil', price = 1500},
					{label = 'Menace verbale ou intimidation envers policier', price = 1500},
					{label = 'Manifestation illégale', price = 1500},
					{label = 'Tentative de corruption', price = 1500},
					{label = 'Arme blanche sortie en ville', price = 1500},
					{label = 'Arme léthale sortie en ville', price = 1500},
					{label = 'Port d\'arme non autorisé (défaut de license)', price = 1500},
					{label = 'Port d\'arme illégal', price = 1500},
					{label = 'Pris en flag lockpick', price = 1500},
					{label = 'Vol de voiture', price = 1500},
					{label = 'Vente de drogue', price = 1500},
					{label = 'Fabriquation de drogue', price = 1500},
					{label = 'Possession de drogue', price = 1500},
					{label = 'Prise d\'ôtage civil', price = 1500},
					{label = 'Prise d\'ôtage agent de l\'état', price = 1500},
					{label = 'Braquage particulier', price = 1500},
					{label = 'Braquage magasin', price = 1500},
					{label = 'Braquage de banque', price = 1500},
					{label = 'Tir sur civil', price = 1500},
					{label = 'Tir sur agent de l\'état', price = 1500},
					{label = 'Tentative de meurtre sur civil', price = 1500},
					{label = 'Tentative de meurtre sur agent de l\'état', price = 1500},
					{label = 'Meurtre sur civil', price = 1500},
					{label = 'Meurte sur agent de l\'état', price = 1500}, 
					{label = 'Escroquerie à l\'entreprise', price = 1500},
				}
			},
			Zones2 = {
				{
					Armurerie2 = vector3(1818.236, 3665.625, 30.31),
					Vestiaire2 = vector3(1828.96,3674.37,34.71),
					PosGarage2 = vector3(1839.11,3684.47,34.10),
				},
			},
			Uniforms = {
				recruit_wear = {
					male = {
						['tshirt_1'] = 156, ['tshirt_2'] = 1,
						['torso_1'] = 308, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 23,
						['pants_1'] = 189, ['pants_2'] = 7,
						['shoes_1'] = 120, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 61, ['bag_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 307, ['torso_2'] = 1,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 1,
						['pants_1'] = 47, ['pants_2'] = 0,
						['shoes_1'] = 38, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 96, ['bag_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				officer_wear = {
					male = {
						['tshirt_1'] = 156, ['tshirt_2'] = 1,
						['torso_1'] = 308, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 23,
						['pants_1'] = 189, ['pants_2'] = 7,
						['shoes_1'] = 120, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 61, ['bag_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 307, ['torso_2'] = 1,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 1,
						['pants_1'] = 47, ['pants_2'] = 0,
						['shoes_1'] = 38, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 96, ['bag_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				sergeant_wear = {
					male = {
						['tshirt_1'] = 156, ['tshirt_2'] = 1,
						['torso_1'] = 308, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 23,
						['pants_1'] = 189, ['pants_2'] = 7,
						['shoes_1'] = 120, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 61, ['bag_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 307, ['torso_2'] = 1,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 1,
						['pants_1'] = 47, ['pants_2'] = 0,
						['shoes_1'] = 38, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 96, ['bag_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				sergeantchief_wear = {
					male = {
						['tshirt_1'] = 156, ['tshirt_2'] = 1,
						['torso_1'] = 308, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 23,
						['pants_1'] = 189, ['pants_2'] = 7,
						['shoes_1'] = 120, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 61, ['bag_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 307, ['torso_2'] = 1,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 1,
						['pants_1'] = 47, ['pants_2'] = 0,
						['shoes_1'] = 38, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 96, ['bag_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				intendent_wear = {
					male = {
						['tshirt_1'] = 156, ['tshirt_2'] = 1,
						['torso_1'] = 308, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 23,
						['pants_1'] = 189, ['pants_2'] = 7,
						['shoes_1'] = 120, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 61, ['bag_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 307, ['torso_2'] = 1,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 1,
						['pants_1'] = 47, ['pants_2'] = 0,
						['shoes_1'] = 38, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 96, ['bag_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				lieutenant_wear = {
					male = {
						['tshirt_1'] = 156, ['tshirt_2'] = 1,
						['torso_1'] = 308, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 23,
						['pants_1'] = 189, ['pants_2'] = 7,
						['shoes_1'] = 120, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 61, ['bag_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 307, ['torso_2'] = 1,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 1,
						['pants_1'] = 47, ['pants_2'] = 0,
						['shoes_1'] = 38, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 96, ['bag_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				chef_wear = {
					male = {
						['tshirt_1'] = 156, ['tshirt_2'] = 1,
						['torso_1'] = 308, ['torso_2'] = 3,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 23,
						['pants_1'] = 189, ['pants_2'] = 7,
						['shoes_1'] = 120, ['shoes_2'] = 1,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 61, ['bag_2'] = 0,
						['chain_1'] = 0, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
					female = {
						['tshirt_1'] = 14, ['tshirt_2'] = 0,
						['torso_1'] = 307, ['torso_2'] = 1,
						['decals_1'] = 0, ['decals_2'] = 0,
						['arms'] = 1,
						['pants_1'] = 47, ['pants_2'] = 0,
						['shoes_1'] = 38, ['shoes_2'] = 0,
						['helmet_1'] = -1, ['helmet_2'] = 0,
						['glasses_1'] = -1, ['glasses_2'] = 0,
						['mask_1'] = -1, ['mask_2'] = 0,
						['bag_1'] = 96, ['bag_2'] = 0,
						['chain_1'] = -1, ['chain_2'] = 0,
						['ears_1'] = -1, ['ears_2'] = 0,
					},
				},
				boss_wear = { -- currently the same as chef_wear
				male = {
					['tshirt_1'] = 156, ['tshirt_2'] = 1,
					['torso_1'] = 308, ['torso_2'] = 3,
					['decals_1'] = 0, ['decals_2'] = 0,
					['arms'] = 23,
					['pants_1'] = 189, ['pants_2'] = 7,
					['shoes_1'] = 120, ['shoes_2'] = 1,
					['helmet_1'] = -1, ['helmet_2'] = 0,
					['mask_1'] = -1, ['mask_2'] = 0,
					['bag_1'] = 61, ['bag_2'] = 0,
					['chain_1'] = 0, ['chain_2'] = 0,
					['ears_1'] = -1, ['ears_2'] = 0,
				},
				female = {
					['tshirt_1'] = 14, ['tshirt_2'] = 0,
					['torso_1'] = 307, ['torso_2'] = 1,
					['decals_1'] = 0, ['decals_2'] = 0,
					['arms'] = 1,
					['pants_1'] = 47, ['pants_2'] = 0,
					['shoes_1'] = 38, ['shoes_2'] = 0,
					['helmet_1'] = -1, ['helmet_2'] = 0,
					['glasses_1'] = -1, ['glasses_2'] = 0,
					['mask_1'] = -1, ['mask_2'] = 0,
					['bag_1'] = 96, ['bag_2'] = 0,
					['chain_1'] = -1, ['chain_2'] = 0,
					['ears_1'] = -1, ['ears_2'] = 0,
				},
			},
				bullet_wear = {
				male = {
					['bproof_1'] = 50,  ['bproof_2'] = 3,
				},
				female = {
					['bproof_1'] = 16,  ['bproof_2'] = 0
				}
			},
				gilet_wear = {
				male = {
					['bproof_1'] = 50,  ['bproof_2'] = 3,
				},
				female = {
					['bproof_1'] = 16,  ['bproof_2'] = 0
				}
			},
				civil_wear = {
					male = {
						['chain_1'] =50, ['chain_2'] = 3
					},
					female = {
						['chain_1'] = 95, ['chain_2'] = 0
					}
				},
			},
		},
		Ambulance = {
			Blips = {
				{coords = vector3(-1839.18, -382.30, 49.39)},
			},
			Gestion = {
				{gestion = vector3(-1851.27, -334.99, 49.45)},
			},
			Pharma = {
				{pharma = vector3(-1839.18, -382.30, 49.39)},
			},
			Clothes = {
				{clothes = vector3(-1813.88, -357.25, 49.46)},
			},
			Vehicle = {
				{vehicle = vector3(-1850.90, -316.54, 49.14)},
			},
			DeleteVeh = {
				{deleteveh = vector3(-1858.63, -308.79, 49.14)},
			},
			Uniforms = {


				stagiaire_wear = { -- currently the same as chef_wear
                male = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                    ['torso_1'] = 404, ['torso_2'] = 0,
                    ['arms'] = 94,
                    ['pants_1'] = 150, ['pants_2'] = 2,
                    ['shoes_1'] = 203, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = 0, ["decals_2"] = 0,
                    ['chain_1'] = 140, ['chain_2'] = 0,
                },
                female = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 14, ['tshirt_2'] = 0,
                    ['torso_1'] = 341, ['torso_2'] = 0,
                    ['arms'] = 119,
                    ['pants_1'] = 210, ['pants_2'] = 3,
                    ['shoes_1'] = 31, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = 0, ["decals_2"] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                }
				},

				ambulance_wear = { -- currently the same as chef_wear
                male = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                    ['torso_1'] = 404, ['torso_2'] = 0,
                    ['arms'] = 94,
                    ['pants_1'] = 150, ['pants_2'] = 2,
                    ['shoes_1'] = 203, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = 0, ["decals_2"] = 0,
                    ['chain_1'] = 140, ['chain_2'] = 0,
                },
                female = {
                    ['bags_1'] = 0, ['bags_2'] = 0,
                    ['tshirt_1'] = 14, ['tshirt_2'] = 0,
                    ['torso_1'] = 341, ['torso_2'] = 0,
                    ['arms'] = 119,
                    ['pants_1'] = 210, ['pants_2'] = 3,
                    ['shoes_1'] = 31, ['shoes_2'] = 0,
                    ['mask_1'] = 0, ['mask_2'] = 0,
                    ['bproof_1'] = 0,
                    ['helmet_1'] = -1, ['helmet_2'] = 0,
                    ["decals_1"] = 0, ["decals_2"] = 0,
                    ['chain_1'] = 0, ['chain_2'] = 0,
                }
			},

			infirmier_wear = { -- currently the same as chef_wear
			male = {
				['bags_1'] = 0, ['bags_2'] = 0,
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 404, ['torso_2'] = 0,
				['arms'] = 94,
				['pants_1'] = 150, ['pants_2'] = 2,
				['shoes_1'] = 203, ['shoes_2'] = 0,
				['mask_1'] = 0, ['mask_2'] = 0,
				['bproof_1'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
				["decals_1"] = 0, ["decals_2"] = 0,
				['chain_1'] = 140, ['chain_2'] = 0,
			},
			female = {
				['bags_1'] = 0, ['bags_2'] = 0,
				['tshirt_1'] = 14, ['tshirt_2'] = 0,
				['torso_1'] = 341, ['torso_2'] = 0,
				['arms'] = 119,
				['pants_1'] = 210, ['pants_2'] = 3,
				['shoes_1'] = 31, ['shoes_2'] = 0,
				['mask_1'] = 0, ['mask_2'] = 0,
				['bproof_1'] = 0,
				['helmet_1'] = -1, ['helmet_2'] = 0,
				["decals_1"] = 0, ["decals_2"] = 0,
				['chain_1'] = 0, ['chain_2'] = 0,
			}
		},

		chirurgien_wear = { -- currently the same as chef_wear
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 404, ['torso_2'] = 0,
			['arms'] = 94,
			['pants_1'] = 150, ['pants_2'] = 2,
			['shoes_1'] = 203, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = 0, ["decals_2"] = 0,
			['chain_1'] = 140, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 14, ['tshirt_2'] = 0,
			['torso_1'] = 341, ['torso_2'] = 0,
			['arms'] = 119,
			['pants_1'] = 210, ['pants_2'] = 3,
			['shoes_1'] = 31, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = 0, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},

		chefs_wear = { -- currently the same as chef_wear
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 404, ['torso_2'] = 0,
			['arms'] = 94,
			['pants_1'] = 150, ['pants_2'] = 2,
			['shoes_1'] = 203, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = 0, ["decals_2"] = 0,
			['chain_1'] = 140, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 14, ['tshirt_2'] = 0,
			['torso_1'] = 341, ['torso_2'] = 0,
			['arms'] = 119,
			['pants_1'] = 210, ['pants_2'] = 3,
			['shoes_1'] = 31, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = 0, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		}
	},
},	
},
},

Taxi = {
	Clothes = {
		{clothes = vector3(-1606.85, -839.30, 10.27)},
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 234, ['torso_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 24, ['pants_2'] = 0,
			['shoes_1'] = 21, ['shoes_2'] = 1,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 392, ['tshirt_2'] = 0,
			['torso_1'] = 60, ['torso_2'] = 1,
			['arms'] = 0,
			['pants_1'] = 39, ['pants_2'] = 0,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},

Bahamas2 = {
	Service = {
		position = vector3(-1382.6242675781, -637.13208007812, 30.319952011108),
	},
	Garage = {
		position = vector3(-1392.1667480469, -584.10235595703, 30.234889984131),
		vehicles = {
			{model = 'stretch', label = 'Stretch'},
		}
	},
	Bar = {
		position = vector3(-1400.6706542969, -601.498046875, 30.319969177246),
		items = {
			{label = "Vin", item = "vine", price = 20},
			{label = "Mojito", item = "mojito", price = 10},
			{label = "Ice Tea", item = "icetea", price = 8},
			{label = "Whisky-coca", item = "wiskycoca", price = 12},
			{label = "Coca", item = "coca", price = 6},
			{label = "Eau", item = "water", price = 7},
			{label = "Limonade", item = "limonade", price = 7},
			{label = "Fanta", item = "fanta", price = 10},
			{label = "Chips", item = "chips", price = 2},
			{label = "Cacahuètes", item = "cacahuete", price = 1},
			{label = "Olive", item = "olive", price = 1},
		}
	},
},

Malibu = {
	Service = {
		position = vector3(-802.05706787109, -1225.2087402344, 11.39234828949),
	},
	Garage = {
		position = vector3(-839.65112304688, -1221.9150390625, 6.8956327438354),
		vehicles = {
			{model = 'stretch', label = 'Stretch'},
		}
	},
	Bar = {
		position = vector3(-801.76971435547, -1224.0617675781, 7.572772026062),
		items = {
			{label = "Vin", item = "vine", price = 20},
			{label = "Mojito", item = "mojito", price = 10},
			{label = "Ice Tea", item = "icetea", price = 8},
			{label = "Whisky-coca", item = "wiskycoca", price = 12},
			{label = "Coca", item = "coca", price = 6},
			{label = "Eau", item = "water", price = 7},
			{label = "Limonade", item = "limonade", price = 7},
			{label = "Fanta", item = "fanta", price = 10},
			{label = "Chips", item = "chips", price = 2},
			{label = "Cacahuètes", item = "cacahuete", price = 1},
			{label = "Olive", item = "olive", price = 1},
		}
	},
},


Burgershot = {
	Clothes = {
		{clothes = vector3(-1196.84, -901.89, 13.88)},
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 271, ['tshirt_2'] = 0,
			['torso_1'] = 66, ['torso_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 39, ['pants_2'] = 0,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 392, ['tshirt_2'] = 0,
			['torso_1'] = 60, ['torso_2'] = 1,
			['arms'] = 0,
			['pants_1'] = 39, ['pants_2'] = 0,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},

LsCustom = {

	Clothes = {
		{clothes = vector3(-350.2326, -123.6819, 39.05)},
	},
	ShopMec = {
		{shopmec = vector3(-330.6211, -108.1713, 39.0097)} 
	},
	
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 122, ['tshirt_2'] = 0,
			['torso_1'] = 474, ['torso_2'] = 0,
			['arms'] =  182, ['arms2'] = 0,
			['pants_1'] = 235, ['pants_2'] = 0,
			['shoes_1'] = 204, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 392, ['tshirt_2'] = 0,
			['torso_1'] = 60, ['torso_2'] = 0,
			['arms'] = 3,
			['pants_1'] = 39, ['pants_2'] = 0,
			['shoes_1'] = 25, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},

LTDSudJob = {
	Clothes = {
		{clothes = vector3(243.54, -906.15, 29.62)},
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 133, ['torso_2'] = 2,
			['arms'] = 19,
			['pants_1'] = 49, ['pants_2'] = 1,
			['shoes_1'] = 36, ['shoes_2'] = 3,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 85, ['bproof_2'] = 8,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 393, ['tshirt_2'] = 0,
			['torso_1'] = 49, ['torso_2'] = 1,
			['arms'] = 14,
			['pants_1'] = 332, ['pants_2'] = 2,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},


LabelJob = {
	Clothes = {
		{clothes = vector3(476.88, -94.82, 63.16)},
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 133, ['torso_2'] = 2,
			['arms'] = 19,
			['pants_1'] = 49, ['pants_2'] = 1,
			['shoes_1'] = 36, ['shoes_2'] = 3,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 85, ['bproof_2'] = 8,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 393, ['tshirt_2'] = 0,
			['torso_1'] = 49, ['torso_2'] = 1,
			['arms'] = 14,
			['pants_1'] = 332, ['pants_2'] = 2,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},

AvocatJob = {
	Clothes = {
		{clothes = vector3(-1753.14, -724.10, 10.41)},
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 133, ['torso_2'] = 2,
			['arms'] = 19,
			['pants_1'] = 49, ['pants_2'] = 1,
			['shoes_1'] = 36, ['shoes_2'] = 3,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 85, ['bproof_2'] = 8,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 393, ['tshirt_2'] = 0,
			['torso_1'] = 49, ['torso_2'] = 1,
			['arms'] = 14,
			['pants_1'] = 332, ['pants_2'] = 2,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},

AgentImmo = {
	Clothes = {
		{clothes = vector3(-700.42, 267.30, 83.10)},
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 133, ['torso_2'] = 2,
			['arms'] = 19,
			['pants_1'] = 49, ['pants_2'] = 1,
			['shoes_1'] = 36, ['shoes_2'] = 3,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 85, ['bproof_2'] = 8,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 393, ['tshirt_2'] = 0,
			['torso_1'] = 49, ['torso_2'] = 1,
			['arms'] = 14,
			['pants_1'] = 332, ['pants_2'] = 2,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},

Journalist = {
	Clothes = {
		{clothes = vector3(-577.82, -923.52, 32.52)},
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 13, ['torso_2'] = 2,
			['arms'] = 11,
			['pants_1'] = 24, ['pants_2'] = 1,
			['shoes_1'] = 10, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 85, ['bproof_2'] = 8,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 393, ['tshirt_2'] = 0,
			['torso_1'] = 49, ['torso_2'] = 1,
			['arms'] = 14,
			['pants_1'] = 332, ['pants_2'] = 2,
			['shoes_1'] = 27, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},


Mecano = {
	Clothes = {
		{clothes = vector3(-194.0701, -1336.1068, 31.30)},
	},
	ShopMec = {
		{shopmec = vector3(-194.2649, -1339.2335, 31.30)},
		
	},
	Uniforms = {
		male = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 122, ['tshirt_2'] = 0,
			['torso_1'] = 474, ['torso_2'] = 1,
			['arms'] = 182,
			['pants_1'] = 235, ['pants_2'] = 1,
			['shoes_1'] = 204, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = 0, ['chain_2'] = 0,
		},
		female = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 392, ['tshirt_2'] = 0,
			['torso_1'] = 924, ['torso_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 358, ['pants_2'] = 0,
			['shoes_1'] = 170, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0,
			['helmet_1'] = 151, ['helmet_2'] = 4,
			["decals_1"] = -1, ["decals_2"] = 0,
			['chain_1'] = -1, ['chain_2'] = 0,
		}
	},
},
Cardealer = {
	Actions = {
		{actions = vector3(-782.78, -212.03, 37.0)},
	},
	Bureau = {
		{Bureau = vector3(-807.01, -205.13, 41.85)},
	},
},
Boat = {
	Actions = {
		{actions = vector3(-735.018, -1344.49, 1.571926)},
	},
},
Plane = {
	Actions = {
		{actions = vector3(-941.60, -2954.81, 13.94)},
	},
},
Unicorn = {
	Blip = {
		{coords = vector3(129.6, -1300.6, 29.2)},
	},
},
Bahamas = {
	Blip = {
		{coords = vector3(-1392.01, -583.50, 29.84)},
	},
},
	},

	Ammunation = {
		showBlip = true, -- Afficher les blips sur la carte // oui = true | non = false
		showMarker = true, -- Afficher les marker // oui = true | non = false
		Menu = {
			Title = "Armurerie",
			Subtitle = "Achetez vos armes",    
		},
		Marker = { -- https://docs.fivem.net/docs/game-references/markers/ & https://htmlcolorcodes.com/fr/
			Type = 2, 
			Size = {0.2, 0.2, 0.2},  -- x, y, z
			Color = {exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b}, -- r, g, b
			Rotation = 180.0,
		},
		Positions = {
			infoBlip = { -- https://docs.fivem.net/docs/game-references/blips/
				Name = "Armurerie",
				Sprite = 313,
				Display = 4,
				Scale = 0.6,
				Color = 1,
				Range = true,
			},
			interactionZone = { -- Position x,y,z pour les intéractions & blips
				{pos = vector3(-662.4192, -935.4647, 21.82921)},
				-- {pos = vector3(810.5966, -2157.017, 29.61898)},
				{pos = vector3(1693.578, 3759.426, 34.7053)},
				{pos = vector3(-330.4556, 6083.456, 31.45476)},
				{pos = vector3(251.9472, -49.86555, 69.94102)},
				{pos = vector3(21.82369, -1107.19, 29.797)},
				{pos = vector3(2568.004, 294.5252, 108.7348)},
				{pos = vector3(-1117.884, 2698.496, 18.55412)},
				{pos = vector3(842.4682, -1033.3, 28.19486)},
				{pos = vector3(-1305.939, -394.0775, 36.69574)},
			},
		},
		PPA = { price = 150000 },
		Items = {
			whiteWeaponVIP = {
				{ label = "Machette", description = "Grand coutelas des régions tropicales, à lame épaisse, à poignée courte, utilisé à la volée et servant à la fois d'outil et d'arme", item = "weapon_machete", type = "weapon", price = "5000" },
				{ label = "Club de Golf", description = "Batte de baseball en aluminium avec une poignée en cuir. Légère et résistante, parfaite pour les battants.", item = "weapon_battleaxe", type = "weapon", price = "5000" },
				{ label = "Couteau", description = "Ce couteau à lame de 17 cm en acier au carbone est doté d'un double tranchant et d'une partie dentelée pour mieux s'enfoncer et découper.", item = "weapon_knife", type = "weapon", price = "5000" },
				{ label = "Batte de baseball", description = "Batte de baseball en aluminium avec une poignée en cuir. Légère et résistante, parfaite pour les battants.", item = "weapon_bat", type = "weapon", price = "5000" },
				{ label = "Pétoire", description = "Le flingue idéal pour sortir à Vinewood. Moins précis qu'un bouchon de bouteille, mais deux fois plus dangereux et puissant.", item = "weapon_snspistol", type = "weapon", price = "150000" },
				{ label = "Pistolet", description = "Arme à feu portative, à canon court, qui se tient d'une seule main. Légère et maniable, une arme pouvant causé de très gros dégâts.", item = "weapon_pistol", type = "weapon", price = "150000" },
				{ label = "Bouteille", description = nil, item = "weapon_bottle", type = "weapon", price = "5000" },
			},
			whiteWeapon = {
				{ label = "Couteau", description = "Ce couteau à lame de 17 cm en acier au carbone est doté d'un double tranchant et d'une partie dentelée pour mieux s'enfoncer et découper.", item = "weapon_knife", type = "weapon", price = "50000" },
				{ label = "Batte de baseball", description = "Batte de baseball en aluminium avec une poignée en cuir. Légère et résistante, parfaite pour les battants.", item = "weapon_bat", type = "weapon", price = "75000" },
			},
			letalWeapon = {
				{ label = "Pétoire", description = "Le flingue idéal pour sortir à Vinewood. Moins précis qu'un bouchon de bouteille, mais deux fois plus dangereux et puissant.", item = "weapon_snspistol", type = "weapon", price = "175000" },
				--{ label = "Pistolet", description = "Arme à feu portative, à canon court, qui se tient d'une seule main. Légère et maniable, une arme pouvant causé de très gros dégâts.", item = "weapon_pistol", type = "weapon", price = "250000" },
			},
			accessories = {
				{ label = "Boite de Munitions", description = nil, item = "clip", type = "item", price = "2000" },
				{ label = "Gilet par Balle", description = nil, item = "kevlar", type = "item", price = "50000" },
			},
		},
	},

	Garage = {
		showBlip = true,
		Positions = {
            infoBlip = { 
                Name = "[Garage] Garage Public",
                Sprite = 290,
				Display = 4,
				Scale = 0.6,
				Color = 38,
				Range = true,
            },
            spawnZone = { 
                {spawn = vector3(233.77, -788.29, 30.81), pos = vector3(215.44, -810.39, 30.72), heading = 156.51}, -- central
                {spawn = vector3(1738.6, 3720.83, 34.02), pos = vector3(1737.43, 3710.22, 34.13), heading = 26.86}, -- sandy shores
				{spawn = vector3(124.63, 6603.73, 31.7), pos = vector3(106.85, 6612.20, 31.97), heading = 221.15}, -- Paleto
				{spawn = vector3(1869.28, 2577.80, 45.67), pos = vector3(1846.98, 2584.44, 45.67-1), heading = 122.36}, -- Prison 
				{spawn = vector3(1202.95, 334.7, 81.99), pos = vector3(1213.29, 341.14, 81.99), heading = 143.32}, -- Casino
				{spawn = vector3(-509.11, -602.58, 30.3), pos = vector3(-505.01, -612.00, 30.29), heading = 266.56}, -- Centre ville
				{spawn = vector3(1019.73, -766.36, 57.92), pos = vector3(1034.58, -762.12, 58.08), heading = 317.63}, -- Spawn
				{spawn = vector3(-1256.01, -385.77, 37.28), pos = vector3(-1255.85, -382.50, 37.28), heading = 295.75}, -- Bloods
				{spawn = vector3(-1134.93, 2672.06, 18.09), pos = vector3(-1145.17, 2668.37, 18.09), heading = 134.60}, -- Military
				{spawn = vector3(-947.39, -2439.93, 13.83), pos = vector3(-944.31, -2460.18, 13.98), heading = 214.11}, -- Airport
				{spawn = vector3(-1670.13, 65.48, 63.54), pos = vector3(-1677.86, 65.64, 63.93), heading = 290.65}, -- Garage Tenis
				{spawn = vector3(4474.42, -4460.30, 4.25), pos = vector3(4462.83, -4469.04, 4.24), heading = 197.38}, -- Garage Cayo
            },
			deleteZone = {
                {pos = vector3(224.50, -757.70, 30.82)}, -- central
                {pos = vector3(1724.98, 3715.85, 34.18)}, -- sandy shores
				{pos = vector3(143.83, 6626.51, 31.7)}, -- Paleto
				{pos = vector3(1216.155, 356.29, 81.99)}, -- Casino
				{pos = vector3(-510.68, -623.23, 30.3)}, -- Centre ville
				{pos = vector3(1039.05, -785.38, 58.01)}, -- Spawn
				{pos = vector3(-1245.61, -394.23, 37.28)}, -- Bloods
				{pos = vector3(-1154.53, 2662.51, 18.09)}, -- Military
				{pos = vector3(-939.37, -2434.63, 13.83)}, -- Airport
				{pos = vector3(-1663.43, 77.48, 63.45)}, -- Garage Tenis
				{pos = vector3(4482.59, -4451.49, 4.09)}, -- Garage Cayo
			},
        },
	},

	Fourriere = {
		showBlip = true,
		Positions = {
            infoBlip = { 
                Name = "[Fourriere] Fourriere Public",
                Sprite = 67,
				Display = 4,
				Scale = 0.6,
				Color = 64,
				Range = true,
            },
            interactionZone = { 
                {spawn = vector3(405.80, -1643.37, 29.29), pos = vector3(409.48, -1623.18, 29.29), heading = 222.32}, -- Los Santos
                {spawn = vector3(1642.38, 3796.84, 34.65), pos = vector3(1651.06, 3802.37, 38.65), heading = 219.77}, -- Sandy Shores
                {spawn = vector3(-239.82, 6194.65, 31.49), pos = vector3(-234.56, 6199.09, 31.93), heading = 129.75}, -- Paleto
				{spawn = vector3(4519.48, -4466.253, 4.18), pos = vector3(4443.31, -4470.25, 4.32), heading = 109.73}, -- Cayo
            },
        },
	},
	Parachute = {
		DrawDistance = 100,
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 0, g = 128, b = 255},
		Type = 40,
	}
}

Propeties = {}
Propeties.IPL = true 
Propeties.TriggerGetEsx = "esx:getSharedObject"
Propeties.TriggerEsxNotif = "esx:showNotification"
Propeties.TriggerEsxPlayerLoaded = "esx:playerLoaded"
Propeties.TriggerEsxSetjob = "esx:setJob"
Propeties.TriggerEsxSetjob2 = "esx:setJob2"
Propeties.GroupFroCreatProperties = "fondateur"
Propeties.KickOption = function(_source) -- Edit ici pour ban ou kick
    DropPlayer(_source, "Tentative de cheat sur les proprietes") -- juste kick the player 
end
Propeties.List = {
    ["Entrepot1"] = {
        INSIDE = vector3(1026.5056, -3099.8320, -38.9998),
        ROOM_MENU = vector3(999.5825, -3096.2946, -38.9998),
        POIDS = 1500,
        PRIX = 250000,
    },
    ["Entrepot2"] = {
        INSIDE = vector3(1048.5067, -3097.0817, -38.9999),
        ROOM_MENU = vector3(1070.8294, -3098.5852, -38.9999),
        POIDS = 750,
        PRIX = 125000,
    },
    ["Entrepot3"] = {
        INSIDE = vector3(1088.1834, -3099.3547, -38.9999),
        ROOM_MENU = vector3(1103.0339, -3101.6630, -38.999),
        POIDS = 500,
        PRIX = 75000,
    },
    ["Appartement1"] = {
        INSIDE = vector3(266.129,-1007.42,-102.008),
        ROOM_MENU = vector3(265.828,-999.302,-99.008),
        POIDS = 150,
        PRIX = 50000,
    },
	["Appartement2"] = {
        INSIDE = vector3(151.46,-1007.74,-99),
        ROOM_MENU = vector3(151.34512329102,-1003.0447387695,-99.0),
        POIDS = 150,
        PRIX = 75000,
    },
	["Appartement3"] = {
        INSIDE = vector3(-31.55,-595.03,79.03),
        ROOM_MENU = vector3(-7.784,-594.330,79.430),
        POIDS = 400,
        PRIX = 500000,
    },
	["Appartement4"] = {
        INSIDE = vector3(-17.766,-589.527,89.114),
        ROOM_MENU = vector3(-22.417,-590.79,90.114),
        POIDS = 400,
        PRIX = 500000,
    },
	["Appartement5"] = {
        INSIDE = vector3(-774.1382, 342.0316, 196.050),
        ROOM_MENU = vector3(-764.16,331.25,196.08),
        POIDS = 400,
        PRIX = 500000,
    },
	-- ["Appartement6"] = {
    --     INSIDE = vector3(-785.13, 315.79, 187.91),
    --     ROOM_MENU = vector3(-795.7161, 326.8150, 187.3129),
    --     POIDS = 400,
    --     PRIX = 500000,
    -- },
	["Villa1"] = {
        INSIDE = vector3(-174.28,497.65,136.66),
        ROOM_MENU = vector3(-169.847,491.016,130.043),
        POIDS = 600,
        PRIX = 2150000,
    },
	["Villa2"] = {
        INSIDE = vector3(373.603,423.684,144.907),
        ROOM_MENU = vector3(373.836,433.312,138.300),
        POIDS = 600,
        PRIX = 2150000,
    },
	["Bureau1"] = {
        INSIDE = vector3(-141.1987, -620.913, 167.8205),
        ROOM_MENU = vector3(-138.975, -634.139, 168.820),
        POIDS = 500,
        PRIX = 1100000,
    },
	["Bureau2"] = {
        INSIDE = vector3(-1902.145,-572.377,18.097),
        ROOM_MENU = vector3(-1912.501,-570.140,19.097),
        POIDS = 200,
        PRIX = 50000,
    },
}

function CreatCamPorperties(type)
    DestroyCam()
	local ped = PlayerPedId()
	if type == 'Entrepot1' then 
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(1026.8707, -3099.8710, -38.9998, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 1026.8707, -3099.8710, -38.9998)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 88.76)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Entrepot2' then 
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(1072.8447, -3100.0390, -38.9999, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 1072.8447, -3100.0390, -38.9999)
		SetCamActive(cam,  true)
		SetCamRot(cam, 0.0, 0.0, 91.85)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)	
	elseif type == 'Entrepot3'	then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(1104.7231, -3100.0690, -38.9999, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 1104.7231, -3100.0690, -38.9999)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 85.68)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Appartement1' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(264.84, -998.53, -99.00, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 264.84, -998.53, -99.00)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 85.68)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Appartement2' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(151.34512329102,-1003.0447387695,-99.0, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 151.34512329102,-1003.0447387695,-99.0)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 180.68)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Appartement3' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-18.54, -592.47, 79.46, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -18.54, -592.47, 79.46)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 5.68)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Appartement4' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-24.90,-581.96,90.11, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -24.90,-581.96,90.11)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 82.68)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Appartement5' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-774.27, 337.16, 196.08, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -774.27, 337.16, 196.08)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 186.68)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	-- elseif type == 'Appartement6' then
	-- 	cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	-- 	SetFocusArea(-788.3881, 320.2430, 187.3132, 0.0, 0.0, 0.0)
	-- 	SetCamCoord(cam, -788.3881, 320.2430, 187.3132)
	--     SetCamActive(cam,  true)
	--   	SetCamRot(cam, 0.0, 0.0, 355.81)
	-- 	RenderScriptCams(true,  false,  0,  true,  true)
	-- 	FreezeEntityPosition(ped, true)
	elseif type == 'Villa1' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-172.59,494.34,137.66, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -172.59,494.34,137.66)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 202.81)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Villa2' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(373.12,419.65,145.90, 0.0, 0.0, 0.0)
		SetCamCoord(cam, 373.12,419.65,145.90, 187.3132)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 172.81)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Bureau1' then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-125.64,-640.04,168.83, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -125.64,-640.04,168.83)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 113.81)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	elseif type == 'Bureau2' then -- Avocat
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
		SetFocusArea(-1903.79,-572.78,19.09, 0.0, 0.0, 0.0)
		SetCamCoord(cam, -1903.79,-572.78,19.09)
	    SetCamActive(cam,  true)
	  	SetCamRot(cam, 0.0, 0.0, 110.81)
		RenderScriptCams(true,  false,  0,  true,  true)
		FreezeEntityPosition(ped, true)
	end	
end

function Notification(player, message)
    if player and message then
        TriggerClientEvent(Propeties.TriggerEsxNotif, player, message) 
    end
end

local prefix = "[^3Properties^7]"
function ToConsol(str)
    -- print(prefix.." "..str)
end

-- function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
-- 	AddTextEntry(entryTitle, textEntry)
-- 	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
-- 	blockinput = true

-- 	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
-- 		Citizen.Wait(0)
-- 	end

-- 	if UpdateOnscreenKeyboard() ~= 2 then
-- 		local result = GetOnscreenKeyboardResult()
-- 		Citizen.Wait(500)
-- 		blockinput = false
-- 		return result
-- 	else
-- 		Citizen.Wait(500)
-- 		blockinput = false
-- 		return nil
-- 	end
-- end