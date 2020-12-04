local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")

local config = module("cfg/base")
local version = module("version")
Debug.active = config.debug

print("[vRP] launch version " .. version)

vRP = {}
Proxy.addInterface("vRP", vRP)

tvRP = {}
Tunnel.bindInterface("vRP", tvRP) -- listening for client tunnel

-- load language
local dict = module("cfg/lang/" .. config.lang) or {}
vRP.lang = Lang.new(dict)

-- init
vRPclient = Tunnel.getInterface("vRP", "vRP") -- server -> client tunnel

vRP.users = {} -- will store logged users (id) by first identifier
vRP.rusers = {} -- store the opposite of users
vRP.user_tables = {} -- user data tables (logger storage, saved to database)
vRP.user_tmp_tables = {} -- user tmp data tables (logger storage, not saved)
vRP.user_sources = {} -- user sources

-- queries
MySQL.createCommand("vRP/create_user", "INSERT INTO vrp_users(whitelisted,banned) VALUES(false,false); SELECT LAST_INSERT_ID() as id")
MySQL.createCommand("vRP/add_identifier", "replace INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)")
MySQL.createCommand("vRP/userid_byidentifier", "SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier")
MySQL.createCommand("vRP/identifiers_byidentifier", "SELECT user_id, identifier FROM vrp_user_ids WHERE user_id in (SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier)")

MySQL.createCommand("vRP/set_userdata", "REPLACE INTO vrp_user_data(user_id,dkey,dvalue,updated) VALUES(@user_id,@key,@value,now())")
MySQL.createCommand("vRP/get_userdata", "SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")

