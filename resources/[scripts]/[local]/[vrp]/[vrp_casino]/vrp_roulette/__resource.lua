resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts {
	"@vrp/lib/utils.lua",
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"src/RMenu.lua",
	"src/menu/RageUI.lua",
	"src/menu/Menu.lua",
	"src/menu/MenuController.lua",
	"src/components/*.lua",
	"src/menu/elements/*.lua",
	"src/menu/items/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/windows/*.lua",
	"RageUI.lua",
	"functions.lua",
	"client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

ui_page("index.html")

files {
	"index.html"
}
