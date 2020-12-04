--[[
vRP Los Santos Customs V1.2
Credits - MythicalBro and マーモット#2533 for the vRP version and some bug fixes
/////License/////
Do not reupload/re release any part of this script without my permission
]]

local colors = {
	{name = "Black", colorindex = 0},{name = "Carbon Black", colorindex = 147},
	{name = "Hraphite", colorindex = 1},{name = "Anhracite Black", colorindex = 11},
	{name = "Black Steel", colorindex = 2},{name = "Dark Steel", colorindex = 3},
	{name = "Silver", colorindex = 4},{name = "Bluish Silver", colorindex = 5},
	{name = "Rolled Steel", colorindex = 6},{name = "Shadow Silver", colorindex = 7},
	{name = "Stone Silver", colorindex = 8},{name = "Midnight Silver", colorindex = 9},
	{name = "Cast Iron Silver", colorindex = 10},{name = "Red", colorindex = 27},
	{name = "Torino Red", colorindex = 28},{name = "Formula Red", colorindex = 29},
	{name = "Lava Red", colorindex = 150},{name = "Blaze Red", colorindex = 30},
	{name = "Grace Red", colorindex = 31},{name = "Garnet Red", colorindex = 32},
	{name = "Sunset Red", colorindex = 33},{name = "Cabernet Red", colorindex = 34},
	{name = "Wine Red", colorindex = 143},{name = "Candy Red", colorindex = 35},
	{name = "Hot Pink", colorindex = 135},{name = "Pfsiter Pink", colorindex = 137},
	{name = "Salmon Pink", colorindex = 136},{name = "Sunrise Orange", colorindex = 36},
	{name = "Orange", colorindex = 38},{name = "Bright Orange", colorindex = 138},
	{name = "Gold", colorindex = 99},{name = "Bronze", colorindex = 90},
	{name = "Yellow", colorindex = 88},{name = "Race Yellow", colorindex = 89},
	{name = "Dew Yellow", colorindex = 91},{name = "Dark Green", colorindex = 49},
	{name = "Racing Green", colorindex = 50},{name = "Sea Green", colorindex = 51},
	{name = "Olive Green", colorindex = 52},{name = "Bright Green", colorindex = 53},
	{name = "Gasoline Green", colorindex = 54},{name = "Lime Green", colorindex = 92},
	{name = "Midnight Blue", colorindex = 141},
	{name = "Galaxy Blue", colorindex = 61},{name = "Dark Blue", colorindex = 62},
	{name = "Saxon Blue", colorindex = 63},{name = "Blue", colorindex = 64},
	{name = "Mariner Blue", colorindex = 65},{name = "Harbor Blue", colorindex = 66},
	{name = "Diamond Blue", colorindex = 67},{name = "Surf Blue", colorindex = 68},
	{name = "Nautical Blue", colorindex = 69},{name = "Racing Blue", colorindex = 73},
	{name = "Ultra Blue", colorindex = 70},{name = "Light Blue", colorindex = 74},
	{name = "Chocolate Brown", colorindex = 96},{name = "Bison Brown", colorindex = 101},
	{name = "Creeen Brown", colorindex = 95},{name = "Feltzer Brown", colorindex = 94},
	{name = "Maple Brown", colorindex = 97},{name = "Beechwood Brown", colorindex = 103},
	{name = "Sienna Brown", colorindex = 104},{name = "Saddle Brown", colorindex = 98},
	{name = "Moss Brown", colorindex = 100},{name = "Woodbeech Brown", colorindex = 102},
	{name = "Straw Brown", colorindex = 99},{name = "Sandy Brown", colorindex = 105},
	{name = "Bleached Brown", colorindex = 106},{name = "Schafter Purple", colorindex = 71},
	{name = "Spinnaker Purple", colorindex = 72},{name = "Midnight Purple", colorindex = 142},
	{name = "Bright Purple", colorindex = 145},{name = "Cream", colorindex = 107},
	{name = "Ice White", colorindex = 111},{name = "Frost White", colorindex = 112}}