MySQL.createCommand("vRP/set_srvdata", "REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
MySQL.createCommand("vRP/get_srvdata", "SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")

MySQL.createCommand("vRP/get_banned", "SELECT banned FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_banned", "UPDATE vrp_users SET banned = @banned WHERE id = @user_id")
MySQL.createCommand("vRP/get_whitelisted", "SELECT whitelisted FROM vrp_users WHERE id = @user_id")
MySQL.createCommand("vRP/set_whitelisted", "UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id")
MySQL.createCommand("vRP/set_last_login", "UPDATE vrp_users SET name = @name, last_login = null, last_login_ip = @last_login_ip, last_login_time = now() WHERE id = @user_id")
MySQL.createCommand("vRP/get_last_login", "SELECT last_login FROM vrp_users WHERE id = @user_id")

local isPlayAccess = false

Citizen.CreateThread(
  function()
    Citizen.Wait(3000)

    local server = "RealWorld RWServer"
    print("\n /$$$$$$$                      /$$ /$$      /$$                     /$$       /$$")
    print("| $$__  $$                    | $$| $$  /$ | $$                    | $$      | $$")
    print("| $$  \\ $$  /$$$$$$   /$$$$$$ | $$| $$ /$$$| $$  /$$$$$$   /$$$$$$ | $$  /$$$$$$$")
    print("| $$$$$$$/ /$$__  $$ |____  $$| $$| $$/$$ $$ $$ /$$__  $$ /$$__  $$| $$ /$$__  $$")
    print("| $$__  $$| $$$$$$$$  /$$$$$$$| $$| $$$$_  $$$$| $$  \\ $$| $$  \\__/| $$| $$  | $$")
    print("| $$  \\ $$| $$_____/ /$$__  $$| $$| $$$/ \\  $$$| $$  | $$| $$      | $$| $$  | $$")
    print("| $$  | $$|  $$$$$$$|  $$$$$$$| $$| $$/   \\  $$|  $$$$$$/| $$      | $$|  $$$$$$$")
    print("|__/  |__/ \\_______/ \\_______/|__/|__/     \\__/ \\______/ |__/      |__/ \\_______/")
    if GetConvar("server_env", "dev") == "pro" then
      print("\n============================================")
      print("\n=== ^2[Production Mode] ^7" .. server .. " ===")
      print("\n============================================")
    else
      print("\n=============================================")
      print("\n=== ^8[Development Mode] ^7" .. server .. " ===")
      print("\n=============================================")
    end
    if GetConvar("server_env", "dev") == "pro" and GetConvar("istest", "false") == "false" then
      Citizen.Wait(10000)
      isPlayAccess = true
    else
      Citizen.Wait(1000)
      isPlayAccess = true
    end
  end
)

function vRP.basicLog(file, info)
  if true then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c") .. " => " .. info .. "\n")
  end
  file:close()
end

function vRP.basicLog2(file, info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c") .. " => " .. info .. "\n")
  end
  file:close()
end

function vRP.getUserIdByIdentifiers(ids, selIds, cbr)
  local task = Task(cbr)

  local findIds = {}

  MySQL.query(
    "vRP/identifiers_byidentifier",
    {identifier = selIds.license},
    function(rows, affected)
      if rows and #rows > 0 then
        local user_id = rows[1].user_id
        if selIds.steam == nil then
          task({user_id})
        else
          for k, v in pairs(rows) do
            if string.find(v.identifier, "steam:") ~= nil then
              findIds.steam = v.identifier
            end
          end
          if findIds.steam == nil then
            MySQL.execute("vRP/add_identifier", {user_id = user_id, identifier = selIds.steam})
            task({user_id})
          else
            if findIds.steam == selIds.steam then
              task({user_id})
            else
              MySQL.query(
                "vRP/userid_byidentifier",
                {identifier = selIds.steam},
                function(rows, affected)
                  if #rows > 0 then
                    local user_id = rows[1].user_id
                    task({user_id})
                  else
                    task()
                  end
                end
              )
            end
          end
        end
      else
        MySQL.query(
          "vRP/create_user",
          {},
          function(rows, affected)
            if #rows >= 2 then
              local user_id = rows[2][1].id
              for l, w in pairs(ids) do
                MySQL.execute("vRP/add_identifier", {user_id = user_id, identifier = w})
              end
              task({user_id, true})
            else
              task()
            end
          end
        )
      end
    end
  )
end

-- return identification string for the source (used for non vRP identifications, for rejected players)
function vRP.getSourceIdKey(source)
  local ids = GetPlayerIdentifiers(source)
  local idk = "idk_"
  for k, v in pairs(ids) do
    idk = idk .. v
  end

  return idk
end

function vRP.getPlayerEndpoint(player)
  return GetPlayerEP(player) or "0.0.0.0"
end

function vRP.getPlayerName(player)
  return GetPlayerName(player) or ""
end

--- sql
function vRP.isBanned(user_id, cbr)
  local task = Task(cbr, {false})

  MySQL.query(
    "vRP/get_banned",
    {user_id = user_id},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].banned})
      else
        task()
      end
    end
  )
end

--- sql
function vRP.setBanned(user_id, banned)
  MySQL.execute("vRP/set_banned", {user_id = user_id, banned = banned})
end

--- sql
function vRP.isWhitelisted(user_id, cbr)
  local task = Task(cbr, {false})

  MySQL.query(
    "vRP/get_whitelisted",
    {user_id = user_id},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].whitelisted})
      else
        task()
      end
    end
  )
end

--- sql
function vRP.setWhitelisted(user_id, whitelisted)
  MySQL.execute("vRP/set_whitelisted", {user_id = user_id, whitelisted = whitelisted})
end

--- sql
function vRP.getLastLogin(user_id, cbr)
  local task = Task(cbr, {""})
  MySQL.query(
    "vRP/get_last_login",
    {user_id = user_id},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].last_login})
      else
        task()
      end
    end
  )
end

function vRP.setUData(user_id, key, value)
  if user_id == nil or key == nil or value == nil then
    return
  end
  MySQL.execute("vRP/set_userdata", {user_id = user_id, key = key, value = value})
end

function vRP.getUData(user_id, key, cbr)
  local task = Task(cbr, {""})

  MySQL.query(
    "vRP/get_userdata",
    {user_id = user_id, key = key},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].dvalue})
      else
        task()
      end
    end
  )
