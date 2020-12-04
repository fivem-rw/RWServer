local options = {
	x = 0.88,
	y = 0.2,
	width = 0.22,
	height = 0.04,
	scale = 0.4,
	font = 2,
	menu_title = "Main obj Menu",
	menu_subtitle = "Categories",
	color_r = 30,
	color_g = 144,
	color_b = 255
}
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if DoesEntityExist(a) then
				local position = "objID " .. a
				local offset = {x = 0.290, y = 0.850}
				local rgb = {r = 25, g = 25, b = 140}
				local alpha = 255
				local scale = 0.2
				local font = 0
				SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
				SetTextFont(font)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString(position)
				DrawText(offset.x, offset.y)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if DoesEntityExist(a) then
				local position = "obj rotation " .. entityRot
				local offset = {x = 0.290, y = 0.860}
				local rgb = {r = 25, g = 25, b = 150}
				local alpha = 255
				local scale = 0.2
				local font = 0
				SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
				SetTextFont(font)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString(position)
				DrawText(offset.x, offset.y)
			end
		end
	end
)
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if DoesEntityExist(a) then
				local position = "obj coords " .. entityCoords
				local offset = {x = 0.290, y = 0.870}
				local rgb = {r = 25, g = 25, b = 120}
				local alpha = 255
				local scale = 0.2
				local font = 0
				SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
				SetTextFont(font)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString(position)
				DrawText(offset.x, offset.y)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if DoesEntityExist(a) then
				if DoesEntityHavePhysics(a) then
					c = "yes"
				else
					c = "no"
				end
				local position = "does obj have physics " .. c
				local offset = {x = 0.290, y = 0.880}
				local rgb = {r = 25, g = 25, b = 130}
				local alpha = 255
				local scale = 0.2
				local font = 0
				SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
				SetTextFont(font)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString(position)
				DrawText(offset.x, offset.y)
			end
		end
	end
)
Citizen.CreateThread(
	function()
		while true do
			isEntityAttached = IsEntityAttached(a)
			Citizen.Wait(0)
			if DoesEntityExist(a) then
				if IsEntityAttached(a) then
					d = "yes"
				else
					d = "no"
				end
				local position = "is Entity Attached " .. d
				local offset = {x = 0.290, y = 0.890}
				local rgb = {r = 25, g = 25, b = 160}
				local alpha = 255
				local scale = 0.2
				local font = 0
				SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
				SetTextFont(font)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString(position)
				DrawText(offset.x, offset.y)
			end
		end
	end
)

isEntityAttached = IsEntityAttached(attach)

function Notify(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 1, 1, -1)
end

--[[*************************************************************]]
------------------------------------------------------------------
--------------------------main menu-------------------------------
------------------------------------------------------------------
--[[*************************************************************]]
function Main()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "my menyoo"
	options.menu_subtitle = "~o~main menu"
	ClearMenu()
	Menu.addButton("~y~GunRunning ~b~menu", "GRCrateMenu", nil)
	Menu.addButton("~y~GunRunning MOC ~b~menu", "MOCmoules", nil)
	Menu.addButton("~y~MP race track ~b~menu", "mpRacetrack", nil)
end
--[[*************************************************************]]
------------------------------------------------------------------
--------------------------dlc menu's---------------------------
------------------------------------------------------------------
--[[*************************************************************]]
------------------------------------------------------------------
--------------------------gunrunning obj menu---------------------
------------------------------------------------------------------

