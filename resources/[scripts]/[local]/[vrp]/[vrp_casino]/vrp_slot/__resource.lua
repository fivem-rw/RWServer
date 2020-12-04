resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/ui.html'

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

client_scripts {
	"@vrp/lib/utils.lua",
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"RageUI/RMenu.lua",
	"RageUI/menu/RageUI.lua",
	"RageUI/menu/Menu.lua",
	"RageUI/menu/MenuController.lua",
	"RageUI/components/*.lua",
	"RageUI/menu/elements/*.lua",
	"RageUI/menu/items/*.lua",
	"RageUI/menu/panels/*.lua",
	"RageUI/menu/panels/*.lua",
	"RageUI/menu/windows/*.lua",
	"RageUI.lua",
	'config.lua',
	'functions.lua',
	'client.lua'
}

server_scripts {
	"@vrp/lib/utils.lua",
	'server.lua'
}

files {
  'html/ui.html',
  'html/script.js',
  'html/design.css',
  -- Images
  'html/img/black.png',
  'html/img/item1.png',
  'html/img/item2.png',
  'html/img/item3.png',
  'html/img/item4.png',
  'html/img/item5.png',
  'html/img/item6.png',
  'html/img/item7.png',
  'html/img/red.png',
  'html/img/lever.png',
  -- Audio
  'html/audio/alarma.wav',
  'html/audio/apasaButonul.wav',
  'html/audio/changeBet.wav',
  'html/audio/collect.wav',
  'html/audio/pornestePacanele.wav',
  'html/audio/seInvarte.wav',
  'html/audio/winDouble.wav',
  'html/audio/winLine.wav'
}