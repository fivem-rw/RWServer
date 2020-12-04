---------------------------------------------------------
------------ VRP DeathMatch, RealWorld MAC --------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

vrp_deathmatchC = {}
Tunnel.bindInterface("vrp_deathmatch", vrp_deathmatchC)
Proxy.addInterface("vrp_deathmatch", vrp_deathmatchC)
vRP = Proxy.getInterface("vRP")
vrp_deathmatchS = Tunnel.getInterface("vrp_deathmatch", "vrp_deathmatch")

local currentMatchId = 0
local matchPoints = {}
local matchId = 0
local matchTeam = 0
local matchMonitor = false
local isDead = false
local isDeadReal = false
local respawnTime = 20
local isGod = false
local teamName = {"~r~[레드]", "~b~[블루]"}
local playerList = {}
local memberList = {}
local bWeaponList = {}
local enterProc = false

DM_PLAYER_1 = GetHashKey("_DM_PLAYER_1")
DM_PLAYER_2 = GetHashKey("_DM_PLAYER_2")
AddRelationshipGroup("_DM_PLAYER_1")
AddRelationshipGroup("_DM_PLAYER_2")
SetRelationshipBetweenGroups(5, DM_PLAYER_1, DM_PLAYER_2)
SetRelationshipBetweenGroups(5, DM_PLAYER_2, DM_PLAYER_1)

function vrp_deathmatchC.add(gameId, gameBlock)
	matchPoints[gameId] = gameBlock
	matchPoints[gameId].color = {r = 255, g = 255, b = 255}
	matchPoints[gameId].colorDir = {r = 0, g = 0, b = 0}
	matchPoints[gameId].setSize = gameBlock.size
	matchPoints[gameId].mapBlips = AddBlipForRadius(gameBlock.coords.x, gameBlock.coords.y, gameBlock.coords.z, gameBlock.size)
	matchPoints[gameId].mapBlipsNext = AddBlipForRadius(gameBlock.coords.x, gameBlock.coords.y, gameBlock.coords.z, gameBlock.size)
	matchPoints[gameId].mapBlipsNextFill = AddBlipForRadius(gameBlock.coords.x, gameBlock.coords.y, gameBlock.coords.z, gameBlock.size)
	matchPoints[gameId].moveWait = gameBlock.gameAreaTime
	matchPoints[gameId].isChangeNewArea = false
end

function vrp_deathmatchC.remove(id)
	vrp_deathmatchC.stop(id)
	RemoveBlip(matchPoints[id].mapBlips)
	RemoveBlip(matchPoints[id].mapBlipsNext)
	RemoveBlip(matchPoints[id].mapBlipsNextFill)
	matchPoints[id] = nil
	compass.show = false

	if matchId > 0 then
		matchId = 0
		matchTeam = 0
		matchMonitor = false
		vRP.giveWeapons({{}, true})
		vRP.giveWeapons({bWeaponList, true})
		TriggerEvent("vrp_ktackle:changeRestControl", false)
		TriggerEvent("vrp_names_ex:changeShowUIRest", false)
		Wait(1000)
		TriggerEvent("vrp_names_ex:changeShowUI", true)
	end
end

function vrp_deathmatchC.start(id)
	if not matchPoints[id] then
		return
	end
	matchPoints[id].status = 3
	if matchId > 0 then
		vRP.setSurvival({false})
	end
end

function vrp_deathmatchC.stop(id)
	if not matchPoints[id] then
		return
	end
	playerList = {}
	matchPoints[id].status = 5
	if matchId > 0 then
		local ped = GetPlayerPed(-1)
		vRP.setSurvival({true})
		respawnTime = 20
		isDead = false
		isDeadReal = false
		local x, y, z = vRP.getPosition()
		NetworkResurrectLocalPlayer(x, y, z, true, true, false)
		Citizen.Wait(0)
		SetEntityAlpha(ped, 255)
		SetEntityHealth(ped, 200)
		SetEntityInvincible(ped, false)
		vRP.giveWeapons({{}, true})
	end