function GRCrateMenu()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning"
	options.menu_subtitle = "select object to spawn"
	ClearMenu()
	Menu.addButton("adv_case", "objMenuGRAdvCase", nil)
	Menu.addButton("carcreeper", "objMenuGRCarCreeper", nil)
	Menu.addButton("gun crate 01a", "objMenuGRCrateGun01a", nil)
	Menu.addButton("mag crate 01a", "objMenuGRCrateMag01a", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
--------------------------gunrunning MOC obj menu-----------------
------------------------------------------------------------------
function MOCmoules()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning MOC"
	options.menu_subtitle = "select object to spawn"
	ClearMenu()
	Menu.addButton("MOC carmod", "MOCCarMod01", nil)
	Menu.addButton("MOC command", "MOCCommand01", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end

------------------------------------------------------------------
------------------race track spawn menu------------------------
------------------------------------------------------------------
function mpRacetrack()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "select object to spawn"
	ClearMenu()
	Menu.addButton("track bend 2 bar left", "trackBend2BarL", nil)
	Menu.addButton("track bend 2 left", "trackBend2L", nil)
	Menu.addButton("track bend 2 left", "trackBend2LB", nil)
	Menu.addButton("track bend 5d", "trackBend5d", nil)
	Menu.addButton("track bend 5d bar", "trackBend5dBar", nil)
	Menu.addButton("track bend 15d", "trackBend15d", nil)
	Menu.addButton("~y~NEXT PAGE", "mpRacetrackPg2", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
------------------race track page 2 spawn menu--------------------
------------------------------------------------------------------
function mpRacetrackPg2()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "select object to spawn"
	ClearMenu()
	Menu.addButton("track bend 15d bar", "trackBend15dBar", nil)
	Menu.addButton("~g~BACK", "mpRacetrack", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end

--[[*************************************************************]]
------------------------------------------------------------------
--------------------------obj menu's---------------------------
------------------------------------------------------------------
--[[*************************************************************]]
------------------------------------------------------------------
-----------------------advanced case spawn menu-------------------
------------------------------------------------------------------
n = 0
function addObjToArray(obj)
	objCoords = GetEntityCoords(obj)
	objRot = GetEntityRotation(obj)
	objArray = {}
	objArray["obj"] = obj
	objArray["objCoords"] = objCoords
	objArray["objRot"] = objRot
end
function objMenuGRAdvCase()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning"
	options.menu_subtitle = "advanced case"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~advanced case", "things1", -739654066)
	Menu.addButton("~b~move ~y~advanced case", "moveAdvCase", nil)
	Menu.addButton("~b~add to array ~y~advanced case", "addObjToArray", a)
	Menu.addButton("~b~disable collision ~y~advanced case", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~advanced case", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~back", "GRCrateMenu", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end

------------------------------------------------------------------
--------------------------car creeper spawn menu------------------
------------------------------------------------------------------
function objMenuGRCarCreeper()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning"
	options.menu_subtitle = "car creeper"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~car creeper", "things1", 1177042352)
	Menu.addButton("~b~move ~y~car creeper", "moveCarCreeper", nil)
	Menu.addButton("~b~disable collision ~y~car creeper", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~car creeper", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~back", "GRCrateMenu", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
---------------------gun crate 01a spawn menu---------------------
------------------------------------------------------------------
function objMenuGRCrateGun01a()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning"
	options.menu_subtitle = "gun crate"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~gun crate 01a", "things1", -471632408)
	Menu.addButton("~b~spawn ~y~dinghy", "things1", 1033245328)
	Menu.addButton("~b~move ~y~gun crate 01a", "moveGunCrate01a", nil)
	Menu.addButton("~b~disable collision ~y~gun crate 01a", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~gun crate 01a", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~back", "GRCrateMenu", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
------------------mag crate 01a spawn menu------------------------
------------------------------------------------------------------
function objMenuGRCrateMag01a()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning"
	options.menu_subtitle = "mag crate"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~mag crate 01", "things1", 1281731670)
	Menu.addButton("~b~move ~y~mag crate 01", "moveMagCrate01a", nil)
	Menu.addButton("~b~disable collision ~y~mag crate 01", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~mag crate 01", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~back", "GRCrateMenu", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end

------------------------------------------------------------------
------------------MOC carmod spawn menu------------------------
------------------------------------------------------------------
function MOCCarMod01()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning MOC"
	options.menu_subtitle = "MOC carmod"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~MOC carmod 01", "things1", -2083549178)
	Menu.addButton("~b~move ~y~MOC carmod 01", "moveMOCCarmod", nil)
	Menu.addButton("~b~disable collision ~y~MOC carmod 01", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~MOC carmod 01", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "MOCmoules", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
------------------MOC command spawn menu------------------------
------------------------------------------------------------------
function MOCCommand01()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~GunRunning MOC"
	options.menu_subtitle = "MOC command"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~MOC command 01", "things1", -2104782239)
	Menu.addButton("~b~disable collision ~y~MOC command 01", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~MOC command 01", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "MOCmoules", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end

------------------------------------------------------------------
-----------------------track bend 2 bar left spawn menu--------------
------------------------------------------------------------------
function trackBend2BarL()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "track bend 2 bar left"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~track bend 2 bar left", "things1", "stt_prop_track_bend2_bar_l")
	Menu.addButton("~b~disable collision ~y~track bend 2 bar left", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~track bend 2 bar left", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "mpRacetrack", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
-----------------------track bend 2 left spawn menu------------------
------------------------------------------------------------------
function trackBend2L()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "track bend 2 left"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~track bend 2 left", "things1", "stt_prop_track_bend2_l")
	Menu.addButton("~b~disable collision ~y~track bend 2 left", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~track bend 2 left", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "mpRacetrack", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
-----------------------track bend 2 left b spawn menu-------------
------------------------------------------------------------------
function trackBend2LB()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "track bend 2 left b"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~track bend 2 left b", "things1", "stt_prop_track_bend2_l_b")
	Menu.addButton("~b~disable collision ~y~track bend 2 left b", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~track bend 2 left b", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "mpRacetrack", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
-----------------------track bend 5 d spawn menu------------------
------------------------------------------------------------------
function trackBend5d()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "track bend 5 d"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~track bend 5 d", "things1", "stt_prop_track_bend_5d")
	Menu.addButton("~b~move ~y~track bend 5 d", "moveTrackBend5d", nil)
	Menu.addButton("~b~disable collision ~y~track bend 5 d", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~track bend 5 d", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "mpRacetrack", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
------------------------------------------------------------------
-----------------------track bend 5 d bar spawn menu------------------
------------------------------------------------------------------
function trackBend5dBar()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "track bend 5 d bar"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~track bend 5 d bar", "things1", "stt_prop_track_bend_5d_bar")
	Menu.addButton("~b~move ~y~track bend 5 d bar", "moveTrackBend5dBar", nil)
	Menu.addButton("~b~disable collision ~y~track bend 5 d bar", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~track bend 5 d bar", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "mpRacetrack", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function trackBend15d()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "track bend 15 d"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~track bend 15 d bar", "things1", "stt_prop_track_bend_15d")
	Menu.addButton("~b~move ~y~track bend 15 d bar", "moveTrackBend15d", nil)
	Menu.addButton("~b~disable collision ~y~track bend 15 d", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~track bend 15 d", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "mpRacetrackPg2", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function trackBend15dBar()
	DisplayHelpText("Use ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ to ~y~move~w~ and ~y~Enter~w~ to ~r~select")
	Notify("Press ~r~F5 ~w~to ~g~open~w~/~r~close~w~!")
	options.menu_title = "~y~MP race track"
	options.menu_subtitle = "track bend 15 d bar"
	ClearMenu()
	Menu.addButton("~b~spawn ~y~track bend 15 d bar", "things1", "stt_prop_track_bend_15d_bar")
	Menu.addButton("~b~move ~y~track bend 15 d bar", "moveTrackBend15dBar", nil)
	Menu.addButton("~b~disable collision ~y~track bend 15 d", "setCollisionStuff", true)
	Menu.addButton("~b~enable collision ~y~track bend 15 d", "setCollisionStuff", false)
	Menu.addButton("~r~delete object", "deleteStuff", nil)
	Menu.addButton("~g~BACK", "mpRacetrackPg2", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end

--[[*************************************************************]]
------------------------------------------------------------------
-----------------------move menu's--------------------------------
------------------------------------------------------------------
--[[*************************************************************]]
------------------------------------------------------------------
-----------------------move advanced case menu--------------------
------------------------------------------------------------------
function moveAdvCase()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~bl~advanced case", "moveAdvCase0", nil)
	Menu.addButton("~g~back", "objMenuGRAdvCase", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveAdvCase0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~advanced case", "moveAdvCase", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move car creeper menu----------------------
------------------------------------------------------------------
function moveCarCreeper()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~car creeper", "moveCarCreeper0", nil)
	Menu.addButton("~g~back", "objMenuGRAdvCase", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveCarCreeper0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~Car Creeper", "moveCarCreeper", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move gun crate menu----------------------
------------------------------------------------------------------
function moveGunCrate01a()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~car creeper", "moveGunCrate01a0", nil)
	Menu.addButton("~g~back", "objMenuGRCrateGun01a", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveGunCrate01a0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~Car Creeper", "moveGunCrate01a", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move mag crate menu----------------------
------------------------------------------------------------------
function moveMagCrate01a()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~car creeper", "moveMagCrate01a0", nil)
	Menu.addButton("~g~back", "objMenuGRCrateGun01a", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveMagCrate01a0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~Car Creeper", "moveMagCrate01a", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move MOC carmod menu----------------------
------------------------------------------------------------------
function moveMOCCarmod()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~car creeper", "moveMOCCarmod0", nil)
	Menu.addButton("~g~back", "MOCmoules", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveMOCCarmod0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~Car Creeper", "moveMOCCarmod", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move track bend 5 d menu-------------------
------------------------------------------------------------------
function moveTrackBend5d()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~track bend 5 d", "moveTrackBend5d0", nil)
	Menu.addButton("~g~back", "trackBend5d", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveTrackBend5d0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~track bend 5 d", "moveTrackBend5d", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move track bend 5 d bar menu-------------------
------------------------------------------------------------------
function moveTrackBend5dBar()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to cange hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~track bend 5 d bar", "moveTrackBend5dBar0", nil)
	Menu.addButton("~g~back", "trackBend5dBar", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveTrackBend5dBar0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~track bend 5 d bar", "moveTrackBend5dBar", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move track bend 15 d menu-------------------
------------------------------------------------------------------
function moveTrackBend15d()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to cange hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~track bend 5 d bar", "moveTrackBend15d0", nil)
	Menu.addButton("~g~back", "trackBend15d", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveTrackBend15d0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~track bend 5 d bar", "moveTrackBend15d", nil)
	unfreezeStuff()
end
------------------------------------------------------------------
-----------------------move track bend 15 d menu-------------------
------------------------------------------------------------------
function moveTrackBend15dBar()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to cange hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	freezeStuff()
	Menu.addButton("~b~unfreeze ~y~track bend 5 d bar", "moveTrackBend15dBar0", nil)
	Menu.addButton("~g~back", "mpRacetrackPg2", nil)
	Menu.addButton("~g~BACK TO MAIN MENU", "Main", nil)
end
function moveTrackBend15dBar0()
	Notify("use arrow keys to move obj ~n~Press [ ] keys to rotate on Y~n~ Press - = keys to rotate on X")
	Notify("Press NUM- NUM+ to change heading ~n~ Press pgUP PgDOWN to change hight")
	Notify("~r~enter ~w~to freeze ")
	options.menu_title = "~y~move menu"
	options.menu_subtitle = "move object"
	ClearMenu()
	Menu.addButton("~b~freeze ~y~track bend 15 d bar", "moveTrackBend15dBar", nil)
	unfreezeStuff()
end
--[[*************************************************************]]
------------------------------------------------------------------
-----------------------other stuff-------------------
------------------------------------------------------------------
--[[*************************************************************]]
------------------------------------------------------------------
--------------------------obj spawner-----------------------------
------------------------------------------------------------------

function things1(stuff1)
	Citizen.CreateThread(
		function()
			--this requests the model of what is to be spawned
			RequestModel(stuff1)
			if not HasModelLoaded(stuff1) then
				Citizen.Wait(0)
			--if model is a veh then spawn a veh
			end
			--spawn the object

			a = CreateObjectNoOffset(stuff1, playerCoordsX + 1, playerCoordsY + 1, playerCoordsZ, 1, 0, 0)
			setCollisionStuff(true)
			freezeStuff()
			SetEntityHeading(a, playerHeading)
		end
	)
end
--function things(stuff)
--things(stuff)
--spawnStuff(stuff)
--end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press F7 to open/close menu
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsControlJustReleased(1, 168) then -- INPUT_CELLPHONE_DOWN
				Main() -- Menu to draw
				Menu.hidden = not Menu.hidden -- Hide/Show the menu
			end
			Menu.renderGUI(options) -- Draw menu on each tick if Menu.hidden = false
		end
	end
)
