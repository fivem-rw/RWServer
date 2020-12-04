local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPcs = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_casino")
vRPcasinoC = Tunnel.getInterface("vrp_casino", "vrp_casino")
Tunnel.bindInterface("vrp_casino", vRPcs)

tokenDealer = {
	{958.88214111328, 25.382736206055, 76.991241455078}
}

local casinoCasier_menu = {name = "카지노칩 구매/환전", css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}}

function round(x, n)
	n = math.pow(10, n or 0)
	x = x * n
	if x >= 0 then
		x = math.floor(x + 0.5)
	else
		x = math.ceil(x - 0.5)
	end
	return x / n
end

function sendToDiscord_casino(color, name, message, footer)
	local embed = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = message,
			["footer"] = {
				["text"] = footer
			}
		}
	}
	PerformHttpRequest(
		"https://discordapp.com/api/webhooks/685762109467787284/HcCVqO8CfBrL8N0Cq-ef00PufGLkd10y4m86svd26NUrjBLPUdC9mf5H4I0nXnPpJ_z-",
		function(err, text, headers)
		end,
		"POST",
		json.encode({embeds = embed}),
		{["Content-Type"] = "application/json"}
	)
end

function sendToDiscord_red(color, name, message, footer)
	local embed = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = message,
			["footer"] = {
				["text"] = footer
			}
		}
	}
	PerformHttpRequest(
		"https://discordapp.com/api/webhooks/685777943192141867/fdBEF_sn3dk99PWqJQFsUhHqfKPh8Jl8EhuQcexodikXr8RAgu-vvV6hvpoZqquV4zMd",
		function(err, text, headers)
		end,
		"POST",
		json.encode({embeds = embed}),
		{["Content-Type"] = "application/json"}
	)
end

function sendToDiscord_black(color, name, message, footer)
	local embed = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = message,
			["footer"] = {
				["text"] = footer
			}
		}
	}
	PerformHttpRequest(
		"https://discordapp.com/api/webhooks/685778965226324010/VD9LVjl3JyVCZHNXH2KW0DAENXHrL78IO1muNuMd09rXHNBZAXwrNY8Gk7OHSgqOOhRB",
		function(err, text, headers)
		end,
		"POST",
		json.encode({embeds = embed}),
		{["Content-Type"] = "application/json"}
	)
end

function sendToDiscord_green(color, name, message, footer)
	local embed = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = message,
			["footer"] = {
				["text"] = footer
			}
		}
	}
	PerformHttpRequest(
		"https://discordapp.com/api/webhooks/685778749811195954/a5s2ucHEjaMJBUiLuJrNHcgfxwEEAG32q75eBEQIoRdHepmi18LaOg4p3xVDUNclCqnc",
		function(err, text, headers)
		end,
		"POST",
		json.encode({embeds = embed}),
		{["Content-Type"] = "application/json"}
	)
end

--[[casinoCasier_menu["카지노칩 구매"] = {
	function(player, choice)
		local user_id = vRP.getUserId({player})
		if (user_id ~= nil and user_id ~= "") then
			vRP.prompt(
				{
					player,
					"칩 구매 (1개 100,000원):",
					"",
					function(player, tokenNr)
						if (tokenNr ~= "" and tokenNr ~= nil) then
							if (tonumber(tokenNr)) then
								tokenNr = tonumber(tokenNr)
								if (tokenNr > 0) and (tokenNr <= 100000) then
									local totalPrice = tokenNr * 100000
									if (vRP.tryPayment({user_id, totalPrice})) then
										vRPclient.notify(player, {"[카지노] ~g~결제 완료 ~r~" .. format_num(totalPrice) .. "원~y~" .. tokenNr .. " 개의 칩"})
										vRP.giveInventoryItem({user_id, "real_chip_n", tokenNr, false})
										vRP.closeMenu({player})
									else
										vRPclient.notify(player, {"[카지노] ~r~당신은 그만한 돈을 가지고 있지 않습니다! ~y~"})
									end
								else
									vRPclient.notify(player, {"[카지노] ~r~1에서 100,000까지의 숫자를 입력하세요!"})
								end
							else
								vRPclient.notify(player, {"[카지노] ~r~칩의 개수를 입력하세요!"})
							end
						else
							vRPclient.notify(player, {"[카지노] ~r~칩의 개수를 입력하세요!"})
						end
					end
				}
			)
		end
	end,
	"<font color='green'>칩 1개 </font>-> <font color='red'>100,000원</font>"
}]]