end

function vrp_deathmatchC.addMember(id, team, monitor)
	matchId = id

	if matchPoints[id].type == 1 then
		matchTeam = 0
		matchMonitor = monitor
	elseif matchPoints[id].type == 2 then
		if monitor then
			matchTeam = 0
		else
			matchTeam = team
		end
		matchMonitor = monitor
		if team == 1 then
			SetPedRelationshipGroupHash(GetPlayerPed(-1), DM_PLAYER_1)
		end
		if team == 2 then
			SetPedRelationshipGroupHash(GetPlayerPed(-1), DM_PLAYER_2)
		end
	end

	bWeaponList = vRP.getWeapons({})

	local addWeapons = {["WEAPON_KNIFE"] = {["ammo"] = 0}, ["WEAPON_BAT"] = {["ammo"] = 0}, ["WEAPON_DBSHOTGUN"] = {["ammo"] = 100}, ["WEAPON_PISTOL50"] = {["ammo"] = 120}, ["WEAPON_GRENADE"] = {["ammo"] = 3}, ["WEAPON_ASSAULTRIFLE"] = {["ammo"] = 300}}
	vRP.giveWeapons({addWeapons, true})

	TriggerEvent("vrp_ktackle:changeRestControl", true)
	TriggerEvent("vrp_names_ex:changeShowUI", false)
	Wait(1000)
	TriggerEvent("vrp_names_ex:changeShowUIRest", true)
	enterProc = false

	compass.show = true
end

function vrp_deathmatchC.kill(type)
	SendNUIMessage({type = "voice_anount", team = "allied", kill = type})
end

function vrp_deathmatchC.removeMember(id)
	matchId = 0
	matchTeam = 0
	matchMonitor = false
	vRP.giveWeapons({{}, true})
	vRP.giveWeapons({bWeaponList, true})
	TriggerEvent("vrp_ktackle:changeRestControl", false)
	TriggerEvent("vrp_names_ex:changeShowUIRest", false)
	Wait(1000)
	TriggerEvent("vrp_names_ex:changeShowUI", true)
	enterProc = false
	compass.show = false
	SetEntityAlpha(GetPlayerPed(-1), 255)
	SetEntityInvincible(GetPlayerPed(-1), false)
end

function vrp_deathmatchC.changeNewArea(id)
	matchPoints[id].isChangeNewArea = true
end

function vrp_deathmatchC.changeZoneSize(id, value, value2)
	matchPoints[id].setSize = value
	matchPoints[id].areaResizePer = value2
end

function vrp_deathmatchC.changeZonePosition(id, x, y)
	matchPoints[id].dcoords = vector3(x, y, matchPoints[id].dcoords.z)
end

function vrp_deathmatchC.updateMemberData(id, value)
	if id and matchPoints[id] then
		matchPoints[id].members = value
		memberList = {}
		for k, v in pairs(value) do
			table.insert(memberList, v)
		end
		table.sort(
			memberList,
			function(a, b)
				if tonumber(a.point) ~= nil and tonumber(b.point) ~= nil then
					return tonumber(a.point) > tonumber(b.point)
				else
					return false
				end
			end
		)
	end
end

function vrp_deathmatchC.updateTeamData(id, value)
	if id and matchPoints[id] then
		matchPoints[id].teams = value
	end
end