local metalcolors = {
	{name = "Brushed Steel",colorindex = 117},
	{name = "Brushed Black Steel",colorindex = 118},
	{name = "Brushed Aluminum",colorindex = 119},
	{name = "Pure Gold",colorindex = 158},
	{name = "Brushed Gold",colorindex = 159}
}
local mattecolors = {
	{name = "Black", colorindex = 12},
	{name = "Gray", colorindex = 13},
	{name = "Light Gray", colorindex = 14},
	{name = "Ice White", colorindex = 131},
	{name = "Blue", colorindex = 83},
	{name = "Dark Blue", colorindex = 82},
	{name = "Midnight Blue", colorindex = 84},
	{name = "Midnight Purple", colorindex = 149},
	{name = "Schafter Purple", colorindex = 148},
	{name = "Red", colorindex = 39},
	{name = "Dark Red", colorindex = 40},
	{name = "Orange", colorindex = 41},
	{name = "Yellow", colorindex = 42},
	{name = "Lime Green", colorindex = 55},
	{name = "Green", colorindex = 128},
	{name = "Frost Green", colorindex = 151},
	{name = "Foliage Green", colorindex = 155},
	{name = "Olive Darb", colorindex = 152},
	{name = "Dark Earth", colorindex = 153},
	{name = "Desert Tan", colorindex = 154}
}



LSC_Config = {}
LSC_Config.prices = {}

--------Prices---------
LSC_Config.prices = {

------Window tint------
	windowtint = {
		{ name = "Pure Black", tint = 1, price = 100*10000},
		{ name = "Darksmoke", tint = 2, price = 100*10000},
		{ name = "Lightsmoke", tint = 3, price = 100*10000},
		{ name = "Limo", tint = 4, price = 100*10000},
		{ name = "Green", tint = 5, price = 100*10000},
	},

-------Respray--------
----Primary color---
	--Chrome 
	chrome = {
		colors = {
			{name = "Chrome Color", colorindex = 120}
		},
		price = 500*10000
	},
	--Classic 
	classic = {
		colors = colors,
		price = 100*10000
	},
	--Matte 
	matte = {
		colors = mattecolors,
		price = 300*10000
	},
	--Metallic 
	metallic = {
		colors = colors,
		price = 200*10000
	},
	--Metals 
	metal = {
		colors = metalcolors,
		price = 200*10000
	},

----Secondary color---
	--Chrome 
	chrome2 = {
		colors = {
			{name = "Chrome Color", colorindex = 120}
		},
		price = 500*10000
	},
	--Classic 
	classic2 = {
		colors = colors,
		price = 100*10000
	},
	--Matte 
	matte2 = {
		colors = mattecolors,
		price = 300*10000
	},
	--Metallic 
	metallic2 = {
		colors = colors,
		price = 200*10000
	},
	--Metals 
	metal2 = {
		colors = metalcolors,
		price = 200*10000
	},

------Neon layout------
	neonlayout = {
		{name = "Front,Back and Sides", price = 500*10000},
	},
	--Neon color
	neoncolor = {
		{ name = "White", neon = {255,255,255}, price = 50*10000},
		{ name = "Blue", neon = {0,0,255}, price = 50*10000},
		{ name = "Electric Blue", neon = {0,150,255}, price = 50*10000},
		{ name = "Mint Green", neon = {50,255,155}, price = 50*10000},
		{ name = "Lime Green", neon = {0,255,0}, price = 50*10000},
		{ name = "Yellow", neon = {255,255,0}, price = 50*10000},
		{ name = "Golden Shower", neon = {204,204,0}, price = 50*10000},
		{ name = "Orange", neon = {255,128,0}, price = 50*10000},
		{ name = "Red", neon = {255,0,0}, price = 50*10000},
		{ name = "Pony Pink", neon = {255,102,255}, price = 50*10000},
		{ name = "Hot Pink",neon = {255,0,255}, price = 50*10000},
		{ name = "Purple", neon = {153,0,153}, price = 50*10000},
		{ name = "Brown", neon = {139,69,19}, price = 50*10000},
	},

	xenoncolor = {
		{ name = "White", xenon = 0, price = 50*10000},
		{ name = "Blue", xenon = 1, price = 50*10000},
		{ name = "Electric Blue", xenon = 2, price = 50*10000},
		{ name = "Mint Green", xenon = 3, price = 50*10000},
		{ name = "Lime Green", xenon = 4, price = 50*10000},
		{ name = "Yellow", xenon = 5, price = 50*10000},
		{ name = "Golden Shower", xenon = 6, price = 50*10000},
		{ name = "Orange", xenon = 7, price = 50*10000},
		{ name = "Red", xenon = 8, price = 50*10000},
		{ name = "Pony Pink", xenon = 9, price = 50*10000},
		{ name = "Hot Pink",xenon = 10, price = 50*10000},
		{ name = "Purple", xenon = 11, price = 50*10000},
		{ name = "Blacklight", xenon = 12, price = 50*10000},
	},

--------Plates---------
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 10*10000},
		{ name = "Blue On White 2", plateindex = 3, price = 10*10000},
		{ name = "Blue On White 3", plateindex = 4, price = 10*10000},
		{ name = "Yellow on Blue", plateindex = 2, price = 30*10000},
		{ name = "Yellow on Black", plateindex = 1, price = 50*10000},
	},
	
