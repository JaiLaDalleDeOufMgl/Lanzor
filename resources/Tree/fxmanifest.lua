shared_scripts{'@KingProtect/resource/imports.lua'}
lua54 'yes'
lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'JaiFaim'
version '0.0.1'
lua54 'yes'


ui_page 'web/build/index.html'

files { 'web/build/index.html', 'web/build/**/*' }

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "endernative/server/*.lua",
    "modules/**/sv_*.lua",
    "modules/**/submodules/sv_*.lua",
    "plugins/**/server/*.lua",
}

client_scripts {
    "endernative/client/*.lua",
    "modules/**/cl_*.lua",
    "modules/**/submodules/cl_*.lua",
    "gui/*.lua",
    "gui/**/*.lua",
    "plugins/**/client/*.lua",
}

shared_scripts {
    "config.lua",
    "logs.lua",
    "modules/**/sh_*.lua",
    "modules/**/submodules/sh_*.lua",
    "plugins/**/shared.lua",
}