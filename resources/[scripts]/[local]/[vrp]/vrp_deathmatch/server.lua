---------------------------------------------------------
------------ VRP DeathMatch, RealWorld MAC --------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_deathmatchS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_deathmatch")
vrp_deathmatchC = Tunnel.getInterface("vrp_deathmatch", "vrp_deathmatch")
Tunnel.bindInterface("vrp_deathmatch", vrp_deathmatchS)

local index = 1
local battles = {}
local superKillUserIds = {}

function vrp_deathmatchS.broadcast(id, message, team)
  if isTest then
    if team == "all" then
      team = nil
    end
  end
  if team == "all" then
    TriggerClientEvent("chatMessage", -1, "[데스매치]", {255, 255, 0}, message)
  else
    for k, v in pairs(battles[id].members) do
      if team and v.team == team then
        TriggerClientEvent("chatMessage", v.source, "[데스매치]", {255, 255, 0}, message)
      else
        TriggerClientEvent("chatMessage", v.source, "[데스매치]", {255, 255, 0}, message)
      end
    end
  end
end

function vrp_deathmatchS.broadcastPlayerName(id)
  for k, v in pairs(battles[id].members) do
    if v and v.source then
      vrp_deathmatchC.syncPlayerName(-1, {battles[id].members})
    end
  end
end

function vrp_deathmatchS.add(type, x, y, z, size, time, isReal)
  local addGameId = index
  local gameBlock = {
    type = type,
    isReal = isReal,
    status = 1,
    members = {},
    coords = vector3(x, y, z),
    dcoords = vector3(x, y, z),
    gameSize = size,
    size = size,
    dsize = size,
    teams = {
      {players = 0, kill = 0, death = 0, point = 0},
      {players = 0, kill = 0, death = 0, point = 0}
    },
    teamResult = nil,
    gameTime = time,
    gameAreaTime = time / 10,
    time = time,
    areaTime = time / 10,
    areaResizePer = 10,
    isSelectNewArea = false
  }
  battles[addGameId] = gameBlock
  vrp_deathmatchC.add(-1, {addGameId, gameBlock})
  index = index + 1
  return addGameId
end

function vrp_deathmatchS.remove(id)
  id = parseInt(id)
  battles[id] = nil
  vrp_deathmatchC.remove(-1, {id})
  print("remove")
end

function vrp_deathmatchS.start(id)
  print("start", id)
  id = parseInt(id)
  local isValid = true
  if battles[id].status ~= 1 then
    isValid = false
  end
  local t1 = false
  local t2 = false
  for k, v in pairs(battles[id].members) do
    if v.team == 1 then
      t1 = true
    end
    if v.team == 2 then
      t2 = true
    end
  end
  if not t1 or not t2 then
  --isValid = false
  end
  if isValid then
    battles[id].status = 3
    vrp_deathmatchC.start(-1, {id})
    vrp_deathmatchS.broadcast(id, "^*^0데스매치가 ^2시작 ^0되었습니다.", "all")
  end
  print("start")
end