--------Wheels--------
----Wheel accessories----
	wheelaccessories = {
		{ name = "Stock Tires", price = 10*10000},
		{ name = "Custom Tires", price = 100*10000},
		{ name = "Bulletproof Tires", price = 500*10000},
		{ name = "White Tire Smoke",smokecolor = {254,254,254}, price = 300*10000},
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 300*10000},
		{ name = "Blue Tire Smoke", smokecolor = {0,150,255}, price = 300*10000},
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 300*10000},
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 300*10000},
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 300*10000},
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 300*10000},
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 300*10000},
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 300*10000},
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 300*10000},
	},

----Wheel color----
	wheelcolor = {
		colors = colors,
		price = 100*10000,
	},

----Front wheel (Bikes)----
	frontwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 200*10000},
		{name = "Speedway", wtype = 6, mod = 0, price = 200*10000},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 200*10000},
		{name = "Racer", wtype = 6, mod = 2, price = 200*10000},
		{name = "Trackstar", wtype = 6, mod = 3, price = 200*10000},
		{name = "Overlord", wtype = 6, mod = 4, price = 200*10000},
		{name = "Trident", wtype = 6, mod = 5, price = 200*10000},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 200*10000},
		{name = "Stilleto", wtype = 6, mod = 7, price = 200*10000},
		{name = "Wires", wtype = 6, mod = 8, price = 200*10000},
		{name = "Bobber", wtype = 6, mod = 9, price = 200*10000},
		{name = "Solidus", wtype = 6, mod = 10, price = 200*10000},
		{name = "Iceshield", wtype = 6, mod = 11, price = 200*10000},
		{name = "Loops", wtype = 6, mod = 12, price = 200*10000},
	},

----Back wheel (Bikes)-----
	backwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 200*10000},
		{name = "Speedway", wtype = 6, mod = 0, price = 200*10000},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 200*10000},
		{name = "Racer", wtype = 6, mod = 2, price = 200*10000},
		{name = "Trackstar", wtype = 6, mod = 3, price = 200*10000},
		{name = "Overlord", wtype = 6, mod = 4, price = 200*10000},
		{name = "Trident", wtype = 6, mod = 5, price = 200*10000},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 200*10000},
		{name = "Stilleto", wtype = 6, mod = 7, price = 200*10000},
		{name = "Wires", wtype = 6, mod = 8, price = 200*10000},
		{name = "Bobber", wtype = 6, mod = 9, price = 200*10000},
		{name = "Solidus", wtype = 6, mod = 10, price = 200*10000},
		{name = "Iceshield", wtype = 6, mod = 11, price = 200*10000},
		{name = "Loops", wtype = 6, mod = 12, price = 200*10000},
	},

