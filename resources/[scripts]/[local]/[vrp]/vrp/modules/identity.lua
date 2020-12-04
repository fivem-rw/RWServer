local htmlEntities = module("lib/htmlEntities")
math.randomseed(os.time())
local cfg = module("cfg/identity")
local cfg_user_title = module("cfg/user_title")
local lang = vRP.lang

local sanitizes = module("cfg/sanitizes")

MySQL.createCommand("vRP/get_user_identities", "SELECT * FROM vrp_user_identities WHERE user_id in (@user_ids)")
MySQL.createCommand("vRP/get_user_identity", "SELECT * FROM vrp_user_identities WHERE user_id = @user_id")
MySQL.createCommand("vRP/init_user_identity", "INSERT IGNORE INTO vrp_user_identities(user_id,registration,phone,firstname,name,age) VALUES(@user_id,@registration,@phone,@firstname,@name,@age)")
MySQL.createCommand("vRP/update_user_identity", "UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age, registration = @registration, phone = @phone WHERE user_id = @user_id")
MySQL.createCommand("vRP/update_user_identity2", "UPDATE vrp_user_identities SET firstname = @firstname, name = @name, age = @age WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_userbyreg", "SELECT user_id FROM vrp_user_identities WHERE registration = @registration")
MySQL.createCommand("vRP/get_userbyphone", "SELECT user_id FROM vrp_user_identities WHERE phone = @phone")

function vRP.getUserIdentity(user_id, cbr)
  if cbr == nil then
    return
  end
  local task = Task(cbr)

  MySQL.query(
    "vRP/get_user_identity",
    {user_id = user_id},
    function(rows, affected)
      if rows and rows[1] then
        task({rows[1]})
      else
        task({})
      end
    end
  )
end

function vRP.getUserIdentities(arr_user_ids, cbr)
  if cbr == nil then
    return
  end
  local task = Task(cbr)
  if arr_user_ids == nil or #arr_user_ids <= 0 then
    task({})
    return
  end
  MySQL.query(
    "vRP/get_user_identities",
    {user_ids = arr_user_ids},
    function(rows, affected)
      if rows == nil then
        task({})
      else
        task({rows})
      end
    end
  )
end

function GetJobType(user_id)
  local jobType = nil
  if vRP.hasPermission(user_id, "cop.whitelisted") then
    jobType = "cop"
  elseif vRP.hasPermission(user_id, "ems.whitelisted") then
    jobType = "ems"
  elseif vRP.hasPermission(user_id, "uber.whitelisted") then
    jobType = "uber"
  elseif vRP.hasPermission(user_id, "repair.whitelisted") then
    jobType = "repair"
  elseif vRP.hasPermission(user_id, "shh.whitelisted") then
    jobType = "shh"
  elseif vRP.hasPermission(user_id, "mafia.whitelisted") then
    jobType = "mafia"
  elseif vRP.hasPermission(user_id, "dok.whitelisted") then
    jobType = "dok"    
  elseif vRP.hasPermission(user_id, "gm.whitelisted") then
    jobType = "gm"
  elseif vRP.hasPermission(user_id, "tow.whitelisted") then
    jobType = "tow"
  elseif vRP.hasPermission(user_id, "cbs.whitelisted") then
    jobType = "cbs"
  elseif vRP.hasPermission(user_id, "kys.whitelisted") then
    jobType = "kys"
  elseif vRP.hasPermission(user_id, "helper.whitelisted") then
    jobType = "helper"
  elseif vRP.hasPermission(user_id, "inspector.whitelisted") then
    jobType = "inspector"
  elseif vRP.hasPermission(user_id, "admin.whitelisted") then
    jobType = "admin"
  elseif vRP.hasPermission(user_id, "subae.whitelisted") then
    jobType = "subae"    
  end
  return jobType
end

function GetUserTitleInfo(user_id)
  local tmpGroups = vRP.getUserGroups(user_id)
  local selUserTitle = nil
  for k, v in pairs(cfg_user_title.titles) do
    for k2, v2 in pairs(tmpGroups) do
      if k2 == v.group and v2 == true then
        selUserTitle = v
        break
      end
    end
    if selUserTitle ~= nil then
      break
    end
  end
  return selUserTitle
end

function GetArrUserGroups(user_id)
  local tmpGroups = vRP.getUserGroups(user_id)
  local arrGroups = {}
  for k2, v2 in pairs(tmpGroups) do
    if v2 == true then
      table.insert(arrGroups, k2)
    end
  end
  return arrGroups
end