function vrp_deathmatchS.stop(id, selId)
  id = parseInt(id)
  if battles[id].status ~= 3 then
    return
  end
  battles[id].status = 5
  vrp_deathmatchC.stop(-1, {id})
  vrp_deathmatchS.broadcast(id, "^*^0데스매치가 ^1종료 ^0되었습니다.")

  if selId then
    local winner = battles[id].members[selId]
    vrp_deathmatchS.broadcast(id, "^*^2[결과] ^0" .. winner.name .. "님 우승!! (킬: " .. winner.kill .. " / 데스: " .. winner.death .. " / 점수: " .. winner.point .. "p)", "all")
  else
    local rankList = {}
    for k, v in pairs(battles[id].members) do
      table.insert(rankList, v)
    end
    table.sort(
      rankList,
      function(a, b)
        if tonumber(a.point) ~= nil and tonumber(b.point) ~= nil then
          return tonumber(a.point) > tonumber(b.point)
        else
          return false
        end
      end
    )

    if battles[id].type == 1 then
      local rankName = {"우승", "2등", "3등"}
      for i = 1, 3 do
        if rankList[i] then
          vrp_deathmatchS.broadcast(id, "^*^2[결과] ^0" .. rankName[i] .. ": " .. rankList[i].name .. "(킬: " .. rankList[i].kill .. " / 데스: " .. rankList[i].death .. " / 점수: " .. rankList[i].point .. "p)", "all")
        end
      end
    elseif battles[id].type == 2 then
      if battles[id].teams[1].point > battles[id].teams[2].point then
        vrp_deathmatchS.broadcast(id, "^*^2[결과] ^0승리팀: ^1레드")
      elseif battles[id].teams[1].point < battles[id].teams[2].point then
        vrp_deathmatchS.broadcast(id, "^*^2[결과] ^0승리팀: ^5블루")
      else
        vrp_deathmatchS.broadcast(id, "^*^2[결과] ^0무승부")
      end
    end
  end

  print("stop")
end

function vrp_deathmatchS.addMember(id, team, monitor)
  local player = source
  local user_id = vRP.getUserId({player})
  if not user_id then
    return false
  end
  if not battles[id] then
    return false
  end
  if battles[id].members[user_id] then
    vRPclient.notify(player, {"~r~당신은 이미 팀에 참여된 상태입니다."})
    return false
  end
  if not monitor then
    monitor = false
  end
  local playerName = GetPlayerName(player)
  local memberBlock = {
    source = player,
    name = playerName,
    skill = 0,
    kill = 0,
    death = 0,
    point = 0,
    rank = 0,
    monitor = monitor,
    died = false
  }
  if battles[id].type == 1 then
    if monitor then
      vRPclient.notify(player, {"~g~게임에 관전자로 참여했습니다."})
      vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 게임에 관전자로 참여했습니다.")
    else
      vRPclient.notify(player, {"~g~게임에 참여했습니다."})
      vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 게임에 참여했습니다.")
    end
    vrp_deathmatchC.addMember(player, {id, 0, monitor})
  elseif battles[id].type == 2 then
    if monitor then
      vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 관전자로 참여했습니다.")
    else
      memberBlock.team = team
      battles[id].teams[team].players = battles[id].teams[team].players + 1
      if team == 1 then
        vRPclient.notify(player, {"~r~레드~y~팀에 참여했습니다."})
      end
      if team == 2 then
        vRPclient.notify(player, {"~b~블루~y~팀에 참여했습니다."})
      end
      vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 " .. teamName[team] .. "^0팀에 참여했습니다.")
    end
    vrp_deathmatchC.addMember(player, {id, team, monitor})
    vrp_deathmatchC.updateTeamData(-1, {id, battles[id].teams})
  end
  battles[id].members[user_id] = memberBlock
  vrp_deathmatchC.updateMemberData(-1, {id, battles[id].members})
  return true
end

function vrp_deathmatchS.removeMember(id)
  local player = source
  local user_id = vRP.getUserId({player})
  if not user_id then
    return false
  end
  if not battles[id] then
    return false
  end
  if not battles[id].members[user_id] then
    return false
  end
  local playerName = GetPlayerName(player)
  if battles[id].type == 1 then
    vRPclient.notify(player, {"~y~게임 참여가 취소되었습니다."})
    vrp_deathmatchC.removeMember(player, {id})
    vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 게임 참여를 취소했습니다.")
  elseif battles[id].type == 2 then
    local team = battles[id].members[user_id].team
    vRPclient.notify(player, {"~y~팀 참여가 취소되었습니다."})
    vrp_deathmatchC.removeMember(player, {id})
    if battles[id].members[user_id].monitor then
      vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 게임 참여를 취소했습니다.")
    else
      battles[id].teams[team].players = battles[id].teams[team].players - 1
      vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 " .. teamName[team] .. "^0팀에서 나갔습니다.")
    end
    vrp_deathmatchC.updateTeamData(-1, {id, battles[id].teams})
  end
  battles[id].members[user_id] = nil
  vrp_deathmatchC.updateMemberData(-1, {id, battles[id].members})
  return true
