resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@evp/main.lua"

client_script 'dist/client.js'
server_script 'dist/server.js'

files {
    'dist/ui.html'
}

ui_page 'dist/ui.html'