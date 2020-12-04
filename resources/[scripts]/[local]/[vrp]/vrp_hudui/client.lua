----------------- vRP Screen UI
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

vrp_huduiC = {}
Tunnel.bindInterface("vrp_hudui", vrp_huduiC)
Proxy.addInterface("vrp_hudui", vrp_huduiC)
vRP = Proxy.getInterface("vRP")
vrp_huduiS = Tunnel.getInterface("vrp_hudui", "vrp_hudui")

local Config = module("vrp_hudui", "config")
local Locales = module("vrp_hudui", "locales/languages")

local hide_name = false

local function lookupify(t)
	local r = {}
	for _, v in pairs(t) do
		r[v] = true
	end
	return r
end

local blockedRanges = {
	{0x0001F601, 0x0001F64F},
	{0x00002702, 0x000027B0},
	{0x0001F680, 0x0001F6C0},
	--{0x000024C2, 0x0001F251},
	{0x0001F300, 0x0001F5FF},
	{0x00002194, 0x00002199},
	{0x000023E9, 0x000023F3},
	{0x000025FB, 0x000026FD},
	{0x0001F300, 0x0001F5FF},
	{0x0001F600, 0x0001F636},
	{0x0001F681, 0x0001F6C5},
	{0x0001F30D, 0x0001F567}
}

local blockedSingles =
	lookupify {
	0x000000A9,
	0x000000AE,
	0x0000203C,
	0x00002049,
	0x000020E3,
	0x00002122,
	0x00002139,
	0x000021A9,
	0x000021AA,
	0x0000231A,
	0x0000231B,
	0x000025AA,
	0x000025AB,
	0x000025B6,
	0x000025C0,
	0x00002934,
	0x00002935,
	0x00002B05,
	0x00002B06,
	0x00002B07,
	0x00002B1B,
	0x00002B1C,
	0x00002B50,
	0x00002B55,
	0x00003030,
	0x0000303D,
	0x00003297,
	0x00003299,
	0x0001F004,
	0x0001F0CF,
	0x0001F985
}

function removeEmoji(str)
	local codepoints = {}
	for _, codepoint in utf8.codes(str) do
		local insert = true
		if blockedSingles[codepoint] then
			insert = false
		else
			for _, range in ipairs(blockedRanges) do
				if range[1] <= codepoint and codepoint <= range[2] then
					insert = false
					break
				end
			end
		end
		if insert then
			table.insert(codepoints, codepoint)
		end
	end
	return utf8.char(table.unpack(codepoints))
end

local zones = {
	["AIRP"] = "Los Santos International Airport",
	["ALAMO"] = "Alamo Sea",
	["ALTA"] = "Alta",
	["ARMYB"] = "Fort Zancudo",
	["BANHAMC"] = "Banham Canyon Dr",
	["BANNING"] = "Banning",
	["BEACH"] = "Vespucci Beach",
	["BHAMCA"] = "Banham Canyon",
	["BRADP"] = "Braddock Pass",
	["BRADT"] = "Braddock Tunnel",
	["BURTON"] = "Burton",
	["CALAFB"] = "Calafia Bridge",
	["CANNY"] = "Raton Canyon",
	["CCREAK"] = "Cassidy Creek",
	["CHAMH"] = "Chamberlain Hills",
	["CHIL"] = "Vinewood Hills",
	["CHU"] = "Chumash",
	["CMSW"] = "Chiliad Mountain State Wilderness",
	["CYPRE"] = "Cypress Flats",
	["DAVIS"] = "Davis",
	["DELBE"] = "Del Perro Beach",
	["DELPE"] = "Del Perro",
	["DELSOL"] = "La Puerta",
	["DESRT"] = "Grand Senora Desert",
	["DOWNT"] = "Downtown",
	["DTVINE"] = "Downtown Vinewood",
	["EAST_V"] = "East Vinewood",
	["EBURO"] = "El Burro Heights",
	["ELGORL"] = "El Gordo Lighthouse",
	["ELYSIAN"] = "Elysian Island",
	["GALFISH"] = "Galilee",
	["GOLF"] = "GWC and Golfing Society",
	["GRAPES"] = "Grapeseed",
	["GREATC"] = "Great Chaparral",
	["HARMO"] = "Harmony",
	["HAWICK"] = "Hawick",
	["HORS"] = "Vinewood Racetrack",
	["HUMLAB"] = "Humane Labs and Research",
	["JAIL"] = "Bolingbroke Penitentiary",
	["KOREAT"] = "Little Seoul",
	["LACT"] = "Land Act Reservoir",
	["LAGO"] = "Lago Zancudo",
	["LDAM"] = "Land Act Dam",
	["LEGSQU"] = "Legion Square",
	["LMESA"] = "La Mesa",
	["LOSPUER"] = "La Puerta",
	["MIRR"] = "Mirror Park",
	["MORN"] = "Morningwood",
	["MOVIE"] = "Richards Majestic",
	["MTCHIL"] = "Mount Chiliad",
	["MTGORDO"] = "Mount Gordo",
	["MTJOSE"] = "Mount Josiah",
	["MURRI"] = "Murrieta Heights",
	["NCHU"] = "North Chumash",
	["NOOSE"] = "N.O.O.S.E",
	["OCEANA"] = "Pacific Ocean",
	["PALCOV"] = "Paleto Cove",
	["PALETO"] = "Paleto Bay",
	["PALFOR"] = "Paleto Forest",
	["PALHIGH"] = "Palomino Highlands",
	["PALMPOW"] = "Palmer-Taylor Power Station",
	["PBLUFF"] = "Pacific Bluffs",
	["PBOX"] = "Pillbox Hill",
	["PROCOB"] = "Procopio Beach",
	["RANCHO"] = "Rancho",
	["RGLEN"] = "Richman Glen",
	["RICHM"] = "Richman",
	["ROCKF"] = "Rockford Hills",
	["RTRAK"] = "Redwood Lights Track",
	["SANAND"] = "San Andreas",
	["SANCHIA"] = "San Chianski Mountain Range",
	["SANDY"] = "Sandy Shores",
	["SKID"] = "Mission Row",
	["SLAB"] = "Stab City",
	["STAD"] = "Maze Bank Arena",
	["STRAW"] = "Strawberry",
	["TATAMO"] = "Tataviam Mountains",
	["TERMINA"] = "Terminal",
	["TEXTI"] = "Textile City",
	["TONGVAH"] = "Tongva Hills",
	["TONGVAV"] = "Tongva Valley",
	["VCANA"] = "Vespucci Canals",
	["VESP"] = "Vespucci",
	["VINE"] = "Vinewood",
	["WINDF"] = "Ron Alternates Wind Farm",
	["WVINE"] = "West Vinewood",
	["ZANCUDO"] = "Zancudo River",
	["ZP_ORT"] = "Port of South Los Santos",
	["ZQ_UAR"] = "Davis Quartz"
}

