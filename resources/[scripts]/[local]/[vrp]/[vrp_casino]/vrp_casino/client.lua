vRPcasinoC = {}
Tunnel.bindInterface("vrp_casino", vRPcasinoC)
Proxy.addInterface("vrp_casino", vRPcasinoC)
vRP = Proxy.getInterface("vRP")
vRPcasinoS = Tunnel.getInterface("vrp_casino", "vrp_casino")

local rltNumbers = {
	"~g~0",
	"~r~1",
	"~b~2",
	"~c~3",
	"~b~4",
	"~c~5",
	"~b~6",
	"~r~7",
	"~b~8",
	"~c~9",
	"~b~10",
	"~b~11",
	"~r~12",
	"~b~13",
	"~b~14",
	"~c~15",
	"~b~16",
	"~r~17",
	"~b~18",
	"~c~19",
	"~b~20",
	"~r~21",
	"~b~22",
	"~b~23",
	"~c~24",
	"~b~25",
	"~b~26",
	"~c~27",
	"~b~28",
	"~c~29",
	"~b~30",
	"~c~31",
	"~b~32",
	"~c~33",
	"~b~34",
	"~c~35",
	"~b~36",
	"~c~37",
	"~b~38",
	"~c~39",
}

local rltBetOn = ""
local rltWinnings = 0
local rltTimesBy = 0
local rltNumber = ""

local theI = 1

local rltSpeed = 5

function text_drawTxt(text, font, centre, x, y, scale, r, g, b, a)
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

function vRPcasinoC.startRoulette(betOn, winnings, timesBy)
	theI = math.random(#rltNumbers)
	rltBetOn = betOn
	rltWinnings = winnings + 1
	rltTimesBy = timesBy + 1
	SetEntityHeading(GetPlayerPed(-1), 179.63815307617)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	coords = GetEntityCoords(GetPlayerPed(-1))
	TaskStartScenarioAtPosition(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FIRE", coords.x, coords.y, coords.z - 0.3, GetEntityHeading(GetPlayerPed(-1)), 0, 0, false)
end

thePeds = {}
thePedNames = {}

markerTexts = {}

function vRPcasinoC.createCasinoNPCs(model, x, y, z, rot, name)
	thePedNames[name] = {x = x, y = y, z = z}
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(0)
	end
	thePeds[name] = CreatePed(RWP, 26, GetHashKey(model), x, y, z, rot, false, false)
	FreezeEntityPosition(thePeds[name], true)
	SetEntityCollision(thePeds[name], false)
	SetEntityDynamic(thePeds[name], false)
	SetEntityInvincible(thePeds[name], true)
	SetBlockingOfNonTemporaryEvents(thePeds[name], true)
end

function vRPcasinoC.createCasinoText(x, y, z, name)
	markerTexts[#markerTexts + 1] = {name = name, x = x, y = y, z = z}
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(rltSpeed)
			if (rltBetOn ~= "") then
				if (theI == #rltNumbers) then
					theI = 1
				else
					theI = theI + 1
				end
				rltNumber = rltNumbers[theI]
			end
		end
	end
)

function DrawText3D(x, y, z, text, scl)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

	local scale = (1 / dist) * scl
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 1.1 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		-- SetTextScale(0.0, 0.55)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
	end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local coords = GetEntityCoords(GetPlayerPed(-1))
			for i, v in pairs(thePedNames) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, coords.x, coords.y, coords.z, true) <= 20.0 then
					DrawText3D(v.x, v.y, v.z + 1.95, i, 0.8)
				end
			end

			for i, v in pairs(markerTexts) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, coords.x, coords.y, coords.z, true) <= 20.0 then
					DrawText3D(v.x, v.y, v.z, v.name, 0.8)
				end
			end

			if (rltBetOn ~= "") then
				text_drawTxt("[리얼월드 룰렛] ~y~현재 색상 : " .. rltNumber, 1, 1, 0.5, 0.8, 1.0, 255, 255, 255, 255)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(300)
			if (rltBetOn ~= "") then
				if (rltSpeed < 1600) then
					if (rltSpeed > 500) then
						rltSpeed = rltSpeed + 30
					elseif (rltSpeed < 500) then
						rltSpeed = rltSpeed + 10
					elseif (rltSpeed > 500 and rltSpeed < 1000) then
						rltSpeed = rltSpeed + 100
					end
				else
					if (rltBetOn == "Black") then
						if (string.match(rltNumber, "c")) then
							vRPcasinoS.payRouletteWinnings({rltWinnings, rltTimesBy})
						else
							vRP.notify({"[CASINO] ~r~You didn't win this time!"})
							vRPcasinoS.didntWinRoulette({})
						end
					elseif (rltBetOn == "Red") then
						if (string.match(rltNumber, "r")) then
							vRPcasinoS.payRouletteWinnings({rltWinnings, rltTimesBy})
						else
							vRP.notify({"[CASINO] ~r~You didn't win this time!"})
							vRPcasinoS.didntWinRoulette({})
						end
					elseif (rltBetOn == "Green") then
						if (string.match(rltNumber, "g")) then
							vRPcasinoS.payRouletteWinnings({rltWinnings, rltTimesBy})
						else
							vRP.notify({"[CASINO] ~r~You didn't win this time!"})
							vRPcasinoS.didntWinRoulette({})
						end
					end
					ClearPedTasks(GetPlayerPed(-1))
					FreezeEntityPosition(GetPlayerPed(-1), false)
					rltSpeed = 5
					rltBetOn = ""
					rltNumber = ""
					theI = 1
					rltWinnings = 0
					rltTimesBy = 0
				end
			end
		end
	end
)

