---------------------------------------------------------
-------------- RealWorld MAC - VRP UserList -------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_rw_userlistS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_rw_userlist")
vrp_rw_userlistC = Tunnel.getInterface("vrp_rw_userlist", "vrp_rw_userlist")
Tunnel.bindInterface("vrp_rw_userlist", vrp_rw_userlistS)

local playerList = {}
local isProcess = false
local maxClientNum = 0

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(5000)
			maxClientNum = GetConvarInt("sv_maxClients", 0)
			if not isProcess then
				isProcess = true
				vRP.getUserList(
					{
						function(userList)
							playerList = {}
							if userList then
								for k, v in pairs(userList) do
									if not v.name or v.name == "" then
										v.name = "(신분증 미발급)"
									end
									if not v.job or v.job == "" then
										v.job = "(직업 미선택)"
									end
									table.insert(
										playerList,
										{
											source = v.source,
											id = v.user_id,
											nickname = v.nickname,
											name = v.name,
											job = v.job,
											jobType = v.jobType,
											groups = v.groups
										}
									)
								end
							end
							vrp_rw_userlistC.updatePlayerList(-1, {playerList, maxClientNum})
							isProcess = false
						end
					}
				)
			end
		end
	end
)