----Sport wheels-----
	sportwheels = {
		{name = "Stock", wtype = 0, mod = -1, price = 200*10000},
		{name = "Inferno", wtype = 0, mod = 0, price = 200*10000},
		{name = "Deepfive", wtype = 0, mod = 1, price = 200*10000},
		{name = "Lozspeed", wtype = 0, mod = 2, price = 200*10000},
		{name = "Diamondcut", wtype = 0, mod = 3, price = 200*10000},
		{name = "Chrono", wtype = 0, mod = 4, price = 200*10000},
		{name = "Feroccirr", wtype = 0, mod = 5, price = 200*10000},
		{name = "Fiftynine", wtype = 0, mod = 6, price = 200*10000},
		{name = "Mercie", wtype = 0, mod = 7, price = 200*10000},
		{name = "Syntheticz", wtype = 0, mod = 8, price = 200*10000},
		{name = "Organictyped", wtype = 0, mod = 9, price = 200*10000},
		{name = "Endov1", wtype = 0, mod = 10, price = 200*10000},
		{name = "Duper7", wtype = 0, mod = 11, price = 200*10000},
		{name = "Uzer", wtype = 0, mod = 12, price = 200*10000},
		{name = "Groundride", wtype = 0, mod = 13, price = 200*10000},
		{name = "Spacer", wtype = 0, mod = 14, price = 200*10000},
		{name = "Venum", wtype = 0, mod = 15, price = 200*10000},
		{name = "Cosmo", wtype = 0, mod = 16, price = 200*10000},
		{name = "Dashvip", wtype = 0, mod = 17, price = 200*10000},
		{name = "Icekid", wtype = 0, mod = 18, price = 200*10000},
		{name = "Ruffeld", wtype = 0, mod = 19, price = 200*10000},
		{name = "Wangenmaster", wtype = 0, mod = 20, price = 200*10000},
		{name = "Superfive", wtype = 0, mod = 21, price = 200*10000},
		{name = "Endov2", wtype = 0, mod = 22, price = 200*10000},
		{name = "Slitsix", wtype = 0, mod = 23, price = 200*10000},
	},
-----Suv wheels------
	suvwheels = {
		{name = "Stock", wtype = 3, mod = -1, price = 200*10000},
		{name = "Vip", wtype = 3, mod = 0, price = 200*10000},
		{name = "Benefactor", wtype = 3, mod = 1, price = 200*10000},
		{name = "Cosmo", wtype = 3, mod = 2, price = 200*10000},
		{name = "Bippu", wtype = 3, mod = 3, price = 200*10000},
		{name = "Royalsix", wtype = 3, mod = 4, price = 200*10000},
		{name = "Fagorme", wtype = 3, mod = 5, price = 200*10000},
		{name = "Deluxe", wtype = 3, mod = 6, price = 200*10000},
		{name = "Icedout", wtype = 3, mod = 7, price = 200*10000},
		{name = "Cognscenti", wtype = 3, mod = 8, price = 200*10000},
		{name = "Lozspeedten", wtype = 3, mod = 9, price = 200*10000},
		{name = "Supernova", wtype = 3, mod = 10, price = 200*10000},
		{name = "Obeyrs", wtype = 3, mod = 11, price = 200*10000},
		{name = "Lozspeedballer", wtype = 3, mod = 12, price = 200*10000},
		{name = "Extra vaganzo", wtype = 3, mod = 13, price = 200*10000},
		{name = "Splitsix", wtype = 3, mod = 14, price = 200*10000},
		{name = "Empowered", wtype = 3, mod = 15, price = 200*10000},
		{name = "Sunrise", wtype = 3, mod = 16, price = 200*10000},
		{name = "Dashvip", wtype = 3, mod = 17, price = 200*10000},
		{name = "Cutter", wtype = 3, mod = 18, price = 200*10000},
	},
