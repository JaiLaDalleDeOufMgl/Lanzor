Config = {}
Config.Locale = 'fr'

Config.DefaultGroup = 'user'
Config.DefaultLevel = '0'
Config.CommandPrefix = '/'
Config.DefaultPosition = vector3(-666.22, 581.5, 140.57)
Config.DefaultIdentifier = "license";

Config.Accounts = {
	['cash'] = {
		label = _U('cash'),
		starting = 0,
		priority = 1
	},
	['dirtycash'] = {
		label = _U('dirtycash'),
		starting = 0,
		priority = 2
	},
	['bank'] = {
		label = _U('bank'),
		starting = 0,
		priority = 3
	},
	['crypto'] = {
		label = 'Crypto',
		starting = 0,
		priority = 4
	},
	['chip'] = {
		label = 'Jetons Casino',
		starting = 0,
		priority = 4
	}
}

Config.EnableSocietyPayouts = true
Config.PaycheckInterval = 45 * 60 * 1000

Config.MaxWeight = 50