local userList = {}
local user_ids = {}
local playerInfo = {}
function makeUserListTask()
  userList = {}
  user_ids = {}
  for _, v in ipairs(GetPlayers()) do
    playerInfo = {
      source = v,
      user_id = vRP.getUserId(v) or "",
      nickname = GetPlayerName(v) or "",
      name = "",
      job = "",
      jobType = ""
    }
    userList[playerInfo.user_id] = playerInfo
    table.insert(user_ids, playerInfo.user_id)
  end
  vRP.getUserIdentities(
    user_ids,
    function(identities)
      if identities == nil then
        SetTimeout(20000, makeUserListTask)
        return
      end
      for _, v in ipairs(identities) do
        if userList[v.user_id] then
          if v.firstname and v.name then
            userList[v.user_id].name = htmlEntities.encode(v.firstname) .. " " .. htmlEntities.encode(v.name)
          end
          userList[v.user_id].job = vRP.getUserGroupByType(userList[v.user_id].user_id, "job") or ""
          userList[v.user_id].jobType = GetJobType(userList[v.user_id].user_id) or ""
          userList[v.user_id].userTitleInfo = GetUserTitleInfo(v.user_id)
          userList[v.user_id].groups = GetArrUserGroups(v.user_id)
          userList[v.user_id].phone = v.phone
          if _ >= #identities then
            SetTimeout(20000, makeUserListTask)
          end
        end
      end
    end
  )
  user_ids = nil
end
makeUserListTask()

function vRP.getUserInfo(user_id, cbr)
  if cbr == nil then
    return
  end
  local task = Task(cbr)
  if userList ~= nil and userList[user_id] ~= nil then
    task({userList[user_id]})
    return
  end
  task({false})
end

function vRP.getUserList(cbr)
  if cbr == nil then
    return
  end
  local task = Task(cbr)
  task({userList})
end

-- cbreturn user_id by registration or nil
function vRP.getUserByRegistration(registration, cbr)
  local task = Task(cbr)

  MySQL.query(
    "vRP/get_userbyreg",
    {registration = registration or ""},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].user_id})
      else
        task()
      end
    end
  )
end

-- cbreturn user_id by phone or nil
function vRP.getUserByPhone(phone, cbr)
  local task = Task(cbr)

  MySQL.query(
    "vRP/get_userbyphone",
    {phone = phone or ""},
    function(rows, affected)
      if #rows > 0 and rows[1] and rows[1].user_id then
        task({rows[1].user_id})
      else
        task()
      end
    end
  )
end

function vRP.generateStringNumber(format) -- (ex: DDDLLL, D => digit, L => letter)
  local abyte = string.byte("A")
  local zbyte = string.byte("0")

  local number = ""
  for i = 1, #format do
    local char = string.sub(format, i, i)
    if char == "D" then
      number = number .. string.char(zbyte + math.random(0, 9))
    elseif char == "L" then
      number = number .. string.char(abyte + math.random(0, 25))
    else
      number = number .. char
    end
  end

  return number
end

-- cbreturn a unique registration number
function vRP.generateRegistrationNumber(cbr)
  local task = Task(cbr)

  local function search()
    -- generate registration number
    local registration = vRP.generateStringNumber("DDLDDD")
    vRP.getUserByRegistration(
      registration,
      function(user_id)
        if user_id ~= nil then
          search() -- continue generation
        else
          task({registration})
        end
      end
    )
  end

  search()
end

-- cbreturn a unique phone number (0DDDDD, D => digit)
function vRP.generatePhoneNumber(cbr)
  local task = Task(cbr)

  local function search()
    -- generate phone number
    local phone = vRP.generateStringNumber(cfg.phone_format)
    vRP.getUserByPhone(
      phone,
      function(user_id)
        if user_id ~= nil then
          search() -- continue generation
        else
          task({phone})
        end
      end
    )
  end

  search()
end