local EmojiList = {
	"🍎",
	"🍋",
	"🍉",
	"🍊",
	"🍒",
	"🍇",
	"🍑",
	"🍓"
}
-- KEK TOP KEK --
local price = {}
price.line3 = {
	cherry = 6,
	lemon = 5,
	other = 4
}
price.line2 = {
	cherry = 3,
	other = 3
}

-- Thank you ideo for GUI
Menu = {}
Menu.GUI = {}
Menu.TitleGUI = {}
Menu.buttonCount = 0
Menu.titleCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Menu"

-------------------
posXMenu = 0.1
posYMenu = 0.05
width = 0.1
height = 0.05

posXMenuTitle = 0.1
posYMenuTitle = 0.05
widthMenuTitle = 0.1
heightMenuTitle = 0.05
-------------------
function Menu.addTitle(name)
	local yoffset = 0.3
	local xoffset = 0
	local xmin = posXMenuTitle
	local ymin = posYMenuTitle
	local xmax = widthMenuTitle
	local ymax = heightMenuTitle
	Menu.TitleGUI[Menu.titleCount + 1] = {}
	Menu.TitleGUI[Menu.titleCount + 1]["name"] = name
	Menu.TitleGUI[Menu.titleCount + 1]["xmin"] = xmin + xoffset
	Menu.TitleGUI[Menu.titleCount + 1]["ymin"] = ymin * (Menu.titleCount + 0.01) + yoffset
	Menu.TitleGUI[Menu.titleCount + 1]["xmax"] = xmax
	Menu.TitleGUI[Menu.titleCount + 1]["ymax"] = ymax
	Menu.titleCount = Menu.titleCount + 1
end
function Menu.addButton(name, func, args)
	local yoffset = 0.3
	local xoffset = 0
	local xmin = posXMenu
	local ymin = posYMenu
	local xmax = width
	local ymax = height
	Menu.GUI[Menu.buttonCount + 1] = {}
	Menu.GUI[Menu.buttonCount + 1]["name"] = name
	Menu.GUI[Menu.buttonCount + 1]["func"] = func
	Menu.GUI[Menu.buttonCount + 1]["args"] = args
	Menu.GUI[Menu.buttonCount + 1]["active"] = false
	Menu.GUI[Menu.buttonCount + 1]["xmin"] = xmin + xoffset
	Menu.GUI[Menu.buttonCount + 1]["ymin"] = ymin * (Menu.buttonCount + 0.01) + yoffset
	Menu.GUI[Menu.buttonCount + 1]["xmax"] = xmax
	Menu.GUI[Menu.buttonCount + 1]["ymax"] = ymax
	Menu.buttonCount = Menu.buttonCount + 1