local Keys = {
	["ESC"] = 322,
	["F1"] = 288,
	["F2"] = 289,
	["F3"] = 170,
	["F5"] = 166,
	["F6"] = 167,
	["F7"] = 168,
	["F8"] = 169,
	["F9"] = 56,
	["F10"] = 57,
	["~"] = 243,
	["1"] = 157,
	["2"] = 158,
	["3"] = 160,
	["4"] = 164,
	["5"] = 165,
	["6"] = 159,
	["7"] = 161,
	["8"] = 162,
	["9"] = 163,
	["-"] = 84,
	["="] = 83,
	["BACKSPACE"] = 177,
	["TAB"] = 37,
	["Q"] = 44,
	["W"] = 32,
	["E"] = 38,
	["R"] = 45,
	["T"] = 245,
	["Y"] = 246,
	["U"] = 303,
	["P"] = 199,
	["["] = 39,
	["]"] = 40,
	["ENTER"] = 18,
	["CAPS"] = 137,
	["A"] = 34,
	["S"] = 8,
	["D"] = 9,
	["F"] = 23,
	["G"] = 47,
	["H"] = 74,
	["K"] = 311,
	["L"] = 182,
	["LEFTSHIFT"] = 21,
	["Z"] = 20,
	["X"] = 73,
	["C"] = 26,
	["V"] = 0,
	["B"] = 29,
	["N"] = 249,
	["M"] = 244,
	[","] = 82,
	["."] = 81,
	["LEFTCTRL"] = 36,
	["LEFTALT"] = 19,
	["SPACE"] = 22,
	["RIGHTCTRL"] = 70,
	["HOME"] = 213,
	["PAGEUP"] = 10,
	["PAGEDOWN"] = 11,
	["DELETE"] = 178,
	["LEFT"] = 174,
	["RIGHT"] = 175,
	["TOP"] = 27,
	["DOWN"] = 173,
	["NENTER"] = 201,
	["N4"] = 108,
	["N5"] = 60,
	["N6"] = 107,
	["N+"] = 96,
	["N-"] = 97,
	["N7"] = 117,
	["N8"] = 61,
	["N9"] = 118,
	["INSERT"] = 121
}

local AllWeapons =
	json.decode(
	'{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"pistol":"0x1B06D571","pistol_mk2":"0xBFE256D4","combatpistol":"0x5EF9FEC4","appistol":"0x22D8FE39","stungun":"0x3656C8C1","pistol50":"0x99AEEB3B","snspistol":"0xBFD21232","snspistol_mk2":"0x88374054","heavypistol":"0xD205520E","vintagepistol":"0x83839C4","flaregun":"0x47757124","marksmanpistol":"0xDC4DB296","revolver":"0xC1B3C3D1","revolver_mk2":"0xCB96392F","doubleaction":"0x97EA20B8","raypistol":"0xAF3696A1"},"smg":{"microsmg":"0x13532244","smg":"0x2BE6766B","smg_mk2":"0x78A97CD0","assaultsmg":"0xEFE7E2DF","combatpdw":"0xA3D4D34","machinepistol":"0xDB1AA450","minismg":"0xBD248B55","raycarbine":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"assaultrifle":"0xBFEFFF6D","assaultrifle_mk2":"0x394F415C","carbinerifle":"0x83BF0278","carbinerifle_mk2":"0xFAD1F1C9","advancedrifle":"0xAF113F99","specialcarbine":"0xC0A3098D","specialcarbine_mk2":"0x969C3D67","bullpuprifle":"0x7F229F94","bullpuprifle_mk2":"0x84D6FAFD","compactrifle":"0x624FE830"},"machine_guns":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776"}}'
)