end

function vRP.setSData(key, value)
  MySQL.execute("vRP/set_srvdata", {key = key, value = value})
end

function vRP.getSData(key, cbr)
  local task = Task(cbr, {""})

  MySQL.query(
    "vRP/get_srvdata",
    {key = key},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].dvalue})
      else
        task()
      end
    end
  )
end

-- return user data table for vRP internal persistant connected user storage
function vRP.getUserDataTable(user_id)
  return vRP.user_tables[user_id]
end

function vRP.setUserDataTable(user_id, data)
  vRP.user_tables[user_id] = data
end

function vRP.getUserTmpTable(user_id)
  return vRP.user_tmp_tables[user_id]
end

function vRP.isConnected(user_id)
  return vRP.rusers[user_id] ~= nil
end

function vRP.isFirstSpawn(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  return tmp and tmp.spawns == 1
end

function vRP.getUserId(source)
  if source ~= nil then
    local ids = GetPlayerIdentifiers(source)
    if ids ~= nil and #ids > 0 then
      return vRP.users[ids[1]]
    end
  end

  return nil
end

-- return map of user_id -> player source
function vRP.getUsers()
  local users = {}
  for k, v in pairs(vRP.user_sources) do
    users[k] = v
  end

  return users
end

-- return source or nil
function vRP.getUserSource(user_id)
  return vRP.user_sources[user_id]
end

function vRP.ban(source, reason)
  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    vRP.setBanned(user_id, true)
    vRP.kick(source, "[차단] " .. reason)
  end
end

function vRP.banByUserId(user_id, reason)
  if user_id ~= nil then
    vRP.setBanned(user_id, true)
  end
end

function vRP.kick(source, reason)
  DropPlayer(source, reason)
end

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(config.save_interval * 1000)

      TriggerEvent("vRP:save")

      Debug.pbegin("vRP save datatables")
      for k, v in pairs(vRP.user_tables) do
        if v ~= nil and v.groups ~= nil and v.groups.user ~= nil and v.groups.user == true then
          vRP.setUData(k, "vRP:datatable", json.encode(v))
        --print("vRP save datatables", k)
        end
        Citizen.Wait(0)
      end

      Debug.pend()
    end
  end
)

function clear_user_cache(user_id)
  if user_id ~= nil then
    vRP.setUData(user_id, "vRP:datatable", json.encode(vRP.getUserDataTable(user_id)))
    local id = vRP.rusers[user_id]
    if id ~= nil then
      vRP.users[id] = nil
    end
    vRP.rusers[user_id] = nil
    vRP.user_tables[user_id] = nil
    vRP.user_tmp_tables[user_id] = nil
    vRP.user_sources[user_id] = nil
  end
end

-- handlers

