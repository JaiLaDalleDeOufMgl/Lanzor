shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield






fx_version('bodacious')
game('gta5')
lua54 'yes'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
}

ui_page 'html/index.html'

server_script {
	'server.lua'
}

client_script {
	'client.lua'
}

files {
	'html/index.html',
	'html/assets/css/*.css',
	'html/assets/js/*.js',
	'html/assets/fonts/roboto/*.woff',
	'html/assets/fonts/roboto/*.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/images/*.png'
}