function _U(entry)
	return Locales[Config.Locale][entry]
end

local vehiclesCars = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 17, 18, 19, 20}

function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

-- Hides TREW UI when it's on Pause Menu
Citizen.CreateThread(
	function()
		local isPauseMenu = false

		while true do
			Citizen.Wait(0)

			if IsPauseMenuActive() then -- ESC Key
				if not isPauseMenu then
					isPauseMenu = not isPauseMenu
					SendNUIMessage({action = "toggleUi", value = false})
				end
			else
				if isPauseMenu then
					isPauseMenu = not isPauseMenu
					SendNUIMessage({action = "toggleUi", value = true})
				end

				HideHudComponentThisFrame(1) -- Wanted Stars
				HideHudComponentThisFrame(2) -- Weapon Icon
				HideHudComponentThisFrame(3) -- Cash
				HideHudComponentThisFrame(4) -- MP Cash
				HideHudComponentThisFrame(6) -- Vehicle Name
				HideHudComponentThisFrame(7) -- Area Name
				HideHudComponentThisFrame(8) -- Vehicle Class
				HideHudComponentThisFrame(9) -- Street Name
				HideHudComponentThisFrame(13) -- Cash Change
				HideHudComponentThisFrame(17) -- Save Game
				HideHudComponentThisFrame(20) -- Weapon Stats
			end
		end
	end
)

-- Date and time update
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if Config.ui.showDate == true then
				SendNUIMessage({action = "setText", id = "date", value = trewDate()})
			end
		end
	end
)

-- Location update
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(100)

			local player = GetPlayerPed(-1)

			local position = GetEntityCoords(player)

			if Config.ui.showLocation == true then
				local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
				local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

				local locationMessage = nil

				if zoneNameFull then
					locationMessage = streetName .. ", " .. zoneNameFull
				else
					locationMessage = streetName
				end

				locationMessage = string.format(Locales[Config.Locale]["you_are_on_location"], locationMessage)

				SendNUIMessage({action = "setText", id = "location", value = locationMessage})
			end
		end
	end
)

local isTest = false
local isShowUI = false
local showUILevel = 0
local showDelay = 10000
if isTest then
	showDelay = 1000
end

local currentVoiceLevel = 1

-- Vehicle Info
local vehicleCruiser
local vehicleSignalIndicator = "off"
local seatbeltEjectSpeed = 45.0
local seatbeltEjectAccel = 100.0
local seatbeltIsOn = false
local seatbeltWarning = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}
local prevVehHealth = 0

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(500)

			SetRadarBigmapEnabled(false, false)

			local player = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(player, false)
			local position = GetEntityCoords(player)
			local vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
			local vehicleInfo

			if IsPedInAnyVehicle(player, false) and vehicleIsOn then
				local vehicleClass = GetVehicleClass(vehicle)

				if Config.ui.showMinimap == false then
					DisplayRadar(true)
				end

				-- Vehicle Speed
				local vehicleSpeedSource = GetEntitySpeed(vehicle)
				local vehicleSpeed
				if Config.vehicle.speedUnit == "MPH" then
					vehicleSpeed = math.ceil(vehicleSpeedSource * 2.237)
				else
					vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
				end

				-- Vehicle Gradient Speed
				local vehicleNailSpeed

				if vehicleSpeed > Config.vehicle.maxSpeed then
					vehicleNailSpeed = math.ceil(280 - math.ceil(math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed))
				else
					vehicleNailSpeed = math.ceil(280 - math.ceil(math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed))
				end

				-- Vehicle Fuel and Gear
				local vehicleFuel
				vehicleFuel = GetVehicleFuelLevel(vehicle)

				local vehicleGear = GetVehicleCurrentGear(vehicle)

				if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
					vehicleGear = "N"
				elseif vehicleSpeed > 0 and vehicleGear == 0 then
					vehicleGear = "R"
				end

				-- Vehicle Lights
				local vehicleVal, vehicleLights, vehicleHighlights = GetVehicleLightsState(vehicle)
				local vehicleIsLightsOn
				if vehicleLights == 1 and vehicleHighlights == 0 then
					vehicleIsLightsOn = "normal"
				elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
					vehicleIsLightsOn = "high"
				else
					vehicleIsLightsOn = "off"
				end

				-- Vehicle Siren
				local vehicleSiren

				if IsVehicleSirenOn(vehicle) then
					vehicleSiren = true
				else
					vehicleSiren = false
				end

				-- Vehicle Seatbelt
				if has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8 then
					local prevSpeed = currSpeed
					currSpeed = vehicleSpeedSource

					SetPedConfigFlag(PlayerPedId(), 32, true)

					local vehBodyHealth = GetVehicleBodyHealth(vehicle)

					if not seatbeltIsOn then
						local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > -1.0
						local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
						if vehIsMovingFwd and vehBodyHealth < prevVehHealth and prevSpeed > (seatbeltEjectSpeed / 2.237) and vehAcc > (seatbeltEjectAccel * 9.81) then
							SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
							SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
							SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
						else
							-- Update previous velocity for ejecting player
							prevVelocity = GetEntityVelocity(vehicle)
						end
						if seatbeltWarning == false then
							seatbeltWarning = true
							SendNUIMessage({action = "seatbelt", status = true})
						end
					else
						DisableControlAction(0, 75)
						SendNUIMessage({action = "seatbelt", status = false})
					end

					prevVehHealth = vehBodyHealth
				end

				vehicleInfo = {
					action = "updateVehicle",
					status = true,
					speed = vehicleSpeed,
					nail = vehicleNailSpeed,
					gear = vehicleGear,
					fuel = vehicleFuel,
					lights = vehicleIsLightsOn,
					signals = vehicleSignalIndicator,
					cruiser = vehicleCruiser,
					type = vehicleClass,
					siren = vehicleSiren,
					seatbelt = {},
					config = {
						speedUnit = Config.vehicle.speedUnit,
						maxSpeed = Config.vehicle.maxSpeed
					}
				}

				vehicleInfo["seatbelt"]["status"] = seatbeltIsOn
			else
				vehicleCruiser = false
				vehicleNailSpeed = 0
				vehicleSignalIndicator = "off"

				seatbeltIsOn = false
				seatbeltWarning = false
				SendNUIMessage({action = "seatbelt", status = false})

				vehicleInfo = {
					action = "updateVehicle",
					status = false,
					nail = vehicleNailSpeed,
					seatbelt = {status = seatbeltIsOn},
					cruiser = vehicleCruiser,
					signals = vehicleSignalIndicator,
					type = 0
				}

				if Config.ui.showMinimap == false then
					DisplayRadar(false)
				end
			end

			SendNUIMessage(vehicleInfo)
		end
	end
)

