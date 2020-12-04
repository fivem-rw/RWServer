description "vRP Bank Robberies by Lee Fall - Edited by Dunko"
--ui_page "ui/index.html"

dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts {
  "@vrp/lib/utils.lua",
  "client.lua"
}

server_scripts {
  "@vrp/lib/utils.lua",
  "server.lua"
}
