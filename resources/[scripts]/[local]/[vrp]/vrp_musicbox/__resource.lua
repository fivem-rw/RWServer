resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

description "vrp_musicbox"

version "1.0.0"

dependencies {
    "vrp"
}

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

server_scripts {
    "@vrp/lib/utils.lua",
    "config.lua",
    "server/main.lua"
}

client_scripts {
    "@vrp/client/Proxy.lua",
    "@vrp/client/Tunnel.lua",
    "@vrp/lib/utils.lua",
    "config.lua",
    "client/main.lua"
}

ui_page {
    "html/index.html"
}

files {
    "html/index.html",
    "html/youtube.html",
    "html/style.css",
    "html/app.js",
    "html/script.js",
    "html/logo.png"
}