Citizen.CreateThread(
	function()
		local minimap = RequestScaleformMovie("minimap")
		SetRadarBigmapEnabled(true, false)
		Wait(0)
		SetRadarBigmapEnabled(false, false)
		while true do
			Wait(100)
			BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
			ScaleformMovieMethodAddParamInt(3)
			EndScaleformMovieMethod()
		end
	end
)

function SetNotificationTextEntry()
end

-- Player status
Citizen.CreateThread(
	function()
		DisplayRadar(true)
		SetNotificationTextEntry("STRING")
		AddTextComponentString("ok")
		DrawNotification(true, false)

		while true do
			Citizen.Wait(1000)

			local playerStatus
			local showPlayerStatus = 0
			playerStatus = {action = "setStatus", status = {}}

			if Config.ui.showHealth == true then
				showPlayerStatus = (showPlayerStatus + 1)

				playerStatus["isdead"] = false

				playerStatus["status"][showPlayerStatus] = {
					name = "health",
					value = GetEntityHealth(GetPlayerPed(-1)) - 100
				}

				if IsEntityDead(GetPlayerPed(-1)) then
					playerStatus.isdead = true
				end
			end

			if Config.ui.showArmor == true then
				showPlayerStatus = (showPlayerStatus + 1)

				playerStatus["status"][showPlayerStatus] = {
					name = "armor",
					value = GetPedArmour(GetPlayerPed(-1))
				}
			end

			if Config.ui.showStamina == true then
				showPlayerStatus = (showPlayerStatus + 1)

				playerStatus["status"][showPlayerStatus] = {
					name = "stamina",
					value = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
				}
			end

			if showPlayerStatus > 0 then
				SendNUIMessage(playerStatus)
			end
		end
	end
)

-- Voice detection and distance
Citizen.CreateThread(
	function()
		if Config.ui.showVoice == true then
			RequestAnimDict("facials@gen_male@variations@normal")
			RequestAnimDict("mp_facial")

			while true do
				Citizen.Wait(300)
				local playerID = PlayerId()

				for _, player in ipairs(GetActivePlayers()) do
					local boolTalking = NetworkIsPlayerTalking(player)

					if player ~= playerID then
						if boolTalking then
							PlayFacialAnim(GetPlayerPed(player), "mic_chatter", "mp_facial")
						elseif not boolTalking then
							PlayFacialAnim(GetPlayerPed(player), "mood_normal_1", "facials@gen_male@variations@normal")
						end
					end
				end
			end
		end
	end
)

GetPedMugshot = function(ped, transparent)
	if DoesEntityExist(ped) then
		local mugshot

		if transparent then
			mugshot = RegisterPedheadshotTransparent(ped)
		else
			mugshot = RegisterPedheadshot(ped)
		end

		while not IsPedheadshotReady(mugshot) do
			Citizen.Wait(0)
		end

		return mugshot, GetPedheadshotTxdString(mugshot)
	else
		return
	end
end

RegisterNetEvent("vrp_hudui:ping_res")
AddEventHandler(
	"vrp_hudui:ping_res",
	function(ping)
		SendNUIMessage({action = "update_ping", data = ping})
	end
)

mugshotStr = nil

Citizen.CreateThread(
	function()
		while true do
			SendNUIMessage({action = "update_players", data = playerNum})
			Citizen.Wait(10000)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			fps = math.floor(1.0 / GetFrameTime())
			SendNUIMessage({action = "update_fps", data = fps})
			Citizen.Wait(1000)
		end
	end
)

Citizen.CreateThread(
	function()
		while false do
			TriggerServerEvent("vrp_hudui:ping_req")
			Citizen.Wait(1000)
		end
	end
)

Citizen.CreateThread(
	function()
		while false do
			mugshot, mugshotStr = GetPedMugshot(GetPlayerPed(-1))
			UnregisterPedheadshot(mugshot)
			Citizen.Wait(5000)
		end
	end
)

