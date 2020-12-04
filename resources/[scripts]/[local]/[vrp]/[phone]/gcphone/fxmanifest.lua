fx_version "adamant"
game "gta5"

name "gcPhone"
description "A Phone for vrp"
author "Converted by Draco"
version "3.0"

ui_page "html/index.html"

dependencies {
	"vrp"
}

shared_script "@evp/main.lua"

files {
	"html/index.html",
	"html/static/css/app.css",
	"html/static/js/app.js",
	"html/static/js/manifest.js",
	"html/static/js/vendor.js",
	"html/static/config/config.json",
	"html/static/img/coque/*.png",
	"html/static/img/background/*.jpg",
	"html/static/img/icons_app/*.png",
	"html/static/img/icons_services/*.png",
	"html/static/img/app_bank/fleeca_tar.png",
	"html/static/img/app_bank/tarjetas.png",
	"html/static/img/app_tchat/reddit.png",
	"html/static/img/twitter/bird.png",
	"html/static/img/twitter/default_profile.png",
	"html/static/sound/*.ogg",
	"html/static/img/courbure.png",
	"html/static/fonts/fontawesome-webfont.eot",
	"html/static/fonts/fontawesome-webfont.ttf",
	"html/static/fonts/fontawesome-webfont.woff",
	"html/static/fonts/fontawesome-webfont.woff2",
	"html/static/sound/*.ogg",
	"html/static/ringtones/*.ogg"
}

client_script {
	"@vrp/client/Proxy.lua",
	"@vrp/client/Tunnel.lua",
	"serverCallbackLib/client.lua",
	"config.lua",
	-- "client/stocks.lua",
	"client/animation.lua",
	"client/client.lua",
	"client/control.lua",
	"client/photo.lua",
	"client/app_tchat.lua",
	"client/app_notes.lua",
	"client/bank.lua",
	"client/twitter.lua"
}

server_script {
	"@vrp/lib/MySQL.lua",
	"@vrp/lib/utils.lua",
	"serverCallbackLib/server.lua",
	"config.lua",
	"server/server.lua",
	"server/app_tchat.lua",
	"server/app_notes.lua",
	"server/twitter.lua"
}
