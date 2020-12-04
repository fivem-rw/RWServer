--[[
vRP Los Santos Customs V1.2
Credits - MythicalBro and マーモット#2533 for the vRP version and some bug fixes
/////License/////
Do not reupload/re release any part of this script without my permission
]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts {
    "@vrp/lib/utils.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",
    "lsconfig.lua",
    "client/menu.lua",
    "client/lscustoms.lua"
}

server_scripts {
    "@vrp/lib/MySQL.lua",
    "@vrp/lib/utils.lua",
    "server/lscustoms.lua"
}