-- events, init user identity at connection
AddEventHandler(
  "vRP:playerJoin",
  function(user_id, source, name, last_login)
    vRP.getUserIdentity(
      user_id,
      function(identity)
        if identity == nil then
          vRP.generateRegistrationNumber(
            function(registration)
              vRP.generatePhoneNumber(
                function(phone)
                  MySQL.execute(
                    "vRP/init_user_identity",
                    {
                      user_id = user_id,
                      registration = vRP.generateStringNumber("DDDDDD"),
                      phone = vRP.generateStringNumber("0D0DDDDDDDD"),
                      firstname = cfg.random_first_names[math.random(1, #cfg.random_first_names)],
                      name = cfg.random_last_names[math.random(1, #cfg.random_last_names)],
                      --age = math.random(25,40)
                      age = 16
                    }
                  )
                end
              )
            end
          )
        end
      end
    )
  end
)

-- city hall menu

local cityhall_menu = {name = lang.cityhall.title(), css = {top = "75px", header_color = "rgba(0,125,255,0.75)"}}

local function ch_identity(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(
      player,
      lang.cityhall.identity.prompt_firstname(),
      "",
      function(player, firstname)
        if string.len(firstname) >= 2 and string.len(firstname) < 50 then
          firstname = sanitizeString(firstname, sanitizes.name[1], sanitizes.name[2])
          vRP.prompt(
            player,
            lang.cityhall.identity.prompt_name(),
            "",
            function(player, name)
              if string.len(name) >= 2 and string.len(name) < 50 then
                name = sanitizeString(name, sanitizes.name[1], sanitizes.name[2])
                vRP.prompt(
                  player,
                  lang.cityhall.identity.prompt_age(),
                  "",
                  function(player, age)
                    age = parseInt(age)
                    if age >= 16 and age <= 150 then
                      if vRP.tryPayment(user_id, cfg.new_identity_cost) then
                        vRP.generateRegistrationNumber(
                          function(registration)
                            vRP.generatePhoneNumber(
                              function(phone)
                                MySQL.execute(
                                  "vRP/update_user_identity2",
                                  {
                                    user_id = user_id,
                                    firstname = firstname,
                                    name = name,
                                    age = age
                                  }
                                )

                                -- update client registration
                                vRPclient.setRegistrationNumber(player, {registration})
                                vRPclient.notify(player, {lang.money.paid({format_num(cfg.new_identity_cost)})})
                              end
                            )
                          end
                        )
                      else
                        vRPclient.notify(player, {lang.money.not_enough()})
                      end
                    else
                      vRPclient.notify(player, {lang.common.invalid_value()})
                    end
                  end
                )
              else
                vRPclient.notify(player, {lang.common.invalid_value()})
              end
            end
          )
        else
          vRPclient.notify(player, {lang.common.invalid_value()})
        end
      end
    )
  end
end

cityhall_menu[lang.cityhall.identity.title()] = {
  ch_identity,
  lang.cityhall.identity.description({format_num(cfg.new_identity_cost)})
}

local function cityhall_enter()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.openMenu(source, cityhall_menu)
  end
end

local function cityhall_leave()
  vRP.closeMenu(source)
end

local function build_client_cityhall(source) -- build the city hall area/marker/blip
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k, v in pairs(cfg.identity) do
      vRPclient.addBlip(source, {v[1], v[2], v[3], cfg.blip[1], cfg.blip[2], lang.cityhall.title()})
      vRPclient.addMarker(source, {v[1], v[2], v[3] - 1, 1.5, 1.5, 0.2, 0, 255, 125, 125, 100, lang.cityhall.title()})
      vRP.setArea(source, "vRP:identity" .. k, v[1], v[2], v[3], 1, 1.5, cityhall_enter, cityhall_leave)
    end
  end
end

AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    -- send registration number to client at spawn
    vRP.getUserIdentity(
      user_id,
      function(identity)
        if identity then
          vRPclient.setRegistrationNumber(source, {identity.registration or "000AAA"})
        end
      end
    )

    -- first spawn, build city hall
    if first_spawn then
      build_client_cityhall(source)
    end
  end
)

-- player identity menu

-- add identity to main menu
vRP.registerMenuBuilder(
  "main",
  function(add, data)
    local player = data.player

    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      vRP.getUserIdentity(
        user_id,
        function(identity)
          if identity then
            -- generate identity content
            -- get address
            vRP.getUserAddress(
              user_id,
              function(address)
                local home = ""
                local number = ""
                if address then
                  home = address.home
                  number = address.number
                end
                local CR1 = vRP.getCR(user_id)
                local CR2 = math.ceil(CR1 * 10 ^ 2 - 0.5) / 10 ^ 2
                local exp = vRP.getEXP(user_id)
                local content =
                  lang.cityhall.menu.info(
                  {
                    htmlEntities.encode(identity.name),
                    htmlEntities.encode(identity.firstname),
                    identity.age,
                    identity.registration,
                    identity.phone,
                    home,
                    number,
                    CR2,
                    format_num(exp)
                  }
                )
                local choices = {}
                choices[lang.cityhall.menu.title()] = {
                  function()
                  end,
                  content
                }

                add(choices)
              end
            )
          end
        end
      )
    end
  end
)
