local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPtruck = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_trucker")
vRPCtruck = Tunnel.getInterface("vRP_trucker", "vRP_trucker")
Tunnel.bindInterface("vRP_trucker", vRPtruck)
Proxy.addInterface("vRP_trucker", vRPtruck)

x, y, z = 20.78282737732, -2486.6345214844, 6.0067796707154

trailerCoords = {
	[1] = {45.078811645508, -2475.0646972656, 6.3240194320678, 1},
	[2] = {42.933082580566, -2476.9184570312, 6.905936717987, 1},
	[3] = {41.984375, -2479.5810546875, 6.9055109024048, 1},
	[4] = {40.802635192872, -2482.0200195312, 5.9073495864868, 1},
	[5] = {38.894924163818, -2483.9655761718, 5.9065561294556, 1}
}

trucks = {"man", "hauler", "actros"}
trailers = {"TANKER", "TRAILERS", "TRAILERS2"}
activeDeliveries = {}

unloadLocations = {
	{"테스코 엑스트라", 186.87092590332, 6614.294921875, 31.82873916626, "연료", 9102}, --Blaine
	{"미들모어 농장", 2015.2478027344, 4979.3334960938, 41.288940429688, "비료", 7728}, --Ferma
	{"낚시 트리톤", 3806.3562011718, 4457.3383789062, 4.3696641921998, "보트 부품", 7909}, --Iesirea inspre mare partea dreapta
	{"모터 우드", -577.99694824218, 5325.5283203125, 70.263298034668, "엔진 부품", 7835}, -- Blaine cherestea
	{"황금 물고기", 1309.264038086, 4328.076171875, 38.1669921875, "어망", 6936}, -- Pescarie lacul din mijloc
	{"비밀 특공대", -2069.2082519532, 3386.5070800782, 31.282091140748, "우라늄", 6234}, -- Blaine cherestea
	{"아르드모어 건설", 870.50927734375, 2343.2783203125, 51.687889099122, "벽돌", 4904}, -- Aproape de armata
	{"로스산토스 정부", 2482.4860839844, -443.32431030274, 92.992576599122, "총", 3299}, -- facilitate secreta los santos dreapta
	{"트레버 공항", 1744.2651367188, 3289.7778320312, 41.102840423584, "항공 부품", 6028}, -- aeroport trevor
	{"애완동물 가게", 562.17309570312, 2722.1853027344, 42.060230255126, "동물 식품", 5237}, -- petshop xtremezone
	{"쇼핑몰 갤러리", -2318.4116210938, 280.80227661132, 169.467086792, "가구", 3627}, -- mall Xtremezone
	{"시멘트 공장", 1215.9357910156, 1877.8912353516, 78.845520019532, "돌", 4526}, -- Fabrica de ciment la iesire din los santos
	{"페레그린 농장", -50.683254241944, 1874.984008789, 196.8624572754, "비료", 4366}, -- Langa Poacher
	{"스팸", -64.300018310546, 6275.9194335938, 31.35410118103, "생 가금류", 8763}, -- Langa Poacher
	{"슈퍼 툴", 2672.3757324218, 3518.2490234375, 52.712032318116, "도구", 6564}, -- Paralel cu Human Labs
	{"랜스 산업", 849.52270507812, 2201.7373046875, 51.490081787116, "살충제", 4761}, -- Langa constructia din mijloc
	{"항공기 묘지", 2333.0327148438, 3137.6437988282, 48.178939819336, "부품", 6081}, --
	{"사스키아 수생공장", -1921.7559814454, 2045.240234375, 140.73533630372, "병", 4932}, -- Podgorie
	{"세븐 주유소", 2563.6311035156, 419.98919677734, 108.45681762696, "연료", 3863} --Benzinarie
}