Citizen.CreateThread(
	function()
		while false do
			Citizen.Wait(0)
			if mugshotStr ~= nil then
				DrawSprite(mugshotStr, mugshotStr, 0.21, 0.918, 0.045, 0.085, 0.0, 255, 255, 255, 255)
			end
		end
	end
)

local minimapAnchor = {}
local userInfo = {
	source = nil,
	userId = nil,
	nickName = nil,
	name = nil,
	jobName = nil
}
playerNum = 0

function vrp_huduiC.getServerInfo(data)
	playerNum = data.playerNum
end

function vrp_huduiC.getUserInfo(data)
	SendNUIMessage({action = "setMoney", id = "wallet", value = data["money"]})
	SendNUIMessage({action = "setMoney", id = "bank", value = data["bankMoney"]})
	SendNUIMessage({action = "setMoney", id = "credit", value = data["credit"]})

	local playerStatus
	local showPlayerStatus = 0
	playerStatus = {action = "setStatus", status = {}}

	if Config.ui.showHunger == true then
		showPlayerStatus = (showPlayerStatus + 1)

		playerStatus["status"][showPlayerStatus] = {
			name = "hunger",
			value = data["hunger"]
		}
	end

	if Config.ui.showThirst == true then
		showPlayerStatus = (showPlayerStatus + 1)

		playerStatus["status"][showPlayerStatus] = {
			name = "thirst",
			value = data["thirst"]
		}
	end

	if showPlayerStatus > 0 then
		SendNUIMessage(playerStatus)
	end
end

function vrp_huduiC.getUserProfileInfo(data)
	userInfo = data
	if userInfo then
		userInfo.nickName = removeEmoji(userInfo.nickName)
		if not userInfo.jobName or userInfo.jobName == "" then
			userInfo.jobName = "없음"
		end
		if not userInfo.phone or userInfo.phone == "" then
			userInfo.phone = "미발급"
		end
	end
end

function drawRct(x, y, width, height, r, g, b, a)
	DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			minimapAnchor = GetMinimapAnchor()
			Citizen.Wait(10000)
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(showDelay)
		while true do
			if isShowUI then
				if userInfo and userInfo.userId then
					if minimapAnchor and minimapAnchor.right_x and minimapAnchor.y then
						DrawTxt(minimapAnchor.right_x + 0.02, minimapAnchor.y + 0.01, 0.00, 0.00, 0.35, "~w~유저: ~r~" .. userInfo.userId .. "~w~ | " .. userInfo.nickName, 255, 255, 255, 255)
						DrawTxt(minimapAnchor.right_x + 0.02, minimapAnchor.y + 0.045, 0.00, 0.00, 0.35, "~w~이름:~g~" .. userInfo.name .. "~w~", 255, 255, 255, 255)
						DrawTxt(minimapAnchor.right_x + 0.02, minimapAnchor.y + 0.08, 0.00, 0.00, 0.35, "~w~직업:~g~" .. userInfo.jobName .. "~w~", 255, 255, 255, 255)
						DrawTxt(minimapAnchor.right_x + 0.02, minimapAnchor.y + 0.115, 0.00, 0.00, 0.35, "~w~전화번호:~b~" .. userInfo.phone .. "~w~", 255, 255, 255, 255)
					end
				end
			end
			Citizen.Wait(1)
		end
	end
)

local isShowTalkerMarker = false
local isShowTalkerMarkerTimer = 0
local isRestTalker = false

function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if vRP.isRTalked() then
				if not isRestTalker then
					isRestTalker = true
					SendNUIMessage({action = "setVoiceDistance", value = "lock"})
				end
			else
				if isRestTalker then
					isRestTalker = false
					SendNUIMessage({action = "setVoiceDistance", value = Config.voice.levels.type[currentVoiceLevel].name})
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(5000)
		NetworkSetTalkerProximity(Config.voice.levels.type[currentVoiceLevel].value)

		if Config.ui.showVoice == true then
			local isTalking = false

			while true do
				Citizen.Wait(0)

				--DrawTxt(0.40, 0.05, 0.00, 0.00, 0.41, "~w~" .. NetworkGetTalkerProximity(), 255, 255, 255, 255)

				if isRestTalker then
					DisableControlAction(0, 245, true)
					if NetworkIsPlayerTalking(PlayerId()) then
						NetworkSetTalkerProximity(Config.voice.levels.type[3].value)
					else
						NetworkSetTalkerProximity(Config.voice.levels.type[1].value)
					end
				else
					if NetworkIsPlayerTalking(PlayerId()) then
						if not isTalking then
							isTalking = not isTalking
							SendNUIMessage({action = "isTalking", value = isTalking})
						end
					else
						if isTalking then
							isTalking = not isTalking
							SendNUIMessage({action = "isTalking", value = isTalking})
						end
					end
				end

				if IsControlJustPressed(1, Keys[Config.voice.keys.distance]) then
					if isRestTalker then
						TriggerEvent("pNotify:SendNotification", {text = "당신은 현재 입막음 상태입니다.", type = "warning", timeout = 1500, layout = "centerLeft"})
					else
						isShowTalkerMarkerTimer = 0
						if isShowTalkerMarker or currentVoiceLevel == 3 then
							if currentVoiceLevel == 3 then
								isShowTalkerMarker = true
							end
							currentVoiceLevel = currentVoiceLevel + 1
							if currentVoiceLevel > #Config.voice.levels.type then
								currentVoiceLevel = 1
							end
							NetworkSetTalkerProximity(Config.voice.levels.type[currentVoiceLevel].value)
							SendNUIMessage({action = "setVoiceDistance", value = Config.voice.levels.type[currentVoiceLevel].name})
						else
							isShowTalkerMarker = true
						end
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local playerPed = GetPlayerPed(-1)
			local playerCoords = GetEntityCoords(playerPed)
			if isShowTalkerMarker then
				isShowTalkerMarkerTimer = isShowTalkerMarkerTimer + 1
				if isShowTalkerMarkerTimer > 100 then
					isShowTalkerMarker = false
					isShowTalkerMarkerTimer = 0
				end
				local range = Config.voice.levels.type[currentVoiceLevel].value
				local color = {255, 255, 255}
				if currentVoiceLevel == 1 then
					color = {0, 255, 0}
				elseif currentVoiceLevel == 2 then
					color = {255, 0, 0}
				elseif currentVoiceLevel == 3 then
					color = {0, 0, 0}
				elseif currentVoiceLevel == 4 then
					color = {255, 255, 0}
				end
				DrawMarker(1, playerCoords.x, playerCoords.y, playerCoords.z - 1.5, 0, 0, 0, 0, 0, 0, range * 2.01, range * 2.01, 1.5, color[1], color[2], color[3], 200, 0, 0, 2, 0, 0, 0, 0)
			end
		end
	end
)