-----Offroad wheels-----
	offroadwheels = {
		{name = "Stock", wtype = 4, mod = -1, price = 200*10000},
		{name = "Raider", wtype = 4, mod = 0, price = 1000},
		{name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 200*10000},
		{name = "Nevis", wtype = 4, mod = 2, price = 200*10000},
		{name = "Cairngorm", wtype = 4, mod = 3, price = 200*10000},
		{name = "Amazon", wtype = 4, mod = 4, price = 200*10000},
		{name = "Challenger", wtype = 4, mod = 5, price = 200*10000},
		{name = "Dunebasher", wtype = 4, mod = 6, price = 200*10000},
		{name = "Fivestar", wtype = 4, mod = 7, price = 200*10000},
		{name = "Rockcrawler", wtype = 4, mod = 8, price = 200*10000},
		{name = "Milspecsteelie", wtype = 4, mod = 9, price = 200*10000},
	},
-----Tuner wheels------
	tunerwheels = {
		{name = "Stock", wtype = 5, mod = -1, price = 500*10000},
		{name = "Cosmo", wtype = 5, mod = 0, price = 500*10000},
		{name = "Supermesh", wtype = 5, mod = 1, price = 500*10000},
		{name = "Outsider", wtype = 5, mod = 2, price = 500*10000},
		{name = "Rollas", wtype = 5, mod = 3, price = 500*10000},
		{name = "Driffmeister", wtype = 5, mod = 4, price = 500*10000},
		{name = "Slicer", wtype = 5, mod = 5, price = 500*10000},
		{name = "Elquatro", wtype = 5, mod = 6, price = 500*10000},
		{name = "Dubbed", wtype = 5, mod = 7, price = 500*10000},
		{name = "Fivestar", wtype = 5, mod = 8, price = 500*10000},
		{name = "Slideways", wtype = 5, mod = 9, price = 500*10000},
		{name = "Apex", wtype = 5, mod = 10, price = 500*10000},
		{name = "Stancedeg", wtype = 5, mod = 11, price = 500*10000},
		{name = "Countersteer", wtype = 5, mod = 12, price = 500*10000},
		{name = "Endov1", wtype = 5, mod = 13, price = 500*10000},
		{name = "Endov2dish", wtype = 5, mod = 14, price = 500*10000},
		{name = "Guppez", wtype = 5, mod = 15, price = 500*10000},
		{name = "Chokadori", wtype = 5, mod = 16, price = 500*10000},
		{name = "Chicane", wtype = 5, mod = 17, price = 500*10000},
		{name = "Saisoku", wtype = 5, mod = 18, price = 500*10000},
		{name = "Dishedeight", wtype = 5, mod = 19, price = 500*10000},
		{name = "Fujiwara", wtype = 5, mod = 20, price = 500*10000},
		{name = "Zokusha", wtype = 5, mod = 21, price = 500*10000},
		{name = "Battlevill", wtype = 5, mod = 22, price = 500*10000},
		{name = "Rallymaster", wtype = 5, mod = 23, price = 500*10000},
	},
-----Highend wheels------
	highendwheels = {
		{name = "Stock", wtype = 7, mod = -1, price = 1000*10000},
		{name = "Shadow", wtype = 7, mod = 0, price = 1000*10000},
		{name = "Hyper", wtype = 7, mod = 1, price = 1000*10000},
		{name = "Blade", wtype = 7, mod = 2, price = 1000*10000},
		{name = "Diamond", wtype = 7, mod = 3, price = 1000*10000},
		{name = "Supagee", wtype = 7, mod = 4, price = 1000*10000},
		{name = "Chromaticz", wtype = 7, mod = 5, price = 1000*10000},
		{name = "Merciechlip", wtype = 7, mod = 6, price = 1000*10000},
		{name = "Obeyrs", wtype = 7, mod = 7, price = 1000*10000},
		{name = "Gtchrome", wtype = 7, mod = 8, price = 1000*10000},
		{name = "Cheetahr", wtype = 7, mod = 9, price = 1000*10000},
		{name = "Solar", wtype = 7, mod = 10, price = 1000*10000},
		{name = "Splitten", wtype = 7, mod = 11, price = 1000*10000},
		{name = "Dashvip", wtype = 7, mod = 12, price = 1000*10000},
		{name = "Lozspeedten", wtype = 7, mod = 13, price = 1000*10000},
		{name = "Carboninferno", wtype = 7, mod = 14, price = 1000*10000},
		{name = "Carbonshadow", wtype = 7, mod = 15, price = 1000*10000},
		{name = "Carbonz", wtype = 7, mod = 16, price = 1000*10000},
		{name = "Carbonsolar", wtype = 7, mod = 17, price = 1000*10000},
		{name = "Carboncheetahr", wtype = 7, mod = 18, price = 1000*10000},
		{name = "Carbonsracer", wtype = 7, mod = 19, price = 1000*10000},
	},
