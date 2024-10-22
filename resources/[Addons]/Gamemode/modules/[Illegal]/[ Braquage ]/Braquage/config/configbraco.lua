

ConfigBraco = {}
ConfigBraco.Locale = 'fr'
ConfigBraco.NumberOfCopsRequired = 7
ConfigBraco.RequiredCopsRob = 0
ConfigBraco.RequiredCopsSell = 3
ConfigBraco.MinJewels = 1 
ConfigBraco.MaxJewels = 2
ConfigBraco.MaxWindows = 20
ConfigBraco.SecBetwNextRob = 7200 --1 hour
ConfigBraco.MaxJewelsSell = 20
ConfigBraco.PriceForOneJewel = 2600
ConfigBraco.EnableMarker = true
ConfigBraco.NeedBag = true
ConfigBraco.Borsoni = {11, 12, 13, 40, 41, 44, 45}

Banks = {
	['Casa'] = {
		position = vector3(3589.88, 3683.94, 27.62),
		reward = math.random(50000, 100000),
		nameofbank = "Maison de fabrication des billet",
		lastrobbed = 0
	},
	['FleecaBank'] = {
		position = vector3(-2957.49, 480.72, 15.38),
		reward = math.random(30000, 100000),
		nameofbank = "Fleeca Bank",
		lastrobbed = 0
	},
	['PaletoBank'] = {
		position = vector3(-103.86, 6477.80, 31.63),
		reward = math.random(10000, 50000),
		nameofbank = "Paleto Bank",
		lastrobbed = 0
	}
}

Stores = {
	['jewelry'] = {
		position2 = { ['x'] = -629.99, ['y'] = -236.542, ['z'] = 38.05 },       
		nameofstore = "Bijouterie",
		lastrobbed = 0
	}
}