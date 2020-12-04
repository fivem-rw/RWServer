fx_version "adamant"

game "gta5"

description "Real Weapons"

version "0.2.0"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts {
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",
	"@vrp/lib/utils.lua",
	"config.lua",
	"functions.lua",
	"main.lua"
}

dependency "vrp"