-----Lowrider wheels------
	lowriderwheels = {
		{name = "Stock", wtype = 2, mod = -1, price = 200*10000},
		{name = "Flare", wtype = 2, mod = 0, price = 200*10000},
		{name = "Wired", wtype = 2, mod = 1, price = 200*10000},
		{name = "Triplegolds", wtype = 2, mod = 2, price = 200*10000},
		{name = "Bigworm", wtype = 2, mod = 3, price = 200*10000},
		{name = "Sevenfives", wtype = 2, mod = 4, price = 200*10000},
		{name = "Splitsix", wtype = 2, mod = 5, price = 200*10000},
		{name = "Freshmesh", wtype = 2, mod = 6, price = 200*10000},
		{name = "Leadsled", wtype = 2, mod = 7, price = 200*10000},
		{name = "Turbine", wtype = 2, mod = 8, price = 200*10000},
		{name = "Superfin", wtype = 2, mod = 9, price = 200*10000},
		{name = "Classicrod", wtype = 2, mod = 10, price = 200*10000},
		{name = "Dollar", wtype = 2, mod = 11, price = 200*10000},
		{name = "Dukes", wtype = 2, mod = 12, price = 200*10000},
		{name = "Lowfive", wtype = 2, mod = 13, price = 200*10000},
		{name = "Gooch", wtype = 2, mod = 14, price = 200*10000},
	},
-----Muscle wheels-----
	musclewheels = {
		{name = "Stock", wtype = 1, mod = -1, price = 200*10000},
		{name = "Classicfive", wtype = 1, mod = 0, price = 200*10000},
		{name = "Dukes", wtype = 1, mod = 1, price = 200*10000},
		{name = "Musclefreak", wtype = 1, mod = 2, price = 200*10000},
		{name = "Kracka", wtype = 1, mod = 3, price = 200*10000},
		{name = "Azrea", wtype = 1, mod = 4, price = 200*10000},
		{name = "Mecha", wtype = 1, mod = 5, price = 200*10000},
		{name = "Blacktop", wtype = 1, mod = 6, price = 200*10000},
		{name = "Dragspl", wtype = 1, mod = 7, price = 200*10000},
		{name = "Revolver", wtype = 1, mod = 8, price = 200*10000},
		{name = "Classicrod", wtype = 1, mod = 9, price = 200*10000},
		{name = "Spooner", wtype = 1, mod = 10, price = 200*10000},
		{name = "Fivestar", wtype = 1, mod = 11, price = 200*10000},
		{name = "Oldschool", wtype = 1, mod = 12, price = 200*10000},
		{name = "Eljefe", wtype = 1, mod = 13, price = 200*10000},
		{name = "Dodman", wtype = 1, mod = 14, price = 200*10000},
		{name = "Sixgun", wtype = 1, mod = 15, price = 200*10000},
		{name = "Mercenary", wtype = 1, mod = 16, price = 200*10000},
	},
	
---------Trim color--------
	trim = {
		colors = colors,
		price = 100*10000
	},
	