casinoCasier_menu["카지노칩 환전"] = {
	function(player, choice)
		local user_id = vRP.getUserId({player})
		if (user_id ~= nil and user_id ~= "1") then
			vRP.prompt(
				{
					player,
					"환전할 칩 개수",
					"",
					function(player, tokenNr)
						if (tokenNr ~= "" and tokenNr ~= nil) then
							if (tonumber(tokenNr)) then
								tokenNr = tonumber(tokenNr)
								if (tokenNr > 0) and (tokenNr <= 100000) then
									if vRP.tryGetInventoryItem({user_id, "real_chip_n", tokenNr, false}) then
										local tokensValue = math.floor(tokenNr * (100000 - (100000 * 0.05)))
										sendToDiscord_sell(65280, "카지노 환전기록", "고유번호 : " .. user_id .. "번\n\n환전한 칩 : " .. format_num(tokenNr) .. "개\n\n판매 금액 : " .. format_num(tokensValue) .. "원\n", os.date("거래일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록"))
										vRP.giveMoney({user_id, tokensValue})
										vRPclient.notify(player, {"[카지노] ~w~카지노 칩 ~y~" .. tokenNr .. "개~w~를 환전해서 ~r~" .. format_num(tokensValue) .. "원~w~을 받았습니다."})
										vRP.closeMenu({player})
									else
										vRPclient.notify(player, {"[카지노] ~r~당신은 충분한 칩이 없습니다!"})
									end
								else
									vRPclient.notify(player, {"[카지노] ~r~1부터 100,000 숫자만 입력하세요!"})
								end
							else
								vRPclient.notify(player, {"[카지노] ~r~칩의 개수를 입력하세요!"})
							end
						else
							vRPclient.notify(player, {"[카지노] ~r~칩의 개수를 입력하세요!"})
						end
					end
				}
			)
		end
	end,
	"<font color='green'>칩 1개 당 환전 비용</font> : <font color='red'>95,000원</font><br>자동 로그기록 저장"
}

function sendToDiscord_sell(color, name, message, footer)
	local embed = {
		{
			["color"] = color,
			["title"] = "**" .. name .. "**",
			["description"] = message,
			["footer"] = {
				["text"] = footer
			}
		}
	}
	PerformHttpRequest(
		"https://discordapp.com/api/webhooks/685781157735956563/nc28jvui2TgCaHRP0Flt5DP9ouvEnNOWVt53Fy9G4SmpIkhlqqMjnDsfLsBwDrpv2KHV",
		function(err, text, headers)
		end,
		"POST",
		json.encode({embeds = embed}),
		{["Content-Type"] = "application/json"}
	)
end

function vRPcs.spawnTokenDealer(thePlayer)
	local casCasier_enter = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.openMenu({player, casinoCasier_menu})
		end
	end

	local casCasier_leave = function(player, area)
		local user_id = vRP.getUserId({player})
		if user_id ~= "" and user_id ~= nil then
			vRP.closeMenu({player})
		end
	end

	for i, v in pairs(tokenDealer) do
		vRP.setArea({thePlayer, "vRP:cashier:" .. i, v[1], v[2], v[3], 1.7, 1.5, casCasier_enter, casCasier_leave})
		vRPclient.addMarker(thePlayer, {v[1], v[2], v[3] - 1, 1.2, 1.2, 0.2, 0, 125, 255, 125, 100, "~b~칩 관리소"})
		vRPcasinoC.createCasinoNPCs(thePlayer, {"A_M_Y_business_01", 960.26922607422, 23.750789642334, 75.991249084473, 50.56, "칩 관리인"})
		vRPcasinoC.createCasinoNPCs(thePlayer, {"A_M_Y_business_02", 963.38525390625, 24.079519271851, 75.991249084473, 288.56, ""})
	end
end

AddEventHandler(
	"vRP:playerLeave",
	function(user_id, source)
	end
)

AddEventHandler(
	"vRP:playerSpawn",
	function(user_id, source, first_spawn)
		SetTimeout(
			2000,
			function()
				vRPcs.spawnTokenDealer(source)
			end
		)
	end
)

Citizen.CreateThread(
	function()
		for _, v in pairs(GetPlayers()) do
			vRPcs.spawnTokenDealer(v)
		end
	end
)