AddEventHandler(
  "playerConnecting",
  function(name, setMessage, deferrals)
    deferrals.defer()

    local source = source
    Debug.pbegin("playerConnecting")

    if not isPlayAccess then
      local user_id = vRP.getUserId(source)
      if user_id then
        print("[vRP] Restrict User (user_id = " .. user_id .. ")")
      end
      deferrals.done("[리얼월드] 서버 준비중 입니다. 잠시후 다시 접속해주세요.")
      Debug.pend()
      return
    end

    local ids = GetPlayerIdentifiers(source)
    local selIds = {}
    for k, v in pairs(ids) do
      if string.find(v, "license:") ~= nil then
        selIds.license = v
      end
      if string.find(v, "steam:") ~= nil then
        selIds.steam = v
      end
    end
    if selIds.license ~= nil then
      if ids ~= nil and #ids > 0 then
        deferrals.update("[리얼월드] 서버에 연결중...")
        vRP.getUserIdByIdentifiers(
          ids,
          selIds,
          function(user_id, isNew)
            -- if user_id ~= nil and vRP.rusers[user_id] == nil then -- check user validity and if not already connected (old way, disabled until playerDropped is sure to be called)
            if user_id ~= nil then -- check user validity
              if tonumber(user_id) > 10 then
                local isTest = GetConvar("istest", "false")
                if isTest == "true" then
                  print("[vRP] Reject User (user_id = " .. user_id .. ")")
                  deferrals.done("[리얼월드] 서버 준비중 입니다. 잠시후 다시 접속해주세요.")
                  return
                elseif isTest == "rest" then
                  print("[vRP] Restrict User (user_id = " .. user_id .. ")")
                  deferrals.done("[리얼월드] 현재 서버 접속을 허용하지 않습니다. 잠시후 다시 접속해주세요.")
                  return
                elseif isTest == "reboot" then
                  print("[vRP] Restrict User (user_id = " .. user_id .. ")")
                  deferrals.done("[리얼월드] 서버 리붓 진행중입니다. 리붓후 다시 접속해주세요.")
                  return
                end
              end
              deferrals.update("[리얼월드] 차단여부 확인중...")
              vRP.isBanned(
                user_id,
                function(banned)
                  if not banned then
                    deferrals.update("[리얼월드] 화이트 리스트 체크중...")
                    vRP.isWhitelisted(
                      user_id,
                      function(whitelisted)
                        if not config.whitelist or whitelisted then
                          Debug.pbegin("playerConnecting_delayed")
                          if vRP.rusers[user_id] == nil then -- not present on the server, init
                            if isNew then
                              deferrals.update("[리얼월드] 새로운 사용자 등록중...")
                            else
                              deferrals.update("[리얼월드] 사용자 데이터를 불러오는중...")
                            end

                            vRP.getUData(
                              user_id,
                              "vRP:datatable",
                              function(sdata)
                                local data = {}
                                if isNew then
                                  data = {
                                    groups = {
                                      user = true
                                    }
                                  }
                                else
                                  data = json.decode(sdata)
                                end
                                if vRP.user_tables[user_id] == nil and data ~= nil and type(data) == "table" and data.groups.user == true then
                                  vRP.users[ids[1]] = user_id
                                  vRP.rusers[user_id] = ids[1]
                                  vRP.user_tables[user_id] = data
                                  vRP.user_tmp_tables[user_id] = {}
                                  vRP.user_sources[user_id] = source

                                  local tmpdata = vRP.getUserTmpTable(user_id)

                                  deferrals.update("[리얼월드] 서버에 로그인 중...")
                                  vRP.getLastLogin(
                                    user_id,
                                    function(last_login)
                                      tmpdata.last_login = last_login or ""
                                      tmpdata.spawns = 0

                                      -- set last login
                                      local last_login_ip = vRP.getPlayerEndpoint(source)
                                      local name = vRP.getPlayerName(source)
                                      MySQL.execute("vRP/set_last_login", {user_id = user_id, name = name, last_login_ip = last_login_ip})

                                      -- trigger join
                                      print("^2[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(source) .. ") joined (user_id = " .. user_id .. ")^7")
                                      TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                                      deferrals.done()
                                    end
                                  )
                                else
                                  deferrals.done("[리얼월드] 데이터 로드 실패. 잠시후 다시 시도해주세요. (고유번호: " .. user_id .. ").")
                                end
                              end
                            )
                          else
                            local old_source = vRP.getUserSource(user_id)
                            if old_source == nil or vRP.getPlayerEndpoint(old_source) == "0.0.0.0" then
                              print("^2[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(source) .. ") re-joined (user_id = " .. user_id .. ")^7")
                              TriggerEvent("vRP:playerRejoin", user_id, source, name)
                              deferrals.done()

                              -- reset first spawn
                              local tmpdata = vRP.getUserTmpTable(user_id)
                              tmpdata.spawns = 0
                            else
                              print("^8[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(old_source) .. ") rejected: already connected (user_id = " .. user_id .. ")^7")
                              vRP.kick(old_source, "다른 PC에서 접속됨.")
                              deferrals.done("[리얼월드] 이미 접속된 사용자 입니다. 잠시후 다시 시도해주세요. (고유번호: " .. user_id .. ").")
                            end
                          end
                          Debug.pend()
                        else
                          print("[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(source) .. ") rejected: not whitelisted (user_id = " .. user_id .. ")")
                          deferrals.done("[리얼월드] 화이트리스트가 아닙니다. (고유번호: " .. user_id .. ").")
                        end
                      end
                    )
                  else
                    print("[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(source) .. ") rejected: banned (user_id = " .. user_id .. ")")
                    deferrals.done("[리얼월드] 당신은 차단된 사용자입니다. (고유번호: " .. user_id .. ").")
                  end
                end
              )
            else
              print("[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(source) .. ") rejected: identification error")
              deferrals.done("[리얼월드] 현재 접속이 지연되고 있습니다. 잠시후 다시 시도해주세요.")
            end
          end
        )
      else
        print("[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(source) .. ") rejected: missing identifiers")
        deferrals.done("[리얼월드] 신원인증 데이터 오류.")
      end
    else
      print("[vRP] " .. name .. " (" .. vRP.getPlayerEndpoint(source) .. ") rejected: missing steam")
      deferrals.done("[리얼월드] 스팀(Steam) 사용자만 접속할 수 있습니다. 스팀실행 > FiveM실행 > 리얼월드 접속. \n 스팀(Steam)다운로드: http://steampowered.com")
    end
    Debug.pend()
  end
)

