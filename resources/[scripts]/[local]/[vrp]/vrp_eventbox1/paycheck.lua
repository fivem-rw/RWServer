local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_eventbox1S = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_eventbox1")
vrp_eventbox1C = Tunnel.getInterface("vrp_eventbox1", "vrp_eventbox1")
Tunnel.bindInterface("vrp_eventbox1", vrp_eventbox1S)

local playerPayTime = {}

---------------------------------------------------------
------------ VRP Eventbox, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

function payEventContent(user_id, source)
	vRP.giveInventoryItem({user_id, "eventbox1", 1})
	vRPclient.notifyPicture(source, {cfg.paycheck.picture, 1, cfg.paycheck.title, false, cfg.paycheck.msg})
end

AddEventHandler(
	"vRP:playerSpawn",
	function(user_id, source, first_spawn)
		if user_id ~= nil and first_spawn then
			playerPayTime[user_id] = {source, os.time()}
		end
	end
)

AddEventHandler(
	"vRP:playerLeave",
	function(user_id, source)
		playerPayTime[user_id] = nil
	end
)

Citizen.CreateThread(
	function()
		while true do
			local setTime = os.time() - cfg.global.paytime
			for user_id, v in pairs(playerPayTime) do
				if user_id ~= nil and v ~= nil and v[2] < setTime then
					playerPayTime[user_id] = {v[1], os.time()}
					--payEventContent(user_id, v[1])
				end
			end
			Citizen.Wait(cfg.global.paytime * 100)
		end
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(100)
		vRP.getUserList(
			{
				function(userList)
					for k, v in pairs(userList) do
						playerPayTime[v.user_id] = {v.source, os.time() - cfg.global.paytime + 60}
					end
				end
			}
		)
	end
)