end

function vrp_deathmatchS.changeMonitorMode(id)
  local player = source
  local user_id = vRP.getUserId({player})
  if not user_id then
    return
  end
  if not battles[id] then
    return
  end
  if battles[id].status ~= 3 then
    return
  end
  if not battles[id].members[user_id] then
    return
  end
  battles[id].members[user_id].monitor = true
  vrp_deathmatchC.updateMemberData(-1, {id, battles[id].members})
end

function actionDead(id, player, attackerPlayer)
  local user_id = vRP.getUserId({player})
  if not user_id then
    return
  end
  if not battles[id] then
    return
  end
  if battles[id].status ~= 3 then
    return
  end

  print("dead", id, player, attackerPlayer)

  local playerName = GetPlayerName(player)

  battles[id].members[user_id].death = battles[id].members[user_id].death + 1
  battles[id].members[user_id].point = battles[id].members[user_id].point - 5
  if battles[id].members[user_id].point < 0 then
    battles[id].members[user_id].point = 0
  end
  battles[id].members[user_id].skill = 0
  battles[id].members[user_id].died = true

  if battles[id].type == 1 then
    vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 사망했습니다. ^1-5p ^0(킬: " .. battles[id].members[user_id].kill .. " / 데스: " .. battles[id].members[user_id].death .. " / 점수: " .. battles[id].members[user_id].point .. "p)")
  elseif battles[id].type == 2 then
    local team = battles[id].members[user_id].team
    battles[id].teams[team].death = battles[id].teams[team].death + 1
    battles[id].teams[team].point = battles[id].teams[team].point - 5
    if battles[id].teams[team].point < 0 then
      battles[id].teams[team].point = 0
    end

    vrp_deathmatchS.broadcast(id, teamName[team] .. " ^2" .. playerName .. "^0님이 사망했습니다. ^1-5p ^0(킬: " .. battles[id].members[user_id].kill .. " / 데스: " .. battles[id].members[user_id].death .. " / 점수: " .. battles[id].members[user_id].point .. "p)", team)
  end
end

function actionKill(id, player, deadPlayer)
  local user_id = vRP.getUserId({player})
  if not user_id then
    return
  end
  if not battles[id] then
    return
  end
  if battles[id].status ~= 3 then
    return
  end
  if player == deadPlayer then
    return
  end

  print("kill", id, player, attackerPlayer)

  local isTeamKill = false
  if battles[id].type == 2 then
    local victimPlayer = {}
    local attackerPlayer = {}
    for k, v in pairs(battles[id].members) do
      if v.source == deadPlayer then
        victimPlayer = v
      end
      if v.source == player then
        attackerPlayer = v
      end
    end
    if victimPlayer.team == attackerPlayer.team then
      isTeamKill = true
    end
  end

  local playerName = GetPlayerName(player)

  if battles[id].type == 2 and isTeamKill then
    battles[id].members[user_id].skill = 0
    battles[id].members[user_id].point = battles[id].members[user_id].point - 10

    local team = battles[id].members[user_id].team
    battles[id].teams[team].point = battles[id].teams[team].point - 10

    vrp_deathmatchS.broadcast(id, teamName[team] .. " ^2" .. playerName .. "^0님이 팀킬했습니다. ^2-10p ^0(킬: " .. battles[id].members[user_id].kill .. " / 데스: " .. battles[id].members[user_id].death .. " / 점수: " .. battles[id].members[user_id].point .. "p)", team)
  else
    battles[id].members[user_id].kill = battles[id].members[user_id].kill + 1
    battles[id].members[user_id].skill = battles[id].members[user_id].skill + 1

    local killPoint = killPoints[1][1]
    local killName = killPoints[1][2]
    if killPoints[battles[id].members[user_id].skill] then
      killPoint = killPoints[battles[id].members[user_id].skill][1]
      killName = killPoints[battles[id].members[user_id].skill][2]
    else
      battles[id].members[user_id].skill = 0
    end
    battles[id].members[user_id].point = battles[id].members[user_id].point + killPoint

    if battles[id].type == 1 then
      vrp_deathmatchS.broadcast(id, "^2" .. playerName .. "^0님이 " .. killName .. " 달성!! ^2+" .. killPoint .. "p ^0(킬: " .. battles[id].members[user_id].kill .. " / 데스: " .. battles[id].members[user_id].death .. " / 점수: " .. battles[id].members[user_id].point .. "p)")
    elseif battles[id].type == 2 then
      local team = battles[id].members[user_id].team
      battles[id].teams[team].kill = battles[id].teams[team].kill + 1
      battles[id].teams[team].point = battles[id].teams[team].point + killPoint

      vrp_deathmatchS.broadcast(id, teamName[team] .. " ^2" .. playerName .. "^0님이 " .. killName .. " 달성!! ^2+" .. killPoint .. "p ^0(킬: " .. battles[id].members[user_id].kill .. " / 데스: " .. battles[id].members[user_id].death .. " / 점수: " .. battles[id].members[user_id].point .. "p)", team)
    end

    vrp_deathmatchC.kill(player, {battles[id].members[user_id].skill})
  end