function vrp_deathmatchC.syncPlayerName(members)
	playerList = members
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if matchId and matchId > 0 and matchPoints[matchId] then
				local PlayerPed = GetPlayerPed(-1)
				local PlayerCoords = GetEntityCoords(PlayerPed)
				for user_id, data in pairs(playerList) do
					local player = GetPlayerFromServerId(data.source)
					if player and player > 0 then
						local playerName = GetPlayerName(player)
						local ped = GetPlayerPed(player)
						local coords = GetEntityCoords(ped)
						local distance = math.floor(GetDistanceBetweenCoords(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z, coords.x, coords.y, coords.z, true))
						if distance < 100 then
							local showName = nil
							if matchPoints[matchId].status == 1 then
								if data.monitor then
									showName = "~y~[관전]\n~w~" .. playerName
								elseif data.team then
									showName = "~g~[참여]\n~w~" .. teamName[data.team] .. "\n~w~" .. playerName
								else
									showName = "~g~[참여]\n~w~" .. playerName
								end
								SetEntityAlpha(ped, 100)
							elseif matchPoints[matchId].status == 5 then
								if data.monitor then
									showName = "~y~[관전]\n~w~" .. playerName
								elseif data.team then
									showName = "~g~[종료]\n~w~" .. teamName[data.team] .. "\n~w~" .. playerName
								else
									showName = "~g~[종료]\n~w~" .. playerName
								end
								SetEntityAlpha(ped, 100)
							else
								if matchMonitor or (matchTeam ~= 0 and matchTeam == data.team) or data.monitor then
									if data.monitor then
										showName = "~y~[관전]\n~w~" .. playerName
									elseif data.team then
										showName = teamName[data.team] .. "\n~w~" .. playerName
									else
										showName = nil
									end
								end
								SetEntityAlpha(ped, 255)
							end
							if showName then
								DrawText3D(coords.x, coords.y, coords.z + 1.35, showName, 1.5)
							end
						end
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(2000)
			local coords = GetEntityCoords(GetPlayerPed(-1))
			if matchId and matchId > 0 and matchPoints[matchId] and matchPoints[matchId].status == 3 then
				if Vdist(matchPoints[matchId].coords, coords) > matchPoints[matchId].size / 2 then
					if not isDeadReal then
						vRP.notify({"~r~구역안으로 들어가세요.\n~y~당신의 체력이 줄어듭니다."})
						SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) - matchPoints[matchId].areaResizePer)
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
			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
			for id, v in pairs(matchPoints) do
				if v and v.status == 1 then
					if v.type == 1 then
						local coords = vector3(v.coords.x, v.coords.y, v.coords.z)
						local dist = Vdist(playerPos, coords)
						DrawMarker(1, coords.x, coords.y, coords.z - 50, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 52.0, 0, 255, 0, 250, 0, 0, 2, 0, 0, 0, 0)
						if dist < 5 then
							DrawText3D(playerPos.x, playerPos.y, playerPos.z + 0.15, "~g~개인전", 1.5)
							DrawText3D(playerPos.x, playerPos.y, playerPos.z, "~w~참여: ~y~[E] ~w~/ 취소: ~y~[Z]", 1.5)
							DrawText3D(playerPos.x, playerPos.y, playerPos.z - 0.15, "~w~관전: ~y~[G]", 1.5)
							if not enterProc then
								if IsControlJustReleased(1, 51) then
									enterProc = true
									vrp_deathmatchS.addMember(
										{id},
										function(r)
											if not r then
												enterProc = false
											end
										end
									)
								elseif IsControlJustReleased(1, 47) then
									enterProc = true
									vrp_deathmatchS.addMember(
										{id, 0, true},
										function(r)
											if not r then
												enterProc = false
											end
										end
									)
								elseif IsControlJustReleased(1, 20) then
									enterProc = true
									vrp_deathmatchS.removeMember(
										{id},
										function(r)
											if not r then
												enterProc = false
											end
										end
									)
								end
							end
						end
					elseif v.type == 2 then
						local coords1 = vector3(v.coords.x - 5.0, v.coords.y - 5.0, v.coords.z)
						local coords2 = vector3(v.coords.x + 5.0, v.coords.y + 5.0, v.coords.z)
						local dist1 = Vdist(playerPos, coords1)
						local dist2 = Vdist(playerPos, coords2)
						DrawMarker(1, coords1.x, coords1.y, coords1.z - 50, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 52.0, 255, 0, 0, 250, 0, 0, 2, 0, 0, 0, 0)
						DrawMarker(1, coords2.x, coords2.y, coords2.z - 50, 0, 0, 0, 0, 0, 0, 10.0, 10.0, 52.0, 0, 0, 255, 250, 0, 0, 2, 0, 0, 0, 0)
						if dist1 < 5 then
							DrawText3D(playerPos.x, playerPos.y, playerPos.z + 0.15, "~g~팀전", 1.5)
							DrawText3D(playerPos.x, playerPos.y, playerPos.z, "~r~레드~w~팀 참여: ~y~[E] ~w~/ 취소: ~y~[Z]", 1.5)
							DrawText3D(playerPos.x, playerPos.y, playerPos.z - 0.15, "~w~관전: ~y~[G]", 1.5)
							if not enterProc then
								if IsControlJustReleased(1, 51) then
									enterProc = true
									vrp_deathmatchS.addMember({id, 1})
								elseif IsControlJustReleased(1, 47) then
									enterProc = true
									vrp_deathmatchS.addMember({id, 1, true})
								elseif IsControlJustReleased(1, 20) then
									enterProc = true
									vrp_deathmatchS.removeMember({id})
								end
							end
						end
						if dist2 < 5 then
							DrawText3D(playerPos.x, playerPos.y, playerPos.z + 0.15, "~g~팀전", 1.5)
							DrawText3D(playerPos.x, playerPos.y, playerPos.z, "~b~블루~w~팀 참여: ~y~[E] ~w~/ 취소: ~y~[Z]", 1.5)
							DrawText3D(playerPos.x, playerPos.y, playerPos.z - 0.15, "~w~관전: ~y~[G]", 1.5)
							if not enterProc then
								if IsControlJustReleased(1, 51) then
									enterProc = true
									vrp_deathmatchS.addMember({id, 2})
								elseif IsControlJustReleased(1, 47) then
									enterProc = true
									vrp_deathmatchS.addMember({id, 2, true})
								elseif IsControlJustReleased(1, 20) then
									enterProc = true
									vrp_deathmatchS.removeMember({id})
								end
							end
						end
					end
				end
			end
		end
	end
)

