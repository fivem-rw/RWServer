resource_manifest_version "05cfa83c-a124-4cfa-a768-c24a5811d8f9"

description "RP module/framework"

dependency "progressBars"

ui_page "gui/index.html"

shared_script "@evp/main.lua"
shared_script "shared/encrypt.lua"

-- server scripts
server_scripts {
  "lib/MySQL.lua",
  "lib/utils.lua",
  "base.lua",
  "modules/gui.lua",
  "modules/group.lua",
  "modules/admin.lua",
  "modules/admin_market.lua",
  "modules/anti_market.lua",
  "modules/survival.lua",
  "modules/player_state.lua",
  "modules/map.lua",
  "modules/money.lua",
  "modules/bonus.lua",
  "modules/inventory.lua",
  "modules/identity.lua",
  "modules/business.lua",
  "modules/item_transformer.lua",
  "modules/emotes.lua",
  "modules/police.lua",
  "modules/home.lua",
  "modules/home_components.lua",
  "modules/mission.lua",
  "modules/aptitude.lua",
  "modules/basic_phone.lua",
  "modules/basic_atm.lua",
  "modules/basic_market.lua",
  "modules/basic_gunshop.lua",
  "modules/basic_garage.lua",
  "modules/basic_items.lua",
  "modules/basic_skinshop.lua",
  "modules/basic_trade.lua",
  "modules/cloakroom.lua",
  "modules/paycheck.lua",
  "modules/hotkeys.lua",
  "modules/user_title.lua"
}

-- client scripts
client_scripts {
  "lib/utils.lua",
  "lib/utf8-utils.lua",
  "lib/gen.lua",
  "lib/Enumerator.lua",
  "client/Tunnel.lua",
  "client/Proxy.lua",
  "client/base.lua",
  "client/iplloader.lua",
  "client/gui.lua",
  "client/player_state.lua",
  "client/survival.lua",
  "client/map.lua",
  "client/identity.lua",
  "client/basic_garage.lua",
  "client/police.lua",
  "client/paycheck.lua",
  "client/admin.lua",
  "client/ai_vehicle.lua"
}

-- client files
files {
  "cfg/client.lua",
  "gui/index.html",
  "gui/design.css",
  "gui/main.js",
  "gui/ogrp.main.js",
  "gui/ogrp.menu.js",
  "gui/ProgressBar.js",
  "gui/WPrompt.js",
  "gui/RequestManager.js",
  "gui/AnnounceManager.js",
  "gui/Div.js",
  "gui/dynamic_classes.js",
  "gui/fonts/Pdown.woff",
  "gui/fonts/GTA.woff",
  "assets/garages/small/*.jpg"
}