end

function vrp_deathmatchS.action(id, attackerId)
  actionDead(id, source, attackerId)
  actionKill(id, attackerId, source)
  if battles[id] then
    vrp_deathmatchC.updateMemberData(-1, {id, battles[id].members})
    vrp_deathmatchC.updateTeamData(-1, {id, battles[id].teams})
  end
end

function vrp_deathmatchS.revive(id)
  local player = source
  local user_id = vRP.getUserId({player})
  if not user_id then
    return
  end
  if not battles[id] then
    return
  end
  battles[id].members[user_id].died = false
  vrp_deathmatchC.updateMemberData(-1, {id, battles[id].members})
end

RegisterCommand(
  "dm",
  function(source, args)
    local player = source
    local coords = GetEntityCoords(GetPlayerPed(player))
    local selId = nil
    local selDist = nil
    for k, v in pairs(battles) do
      local dist = #(coords - v.dcoords)
      if selDist == nil or selDist > dist then
        selId = k
        selDist = dist
      end
    end
    if args[1] == "add" then
      if not args[2] then
        args[2] = 1800
      end
      if not args[3] then
        args[3] = 500
      end
      local id = vrp_deathmatchS.add(1, coords.x, coords.y, coords.z, parseInt(args[3]) + 0.1, parseInt(args[2]))
      vRPclient.notify(player, {"~w~데스매치 ~g~개인전 ~w~생성완료.\n(매치아이디: ~y~" .. id .. "~w~)"})
    elseif args[1] == "addr" then
      if not args[2] then
        args[2] = 1800
      end
      if not args[3] then
        args[3] = 500
      end
      local id = vrp_deathmatchS.add(1, coords.x, coords.y, coords.z, parseInt(args[3]) + 0.1, parseInt(args[2]), true)
      vRPclient.notify(player, {"~w~데스매치 ~g~개인전(생존) ~w~생성완료.\n(매치아이디: ~y~" .. id .. "~w~)"})
    elseif args[1] == "remove" and selId then
      vrp_deathmatchS.remove(selId)
    elseif args[1] == "start" and selId then
      vrp_deathmatchS.start(selId)
    elseif args[1] == "stop" and selId then
      vrp_deathmatchS.stop(selId)
    end
  end
)

