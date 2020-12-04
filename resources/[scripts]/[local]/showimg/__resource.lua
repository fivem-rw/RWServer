resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "vrp"

ui_page "html/ui.html"

file {
  "html/*.*",
}

shared_script "@evp/main.lua"

server_scripts {
	"@vrp/lib/utils.lua",
  "server.lua",
}

client_scripts {
	"@vrp/lib/utils.lua",
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "client.lua",
}
