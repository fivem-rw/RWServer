----------------- Screen Monitoring System
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
sb_managerC = {}
Tunnel.bindInterface("sb_manager", sb_managerC)
Proxy.addInterface("sb_manager", sb_managerC)
sb_managerS = Tunnel.getInterface("sb_manager", "sb_manager")

local uploadUrl = "https://www.realw.kr/server/smonitor/sb_upload"
local userInfo = {}
local checkCounter = 20

function sendSB()
	if exports["sb"] ~= nil and userInfo.user_id ~= nil and userInfo.name ~= nil then
		exports["sb"]:requestScreenshotUpload(
			uploadUrl .. "?user_id=" .. userInfo.user_id .. "&name=" .. userInfo.name,
			"files",
			{
				encoding = "jpg",
				quality = 0.1
			},
			function(data)
				if checkCounter < 20 then
					checkCounter = 0
					SetTimeout(2000, sendSB)
				else
					checkCounter = 0
				end
			end
		)
	end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			checkCounter = checkCounter + 1
			if checkCounter > 20 then
				checkCounter = 0
				sb_managerS.getUserInfo(
					{},
					function(source, user_id, name)
						userInfo = {
							source = source,
							user_id = user_id,
							name = name
						}
						sendSB()
					end
				)
			end
		end
	end
)
