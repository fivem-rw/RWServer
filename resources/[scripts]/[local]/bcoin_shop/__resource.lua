resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

shared_script "@evp/main.lua"

client_scripts {
    "@vrp/lib/utils.lua",
    "config.lua",
    "client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "config.lua",
    "server.lua"
}

ui_page "nui/index.html"

files {
    "nui/index.html",
    "nui/app.js",
    "nui/style.css",
    "nui/images/bcoin.png",
    "nui/images/ready.png",
}