-- Weapons
Citizen.CreateThread(
	function()
		if Config.ui.showWeapons == true then
			while true do
				Citizen.Wait(100)

				local player = GetPlayerPed(-1)
				local status = {}

				if IsPedArmed(player, 7) then
					local weapon = GetSelectedPedWeapon(player)
					local ammoTotal = GetAmmoInPedWeapon(player, weapon)
					local bool, ammoClip = GetAmmoInClip(player, weapon)
					local ammoRemaining = math.floor(ammoTotal - ammoClip)

					status["armed"] = true

					for key, value in pairs(AllWeapons) do
						for keyTwo, valueTwo in pairs(AllWeapons[key]) do
							if weapon == GetHashKey("weapon_" .. keyTwo) then
								status["weapon"] = keyTwo

								if key == "melee" then
									SendNUIMessage({action = "element", task = "disable", value = "weapon_bullets"})
									SendNUIMessage({action = "element", task = "disable", value = "bullets"})
								else
									if keyTwo == "stungun" then
										SendNUIMessage({action = "element", task = "disable", value = "weapon_bullets"})
										SendNUIMessage({action = "element", task = "disable", value = "bullets"})
									else
										SendNUIMessage({action = "element", task = "enable", value = "weapon_bullets"})
										SendNUIMessage({action = "element", task = "enable", value = "bullets"})
									end
								end
							end
						end
					end

					SendNUIMessage({action = "setText", id = "weapon_clip", value = ammoClip})
					SendNUIMessage({action = "setText", id = "weapon_ammo", value = ammoRemaining})
				else
					status["armed"] = false
				end

				SendNUIMessage({action = "updateWeapon", status = status})
			end
		end
	end
)

-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			local player = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(player, false)
			local vehicleClass = GetVehicleClass(vehicle)

			-- Vehicle Seatbelt
			if IsPedInAnyVehicle(player, false) and GetIsVehicleEngineRunning(vehicle) then
				if IsControlJustReleased(0, Keys[Config.vehicle.keys.seatbelt]) and (has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8) then
					seatbeltIsOn = not seatbeltIsOn
					if seatbeltIsOn then
						seatbeltWarning = false
						TriggerEvent("pNotify:SendNotification", {text = "안전벨트가 착용되었습니다.", type = "success", timeout = 1400, layout = "centerLeft"})
					else
						TriggerEvent("pNotify:SendNotification", {text = "안전벨트가 해제되었습니다.", type = "error", timeout = 1400, layout = "centerLeft"})
					end
				end
			end

			-- Vehicle Cruiser
			if IsControlJustPressed(1, Keys[Config.vehicle.keys.cruiser]) and GetPedInVehicleSeat(vehicle, -1) == player and (has_value(vehiclesCars, vehicleClass) == true) then
				local vehicleSpeedSource = GetEntitySpeed(vehicle)

				if vehicleCruiser == "on" then
					vehicleCruiser = "off"
					SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
				else
					vehicleCruiser = "on"
					SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
				end
			end

			-- Vehicle Signal Lights
			if not IsControlJustPressed(1, Keys[Config.vehicle.keys.signalRight]) and IsControlJustReleased(1, Keys[Config.vehicle.keys.signalLeft]) and (has_value(vehiclesCars, vehicleClass) == true) then
				if vehicleSignalIndicator == "off" then
					vehicleSignalIndicator = "left"
				else
					vehicleSignalIndicator = "off"
				end

				TriggerEvent("vrp_hudui:setCarSignalLights", vehicleSignalIndicator)
			end

			if not IsControlJustPressed(1, Keys[Config.vehicle.keys.signalLeft]) and IsControlJustReleased(1, Keys[Config.vehicle.keys.signalRight]) and (has_value(vehiclesCars, vehicleClass) == true) then
				if vehicleSignalIndicator == "off" then
					vehicleSignalIndicator = "right"
				else
					vehicleSignalIndicator = "off"
				end

				TriggerEvent("vrp_hudui:setCarSignalLights", vehicleSignalIndicator)
			end

			if IsControlJustReleased(1, Keys[Config.vehicle.keys.signalBoth]) and (has_value(vehiclesCars, vehicleClass) == true) then
				if vehicleSignalIndicator == "off" then
					vehicleSignalIndicator = "both"
				else
					vehicleSignalIndicator = "off"
				end

				TriggerEvent("vrp_hudui:setCarSignalLights", vehicleSignalIndicator)
			end
		end
	end
)

