dependency 'vrp'

shared_script "@evp/main.lua"

client_scripts {
	'config.lua',
	'client/vrp_vangelico_robbery_cl.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config.lua',
	'server/vrp_vangelico_robbery_sv.lua',
	'lib/lib.lua'
}
