shared_scripts{'@KingProtect/resource/imports.lua'}
lua54 'yes'
shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield


fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'A simple voting resource created by Entity Evolution'

version '1.0.0'

client_script {
    'config/config.lua',
    'client/*.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'config/config.json',
    'html/fonts/*.ttf',
    'html/img/*.jpg',
    'html/css/style.css',
    'html/js/script.js'
}