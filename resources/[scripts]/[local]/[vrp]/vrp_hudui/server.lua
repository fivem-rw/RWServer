----------------- vRP Screen UI
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_huduiS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_hudui")
vrp_huduiC = Tunnel.getInterface("vrp_hudui", "vrp_hudui")
Tunnel.bindInterface("vrp_hudui", vrp_huduiS)

local Config = module("vrp_hudui", "config")
local Locales = module("vrp_hudui", "locales/languages")

function _U(entry)
	return Locales[Config.Locale][entry]
end

RegisterServerEvent("vrp_hudui:getServerInfo")
AddEventHandler(
	"vrp_hudui:getServerInfo",
	function()
	end
)

RegisterServerEvent("vrp_hudui:syncCarLights")
AddEventHandler(
	"vrp_hudui:syncCarLights",
	function(status)
		local player = source
		TriggerClientEvent("vrp_hudui:syncCarLights", -1, player, status)
	end
)

RegisterServerEvent("vrp_hudui:ping_req")
AddEventHandler(
	"vrp_hudui:ping_req",
	function(CurrentPing)
		local src = source
		local CurrentPing = GetPlayerPing(src)
		TriggerClientEvent("vrp_hudui:ping_res", src, CurrentPing)
	end
)

local isLoad = false
local isReady = false
local isProcess = false
local isChangeLoad = false
local userList = {}
local serverInfo = {
	playerNum = 0
}
local userInfo = {}
local userProfileInfo = {}

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		while true do
			if isReady then
				if serverInfo.isReqSend then
					serverInfo.isReqSend = false
					vrp_huduiC.getServerInfo(-1, {serverInfo})
				end
				Citizen.Wait(10000)
			else
				Citizen.Wait(100)
			end
		end
	end
)
Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		while true do
			if isReady then
				for k, v in pairs(userInfo) do
					if v and v.isReqSend then
						v.isReqSend = false
						vrp_huduiC.getUserInfo(v.source, {v})
					end
				end
				Citizen.Wait(5000)
			else
				Citizen.Wait(100)
			end
		end
	end
)
Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		while true do
			if isReady then
				for k, v in pairs(userProfileInfo) do
					if v and v.isReqSend then
						v.isReqSend = false
						vrp_huduiC.getUserProfileInfo(v.source, {v})
					end
				end
				Citizen.Wait(5000)
			else
				Citizen.Wait(100)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		while true do
			if isProcess then
				Citizen.Wait(100)
			else
				isProcess = true
				vRP.getUserList(
					{
						function(data)
							userList = data
							isLoad = true
							isProcess = false
							isChangeLoad = true
						end
					}
				)
				Citizen.Wait(5000)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		while true do
			if isLoad and isChangeLoad then
				isChangeLoad = false
				local playerNum = 0
				for _, v in pairs(userList) do
					if v ~= nil then
						playerNum = playerNum + 1
					end
				end
				if serverInfo.playerNum ~= playerNum then
					serverInfo.playerNum = playerNum
					serverInfo.isReqSend = true
				end

				for _, v in pairs(userList) do
					if v ~= nil then
						local data = vRP.getUserDataTable({v.user_id})
						local tmpdata = vRP.getUserTmpTable({v.user_id})
						local hunger = 0
						local thirst = 0
						local money = 0
						local bankMoney = 0
						local credit = 0
						local player = vRP.getUserSource({v.user_id})
						if player then
							if data then
								hunger = parseInt(data.hunger) or 0
								thirst = parseInt(data.thirst) or 0
							end
							if tmpdata then
								money = parseInt(tmpdata.wallet) or 0
								bankMoney = parseInt(tmpdata.bank) or 0
								credit = parseInt(tmpdata.credit) or 0
							end
							local getUserInfo = {
								source = player,
								hunger = hunger,
								thirst = thirst,
								money = money,
								bankMoney = bankMoney,
								credit = credit
							}
							if userInfo[v.user_id] == nil or userInfo[v.user_id].hunger ~= getUserInfo.hunger or userInfo[v.user_id].thirst ~= getUserInfo.thirst or userInfo[v.user_id].money ~= getUserInfo.money or userInfo[v.user_id].bankMoney ~= getUserInfo.bankMoney or userInfo[v.user_id].credit then
								userInfo[v.user_id] = getUserInfo
								userInfo[v.user_id].isReqSend = true
							end
							local getUserProfileInfo = {
								source = player,
								userId = v.user_id,
								nickName = v.nickname,
								name = v.name,
								jobName = v.job,
								phone = v.phone
							}
							if userProfileInfo[v.user_id] == nil or userProfileInfo[v.user_id].name ~= getUserProfileInfo.name or userProfileInfo[v.user_id].jobName ~= getUserProfileInfo.jobName or userProfileInfo[v.user_id].phone ~= getUserProfileInfo.phone then
								userProfileInfo[v.user_id] = getUserProfileInfo
								userProfileInfo[v.user_id].isReqSend = true
							end
						end
						Citizen.Wait(0)
					end
				end
				isReady = true
			end
			Citizen.Wait(1000)
		end
	end
)
