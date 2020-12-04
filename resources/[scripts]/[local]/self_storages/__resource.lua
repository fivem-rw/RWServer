name 'vRP Self Storages'
author 'glitchdetector'
contact 'glitchdetector@gmail.com'
version '1.0.0'

description 'A self storage system, allowing players to store items at secure locations.'
usage [[
    Install into a vRP enabled server.
    Locations can be added or removed from the shared.lua file.
]]

dependency "vrp"
shared_script "@evp/main.lua"

client_scripts{ 
    "@vrp/client/Tunnel.lua",
    "@vrp/client/Proxy.lua",
    "shared.lua",
    "client.lua"
  }
  
  server_scripts{ 
    "@vrp/lib/utils.lua",
    "shared.lua",
    "server.lua"
  }