----------Mods-----------
	mods = {
	
----------Liveries--------
	[48] = {
		startprice = 150*10000,
		increaseby = 250*10000
	},
	
----------Windows--------
	[46] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Tank--------
	[45] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Trim--------
	[44] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Aerials--------
	[43] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},

----------Arch cover--------
	[42] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},

----------Struts--------
	[41] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Air filter--------
	[40] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Engine block--------
	[39] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},

----------Hydraulics--------
	[38] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Trunk--------
	[37] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},

----------Speakers--------
	[36] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},

----------Plaques--------
	[35] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Seats--------
	[32] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Door speaker--------
	[31] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},

----------Dial--------
	[30] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
----------Dashboard--------
	[29] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Ornaments--------
	[28] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Trim--------
	[27] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
----------Plate holder--------
	[25] = {
		startprice = 500*10000,
		increaseby = 125*10000
	},
	
---------Headlights---------
	[22] = {
		{name = "Stock Lights", mod = 0, price = 50*10000},
		{name = "Xenon Lights", mod = 1, price = 120*10000},
	},
	
----------Turbo---------
	[18] = {
		{ name = "None", mod = 0, price = 10*10000},
		{ name = "Turbo Tuning", mod = 1, price = 1500*10000},
	},
	
-----------Armor-------------
	[16] = {
		{name = "Armor Upgrade 20%",modtype = 16, mod = 0, price = 300*10000},
		{name = "Armor Upgrade 40%",modtype = 16, mod = 1, price = 500*10000},
		{name = "Armor Upgrade 60%",modtype = 16, mod = 2, price = 750*10000},
		{name = "Armor Upgrade 80%",modtype = 16, mod = 3, price = 1000*10000},
		{name = "Armor Upgrade 100%",modtype = 16, mod = 4, price = 2000*10000},
	},

---------Suspension-----------
	[15] = {
		{name = "Lowered Suspension",mod = 0, price = 100*10000},
		{name = "Street Suspension",mod = 1, price = 200*10000},
		{name = "Sport Suspension",mod = 2, price = 350*10000},
		{name = "Competition Suspension",mod = 3, price = 500*10000},
	},

-----------Horn----------
	[14] = {
		{name = "Truck Horn", mod = 0, price = 30*10000},
		{name = "Police Horn", mod = 1, price = 50*10000},
		{name = "Clown Horn", mod = 2, price = 70*10000},
		{name = "Musical Horn 1", mod = 3, price = 150*10000},
		{name = "Musical Horn 2", mod = 4, price = 150*10000},
		{name = "Musical Horn 3", mod = 5, price = 150*10000},
		{name = "Musical Horn 4", mod = 6, price = 150*10000},
		{name = "Musical Horn 5", mod = 7, price = 150*10000},
		{name = "Sadtrombone Horn", mod = 8, price = 150*10000},
		{name = "Calssical Horn 1", mod = 9, price = 150*10000},
		{name = "Calssical Horn 2", mod = 10, price = 150*10000},
		{name = "Calssical Horn 3", mod = 11, price = 150*10000},
		{name = "Calssical Horn 4", mod = 12, price = 150*10000},
		{name = "Calssical Horn 5", mod = 13, price = 150*10000},
		{name = "Calssical Horn 6", mod = 14, price = 150*10000},
		{name = "Calssical Horn 7", mod = 15, price = 150*10000},
		{name = "Scaledo Horn", mod = 16, price = 150*10000},
		{name = "Scalere Horn", mod = 17, price = 150*10000},
		{name = "Scalemi Horn", mod = 18, price = 150*10000},
		{name = "Scalefa Horn", mod = 19, price = 150*10000},
		{name = "Scalesol Horn", mod = 20, price = 150*10000},
		{name = "Scalela Horn", mod = 21, price = 150*10000},
		{name = "Scaleti Horn", mod = 22, price = 150*10000},
		{name = "Scaledo Horn High", mod = 23, price = 150*10000},
		{name = "Jazz Horn 1", mod = 25, price = 150*10000},
		{name = "Jazz Horn 2", mod = 26, price = 150*10000},
		{name = "Jazz Horn 3", mod = 27, price = 150*10000},
		{name = "Jazzloop Horn", mod = 28, price = 150*10000},
		{name = "Starspangban Horn 1", mod = 29, price = 150*10000},
		{name = "Starspangban Horn 2", mod = 30, price = 150*10000},
		{name = "Starspangban Horn 3", mod = 31, price = 150*10000},
		{name = "Starspangban Horn 4", mod = 32, price = 150*10000},
		{name = "Classicalloop Horn 1", mod = 33, price = 150*10000},
		{name = "Classicalloop Horn 2", mod = 34, price = 150*10000},
		{name = "Classicalloop Horn 3", mod = 35, price = 150*10000},
	},

