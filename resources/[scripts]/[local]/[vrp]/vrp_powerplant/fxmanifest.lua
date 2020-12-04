--------------------------------
----- Converting By. blyyn -----
-------------------------------- 

fx_version 'adamant'

game "gta5"

shared_script "@evp/main.lua"

server_script {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}

client_scripts {
	"config.lua",
    "client/powerplant.lua"
}