end
local input = {["E"] = 38, ["DOWN"] = 173, ["TOP"] = 27, ["NENTER"] = 201}
function Menu.updateSelection()
	if IsControlJustPressed(1, input["DOWN"]) then
		if (Menu.selection < Menu.buttonCount - 1) then
			Menu.selection = Menu.selection + 1
		else
			Menu.selection = 0
		end
	elseif IsControlJustPressed(1, input["TOP"]) then
		if (Menu.selection > 0) then
			Menu.selection = Menu.selection - 1
		else
			Menu.selection = Menu.buttonCount - 1
		end
	elseif IsControlJustPressed(1, input["NENTER"]) then
		MenuCallFunction(Menu.GUI[Menu.selection + 1]["func"], Menu.GUI[Menu.selection + 1]["args"])
	end
	local iterator = 0
	for id, settings in ipairs(Menu.GUI) do
		Menu.GUI[id]["active"] = false
		if (iterator == Menu.selection) then
			Menu.GUI[iterator + 1]["active"] = true
		end
		iterator = iterator + 1
	end
end
function Menu.renderGUI()
	if not Menu.hidden then
		Menu.renderTitle()
		Menu.renderButtons()
		Menu.updateSelection()
	end
end
function Menu.renderBox(xMin, xMax, yMin, yMax, color1, color2, color3, color4)
	DrawRect(xMin, yMin, xMax, yMax, color1, color2, color3, color4)
end
function drawText(x, y, width, height, scale, text, r, g, b, a, n)
	SetTextFont(n)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.0125)
