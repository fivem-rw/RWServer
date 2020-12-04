---------------------------------------------------------
-------------- RealWorld MAC - VRP UserList -------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_rw_userlistC = {}
Tunnel.bindInterface("vrp_rw_userlist", vrp_rw_userlistC)
Proxy.addInterface("vrp_rw_userlist", vrp_rw_userlistC)
vRP = Proxy.getInterface("vRP")
vrp_rw_userlistS = Tunnel.getInterface("vrp_rw_userlist", "vrp_rw_userlist")

function isSearchGroup(groups, value)
	if groups == nil then
		return false
	end
	for _, v in pairs(groups) do
		if v == value then
			return true
		end
	end
	return false
end

function UpdatePlayerTable(playerList, maxClients)
	if not playerList or not maxClients then
		return
	end

	local typeCount = {
		all = 0,
		ems = 0,
		cop = 0,
		uber = 0,
		repair = 0,
		shh = 0,
		mafia = 0,
		gm = 0,
		tow = 0,
		cbs = 0,
		dok = 0,
		kys = 0,
		helper = 0,
		inspector = 0,
		admin = 0,
		subae = 0
	}

	table.sort(
		playerList,
		function(a, b)
			if tonumber(a.id) ~= nil and tonumber(b.id) ~= nil then
				return tonumber(a.id) < tonumber(b.id)
			else
				return false
			end
		end
	)

	for k, v in ipairs(playerList) do
		if not v.jobType then
			v.jobType = ""
		end

		local icon = Config.jobIcons[v.jobType] or Config.jobIcons["person"]
		v.nickname = removeEmoji(v.nickname)
		v.job = icon .. " " .. v.job

		if typeCount[v.jobType] then
			typeCount[v.jobType] = typeCount[v.jobType] + 1
		end

		typeCount.all = typeCount.all + 1
	end

	SendNUIMessage(
		{
			action = "updatePlayerList",
			players = playerList,
			maxClients = maxClients
		}
	)

	SendNUIMessage(
		{
			action = "updatePlayerJobs",
			jobs = typeCount
		}
	)
end

function ToggleScoreBoard()
	SendNUIMessage(
		{
			action = "toggle"
		}
	)
end

function vrp_rw_userlistC.updatePlayerList(playerList, maxClients)
	UpdatePlayerTable(playerList, maxClients)
end

RegisterNUICallback(
	"showList",
	function(data, cb)
		SetNuiFocus(true, true)
	end
)

RegisterNUICallback(
	"hideList",
	function(data, cb)
		SetNuiFocus(false, false)
	end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(500)
		SetNuiFocus(false, false)

		local categories = {}
		for k, v in pairs(Config.categories) do
			table.insert(categories, {v[1], k, v[2], v[3]})
		end

		table.sort(
			categories,
			function(a, b)
				return tonumber(a[1]) < tonumber(b[1])
			end
		)

		SendNUIMessage(
			{
				action = "init",
				categories = categories,
				toggleKey = Config.toggleKey[2]
			}
		)
		while true do
			Citizen.Wait(0)
			if IsControlJustReleased(0, Config.toggleKey[1]) and IsInputDisabled(0) then
				SetNuiFocus(true, true)
				SetNuiFocus(false, false)
				ToggleScoreBoard()
				Citizen.Wait(500)
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(500)
			if IsPauseMenuActive() and not IsPaused then
				IsPaused = true
				SendNUIMessage(
					{
						action = "close"
					}
				)
			elseif not IsPauseMenuActive() and IsPaused then
				IsPaused = false
			end
		end
	end
)

Citizen.CreateThread(
	function()
		local playMinute, playHour = 0, 0

		while true do
			Citizen.Wait(1000 * 60)
			playMinute = playMinute + 1

			if playMinute == 60 then
				playMinute = 0
				playHour = playHour + 1
			end

			SendNUIMessage(
				{
					action = "updateServerInfo",
					playTime = string.format("%02d시간 %02d분", playHour, playMinute)
				}
			)
		end
	end
)
