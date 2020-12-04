---------------------------------------------------------
-------------- VRP Names, RealWorld MAC -----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_names")
vrp_namesC = Tunnel.getInterface("vrp_names", "vrp_names")

vrp_namesS = {}
Tunnel.bindInterface("vrp_names", vrp_namesS)

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/last_user_id" .. rand, "SELECT id FROM vrp_users order by id desc")

local userList = {}
local lastUserId = nil
local arrVisibleMode = {}

function getSelectNameIconByGroups(groups)
	if groups == nil then
		return nil
	end
	local selNameIcon = nil
	for k, v in pairs(custom_icons) do
		for _, v2 in pairs(groups) do
			if v2 == v[1] then
				selNameIcon = v[1]
				break
			end
		end
		if selNameIcon ~= nil then
			break
		end
	end
	return selNameIcon
end

function vrp_namesS.changeVisibleMode()
	local player = source
	local user_id = vRP.getUserId({player})
	if user_id then
		if arrVisibleMode[user_id] == nil then
			arrVisibleMode[user_id] = 0
		end
		arrVisibleMode[user_id] = arrVisibleMode[user_id] + 1
		if vRP.hasPermission({user_id, "admin.market"}) then
			if arrVisibleMode[user_id] > 2 then
				arrVisibleMode[user_id] = 0
			end
		else
			if arrVisibleMode[user_id] > 1 then
				arrVisibleMode[user_id] = 0
			end
		end
		setUserListMode()
		sendToClient()
		return arrVisibleMode[user_id]
	end
end

function setUserListMode()
	for user_id, mode in pairs(arrVisibleMode) do
		if userList[user_id] then
			userList[user_id].visibleMode = mode
		end
	end
end

function setUserList()
	for k, v in pairs(userList) do
		v.visibleMode = 0
		v.nameIcon = getSelectNameIconByGroups(v.groups)
		v.playerId = vRP.getUserSource({v.user_id})
	end
	setUserListMode()
end

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		MySQL.query(
			"vRP/last_user_id" .. rand,
			{},
			function(rows, affected)
				if rows and #rows > 0 then
					lastUserId = tonumber(rows[1].id) or nil
				end
			end
		)
		Citizen.Wait(60000)
	end
)

function sendToClient()
	vrp_namesC.push(-1, {userList, lastUserId, true})
end

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		while true do
			userList = {}
			vRP.getUserList(
				{
					function(users)
						for k, v in pairs(users) do
							userList[v.user_id] = v
						end
						setUserList()
						sendToClient()
					end
				}
			)
			Citizen.Wait(30000)
		end
	end
)
