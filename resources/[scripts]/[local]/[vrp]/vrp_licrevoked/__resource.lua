dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

server_scripts {
  "@vrp/lib/utils.lua",
  "server.lua"
}