AddEventHandler(
  "playerDropped",
  function(reason)
    local source = source
    Debug.pbegin("playerDropped")
    -- remove player from connected clients
    vRPclient.removePlayer(-1, {source})
    local user_id = vRP.getUserId(source)
    local data = vRP.getUserId(source)
    if user_id ~= nil then
      TriggerEvent("vRP:playerLeave", user_id, source)
      print("^8[vRP] " .. vRP.getPlayerEndpoint(source) .. " disconnected (user_id = " .. user_id .. ") (" .. reason .. ")^7")
      if vRP.user_tables[user_id] ~= nil and vRP.user_tables[user_id].position ~= nil then
        local pos = vRP.user_tables[user_id].position
        print("^8[vRP] " .. pos.x .. "," .. pos.y .. "," .. pos.z .. "^7")
        if reason ~= nil and string.find(reason, "crash") ~= nil then
          vRP.basicLog2("logs/gamecrash.txt", user_id .. " | " .. reason .. " | " .. pos.x .. "," .. pos.y .. "," .. pos.z)
        end
      end
      clear_user_cache(user_id)
    end
    Debug.pend()
  end
)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler(
  "vRPcli:playerSpawned",
  function()
    Debug.pbegin("playerSpawned")
    -- register user sources and then set first spawn to false
    local user_id = vRP.getUserId(source)
    local player = source
    if user_id ~= nil then
      vRP.user_sources[user_id] = source
      local tmp = vRP.getUserTmpTable(user_id)
      tmp.spawns = tmp.spawns + 1
      local first_spawn = (tmp.spawns == 1)

      if first_spawn then
        -- first spawn, reference player
        -- send players to new player
        for k, v in pairs(vRP.user_sources) do
          vRPclient.addPlayer(source, {v})
        end
        -- send new player to all players
        vRPclient.addPlayer(-1, {source})
      end

      -- set client tunnel delay at first spawn
      Tunnel.setDestDelay(player, config.load_delay)

      -- show loading
      vRPclient.setProgressBar(player, {"vRP:loading", "botright", "로딩중...", 0, 0, 0, 100})

      SetTimeout(
        2000,
        function()
          -- trigger spawn event
          TriggerEvent("vRP:playerSpawn", user_id, player, first_spawn)

          SetTimeout(
            config.load_duration * 1000,
            function()
              -- set client delay to normal delay
              Tunnel.setDestDelay(player, config.global_delay)
              vRPclient.removeProgressBar(player, {"vRP:loading"})
            end
          )
        end
      )
    end

    Debug.pend()
  end
)

RegisterServerEvent("vRP:playerDied")