----------Transmission---------
	[13] = {
		{name = "Street Transmission", mod = 0, price = 500*10000},
		{name = "Sports Transmission", mod = 1, price = 1000*10000},
		{name = "Race Transmission", mod = 2, price = 2000*10000},
	},
	
-----------Brakes-------------
	[12] = {
		{name = "Street Brakes", mod = 0, price = 300*10000},
		{name = "Sport Brakes", mod = 1, price = 500*10000},
		{name = "Race Brakes", mod = 2, price = 1200*10000},
	},
	
------------Engine----------
	[11] = {
		{name = "Upgrade, Stage 1", mod = 0, price = 500*10000},
		{name = "Upgrade, Stage 2", mod = 1, price = 800*10000},
		{name = "Upgrade, Stage 3", mod = 2, price = 1500*10000},
	},
	
-------------Roof----------
	[10] = {
		startprice = 500*10000,
		increaseby = 300*10000
	},
	
------------Fenders---------
	[8] = {
		startprice = 500*10000,
		increaseby = 300*10000
	},
	
------------Hood----------
	[7] = {
		startprice = 500*10000,
		increaseby = 300*10000
	},
	
----------Grille----------
	[6] = {
		startprice = 500*10000,
		increaseby = 300*10000
	},
	
----------Roll cage----------
	[5] = {
		startprice = 500*10000,
		increaseby = 100*10000
	},
	
----------Exhaust----------
	[4] = {
		startprice = 500*10000,
		increaseby = 300*10000
	},
	
----------Skirts----------
	[3] = {
		startprice = 300*10000,
		increaseby = 100*10000
	},
	
-----------Rear bumpers----------
	[2] = {
		startprice = 500*10000,
		increaseby = 300*10000
	},
	
----------Front bumpers----------
	[1] = {
		startprice = 500*10000,
		increaseby = 300*10000
	},
	
----------Spoiler----------
	[0] = {
		startprice = 100*10000,
		increaseby = 120*10000
	},
	}
	
}

------Model Blacklist--------
--Does'nt allow specific vehicles to be upgraded
LSC_Config.ModelBlacklist = {
	"police",
}

--Sets if garage will be locked if someone is inside it already
LSC_Config.lock = true

-- Enable/disable using vrp_adv_garages
LSC_Config.vrp_adv_garages = false

--Enable/disable old entering way
LSC_Config.oldenter = true

--Menu settings
LSC_Config.menu = {

-------Controls--------
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},

-------Menu position-----
	--Possible positions:
	--Left
	--Right
	--Custom position, example: position = {x = 0.2, y = 0.2}
	position = "right",

-------Menu theme--------
	--Possible themes: light, darkred, bluish, greenish
	--Custom example:
	--[[theme = {
		text_color = { r = 255,g = 255, b = 255, a = 255},
		bg_color = { r = 0,g = 0, b = 0, a = 155},
		--Colors when button is selected
		stext_color = { r = 0,g = 0, b = 0, a = 255},
		sbg_color = { r = 255,g = 255, b = 0, a = 200},
	},]]
	theme = "light",
	
--------Max buttons------
	--Default: 10
	maxbuttons = 10,

-------Size---------
	--[[
	Default:
	width = 0.24
	height = 0.36
	]]
	width = 0.24,
	height = 0.36

}