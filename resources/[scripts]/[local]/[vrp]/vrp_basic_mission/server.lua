local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp_basic_mission", "cfg/missions")

-- load global and local languages
local glang = Lang.new(module("vrp", "cfg/lang/" .. cfg.lang) or {})
local lang = Lang.new(module("vrp_basic_mission", "cfg/lang/" .. cfg.lang) or {})

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vRP_basic_mission")

function task_mission() -- -- bankdriver
  for k, v in pairs(cfg.bankdriver) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        if math.random(1, v.chance + 1) == 1 then -- chance check
          -- build mission
          local mdata = {}
          mdata.name = lang.bankdriver({v.title})
          mdata.steps = {}

          -- build steps
          for i = 1, v.steps do
            local step = {
              text = lang.bankdriver({v.title}) .. "<br />" .. lang.reward({v.reward}),
              onenter = function(player, area)
                if vRP.tryGetInventoryItem({user_id, "bank_money", 500000, true}) then
                  vRPclient.playAnim(player, {false, {task = "CODE_HUMAN_POLICE_INVESTIGATE"}, false})
                  SetTimeout(
                    15000,
                    function()
                      vRP.nextMissionStep({player})
                      vRPclient.stopAnim(player, {false})

                      -- last step
                      if i == v.steps then
                        vRP.giveMoney({user_id, v.reward})
                        vRPclient.notify(player, {glang.money.received({v.reward})})
                      end
                    end
                  )
                end
              end,
              position = v.positions[math.random(1, #v.positions)]
            }

            table.insert(mdata.steps, step)
          end

          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- Cargo Pilot
  for k, v in pairs(cfg.pilot) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.pilot.title()

        -- generate items
        local todo = 0
        local cargo_pilot_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            cargo_pilot_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(cargo_pilot_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  cargo_pilot_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(cargo_pilot_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.pilot.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  --UPS

  for k, v in pairs(cfg.ups) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.ups.title()

        -- generate items
        local todo = 0
        local ups_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            ups_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(ups_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  ups_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(ups_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.ups.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- DELIVERY
  for k, v in pairs(cfg.delivery) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- 성장형 직업 시스템
  for k, v in pairs(cfg.delivery1) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(80)
                  local nowexp = exp + giveexp
                  if nowexp >= 500 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.2"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery2) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 1000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.3"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery3) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 2000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.4"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery4) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 3500 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.5"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery5) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 7000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.6"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery6) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 10000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.7"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery7) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 15000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.8"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery8) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 20000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.9"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery9) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(50)
                  local nowexp = exp + giveexp
                  if nowexp >= 30000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "배달부 LV.10"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery10) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(100)
                  local ultimateexp = giveexp * 3
                  local nowexp = exp + giveexp
                  if vRP.hasPermission({user_id, "ultimate.paycheck"}) then
                    if nowexp >= 50000 then
                      vRP.addUserGroup({user_id, "배달부 LV.11"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  else
                    if nowexp >= 50000 then
                      vRP.addUserGroup({user_id, "배달부 LV.11"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery11) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(100)
                  local ultimateexp = giveexp * 3
                  local nowexp = exp + giveexp
                  if vRP.hasPermission({user_id, "ultimate.paycheck"}) then
                    if nowexp >= 70000 then
                      vRP.addUserGroup({user_id, "배달부 LV.12"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  else
                    if nowexp >= 70000 then
                      vRP.addUserGroup({user_id, "배달부 LV.12"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery12) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(175)
                  local ultimateexp = giveexp * 3
                  local nowexp = exp + giveexp
                  if vRP.hasPermission({user_id, "ultimate.paycheck"}) then
                    if nowexp >= 100000 then
                      vRP.addUserGroup({user_id, "배달부 LV.13"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  else
                    if nowexp >= 100000 then
                      vRP.addUserGroup({user_id, "배달부 LV.13"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery13) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(175)
                  local ultimateexp = giveexp * 3
                  local nowexp = exp + giveexp
                  if vRP.hasPermission({user_id, "ultimate.paycheck"}) then
                    if nowexp >= 150000 then
                      vRP.addUserGroup({user_id, "배달부 LV.14"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  else
                    if nowexp >= 150000 then
                      vRP.addUserGroup({user_id, "배달부 LV.14"})
                      vRPclient.notify(player, {"~b~레벨 업!"})
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery14) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(175)
                  local ultimateexp = giveexp * 3
                  local nowexp = exp + giveexp
                  if vRP.hasPermission({user_id, "ultimate.paycheck"}) then
                    if nowexp >= 250000 then
                      vRP.addUserGroup({user_id, "배달부 LV.15"})
                      vRPclient.notify(player, {"~b~만렙 달성!"})
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + ultimateexp})
                      vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  else
                    if nowexp >= 250000 then
                      vRP.addUserGroup({user_id, "배달부 LV.15"})
                      vRPclient.notify(player, {"~b~만렙 달성!"})
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    else
                      vRP.setEXP({user_id, exp + giveexp})
                      vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    end
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.delivery15) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.delivery.title()

        -- generate items
        local todo = 0
        local delivery_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            delivery_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(delivery_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  delivery_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(175)
                  local ultimateexp = giveexp * 3
                  local nowexp = exp + giveexp
                  if vRP.hasPermission({user_id, "ultimate.paycheck"}) then
                    vRP.setEXP({user_id, exp + ultimateexp})
                    vRPclient.notify(player, {"Ultimate 적용!\n누적 경험치 : ~b~" .. nowexp .. ""})
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                    if todo == 0 then -- all received, finish mission
                      vRP.nextMissionStep({player})
                    end
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(delivery_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.delivery.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- 성장형 직업 시스템 마약밀매상 VER
  for k, v in pairs(cfg.drugseller1) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(80)
                  local nowexp = exp + giveexp
                  if nowexp >= 500 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.2"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.drugseller2) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 1000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.3"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.drugseller3) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 2000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.4"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.drugseller4) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 3500 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.5"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.drugseller5) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 7000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.6"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.drugseller6) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 10000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.7"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.drugseller7) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 15000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.8"})
                    vRPclient.notify(player, {"~b~레벨 업!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  for k, v in pairs(cfg.drugseller8) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  local tax = math.ceil(reward / 100 * 8)
                  local taxreward = math.ceil(reward - tax)
                  vRP.giveMoney({user_id, taxreward})
                  vRP.addTax({tax})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  vRPclient.notify(player, {"~b~리얼월드 소득세 8%"})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  local exp = tonumber(vRP.getEXP({user_id}))
                  local giveexp = tonumber(30)
                  local nowexp = exp + giveexp
                  if nowexp >= 20000 then
                    --vRP.setEXP({user_id,1000})
                    vRP.addUserGroup({user_id, "마약밀매상 LV.9"})
                    vRPclient.notify(player, {"~b~만렙 달성!"})
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  else
                    vRP.setEXP({user_id, exp + giveexp})
                    vRPclient.notify(player, {"누적 경험치 : ~b~" .. nowexp .. ""})
                  end
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end
  ------

  -- Drug seller
  for k, v in pairs(cfg.drugseller) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.drugseller.title()

        -- generate items
        local todo = 0
        local drugseller_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            drugseller_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(drugseller_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  drugseller_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(drugseller_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.drugseller.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- Fisherman
  for k, v in pairs(cfg.fisherman) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.fisherman.title()

        -- generate items
        local todo = 0
        local fisherman_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            fisherman_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(fisherman_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  fisherman_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(fisherman_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.fisherman.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- Medical Delivery
  for k, v in pairs(cfg.medical_driver) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.medical.title()

        -- generate items
        local todo = 0
        local medical_driver_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            medical_driver_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(medical_driver_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  medical_driver_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(medical_driver_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.medical.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- Weapons Smuggler
  for k, v in pairs(cfg.weapons_smuggler) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.weapons_smuggler.title()

        -- generate items
        local todo = 0
        local weapons_smuggler_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            weapons_smuggler_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(weapons_smuggler_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  weapons_smuggler_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(weapons_smuggler_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.weapons_smuggler.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  -- Santa (Disabled)
  -- for k,v in pairs(cfg.santa) do -- each repair perm def
  -- add missions to users
  -- local users = vRP.getUsersByPermission({k})
  -- for l,w in pairs(users) do
  -- local user_id = w
  -- local player = vRP.getUserSource({user_id})
  -- if not vRP.hasMission({player}) then
  -- build mission
  -- local mdata = {}
  -- mdata.name = lang.santa.title()

  -- generate items
  -- local todo = 0
  -- local santa_items = {}
  -- for idname,data in pairs(v.items) do
  -- local amount = math.random(data[1],data[2]+1)
  -- if amount > 0 then
  -- santa_items[idname] = amount
  -- todo = todo+1
  -- end
  -- end

  -- local step = {
  -- text = "",
  -- onenter = function(player, area)
  -- for idname,amount in pairs(santa_items) do
  -- if amount > 0 then -- check if not done
  -- if vRP.tryGetInventoryItem({user_id,idname,amount,true}) then
  -- local reward = v.items[idname][3]*amount
  -- vRP.giveMoney({user_id,reward})
  -- vRPclient.notify(player,{glang.money.received({reward})})
  -- todo = todo-1
  -- santa_items[idname] = 0
  -- if todo == 0 then -- all received, finish mission
  -- vRP.nextMissionStep({player})
  -- end
  -- end
  -- end
  -- end
  -- end,
  -- position = v.positions[math.random(1,#v.positions)]
  -- }

  -- mission display
  -- for idname,amount in pairs(santa_items) do
  -- local name = vRP.getItemName({idname})
  -- step.text = step.text..lang.santa.item({name,amount}).."<br />"
  -- end

  -- mdata.steps = {step}

  -- if todo > 0 then
  -- vRP.startMission({player,mdata})
  -- end
  -- end
  -- end
  -- end

  -- hacker
  for k, v in pairs(cfg.hacker) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.hacker.title()

        -- generate items
        local todo = 0
        local hacker_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            hacker_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(hacker_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  hacker_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(hacker_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.hacker.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end

  --[[
  for k, v in pairs(cfg.trash) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.trash.title()

        -- generate items
        local todo = 0
        local trash_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            trash_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(trash_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  trash_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(trash_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.trash.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end
  ]]
  -- Forger
  for k, v in pairs(cfg.forger) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l, w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.forger.title()

        -- generate items
        local todo = 0
        local forger_items = {}
        for idname, data in pairs(v.items) do
          local amount = math.random(data[1], data[2] + 1)
          if amount > 0 then
            forger_items[idname] = amount
            todo = todo + 1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname, amount in pairs(forger_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id, idname, amount, true}) then
                  local reward = v.items[idname][3] * amount
                  vRP.giveMoney({user_id, reward})
                  vRPclient.notify(player, {glang.money.received({reward})})
                  todo = todo - 1
                  forger_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1, #v.positions)]
        }

        -- mission display
        for idname, amount in pairs(forger_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text .. lang.forger.item({name, amount}) .. "<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player, mdata})
        end
      end
    end
  end
  --

  --[[    -- Police
  for k,v in pairs(cfg.police) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.police.title()

        -- generate items
        local todo = 0
        local police_items = {}
        for idname,data in pairs(v.items) do
          local amount = math.random(data[1],data[2]+1)
          if amount > 0 then
            police_items[idname] = amount
            todo = todo+1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname,amount in pairs(police_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id,idname,amount,true}) then
                  local reward = v.items[idname][3]*amount
                  vRP.giveMoney({user_id,reward})
                  vRPclient.notify(player,{glang.money.received({reward})})
                  todo = todo-1
                  police_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1,#v.positions)]
        }

        -- mission display
        for idname,amount in pairs(police_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text..lang.police.item({name,amount}).."<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player,mdata})
        end
      end
    end
  end  

      -- EMS
  for k,v in pairs(cfg.ems) do -- each repair perm def
    -- add missions to users
    local users = vRP.getUsersByPermission({k})
    for l,w in pairs(users) do
      local user_id = w
      local player = vRP.getUserSource({user_id})
      if not vRP.hasMission({player}) then
        -- build mission
        local mdata = {}
        mdata.name = lang.ems.title()

        -- generate items
        local todo = 0
        local ems_items = {}
        for idname,data in pairs(v.items) do
          local amount = math.random(data[1],data[2]+1)
          if amount > 0 then
            ems_items[idname] = amount
            todo = todo+1
          end
        end

        local step = {
          text = "",
          onenter = function(player, area)
            for idname,amount in pairs(ems_items) do
              if amount > 0 then -- check if not done
                if vRP.tryGetInventoryItem({user_id,idname,amount,true}) then
                  local reward = v.items[idname][3]*amount
                  vRP.giveMoney({user_id,reward})
                  vRPclient.notify(player,{glang.money.received({reward})})
                  todo = todo-1
                  ems_items[idname] = 0
                  if todo == 0 then -- all received, finish mission
                    vRP.nextMissionStep({player})
                  end
                end
              end
            end
          end,
          position = v.positions[math.random(1,#v.positions)]
        }

        -- mission display
        for idname,amount in pairs(ems_items) do
          local name = vRP.getItemName({idname})
          step.text = step.text..lang.ems.item({name,amount}).."<br />"
        end

        mdata.steps = {step}

        if todo > 0 then
          vRP.startMission({player,mdata})
        end
      end
    end
  end]] SetTimeout(
    60000,
    task_mission
  )
end
task_mission()