RegisterCommand(
  "dmt",
  function(source, args)
    local player = source
    local coords = GetEntityCoords(GetPlayerPed(player))
    local selId = nil
    local selDist = nil
    for k, v in pairs(battles) do
      local dist = #(coords - v.dcoords)
      if selDist == nil or selDist > dist then
        selId = k
        selDist = dist
      end
    end
    if args[1] == "add" then
      if not args[2] then
        args[2] = 1800
      end
      if not args[3] then
        args[3] = 500
      end
      local id = vrp_deathmatchS.add(2, coords.x, coords.y, coords.z, parseInt(args[3]) + 0.1, parseInt(args[2]))
      vRPclient.notify(player, {"~w~데스매치 ~b~팀전 ~w~생성완료.\n(매치아이디: ~y~" .. id .. "~w~)"})
    elseif args[1] == "addr" and false then
      if not args[2] then
        args[2] = 1800
      end
      if not args[3] then
        args[3] = 500
      end
      local id = vrp_deathmatchS.add(2, coords.x, coords.y, coords.z, parseInt(args[3]) + 0.1, parseInt(args[2]), true)
      vRPclient.notify(player, {"~w~데스매치 ~b~팀전(생존) ~w~생성완료.\n(매치아이디: ~y~" .. id .. "~w~)"})
    elseif args[1] == "remove" and selId then
      vrp_deathmatchS.remove(selId)
    elseif args[1] == "start" and selId then
      vrp_deathmatchS.start(selId)
    elseif args[1] == "stop" and selId then
      vrp_deathmatchS.stop(selId)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(10)
      for id, v in pairs(battles) do
        if v and v.status == 3 then
          if v.isSelectNewArea then
            v.isSelectNewArea = false
            local rand = math.random(parseInt(v.size), parseInt(v.size * 2))
            rand = (rand / 20) * (v.size / v.gameSize)
            if math.random(1, 2) == 1 then
              v.dcoords = vector3(v.dcoords.x + rand, v.dcoords.y, v.dcoords.z)
            else
              v.dcoords = vector3(v.dcoords.x - rand, v.dcoords.y, v.dcoords.z)
            end
            if math.random(1, 2) == 1 then
              v.dcoords = vector3(v.dcoords.x, v.dcoords.y + rand, v.dcoords.z)
            else
              v.dcoords = vector3(v.dcoords.x, v.dcoords.y - rand, v.dcoords.z)
            end

            vrp_deathmatchC.changeZonePosition(-1, {id, v.dcoords.x, v.dcoords.y})

            if v.size > 50 then
              v.size = v.size - (v.size * (v.areaResizePer / 100))
              if v.areaResizePer < 50 then
                v.areaResizePer = v.areaResizePer + 5
              end
              vrp_deathmatchC.changeZoneSize(-1, {id, v.size, v.areaResizePer})
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
      Citizen.Wait(1000)
      for id, v in pairs(battles) do
        if v.isReal then
          local life = 0
          local selId = 0
          for a, b in pairs(v.members) do
            if not b.died and not b.monitor then
              life = life + 1
              selId = a
            end
          end
          if life == 1 then
            vrp_deathmatchS.stop(id, selId)
          elseif life == 0 then
            vrp_deathmatchS.stop(id)
          end
        end
        vrp_deathmatchC.syncPlayerName(-1, {v.members})
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1000 / gameSpeed)
      for id, v in pairs(battles) do
        if v and v.status == 3 then
          if v.time > 0 then
            if v.time % (v.gameAreaTime) == 0 then
              vrp_deathmatchC.changeNewArea(-1, {id})
            elseif v.time % (v.gameAreaTime / 2) == 0 then
              v.isSelectNewArea = true
            end
            v.time = v.time - 1
          else
            if not v.isReal then
              vrp_deathmatchS.stop(id)
            end
          end
        end
      end
    end
  end
)

AddEventHandler(
  "playerDropped",
  function(reason)
    local player = source
    if not player then
      return
    end
    for id, battle in pairs(battles) do
      for k, v in pairs(battle.members) do
        if v.source == player then
          battles[id].members[k] = nil
          vrp_deathmatchC.updateMemberData(-1, {id, battles[id].members})
          break
        end
      end
    end
  end
)