deliveryDistances = {}
deliveryCompany = {"(주)금강", "주식회사 월드", "(주)세상", "주식회사 리얼", "법무법인 맥", "법무법인 블린", "주식회사 연화", "주식회사 악동", "주식회사 리진", "주식회사 화양"}

AddEventHandler(
	"vRP:playerSpawn",
	function(user_id, source, first_spawn)
		vRPclient.addBlip(source, {x, y, z, 162, 5, "배송지"})
	end
)

function vRPtruck.getTrucks()
	return trucks, trailers
end

local arrRestTime = {}
local isTest = false

function vRPtruck.finishTruckingDelivery(distance)
	if tonumber(distance) > 10000 then
		return
	end
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if not isTest then
		local ctime = os.time()
		if arrRestTime[user_id] ~= nil and ctime - 300 < arrRestTime[user_id] then
			vRPclient.notify(thePlayer, {"~r~[오류] ~w~비정상적인 배달"})
			return
		end
		arrRestTime[user_id] = ctime
	end
	deliveryMoney = math.ceil(distance * 500.000)
	vRPclient.notify(thePlayer, {"~y~[안내] ~w~화물 전달 완료!\n~p~[수당] ~w~" .. comma_value(deliveryMoney) .. "원"})
	vRP.giveMoney({user_id, deliveryMoney})
end

function vRPtruck.payTrailerFine()
	thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if (vRP.tryFullPayment({user_id, 2000000})) then
		vRPclient.notify(thePlayer, {"~r~[안내] ~w~트레일러가 손상되었습니다!\n~y~[손상 지불 금액] ~w~2,000,000원"})
	end
end

function vRPtruck.updateBayStats(theBay, stats)
	trailerCoords[theBay][4] = stats
end

local function takeDeliveryJob(thePlayer, theDelivery)
	lBay = 0
	for i, v in pairs(trailerCoords) do
		if (v[4] == 1) then
			lBay = i
			trailerCoords[lBay][4] = 0
			break
		end
	end
	if (lBay ~= 0) then
		vRPCtruck.spawnTrailer(thePlayer, {lBay, trailerCoords[lBay]})
		local user_id = vRP.getUserId({thePlayer})
		activeDeliveries[user_id] = unloadLocations[theDelivery]
		vRPCtruck.saveDeliveryDetails(thePlayer, {activeDeliveries[user_id]})
		vRP.closeMenu({thePlayer})
		vRPclient.notify(thePlayer, {"~y~목적지 : ~w~" .. activeDeliveries[user_id][1] .. "\n~o~배달 물건 :~w~" .. activeDeliveries[user_id][5]})
	else
		vRPclient.notify(thePlayer, {"~r~트레일러 자리가 꽉차 있어 지금은 일을 할 수 없습니다!"})
		return
	end
end

trucker_menu = {name = "물류 배송", css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}}

function comma_value(deliveryMoney)
	local formatted = deliveryMoney
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if (k == 0) then
			break
		end
	end
	return formatted
end

RegisterServerEvent("openTruckerJobs")
AddEventHandler(
	"openTruckerJobs",
	function()
		thePlayer = source
		local user_id = vRP.getUserId({thePlayer})
		for i, v in ipairs(unloadLocations) do
			deliveryName = tostring(v[1])
			dX, dY, dZ = v[2], v[3], v[4]
			deliveryType = v[5]
			deliveryDistance = v[6]
			deliveryMoney = math.ceil(deliveryDistance * 500.000)
			theCompany = deliveryCompany[math.random(1, #deliveryCompany)]
			trucker_menu[deliveryName] = {
				function()
					takeDeliveryJob(thePlayer, i)
				end,
				"<font color='yellow'>[회사명]</font><br>" .. theCompany .. "<br><br><font color='red'>[물건 종류]</font><br>" .. deliveryType .. "<br><br><font color='green'>[수당]</font><br>" .. comma_value(deliveryMoney) .. "원"
			}
		end
		vRP.openMenu({thePlayer, trucker_menu})
	end
)
