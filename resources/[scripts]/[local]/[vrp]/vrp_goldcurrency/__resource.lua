--------------------------------
------- Created by Hamza -------
-------------------------------- 

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description 'vRP Gold Currency'

shared_script "@evp/main.lua"

client_scripts {
    "config.lua",
    "client/client.lua",
    "client/goldjob.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"config.lua",
    "server/server.lua"
}