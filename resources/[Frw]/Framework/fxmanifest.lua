shared_scripts{'@KingProtect/resource/imports.lua'}
lua54 'yes'
shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield


 --this line was automatically written by WaveShield

 



lua54 "yes"

fx_version('bodacious')
game('gta5')

shared_script {
	'locale/locale.lua',
	'locale/lang/fr.lua',
	
	'config/config.lua',
	'config/config.weapons.lua',
}

server_scripts {
	'libs/async.lua',
	'@oxmysql/lib/MySQL.lua',

	'server/common.lua',
	'server/classes/groups.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/commands.lua',
	
	'common/modules/Logs.lua',
	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
}

client_scripts {
	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',

	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',
	'client/modules/spawnMass.lua',
	
	'common/modules/Logs.lua',
	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua',
}


files {
	'locale.js',
}