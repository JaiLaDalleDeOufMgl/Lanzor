shared_scripts{'@KingProtect/resource/imports.lua'}
lua54 'yes'
shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield




fx_version 'bodacious'
games { 'gta5' }

author 'xPiwel'
description 'Zone GF for GamemodeRP'
version '1.0.0'

shared_scripts{'config.lua'}

client_scripts {
    'client/functions.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}
