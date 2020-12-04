local cfg = module("cfg/player_state")
local lang = vRP.lang

-- client -> server events
AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    Debug.pbegin("playerSpawned_player_state")
    local player = source
    local data = vRP.getUserDataTable(user_id)
    local tmpdata = vRP.getUserTmpTable(user_id)
    if not data then
      return
    end

    SetTimeout(
      15000,
      function()
        if data.smaskitem_idle then
          vRPclient.setSpecialMaskOn(source, {{id = data.smaskitem_idle}})
        end
      end
    )

    if first_spawn then -- first spawn
      -- cascade load customization then weapons
      if data.customization == nil then
        data.customization = cfg.default_customization
      end

      if data.position == nil and cfg.spawn_enabled then
        local x = cfg.spawn_position[1] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
        local y = cfg.spawn_position[2] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
        local z = cfg.spawn_position[3] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
        data.position = {x = x, y = y, z = z}
      end

      if data.position ~= nil then -- teleport to saved pos
        vRPclient.teleport(source, {data.position.x, data.position.y, data.position.z})
      end

      if data.customization ~= nil then
        vRPclient.setCustomization(
          source,
          {data.customization},
          function()
            -- delayed weapons/health, because model respawn
            if data.weapons ~= nil then -- load saved weapons
              vRPclient.giveWeapons(source, {data.weapons, true})

              if data.health ~= nil then -- set health
                vRPclient.setHealth(source, {data.health})
                SetTimeout(
                  5000,
                  function()
                    -- check coma, kill if in coma
                    vRPclient.isInComa(
                      player,
                      {},
                      function(in_coma)
                        vRPclient.killComa(player, {})
                      end
                    )
                  end
                )
              end
            end
          end
        )
      else
        if data.weapons ~= nil then -- load saved weapons
          vRPclient.giveWeapons(source, {data.weapons, true})
        end

        if data.health ~= nil then
          vRPclient.setHealth(source, {data.health})
        end
      end

      -- notify last login
      SetTimeout(
        15000,
        function()
          if tmpdata then
            vRPclient.notify(player, {lang.common.welcome({tmpdata.last_login})})
          end
        end
      )
    else -- not first spawn (player died), don't load weapons, empty wallet, empty inventory
      vRP.setHunger(user_id, 0)
      vRP.setThirst(user_id, 0)

      if cfg.clear_phone_directory_on_death then
        data.phone_directory = {} -- clear phone directory after death
      end

      if cfg.lose_aptitudes_on_death then
        data.gaptitudes = {} -- clear aptitudes after death
      end

      local diedPriceRemain = cfg.new_life_cost
      local gm = vRP.getMoney(user_id)
      local gbm = vRP.getBankMoney(user_id)

      if diedPriceRemain > 0 then
        local resultAmount = gm - diedPriceRemain
        if resultAmount >= 0 then
          diedPriceRemain = 0
          vRP.setMoney(user_id, resultAmount)
        else
          diedPriceRemain = math.abs(resultAmount)
          vRP.setMoney(user_id, 0)
        end
      end

      if diedPriceRemain > 0 then
        local resultAmount = gbm - diedPriceRemain
        if resultAmount >= 0 then
          diedPriceRemain = 0
          vRP.setBankMoney(user_id, resultAmount)
        else
          diedPriceRemain = math.abs(resultAmount)
          vRP.setBankMoney(user_id, 0)
        end
      end

      -- disable handcuff
      vRPclient.setHandcuffed(player, {false})

      if cfg.spawn_enabled then -- respawn (CREATED SPAWN_DEATH)
        local spawn_pos = cfg.spawn_death
        vRPclient.isJailed(
          player,
          {},
          function(jailed)
            if jailed then
              spawn_pos = cfg.spawn_death_jailed
            end
            local x = spawn_pos[1] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            local y = spawn_pos[2] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            local z = spawn_pos[3] + math.random() * cfg.spawn_radius * 2 - cfg.spawn_radius
            data.position = {x = x, y = y, z = z}
            vRPclient.teleport(source, {x, y, z})
          end
        )
      end

      -- load character customization
      SetTimeout(
        1000,
        function()
          if data.customization == nil then
            data.customization = cfg.default_customization
          end
          vRPclient.setCustomization(source, {data.customization})
        end
      )
    end
    Debug.pend()
  end
)

-- updates

function tvRP.updatePlayerState(x, y, z, weapons, customization, health)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    local tmp = vRP.getUserTmpTable(user_id)
    if data ~= nil and (tmp == nil or tmp.home_stype == nil) then -- don't save position if inside home slot
      data.position = {x = tonumber(x), y = tonumber(y), z = tonumber(z)}
    end
    if data ~= nil then
      data.weapons = weapons
    end
    if data ~= nil then
      data.customization = customization
    end
    if data ~= nil then
      data.health = health
    end
  end
end

function tvRP.updatePos(x, y, z)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    local tmp = vRP.getUserTmpTable(user_id)
    if data ~= nil and (tmp == nil or tmp.home_stype == nil) then -- don't save position if inside home slot
      data.position = {x = tonumber(x), y = tonumber(y), z = tonumber(z)}
    end
  end
end

function tvRP.updateWeapons(weapons)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
      data.weapons = weapons
    end
  end
end

function tvRP.updateCustomization(customization)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
      data.customization = customization
    end
  end
end

function tvRP.updateHealth(health)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data ~= nil then
      data.health = health
    end
  end
end
