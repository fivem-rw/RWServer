
description "vRP basic mission"
--ui_page "ui/index.html"

dependency "vrp"

-- client_scripts{ 
  -- "@vrp/lib/utils.lua",
  -- "client.lua"
-- }

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