end
function Menu.renderTitle()
	local yoffset = 0.3
	local xoffset = 0
	local xmin = posXMenuTitle
	local ymin = posYMenuTitle
	local xmax = widthMenuTitle
	local ymax = heightMenuTitle
	for id, settings in pairs(Menu.TitleGUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h = GetScreenResolution(0, 0)
		boxColor = {20, 30, 10, 255}
		SetTextFont(7)
		SetTextScale(0.0, 0.5)
		SetTextColour(255, 255, 255, 255)
		SetTextCentre(true)
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextEntry("STRING")
		AddTextComponentString("~y~" .. string.upper(settings["name"]))
		DrawText(settings["xmin"], (settings["ymin"] - heightMenuTitle - 0.0125))
		Menu.renderBox(settings["xmin"], settings["xmax"], settings["ymin"] - heightMenuTitle, settings["ymax"], boxColor[1], boxColor[2], boxColor[3], boxColor[4])
	end
end
function Menu.renderButtons()
	for id, settings in pairs(Menu.GUI) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h = GetScreenResolution(0, 0)
		boxColor = {42, 63, 17, 255}
		if (settings["active"]) then
			boxColor = {107, 158, 44, 255}
		end
		SetTextFont(0)
		SetTextScale(0.0, 0.4)
		SetTextColour(255, 255, 255, 255)
		SetTextCentre(true)
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
		SetTextEntry("STRING")
		AddTextComponentString(settings["name"])
		DrawText(settings["xmin"], (settings["ymin"] - 0.0125))
		Menu.renderBox(settings["xmin"], settings["xmax"], settings["ymin"], settings["ymax"], boxColor[1], boxColor[2], boxColor[3], boxColor[4])
	end
end
--------------------------------------------------------------------------------------------------------------------
function ClearMenu()
	Menu.GUI = {}
	Menu.buttonCount = 0
	Menu.titleCount = 0
	Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
	_G[fnc](arg)
end
--------------------------------------------------------------------------------------------------------------------
-- _Darkz
local money = 1
function SlotMenu()
	ClearMenu()
	Menu.addTitle("슬롯 머신")
	Menu.addButton("~h~돌리기", "Spin", nil)
	Menu.addButton("+", "Plus", nil)
	Menu.addButton("-", "Minus", nil)
end

function Spin()
	rand1 = EmojiList[math.random(#EmojiList)]
	rand2 = EmojiList[math.random(#EmojiList)]
	rand3 = EmojiList[math.random(#EmojiList)]
	vRPcasinoS.spinSlotMachine({money, rand1, rand2, rand3})
end

function Chat(title, text, r, g, b)
	TriggerEvent("chatMessage", title, {r, g, b}, text)
end

function Plus(a)
	if money >= 1000 then
		money = 1000
	elseif money >= 100 then
		money = money + 100
	elseif money >= 10 then
		money = money + 10
	else
		money = money + 1
	end
	return money
end

function Minus(a)
	if money <= 1 then
		money = 1
	elseif money > 100 then
		money = money - 100
	elseif money > 10 then
		money = money - 10
	else
		money = money - 1
	end
	return money
end

function vRPcasinoC.checkWinSlotmachine(MoneyRecive, a, b, c)
	SlotMenu()
	Menu.hidden = not Menu.hidden
	if a == b and a == c then
		if a == "??" then
			reward = tonumber(MoneyRecive * (price.line3.cherry - 1))
			vRPcasinoS.winSlotMachine({reward})
		elseif a == "??" then
			reward = tonumber(MoneyRecive * (price.line3.lemo - 1))
			vRPcasinoS.winSlotMachine({reward})
		else
			reward = tonumber(MoneyRecive * (price.line3.other - 1))
			vRPcasinoS.winSlotMachine({reward})
		end
		Chat("리얼월드 카지노", a .. " " .. b .. " " .. c, 0, 255, 0)
	elseif a == b or b == c then
		if b == "??" then
			reward = tonumber(MoneyRecive * (price.line2.cherry - 1))
			vRPcasinoS.winSlotMachine({reward})
		else
			reward = tonumber(MoneyRecive * (price.line2.other - 1))
			vRPcasinoS.winSlotMachine({reward})
		end
		Chat("승리!", a .. " " .. b .. " " .. c, 0, 255, 0)
	else
		vRPcasinoS.lostSlotMachine({})
		Chat("패배..", a .. " " .. b .. " " .. c, 255, 0, 0)
	end
end
local moneymachine_slot = {
	--{["x"] = 1115.83, ["y"] = 227.56, ["z"] = -49.84},
	--{["x"] = 1114.96, ["y"] = 230.13, ["z"] = -49.84},
	--{["x"] = 1117.12, ["y"] = 231.68, ["z"] = -49.84},
	--{["x"] = 1115.36, ["y"] = 232.55, ["z"] = -49.84},
	--{["x"] = 1112.88, ["y"] = 232.52, ["z"] = -49.84},
	--{["x"] = 1112.07, ["y"] = 235.01, ["z"] = -49.84},
	--{["x"] = 1109.74, ["y"] = 232.68, ["z"] = -49.84},
	--{["x"] = 1107.14, ["y"] = 232.73, ["z"] = -49.84},
	--{["x"] = 1106.46, ["y"] = 228.33, ["z"] = -49.84}
}

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			local pos = GetEntityCoords(GetPlayerPed(-1), false)
			for k, v in ipairs(moneymachine_slot) do
				if (GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 20.0) then
					DrawText3D(v.x, v.y, v.z, "~g~슬롯 머신", 1)
					DrawMarker(29, v.x, v.y, v.z - 0.5, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 25, 165, 165, 0, 0, 0, true)
					if (GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 1.0) then
						if (Menu.hidden == true) then
							DrawText3D(v.x, v.y, v.z + 0.5, "~r~'E'~w~키를 눌러 베팅", 1)
						end
						if IsControlJustPressed(1, input["E"]) then
							SlotMenu()
							Menu.hidden = not Menu.hidden
						end
						if not Menu.hidden then
							DrawRect(0.1, 0.45, 0.1, 0.05, 0, 0, 0, 255)
							drawText(0.55, 0.42 + 0.5, 1.0, 1.0, 0.6, "~w~" .. tostring(money) .. "~g~개", 255, 0, 0, 255, 7)
						end
						Menu.renderGUI()
					end
				end
			end
		end
	end
)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
