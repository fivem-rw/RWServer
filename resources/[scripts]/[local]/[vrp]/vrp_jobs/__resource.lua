-- Discord Ice Heart#1826
dependency 'vrp'

ui_page "html/ui.html"

shared_script "@evp/main.lua"

files {
  "html/ui.html",
  "html/js/index.js",
  "html/css/style.css"
}

client_script {
  '@vrp/client/Tunnel.lua',
  '@vrp/client/Proxy.lua',
  'config.lua',
  'client.lua'
}

server_script {
  '@vrp/lib/utils.lua',
  'config.lua',
  'server.lua'
}
