dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

ui_page 'notifs/index.html'

files {
	'notifs/index.html',
	'notifs/hotsnackbar.css',
	'notifs/hotsnackbar.js'
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'config.lua',
	'notifs.lua',
	'map.lua',
	'incheon.lua',
	'client.lua',
	'GUI.lua',
	'models_c.lua'
}

server_scripts {
		'@vrp/lib/utils.lua',
		'config.lua',
    'server.lua'
}