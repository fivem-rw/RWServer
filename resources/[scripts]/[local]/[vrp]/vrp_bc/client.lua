----------------- vRP Broadcast Player
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vrp_videocontrolC = {}
Tunnel.bindInterface("vrp_videocontrol", vrp_videocontrolC)
Proxy.addInterface("vrp_videocontrol", vrp_videocontrolC)
vRP = Proxy.getInterface("vRP")
vrp_videocontrolS = Tunnel.getInterface("vrp_videocontrol", "vrp_videocontrol")

function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end

local extendMode = false
local scale = 1.2
local screenWidth = math.floor((1280) * scale)
local screenHeight = math.floor((720) * scale)
local handles = {}

local renderModels = {}
local isReady = false
local isRender = false

function vrp_videocontrolC.setPlay(id, type, url, volume, time)
	local coords = GetEntityCoords(PlayerPedId(-1))
	for k, v in pairs(handles) do
		if k == id then
			v.playerInfo.isPlay = true
			v.playerInfo.type = type
			v.playerInfo.url = url
			v.playerInfo.volume = volume
			v.playerInfo.time = time
			local dist = Vdist(coords.x, coords.y, coords.z, v.coords.x, v.coords.y, v.coords.z)
			if dist < v.dist then
				SetDuiUrl(v.duiObj, v.duiUrl .. "?type=" .. v.playerInfo.type .. "&url=" .. v.playerInfo.url .. "&volume=" .. v.playerInfo.volume .. "&start=" .. v.playerInfo.time)
			end
		end
	end
	extendMode = false
	TriggerEvent("vrp_hudui_ex:changeUIMode", 3)
end

function vrp_videocontrolC.setStop(id)
	for k, v in pairs(handles) do
		if k == id then
			v.playerInfo.isPlay = false
			SetDuiUrl(v.duiObj, "about:blank")
		end
	end
	extendMode = false
	TriggerEvent("vrp_hudui_ex:changeUIMode", 3)
end

Citizen.CreateThread(
	function()
		Citizen.Wait(5000)
		screenWidth, screenHeight = GetActiveScreenResolution()
		for k, v in pairs(Config.models) do
			local model = GetHashKey(v[1])
			local txd = CreateRuntimeTxd(v[1])
			local duiObj = CreateDui("about:blank", screenWidth, screenHeight)
			local dui = GetDuiHandle(duiObj)
			local tx = CreateRuntimeTextureFromDuiHandle(txd, v[2], dui)
			local renderId = CreateNamedRenderTargetForModel(v[2], model)
			renderModels[model] = {
				renderId = renderId,
				modelTarget = v[1],
				renderTarget = v[2],
				duiObj = duiObj
			}
		end
		for k, v in pairs(Config.screens) do
			local model = GetHashKey(v[1])
			local renderInfo = renderModels[model]
			table.insert(
				handles,
				{
					renderId = renderInfo.renderId,
					modelTarget = renderInfo.modelTarget,
					renderTarget = renderInfo.renderTarget,
					duiObj = renderInfo.duiObj,
					duiUrl = v[2],
					isSetUrl = false,
					coords = v[3],
					dist = v[4],
					isNoSound = v[6] or false,
					playerInfo = {
						isPlay = false,
						type = "",
						url = "",
						volume = 0,
						time = 0
					}
				}
			)
		end
		isReady = true
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(500)
			if isReady then
				local coords = GetEntityCoords(PlayerPedId(-1))
				local isSetScreen = false
				for k, v in pairs(handles) do
					local dist = Vdist(coords.x, coords.y, coords.z, v.coords.x, v.coords.y, v.coords.z)
					if dist < v.dist then
						isSetScreen = true
						if v.playerInfo.isPlay and not v.isSetUrl then
							v.isSetUrl = true
							SetDuiUrl(v.duiObj, v.duiUrl .. "?type=" .. v.playerInfo.type .. "&url=" .. v.playerInfo.url .. "&volume=" .. v.playerInfo.volume .. "&start=" .. v.playerInfo.time)
						end
					else
						if v.isSetUrl then
							v.isSetUrl = false
							SetDuiUrl(v.duiObj, "about:blank")
						end
					end
				end
				if isSetScreen then
					isRender = true
				else
					if extendMode then
						extendMode = false
						TriggerEvent("vrp_hudui_ex:changeUIMode", 3)
					end
					isRender = false
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if isReady and isRender then
				for k, v in pairs(handles) do
					if not extendMode then
						SetTextRenderId(v.renderId)
					end
					DrawSprite(v.modelTarget, v.renderTarget, 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
					SetTextRenderId(GetDefaultScriptRendertargetRenderId())
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if isReady then
				for k, v in pairs(handles) do
					if v.playerInfo.isPlay then
						v.playerInfo.time = v.playerInfo.time + 1
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
			if isReady and isRender and IsControlJustReleased(0, 47) and IsControlPressed(0, 21) then
				extendMode = not extendMode
				if extendMode then
					TriggerEvent("vrp_hudui_ex:changeUIMode", 1)
				else
					TriggerEvent("vrp_hudui_ex:changeUIMode", 3)
				end
			end
		end
	end
)

AddEventHandler(
	"onResourceStop",
	function(resource)
		if resource == GetCurrentResourceName() then
			isReady = false
			isRender = false
			for k, v in pairs(renderModels) do
				SetDuiUrl(v.duiObj, "about:blank")
				DestroyDui(v.duiObj)
			end
		end
	end
)
