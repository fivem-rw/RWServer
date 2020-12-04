fx_version 'adamant'

game 'gta5'

dependency "vrp"

client_scripts {
	'lib/Proxy.lua',
	'lib/Tunnel.lua',
	'config.lua',
    'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config.lua',
    'server.lua'
}

files {
    "html/alarm.html",
    "html/alarm.ogg"
}

ui_page 'html/alarm.html'
