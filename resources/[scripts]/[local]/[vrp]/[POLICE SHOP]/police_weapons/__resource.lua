--[[-----------------------------------------------------------------------

	ActionMenu - Version 1.0.1 
	Created by WolfKnight
	Additional help from TheStonedTurtle, Briglair, and lowheartrate. 

	NOTE: This is an example resource, which you must add to in order for 
	it to become useable in your server/gamemode. Each area has been 
	commented for your understanding. 

-----------------------------------------------------------------------]]--

-- Set the resource manifest version 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- Tell FiveM's NUI system what the main html file is for this resource 
dependency "vrp"

shared_script "@evp/main.lua"
shared_script "@vrp/shared/encrypt.lua"

ui_page "nui/ui.html"

-- Add the files that need to be used/loaded
files {
	"nui/ui.html",
	"nui/ui.js", 
	"nui/ui.css",
	"nui/Roboto.ttf"
}

dependency "vrp"

client_scripts{ 
  "cl_action.lua",
  "client/main.lua",
  "config.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "vrp/lib/mysql.lua",
  "config.lua",
  "server/main.lua",
  "sv_action.lua"
}