local uiModeTextShowTime = 0
local uiModeName = {"~r~[0] 전체숨김", "~y~[1] 최소표시", "~b~[2] 이름숨김", "~g~[3] 모두표시"}

function applyUIMode()
	uiModeTextShowTime = 5
	if showUILevel == 3 then
		TriggerEvent("vrp_hudui_ex:changeShowUI", true)
		TriggerEvent("chat:changeShowUI", true)
		TriggerEvent("vrp_names_ex:changeShowUI", true)
		TriggerEvent("gameui:changeShowUI", true)
		DisplayRadar(true)
	elseif showUILevel == 2 then
		TriggerEvent("vrp_hudui_ex:changeShowUI", true)
		TriggerEvent("chat:changeShowUI", true)
		TriggerEvent("vrp_names_ex:changeShowUI", false)
		TriggerEvent("gameui:changeShowUI", true)
		DisplayRadar(true)
	elseif showUILevel == 1 then
		TriggerEvent("vrp_hudui_ex:changeShowUI", false)
		TriggerEvent("chat:changeShowUI", true)
		TriggerEvent("vrp_names_ex:changeShowUI", false)
		TriggerEvent("gameui:changeShowUI", false)
		DisplayRadar(false)
	elseif showUILevel == 0 then
		TriggerEvent("vrp_hudui_ex:changeShowUI", false)
		TriggerEvent("chat:changeShowUI", false)
		TriggerEvent("vrp_names_ex:changeShowUI", false)
		TriggerEvent("gameui:changeShowUI", false)
		DisplayRadar(false)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
		if GetDistanceBetweenCoords(259.97027587891,223.0952911377,106.28517913818, GetEntityCoords(playerPed)) < 63.0 or GetDistanceBetweenCoords(-1883.2252197266,2063.6071777344,140.98416137695, GetEntityCoords(playerPed)) < 60.0 then
			DisableControlAction(0, 244, true)
			if hide_name == false then
				hide_name = true
				TriggerEvent("vrp_names_ex:changeShowUI", false)
				vRP.notify({"~r~[ 리얼월드 ]~w~\n이름표가 ~r~비활성화~w~ 되었습니다."})
    end
    else
if hide_name == true then
		hide_name = false
		TriggerEvent("vrp_names_ex:changeShowUI", true)
    vRP.notify({"~g~[ 리얼월드 ]~w~\n이름표가 ~g~활성화~w~ 되었습니다."})
    end
end
end
end)

Citizen.CreateThread(
	function()
		Citizen.Wait(500)
		SendNUIMessage({action = "ui", config = Config.ui})
		SendNUIMessage({action = "setFont", url = Config.font.url, name = Config.font.name})
		SendNUIMessage({action = "setLogo", value = Config.serverLogo})

		Citizen.Wait(showDelay)

		isShowUI = true
		showUILevel = 3
		TriggerEvent("vrp_hudui_ex:changeShowUI", true)
		TriggerEvent("chat:changeShowUI", true)
		TriggerEvent("vrp_names_ex:changeShowUI", true)
		TriggerEvent("gameui:changeShowUI", true)
		DisplayRadar(true)
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsControlJustPressed(0, 244) and IsControlPressed(0, 21) then
				showUILevel = showUILevel - 1
				if showUILevel < 0 then
					showUILevel = 3
				end
				applyUIMode()
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if uiModeTextShowTime > 0 then
				uiModeTextShowTime = uiModeTextShowTime - 1
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if uiModeTextShowTime > 0 then
				DrawTxt(0.40, 0.05, 0.00, 0.00, 0.41, "~w~인터페이스 모드: " .. uiModeName[showUILevel + 1], 255, 255, 255, 255)
			end
		end
	end
)

RegisterNetEvent("vrp_hudui_ex:changeShowUI")
AddEventHandler(
	"vrp_hudui_ex:changeShowUI",
	function(isShow)
		isShowUI = isShow
		SendNUIMessage({action = "toggle_ui", data = isShowUI})
	end
)

RegisterNetEvent("vrp_hudui_ex:changeUIMode")
AddEventHandler(
	"vrp_hudui_ex:changeUIMode",
	function(mode)
		showUILevel = mode
		applyUIMode()
	end
)

AddEventHandler(
	"playerSpawned",
	function()
		HideHudComponentThisFrame(7) -- Area
		HideHudComponentThisFrame(9) -- Street
		HideHudComponentThisFrame(6) -- Vehicle
		HideHudComponentThisFrame(3) -- SP Cash
		HideHudComponentThisFrame(4) -- MP Cash
		HideHudComponentThisFrame(13) -- Cash changes!
	end
)

