local cfg = module("cfg/survival")
local lang = vRP.lang

local revive_seq = {
  {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", 10},
  {"mini@cpr@char_a@cpr_def", "cpr_success", 1}
}

local progressMedRevive = {}

-- api

function vRP.getHunger(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.hunger
  end

  return 0
end

function vRP.getThirst(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.thirst
  end

  return 0
end

function vRP.setHunger(user_id, value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.hunger = value
    if data.hunger < 0 then
      data.hunger = 0
    elseif data.hunger > 100 then
      data.hunger = 100
    end
  end
end

function vRP.setThirst(user_id, value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.thirst = value
    if data.thirst < 0 then
      data.thirst = 0
    elseif data.thirst > 100 then
      data.thirst = 100
    end
  end
end

function vRP.varyHunger(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.hunger = data.hunger + variation

    -- apply overflow as damage
    local overflow = data.hunger - 100
    if overflow > 0 then
      vRPclient.varyHealth(vRP.getUserSource(user_id), {-overflow * cfg.overflow_damage_factor})
    end

    if data.hunger < 0 then
      data.hunger = 0
    elseif data.hunger > 100 then
      data.hunger = 100
    end
  end
end

function vRP.varyThirst(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.thirst = data.thirst + variation

    local overflow = data.thirst - 100
    if overflow > 0 then
      vRPclient.varyHealth(vRP.getUserSource(user_id), {-overflow * cfg.overflow_damage_factor})
    end

    if data.thirst < 0 then
      data.thirst = 0
    elseif data.thirst > 100 then
      data.thirst = 100
    end
  end
end

function vRP.revive(user_id)
  local player = vRP.getUserSource(user_id)
  if player == nil then
    return
  end
  if vRP.hasPermission(user_id, "emergency.revive") then
    vRPclient.getNearestPlayer(
      player,
      {5},
      function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
          if progressMedRevive[nuser_id] ~= nil then
            vRPclient.notify(player, {"~r~해당유저는 이미 회복중입니다."})
            return
          end

          vRPclient.isInComa(
            nplayer,
            {},
            function(in_coma)
              if in_coma then
                if vRP.tryGetInventoryItem(user_id, "medkit", 1, true) then
                  progressMedRevive[nuser_id] = user_id

                  vRPclient.playAnim(player, {false, revive_seq, false})
                  vRPclient.progressBars(player, {5000, "회복시키는중.."})
                  vRPclient.progressBars(nplayer, {5000, "회복중.."})
                  SetTimeout(
                    5000,
                    function()
                      progressMedRevive[nuser_id] = nil
                      local emsamount = 350000
                      local money = vRP.getBankMoney(nuser_id)
                      vRPclient.varyHealth(nplayer, {80}) -- heal 50
                      vRP.setBankMoney(nuser_id, money - emsamount)
                      vRP.giveBankMoney(user_id, emsamount)
                      vRPclient.notify(player, {"~b~ 치료비를 받았습니다. ~g~" .. format_num(emsamount)})
                      vRPclient.notify(nplayer, {"~r~ 치료비를 지불하였습니다. ~r~" .. format_num(emsamount)})
                      vRPclient.stopAnim(player, {false})
                    end
                  )
                end
              else
                vRPclient.notify(player, {lang.emergency.menu.revive.not_in_coma()})
              end
            end
          )
        else
          vRPclient.notify(player, {lang.common.no_player_near()})
        end
      end
    )
  end
end

-- tunnel api (expose some functions to clients)

function tvRP.varyHunger(variation)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.varyHunger(user_id, variation)
  end
end

function tvRP.varyThirst(variation)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.varyThirst(user_id, variation)
  end
end

function tvRP.revive()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    vRP.revive(user_id)
  end
end

-- tasks

-- hunger/thirst increase
function task_update()
  for k, v in pairs(vRP.users) do
    vRP.varyHunger(v, cfg.hunger_per_minute)
    vRP.varyThirst(v, cfg.thirst_per_minute)
  end

  SetTimeout(60000, task_update)
end
task_update()

-- handlers

-- init values
AddEventHandler(
  "vRP:playerJoin",
  function(user_id, source, name, last_login)
    local data = vRP.getUserDataTable(user_id)
    if data.hunger == nil then
      data.hunger = 0
      data.thirst = 0
    end
  end
)

-- add survival progress bars on spawn
AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    local data = vRP.getUserDataTable(user_id)

    -- disable police
    vRPclient.setPolice(source, {cfg.police})
    -- set friendly fire
    vRPclient.setFriendlyFire(source, {cfg.pvp})
    --vRPclient.setProgressBar(source,{"vRP:hunger","minimap",htxt,255,153,0,0})
    --vRPclient.setProgressBar(source,{"vRP:thirst","minimap",ttxt,0,125,255,0})
    if data then
      vRP.setHunger(user_id, data.hunger)
      vRP.setThirst(user_id, data.thirst)
    end
  end
)

local choice_revive = {
  function(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      vRP.revive(user_id)
    end
  end,
  lang.emergency.menu.revive.description()
}

-- add choices to the main menu (emergency)
vRP.registerMenuBuilder(
  "main",
  function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      local choices = {}
      if vRP.hasPermission(user_id, "emergency.revive") then
        choices[lang.emergency.menu.revive.title()] = choice_revive
      end

      add(choices)
    end
  end
)

RegisterNetEvent("proxy_vrp:action")
AddEventHandler(
  "proxy_vrp:action",
  function(type)
    local player = source
    local user_id = vRP.getUserId(player)
    if not user_id then
      return
    end
    if type == "ch_revive" then
      if vRP.hasPermission(user_id, "emergency.revive") then
        choice_revive[1](source, "")
      end
    end
  end
)