local isShowUserList = false

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if matchId and matchId > 0 and matchPoints[matchId] then
				if IsControlJustReleased(1, 44) then
					isShowUserList = false
				end
				if IsControlJustPressed(1, 44) then
					isShowUserList = true
				end
				if not isDead and GetEntityHealth(GetPlayerPed(-1)) <= 10 then
					isDead = true
				end
				if isDead then
					SetEntityHealth(GetPlayerPed(-1), 120)
				end
				if matchPoints[matchId].type == 1 then
					local totalTime = getTimeString(matchPoints[matchId].time)
					local areaTime = getTimeString(matchPoints[matchId].areaTime)
					local serverId = GetPlayerServerId(PlayerId())
					local myStatus = ""
					local myRank = 0
					local myInfo = {}
					for k, v in pairs(memberList) do
						if v.source == serverId then
							if v.monitor then
								myStatus = "~w~관전"
								myRank = "~w~없음"
							else
								myStatus = "~g~참여"
								myRank = "~y~" .. k
							end
							myInfo = v
							break
						end
					end
					local myInfoText = ""
					local myInfoText2 = ""
					if myInfo.kill then
						myInfoText = "~w~(상태: " .. myStatus .. "~w~ / 랭크: " .. myRank .. "~w~)"
						myInfoText2 = "~w~(킬: ~y~" .. myInfo.kill .. "~w~ / 데스: ~r~" .. myInfo.death .. "~w~ / 점수: ~b~" .. myInfo.point .. "p~w~)"
					end

					local total = 0
					local life = 0
					local monitor = 0
					local died = 0
					for k, v in pairs(memberList) do
						if v.died then
							died = died + 1
						elseif not v.monitor then
							life = life + 1
						end
						if v.monitor then
							monitor = monitor + 1
						end
						total = total + 1
					end

					local typeName = "매치게임"
					if matchPoints[matchId].isReal then
						typeName = "생존게임"
					end

					DrawTxt2(0.40, 0.07, 0.00, 0.00, 0.28, "~w~게임상태: ~w~" .. typeName .. " ~w~(" .. statusName[matchPoints[matchId].status] .. "~w~)", 255, 255, 255, 255)
					DrawTxt2(0.40, 0.1, 0.00, 0.00, 0.28, "~w~참여인원: (전체: ~y~" .. total .. "~w~ / 생존: ~g~" .. life .. "~w~ / 사망: ~r~" .. died .. "~w~)", 255, 255, 255, 255)
					DrawTxt2(0.60, 0.07, 0.00, 0.00, 0.28, "~w~남은시간: ~y~" .. totalTime, 255, 255, 255, 255)
					DrawTxt2(0.60, 0.1, 0.00, 0.00, 0.28, "~w~구역제한: ~b~" .. areaTime, 255, 255, 255, 255)
					DrawTxt2(0.40, 0.13, 0.00, 0.00, 0.28, "~w~나의현황: " .. myInfoText, 255, 255, 255, 255)
					DrawTxt2(0.60, 0.13, 0.00, 0.00, 0.28, "~w~나의기록: " .. myInfoText2, 255, 255, 255, 255)
					if isShowUserList then
						local index = 1
						local x = 0.400
						local y = 0.150
						for k, v in pairs(memberList) do
							for i = 1, 1 do
								if index <= 30 and not v.monitor then
									y = y + 0.02
									local rank = index
									if rank < 10 then
										rank = " " .. rank
									end
									if matchPoints[matchId].status < 3 then
										rank = "*"
									end
									local name = v.name
									name = removeEmoji(name)
									name = utf8sub(name, 1, 7)
									if v.monitor then
										DrawTxt2(x, y + 0.002, 0.00, 0.00, 0.22, "~w~**", 255, 255, 255, 255)
										DrawTxt2(x + 0.015, y, 0.00, 0.00, 0.30, "~w~" .. name, 255, 255, 255, 255)
										DrawTxt2(x + 0.1, y + 0.002, 0.00, 0.00, 0.22, "~w~(킬: " .. v.kill .. " / 데스: " .. v.death .. " / 점수: " .. v.point .. "p)", 255, 255, 255, 255)
									else
										DrawTxt2(x, y + 0.002, 0.00, 0.00, 0.22, "~w~" .. rank, 255, 255, 255, 255)
										DrawTxt2(x + 0.015, y, 0.00, 0.00, 0.30, "~y~" .. name, 255, 255, 255, 255)
										DrawTxt2(x + 0.1, y + 0.002, 0.00, 0.00, 0.22, "~w~(킬: " .. v.kill .. " / 데스: " .. v.death .. " / 점수: " .. v.point .. "p)", 255, 255, 255, 255)
									end
									index = index + 1
									if index == 16 then
										x = 0.650
										y = 0.150
									end
								end
							end
						end
					else
						DrawTxt2(0.40, 0.170, 0.00, 0.00, 0.28, "~w~유저목록보기: ~y~[Q]~w~키", 255, 255, 255, 255)
					end
				elseif matchPoints[matchId].type == 2 then
					local teams = matchPoints[matchId].teams
					local totalTime = getTimeString(matchPoints[matchId].time)
					local areaTime = getTimeString(matchPoints[matchId].areaTime)
					DrawTxt2(0.40, 0.07, 0.00, 0.00, 0.31, "~w~남은시간: ~y~" .. totalTime, 255, 255, 255, 255)
					DrawTxt2(0.60, 0.07, 0.00, 0.00, 0.31, "~w~구역제한: ~b~" .. areaTime, 255, 255, 255, 255)
					DrawTxt2(0.40, 0.13, 0.00, 0.00, 0.41, "~r~레드 (" .. teams[1].players .. "명)", 255, 255, 255, 255)
					DrawTxt2(0.40, 0.16, 0.00, 0.00, 0.41, "~w~킬: ~g~" .. teams[1].kill, 255, 255, 255, 255)
					DrawTxt2(0.40, 0.19, 0.00, 0.00, 0.41, "~w~데스: ~r~" .. teams[1].death, 255, 255, 255, 255)
					DrawTxt2(0.40, 0.22, 0.00, 0.00, 0.41, "~w~점수: ~y~" .. teams[1].point, 255, 255, 255, 255)
					DrawTxt2(0.60, 0.13, 0.00, 0.00, 0.41, "~b~블루 (" .. teams[2].players .. "명)", 255, 255, 255, 255)
					DrawTxt2(0.60, 0.16, 0.00, 0.00, 0.41, "~w~킬: ~g~" .. teams[2].kill, 255, 255, 255, 255)
					DrawTxt2(0.60, 0.19, 0.00, 0.00, 0.41, "~w~데스: ~r~" .. teams[2].death, 255, 255, 255, 255)
					DrawTxt2(0.60, 0.22, 0.00, 0.00, 0.41, "~w~점수: ~y~" .. teams[2].point, 255, 255, 255, 255)
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			if matchId and matchId > 0 and matchPoints[matchId] and isDead then
				if matchPoints[matchId].isReal then
					if respawnTime > 0 and respawnTime % 5 == 0 then
						vRP.notify({"~r~당신은 사망했습니다.\n~y~" .. respawnTime .. "초~w~ 후 관전모드로 전환됩니다."})
					end
					if respawnTime > 0 then
						respawnTime = respawnTime - 1
					else
						vrp_deathmatchS.changeMonitorMode({matchId})
						respawnTime = 20
						isDeadReal = true
						isDead = false
						matchMonitor = true
						local x, y, z = vRP.getPosition()
						NetworkResurrectLocalPlayer(x, y, z, true, true, false)
						Citizen.Wait(0)
						vRP.giveWeapons({{}, true})
						vRP.notify({"~g~관전모드로 전환되었습니다."})
						isGod = true

						vRP.notify({"~y~잠시후 부활지로 이동됩니다."})
						Citizen.Wait(5000)
						SetEntityCoords(GetPlayerPed(-1), 338.51736450195, -1394.6850585938, 32.509258270264)
					end
				else
					if respawnTime > 0 and respawnTime % 5 == 0 then
						vRP.notify({"~r~당신은 사망했습니다.\n~y~" .. respawnTime .. "초~w~ 후 부활합니다."})
					end
					if respawnTime > 0 then
						respawnTime = respawnTime - 1
					else
						vrp_deathmatchS.revive({matchId})
						respawnTime = 20
						isDead = false
						local x, y, z = vRP.getPosition()
						NetworkResurrectLocalPlayer(x, y, z, true, true, false)
						Citizen.Wait(0)
						vRP.notify({"~g~부활 했습니다."})
						isGod = true
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
			if matchId and matchId > 0 and matchPoints[matchId] then
				local ped = GetPlayerPed(-1)
				if isGod or matchMonitor or matchPoints[matchId].status == 1 or matchPoints[matchId].status == 5 then
					SetEntityHealth(ped, 2000)
					SetEntityInvincible(ped, true)
				else
					SetEntityInvincible(ped, false)
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if matchId and matchId > 0 and matchPoints[matchId] then
				if isGod and not matchPoints[matchId].isReal then
					vRP.notify({"~w~부활 후엔 ~y~5초간 ~w~무적입니다."})
					Citizen.Wait(5000)
					isGod = false
					Citizen.Wait(100)
					vRP.notify({"~w~무적이 해제되었습니다."})
					SetEntityHealth(GetPlayerPed(-1), 200)
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			for _, v in pairs(matchPoints) do
				if v then
					if matchId and matchId > 0 and matchPoints[matchId] then
						DrawMarker(1, v.coords.x, v.coords.y, v.coords.z - 50, 0, 0, 0, 0, 0, 0, v.size, v.size, 200.0, v.color.r, v.color.g, v.color.b, 100, 0, 0, 2, 0, 0, 0, 0)

						SetBlipSprite(v.mapBlips, 10)
						SetBlipAlpha(v.mapBlips, 200)
						SetBlipCoords(v.mapBlips, v.coords.x, v.coords.y, v.coords.z)
						SetBlipScale(v.mapBlips, v.size / 2)
						SetBlipColour(v.mapBlips, math.random(1, 10))

						if v.status == 3 then
							SetBlipSprite(v.mapBlipsNext, 10)
							SetBlipAlpha(v.mapBlipsNext, 200)
							SetBlipCoords(v.mapBlipsNext, v.dcoords.x, v.dcoords.y, v.dcoords.z)
							SetBlipScale(v.mapBlipsNext, v.setSize / 2.1)
							SetBlipColour(v.mapBlipsNext, 0)

							SetBlipSprite(v.mapBlipsNextFill, 9)
							SetBlipAlpha(v.mapBlipsNextFill, 100)
							SetBlipCoords(v.mapBlipsNextFill, v.dcoords.x, v.dcoords.y, v.dcoords.z)
							SetBlipScale(v.mapBlipsNextFill, v.setSize / 2.1)
							SetBlipColour(v.mapBlipsNextFill, 2)
						else
							SetBlipAlpha(v.mapBlipsNext, 0)
							SetBlipAlpha(v.mapBlipsNextFill, 0)
						end
					else
						SetBlipAlpha(v.mapBlips, 0)
						SetBlipAlpha(v.mapBlipsNext, 0)
						SetBlipAlpha(v.mapBlipsNextFill, 0)
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000 / gameSpeed)
			if matchId and matchId > 0 then
				for _, v in pairs(matchPoints) do
					if v and v.status == 3 then
						if v.time > 0 then
							v.time = v.time - 1
						else
							vRP.notify({"~y~잠시후 게임이 종료됩니다."})
						end
						if v.time < v.gameAreaTime then
							v.areaTime = 0
						else
							if v.areaTime > 1 then
								v.areaTime = v.areaTime - 1
								if v.areaTime < 5 then
									if matchId and matchId > 0 then
										vRP.notify({"~y~잠시후 구역이 제한됩니다."})
									end
								end
							else
								v.areaTime = v.gameAreaTime
							end
						end
					end
					if v and v.status == 5 then
						v.time = 0
						v.areaTime = 0
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
			if matchId and matchId > 0 then
				if isDead or matchMonitor then
					DisableControlAction(0, 24, true) -- disable attack
					DisableControlAction(0, 29, true) -- Point
					DisableControlAction(0, 25, true) -- disable aim
					DisableControlAction(0, 47, true) -- disable weapon
					DisableControlAction(0, 58, true) -- disable weapon
					DisableControlAction(0, 263, true) -- disable melee
					DisableControlAction(0, 264, true) -- disable melee
					DisableControlAction(0, 257, true) -- disable melee
					DisableControlAction(0, 140, true) -- disable melee
					DisableControlAction(0, 141, true) -- disable melee
					DisableControlAction(0, 142, true) -- disable melee
					DisableControlAction(0, 143, true) -- disable melee
					DisableControlAction(0, 75, true) -- disable exit vehicle
					DisableControlAction(27, 75, true) -- disable exit vehicle
					DisableControlAction(0, 166, true) -- F5
					DisableControlAction(0, 167, true) -- F6
					DisableControlAction(0, 168, true) -- F7
					DisableControlAction(0, 303, true) -- U
					DisableControlAction(0, 123, true)
					DisableControlAction(0, 124, true)
					DisableControlAction(0, 125, true)
					DisableControlAction(0, 126, true)
					DisableControlAction(0, 127, true)
					DisableControlAction(0, 128, true)
					DisableControlAction(0, 311, true) -- K
					DisableControlAction(0, 182, true) -- L
					DisableControlAction(0, 82, true) -- ,
					DisableControlAction(0, 38, true) -- E
					DisableControlAction(0, 243, true) -- `
					DisableControlAction(0, 288, true) -- F1
				else
					DisableControlAction(0, 311, true)
					DisableControlAction(0, 288, true)
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			for _, v in pairs(matchPoints) do
				if v and v.status == 3 then
					if v.isChangeNewArea then
						v.moveWait = v.moveWait - 1
						if v.moveWait < 0 then
							v.moveWait = parseInt((v.gameAreaTime / 10) / gameSpeed)
							local isStop = true
							if Vdist(v.coords, v.dcoords) > 1 then
								v.coords = vector3(v.coords.x - ((v.coords.x - v.dcoords.x) / 10), v.coords.y - ((v.coords.y - v.dcoords.y) / 10), v.coords.z)
								isStop = false
							end
							if v.size > v.setSize then
								v.size = v.size - (v.size * 0.01)
								isStop = false
							end
							if isStop then
								print("isStop")
								v.isChangeNewArea = false
							end
							for a, b in pairs(v.color) do
								if v.colorDir[a] == 1 then
									v.color[a] = v.color[a] + math.random(1, 5)
									if v.color[a] >= 255 then
										v.colorDir[a] = 0
									end
								else
									v.color[a] = v.color[a] - math.random(1, 5)
									if v.color[a] <= 0 then
										v.colorDir[a] = 1
									end
								end
							end
						end
					end
				end
			end
		end
	end
)

AddEventHandler(
	"gameEventTriggered",
	function(name, args)
		if name == "CEventNetworkEntityDamage" and matchId and matchId > 0 then
			local victim = args[1]
			local attacker = args[2]
			local victimDied = args[4]

			if victimDied == 1 then
				if not isDead and IsEntityAPed(attacker) and IsPedAPlayer(attacker) and victim == PlayerPedId() then
					isDead = true

					vRP.notify({"~r~당신은 사망했습니다.\n~y~잠시후 리스폰됩니다."})
					local attackerServerId = 0
					for _, player in ipairs(GetActivePlayers()) do
						local ped = GetPlayerPed(player)
						if ped == attacker then
							attackerServerId = GetPlayerServerId(player)
							break
						end
					end
					vrp_deathmatchS.action({matchId, attackerServerId})
				end
			end
		end
	end
)

AddEventHandler(
	"onResourceStart",
	function(resource)
		if resource == GetCurrentResourceName() then
			for _, player in ipairs(GetActivePlayers()) do
				local ped = GetPlayerPed(player)
				SetEntityAlpha(ped, 255)
				SetEntityInvincible(ped, false)
			end
			TriggerEvent("vrp_ktackle:changeRestControl", false)
			TriggerEvent("vrp_names_ex:changeShowUIRest", false)
			Wait(1000)
			TriggerEvent("vrp_names_ex:changeShowUI", true)
		end
	end
)

AddEventHandler(
	"onResourceStop",
	function(resource)
		if resource == GetCurrentResourceName() then
			if matchId and matchId > 0 then
				vRP.giveWeapons({{}, true})
				vRP.giveWeapons({bWeaponList, true})
				TriggerEvent("vrp_ktackle:changeRestControl", false)
				TriggerEvent("vrp_names_ex:changeShowUIRest", false)
				Wait(1000)
				TriggerEvent("vrp_names_ex:changeShowUI", true)
			end
			for k, v in pairs(matchPoints) do
				vrp_deathmatchC.remove(k)
			end

			for _, player in ipairs(GetActivePlayers()) do
				local ped = GetPlayerPed(player)
				SetEntityAlpha(ped, 255)
			end
		end
	end
)