AddEventHandler(
	"vrp_hudui:setCarSignalLights",
	function(status)
		local driver = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local hasTrailer, vehicleTrailer = GetVehicleTrailerVehicle(driver, vehicleTrailer)
		local leftLight
		local rightLight

		if status == "left" then
			leftLight = false
			rightLight = true
			if hasTrailer then
				driver = vehicleTrailer
			end
		elseif status == "right" then
			leftLight = true
			rightLight = false
			if hasTrailer then
				driver = vehicleTrailer
			end
		elseif status == "both" then
			leftLight = true
			rightLight = true
			if hasTrailer then
				driver = vehicleTrailer
			end
		else
			leftLight = false
			rightLight = false
			if hasTrailer then
				driver = vehicleTrailer
			end
		end

		TriggerServerEvent("vrp_hudui:syncCarLights", status)

		SetVehicleIndicatorLights(driver, 0, leftLight)
		SetVehicleIndicatorLights(driver, 1, rightLight)
	end
)

RegisterNetEvent("vrp_hudui:syncCarLights")
AddEventHandler(
	"vrp_hudui:syncCarLights",
	function(serverId, status)
		local playerId = GetPlayerFromServerId(serverId)
		if playerId ~= PlayerId() and playerId ~= -1 then
			local driver = GetVehiclePedIsIn(GetPlayerPed(playerId), false)

			if status == "left" then
				leftLight = false
				rightLight = true
			elseif status == "right" then
				leftLight = true
				rightLight = false
			elseif status == "both" then
				leftLight = true
				rightLight = true
			else
				leftLight = false
				rightLight = false
			end

			if driver ~= 0 then
				SetVehicleIndicatorLights(driver, 0, leftLight)
				SetVehicleIndicatorLights(driver, 1, rightLight)
			end
		end
	end
)

function trewDate()
	local timeString = nil

	local day = _U("day_" .. GetClockDayOfMonth())
	local weekDay = _U("weekDay_" .. GetClockDayOfWeek())
	local month = _U("month_" .. GetClockMonth())
	local day = _U("day_" .. GetClockDayOfMonth())
	local year = GetClockYear()

	local hour = GetClockHours()
	local minutes = GetClockMinutes()
	local time = nil
	local AmPm = ""

	if Config.date.AmPm == true then
		if hour >= 13 and hour <= 24 then
			hour = hour - 12
			AmPm = "PM"
		else
			if hour == 0 or hour == 24 then
				hour = 12
			end
			AmPm = "AM"
		end
	end

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minutes <= 9 then
		minutes = "0" .. minutes
	end

	time = hour .. ":" .. minutes .. " " .. AmPm

	local date_format = Locales[Config.Locale]["date_format"][Config.date.format]

	if Config.date.format == "default" then
		timeString = string.format(date_format, year, month, day, time)
	elseif Config.date.format == "simple" then
		timeString = string.format(date_format, day, month)
	elseif Config.date.format == "simpleWithHours" then
		timeString = string.format(date_format, time, day, month)
	elseif Config.date.format == "withWeekday" then
		timeString = string.format(date_format, weekDay, day, month, year)
	elseif Config.date.format == "withHours" then
		timeString = string.format(date_format, time, day, month, year)
	elseif Config.date.format == "withWeekdayAndHours" then
		timeString = string.format(date_format, time, weekDay, day, month, year)
	end

	return timeString
end

function has_value(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

local toggleui = false
RegisterCommand(
	"toggleui",
	function()
		if not toggleui then
			SendNUIMessage({action = "element", task = "disable", value = "job"})
			SendNUIMessage({action = "element", task = "disable", value = "society"})
			SendNUIMessage({action = "element", task = "disable", value = "bank"})
			SendNUIMessage({action = "element", task = "disable", value = "blackMoney"})
			SendNUIMessage({action = "element", task = "disable", value = "wallet"})
			SendNUIMessage({action = "element", task = "disable", value = "credit"})
		else
			if (Config.ui.showJob == true) then
				SendNUIMessage({action = "element", task = "enable", value = "job"})
			end
			if (Config.ui.showSocietyMoney == true) then
				SendNUIMessage({action = "element", task = "enable", value = "society"})
			end
			if (Config.ui.showBankMoney == true) then
				SendNUIMessage({action = "element", task = "enable", value = "bank"})
			end
			if (Config.ui.showBlackMoney == true) then
				SendNUIMessage({action = "element", task = "enable", value = "blackMoney"})
			end
			if (Config.ui.showWalletMoney == true) then
				SendNUIMessage({action = "element", task = "enable", value = "wallet"})
			end
			if (Config.ui.showCreditMoney == true) then
				SendNUIMessage({action = "element", task = "enable", value = "credit"})
			end			
		end

		toggleui = not toggleui
	end
)

exports(
	"createStatus",
	function(args)
		local statusCreation = {action = "createStatus", status = args["status"], color = args["color"], icon = args["icon"]}
		SendNUIMessage(statusCreation)
	end
)

exports(
	"setStatus",
	function(args)
		local playerStatus = {
			action = "setStatus",
			status = {
				{name = args["name"], value = args["value"]}
			}
		}
		SendNUIMessage(playerStatus)
	end
)
