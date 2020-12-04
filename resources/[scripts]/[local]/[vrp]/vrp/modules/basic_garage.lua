-- a basic garage implementation

MySQL.createCommand("vRP/add_vehicle", "INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle) VALUES(@user_id,@vehicle)")
MySQL.createCommand("vRP/remove_vehicle", "DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/get_vehicles", "SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_vehicle", "SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/sell_vehicle_player", "UPDATE vrp_user_vehicles SET user_id = @user_id WHERE user_id = @oldUser AND vehicle = @vehicle")

-- load config

local cfg = module("cfg/garages")
local cfg_inventory = module("cfg/inventory")
local vehicle_groups = cfg.garage_types

local lang = vRP.lang
local garages = cfg.garages

local limitedcfg = module("cfg/limitedgarage")
local limited_vehicle_groups = limitedcfg.garage_types
local limited_garages = limitedcfg.garages

-- 일반 차고 메뉴

local garage_menus = {}

for group, vehicles in pairs(vehicle_groups) do
  local veh_type = vehicles._config.vtype or "default"

  local menu = {
    name = lang.garage.title({group}),
    css = {top = "75px", header_color = "rgba(255,125,0,0.75)"}
  }
  garage_menus[group] = menu

  menu["*소유중인 차량"] = {
    function(player, choice)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        -- init tmpdata for rents
        local tmpdata = vRP.getUserTmpTable(user_id)
        if tmpdata.rent_vehicles == nil then
          tmpdata.rent_vehicles = {}
        end

        -- build nested menu
        local kitems = {}
        local submenu = {
          name = lang.garage.title({"소유중인 차량"}),
          css = {top = "75px", header_color = "rgba(255,125,0,0.75)"}
        }
        submenu.onclose = function()
          vRP.openMenu(player, menu)
        end

        local choose = function(player, choice)
          local vname = kitems[choice]
          if vname then
            -- spawn vehicle
            local user_id = vRP.getUserId(source)
            if user_id ~= nil then
              --if vRP.CheckInventoryItem(user_id,'driver',1,"운전면허증") then
              if true then
                local vehicle = vehicles[vname]
                if vehicle then
                  if vRP.getLicenseStatus(user_id) == 0 then
                    vRP.closeMenu(player)
                    vRPclient.spawnGarageVehicle(player, {veh_type, vname})
                  else
                    vRPclient.notify(player, {"~r~운전면허가 정지되어있어 소환할 수 없습니다, 경찰서에 문의하세요!"})
                  end
                end
              end
            end
          end
        end

        -- get player owned vehicles
        MySQL.query(
          "vRP/get_vehicles",
          {user_id = user_id},
          function(pvehicles, affected)
            if pvehicles then
              -- add rents to whitelist
              for k, v in pairs(tmpdata.rent_vehicles) do
                if v then -- check true, prevent future neolua issues
                  table.insert(pvehicles, {vehicle = k})
                end
              end

              for k, v in pairs(pvehicles) do
                local vehicle = vehicles[v.vehicle]
                if vehicle then
                  local tax = math.ceil(vehicle[2] / 100 * 8)
                  submenu[vehicle[1]] = {choose, lang.garage.buy.info({"💵 구매한 가격: " .. format_num(vehicle[2]) .. "<br>💸 소비세 포함: " .. format_num(vehicle[2] + tax), vehicle[3] .. "<br><img src='nui://assets/garages/small/" .. v.vehicle .. ".jpg'>"})}
                  kitems[vehicle[1]] = v.vehicle
                end
              end

              vRP.openMenu(player, submenu)
            end
          end
        )
      end
    end,
    lang.garage.owned.description()
  }
  if vehicles._config.disableBuy ~= true then
    menu["*차량 구매"] = {
      function(player, choice)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          -- build nested menu
          local kitems = {}
          local submenu = {
            name = lang.garage.title({"차량 구매"}),
            css = {top = "75px", header_color = "rgba(255,0,0,1.0)"}
          }
          submenu.onclose = function()
            vRP.openMenu(player, menu)
          end

          local choose = function(player, choice)
            local vname = kitems[choice]
            if vname then
              -- buy vehicle
              local vehicle = vehicles[vname]
              local tax = math.ceil(vehicle[2] / 100 * 8)
              local buyprice = math.ceil(vehicle[2] + tax)
              if vehicle and vRP.tryPayment(user_id, buyprice) then
                MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = vname})
                vRPclient.notify(player, {lang.money.paid({format_num(buyprice)})})
                vRPclient.notify(player, {"리얼월드 소비세 8% 포함"})
                MySQL.execute("vRP/add_tax", {statecoffers = tax})
                vRP.closeMenu(player)
              else
                vRPclient.notify(player, {lang.money.not_enough()})
              end
            end
          end
          MySQL.query(
            "vRP/get_vehicles",
            {user_id = user_id},
            function(_pvehicles, affected)
              local pvehicles = {}
              for k, v in pairs(_pvehicles) do
                pvehicles[string.lower(v.vehicle)] = true
              end

              -- for each existing vehicle in the garage group
              for k, v in pairs(vehicles) do
                if k ~= "_config" and pvehicles[string.lower(k)] == nil then -- not already owned
                  local tax = math.ceil(v[2] / 100 * 8)
                  submenu[v[1]] = {choose, lang.garage.buy.info({"💵 차량 가격: " .. format_num(v[2]) .. "<br>💸 소비세 포함: " .. format_num(v[2] + tax), v[3] .. "<img src='nui://assets/garages/small/" .. k .. ".jpg'>"})}
                  kitems[v[1]] = k
                end
              end

              vRP.openMenu(player, submenu)
            end
          )
        end
      end,
      lang.garage.buy.description()
    }
    menu["시승 하기"] = {
      function(player, choice)
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          -- init tmpdata for rents
          local kitems = {}
          local submenu = {
            name = lang.garage.title({"시승 하기"}),
            css = {top = "75px", header_color = "rgba(0,255,0,1.0)"}
          }
          submenu.onclose = function()
            vRP.openMenu(player, menu)
          end

          local rentRate = 0.005
          local rentTime = 2

          local choose = function(player, choice)
            local vname = kitems[choice]
            if vname then
              local vehicle = vehicles[vname]
              local rentPrice = math.ceil(vehicle[2] * rentRate)
              local tax = math.ceil(rentPrice / 100 * 8)
              local totalPrice = math.ceil(rentPrice + tax)
              if vehicle and vRP.tryPayment(user_id, totalPrice) then
                vRPclient.notify(player, {lang.money.paid({format_num(totalPrice)})})
                vRPclient.notify(player, {"리얼월드 소비세 8% 포함"})
                MySQL.execute("vRP/add_tax", {statecoffers = tax})
                vRP.closeMenu(player)
                vRPclient.spawnRentVehicle(player, {veh_type, vname, rentTime})
              else
                vRPclient.notify(player, {lang.money.not_enough()})
              end
            end
          end
          for k, v in pairs(vehicles) do
            if k ~= "_config" then
              local rentPrice = math.ceil(v[2] * rentRate)
              local tax = math.ceil(rentPrice / 100 * 8)
              local totalPrice = math.ceil(rentPrice + tax)
              submenu[v[1]] = {choose, lang.garage.buy.info({"💵 시승 요금: " .. format_num(totalPrice) .. "<br>⌚ 시승 시간: " .. rentTime .. "분", v[3] .. "<img src='nui://assets/garages/small/" .. k .. ".jpg'>"})}
              kitems[v[1]] = k
            end
          end
          vRP.openMenu(player, submenu)
        end
      end,
      "차량을 시승합니다."
    }
  end

  menu["주차 하기"] = {
    function(player, choice)
      vRPclient.despawnGarageVehicle(player, {veh_type, 15})
    end,
    lang.garage.store.description()
  }
end

local limited_garage_menus = {}

for group, vehicles in pairs(limited_vehicle_groups) do
  local veh_type = vehicles._config.vtype or "default"

  local menu = {
    --name=lang.garage.title({group}),
    name = "특별 차고",
    css = {top = "75px", header_color = "rgba(255,0,0,0.75)"}
  }
  limited_garage_menus[group] = menu

  menu["*소유중인 차량"] = {
    function(player, choice)
      local user_id = vRP.getUserId(player)
      if user_id ~= nil then
        -- init tmpdata for rents
        local tmpdata = vRP.getUserTmpTable(user_id)
        if tmpdata.rent_vehicles == nil then
          tmpdata.rent_vehicles = {}
        end

        -- build nested menu
        local kitems = {}
        local submenu = {
          name = lang.garage.title({"소유중인 차량"}),
          css = {top = "75px", header_color = "rgba(255,125,0,0.75)"}
        }
        submenu.onclose = function()
          vRP.openMenu(player, menu)
        end

        local choose = function(player, choice)
          local vname = kitems[choice]
          if vname then
            -- spawn vehicle
            local user_id = vRP.getUserId(source)
            if user_id ~= nil then
              --if vRP.CheckInventoryItem(user_id,'driver',1,"운전면허증") then
              if true then
                local vehicle = vehicles[vname]
                if vehicle then
                  if vRP.getLicenseStatus(user_id) == 0 then
                    vRP.closeMenu(player)
                    vRPclient.spawnGarageVehicle(player, {veh_type, vname})
                  else
                    vRPclient.notify(player, {"~r~운전면허가 정지되어있어 소환할 수 없습니다, 경찰서에 문의하세요!"})
                  end
                end
              end
            end
          end
        end

        -- get player owned vehicles
        MySQL.query(
          "vRP/get_vehicles",
          {user_id = user_id},
          function(pvehicles, affected)
            -- add rents to whitelist
            for k, v in pairs(tmpdata.rent_vehicles) do
              if v then -- check true, prevent future neolua issues
                table.insert(pvehicles, {vehicle = k})
              end
            end

            for k, v in pairs(pvehicles) do
              local vehicle = vehicles[v.vehicle]
              if vehicle then
                local tax = math.ceil(vehicle[2] / 100 * 8)
                submenu[vehicle[1]] = {choose, lang.garage.buy.info({"💵 구매한 가격: " .. format_num(vehicle[2]) .. "<br>💸 소비세 포함: " .. format_num(vehicle[2] + tax), vehicle[3] .. "<br><img src='nui://assets/garages/small/" .. v.vehicle .. ".jpg'>"})}
                kitems[vehicle[1]] = v.vehicle
              end
            end

            vRP.openMenu(player, submenu)
          end
        )
      end
    end,
    lang.garage.owned.description()
  }

  menu["주차 하기"] = {
    function(player, choice)
      vRPclient.despawnGarageVehicle(player, {veh_type, 15})
    end,
    lang.garage.store.description()
  }
end

local function build_client_garages(source)
  local _source = source
  local user_id = vRP.getUserId(_source)
  if user_id ~= nil then
    Citizen.CreateThread(
      function()
        for k, v in pairs(garages) do
          local gtype, x, y, z, text, hideBlip = table.unpack(v)

          local group = vehicle_groups[gtype]
          if group then
            local gcfg = group._config

            -- enter
            local garage_enter = function(player, area)
              local user_id = vRP.getUserId(_source)
              if user_id ~= nil and vRP.hasPermissions(user_id, gcfg.permissions or {}) then
                local menu = garage_menus[gtype]
                if menu then
                  vRP.openMenu(player, menu)
                end
              end
            end

            -- leave
            local garage_leave = function(player, area)
              vRP.closeMenu(player, true)
            end

            if not hideBlip then
              vRPclient.addBlip(_source, {x, y, z, gcfg.blipid, gcfg.blipcolor, lang.garage.title({gtype})})
            end
            vRPclient.addMarker(_source, {x, y, z - 1, 2.5, 2.5, 0.2, 0, 255, 125, 125, 80, text})
            vRP.setArea(_source, "vRP:garage" .. k, x, y, z, 1.5, 1.5, garage_enter, garage_leave)
          end

          Citizen.Wait(0)
        end
      end
    )
  end
end

local function build_client_limited_garages(source)
  local _source = source
  local user_id = vRP.getUserId(_source)
  if user_id ~= nil then
    Citizen.CreateThread(
      function()
        for k, v in pairs(limited_garages) do
          local gtype, x, y, z, text = table.unpack(v)

          local group = limited_vehicle_groups[gtype]
          if group then
            local gcfg = group._config

            -- enter
            local limited_garage_enter = function(player, area)
              local user_id = vRP.getUserId(_source)
              if user_id ~= nil and vRP.hasPermissions(user_id, gcfg.permissions or {}) then
                local menu = limited_garage_menus[gtype]
                if menu then
                  vRP.openMenu(player, menu)
                end
              end
            end

            -- leave
            local limited_garage_leave = function(player, area)
              vRP.closeMenu(player)
            end

            vRPclient.addBlip(_source, {x, y, z, gcfg.blipid, gcfg.blipcolor, lang.garage.title({gtype})})
            vRPclient.addMarker(_source, {x, y, z - 1, 2.5, 2.5, 0.2, 255, 0, 0, 125, 80, text})
            vRP.setArea(_source, "vRP:limited_garages" .. k, x, y, z, 1.5, 1.5, limited_garage_enter, limited_garage_leave)

            Citizen.Wait(0)
          end
        end
      end
    )
  end
end

AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    if first_spawn then
      build_client_garages(source)
      build_client_limited_garages(source)
    end
  end
)

-- VEHICLE MENU

-- define vehicle actions
-- action => {cb(user_id,player,veh_group,veh_name),desc}
local veh_actions = {}

-- open trunk
veh_actions[lang.vehicle.trunk.title()] = {
  function(user_id, player, vtype, name)
    local chestname = "u" .. user_id .. "veh_" .. string.lower(name)
    local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

    -- open chest
    vRPclient.vc_openDoor(player, {vtype, 5})
    vRP.openChest(
      player,
      chestname,
      max_weight,
      function()
        vRPclient.vc_closeDoor(player, {vtype, 5})
      end
    )
  end,
  lang.vehicle.trunk.description()
}

-- detach trailer
veh_actions[lang.vehicle.detach_trailer.title()] = {
  function(user_id, player, vtype, name)
    vRPclient.vc_detachTrailer(player, {vtype})
  end,
  lang.vehicle.detach_trailer.description()
}

-- detach towtruck
veh_actions[lang.vehicle.detach_towtruck.title()] = {
  function(user_id, player, vtype, name)
    vRPclient.vc_detachTowTruck(player, {vtype})
  end,
  lang.vehicle.detach_towtruck.description()
}

-- detach cargobob
veh_actions[lang.vehicle.detach_cargobob.title()] = {
  function(user_id, player, vtype, name)
    vRPclient.vc_detachCargobob(player, {vtype})
  end,
  lang.vehicle.detach_cargobob.description()
}

-- lock/unlock
veh_actions[lang.vehicle.lock.title()] = {
  function(user_id, player, vtype, name)
    vRPclient.vc_toggleLock(player, {vtype})
  end,
  lang.vehicle.lock.description()
}

-- engine on/off
veh_actions[lang.vehicle.engine.title()] = {
  function(user_id, player, vtype, name)
    vRPclient.vc_toggleEngine(player, {vtype})
  end,
  lang.vehicle.engine.description()
}

--sell2

-- sell vehicle
veh_actions[lang.vehicle.sellTP.title()] = {
  function(playerID, player, vtype, name)
    if playerID ~= nil then
      vRPclient.getNearestPlayers(
        player,
        {15},
        function(nplayers)
          usrList = ""
          for k, v in pairs(nplayers) do
            usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
          end
          if usrList ~= "" then
            vRP.prompt(
              player,
              "근처 플레이어 : " .. usrList .. "",
              "",
              function(player, user_id)
                user_id = user_id
                if user_id ~= nil and user_id ~= "" then
                  local target = vRP.getUserSource(tonumber(user_id))
                  local my_id = vRP.getUserId(source)
                  local my_name = GetPlayerName(source)
                  if target ~= nil then
                    vRP.prompt(
                      player,
                      "판매할 가격 : ",
                      "",
                      function(player, amount)
                        if (tonumber(amount)) and (tonumber(amount) > 0) then
                          MySQL.query(
                            "vRP/get_vehicle",
                            {user_id = user_id, vehicle = name},
                            function(pvehicle, affected)
                              if #pvehicle > 0 then
                                vRPclient.notify(player, {"~r~상대방이 이미 이 차량을 가지고 있습니다!"})
                              else
                                local tmpdata = vRP.getUserTmpTable(playerID)
                                if tmpdata.rent_vehicles[name] == true then
                                  vRPclient.notify(player, {"~r~렌트 차량은 판매할 수 없습니다!"})
                                  return
                                else
                                  vRP.request(
                                    target,
                                    GetPlayerName(player) .. " 님께서 " .. name .. " 차량을 " .. amount .. "원에 판매하였습니다.",
                                    30,
                                    function(target, ok)
                                      if ok then
                                        local pID = vRP.getUserId(target)
                                        local money = vRP.getMoney(pID)
                                        if (tonumber(money) >= tonumber(amount)) then
                                          vRPclient.despawnGarageVehicle(player, {vtype, 15})
                                          vRP.getUserIdentity(
                                            pID,
                                            function(identity)
                                              MySQL.execute("vRP/sell_vehicle_player", {user_id = user_id, oldUser = playerID, vehicle = name})
                                            end
                                          )
                                          local tax = math.ceil(amount / 100 * 5)
                                          MySQL.execute("vRP/add_tax", {statecoffers = tax})
                                          vRP.giveMoney(playerID, amount - tax)
                                          vRP.setMoney(pID, money - amount)
                                          vRPclient.notify(
                                            player,
                                            {
                                              "~g~차량을 " .. GetPlayerName(target) .. "님에게 " .. format_num(amount) .. "원에 성공적으로 판매하였습니다!"
                                            }
                                          )
                                          if name == "radi" then
                                            names = "대우 다마스"
                                          elseif name == "accent" then
                                            names = "엑센트"
                                          elseif name == "kiagt" then
                                            names = "스팅어 GT"
                                          elseif name == "veln" then
                                            names = "현대 벨로스터 N 2018"
                                          elseif name == "premier" then
                                            names = "현대 아반떼"
                                          elseif name == "fugitive" then
                                            names = "현대 아제라(해외)"
                                          elseif name == "felon" then
                                            names = "현대 제네시스 G380"
                                          elseif name == "genesis" then
                                            names = "현대 제네시스 쿠페"
                                          elseif name == "santafe" then
                                            names = "현대 싼타페"
                                          elseif name == "hkona" then
                                            names = "현대 코나 2018"
                                          elseif name == "sonata" then
                                            names = "현대 쏘나타 2018"
                                          elseif name == "jackal" then
                                            names = "기아 K5 SX"
                                          elseif name == "koup" then
                                            names = "기아 포르테"
                                          elseif name == "kiamansory" then
                                            names = "기아 스팅어 만소리튠"
                                          elseif name == "baller2" then
                                            names = "기아 스포티지 2017"
                                          elseif name == "equus" then
                                            names = "현대 에쿠스 리무진"
                                          elseif name == "carnival" then
                                            names = "기아 카니발 하이리무진"
                                          elseif name == "tuscani" then
                                            names = "현대 투스카니"
                                          elseif name == "sibal" then
                                            names = "시발차"
                                          elseif name == "lc500" then
                                            names = "렉서스 LC500 2018"
                                          elseif name == "rx450h" then
                                            names = "렉서스 RX450H 2016"
                                          elseif name == "f620" then
                                            names = "렉서스 RC350"
                                          elseif name == "RC350" then
                                            names = "렉서스 RC350 튜닝"
                                          elseif name == "rcf" then
                                            names = "렉서스 RC F"
                                          elseif name == "gt86rb" then
                                            names = "도요타86 GTO"
                                          elseif name == "ae86" then
                                            names = "도요타 AE86"
                                          elseif name == "camry55" then
                                            names = "도요타 캠리 구형"
                                          elseif name == "cam8tun" then
                                            names = "도요타 캠리 튜닝"
                                          elseif name == "prius" then
                                            names = "도요타 프리우스"
                                          elseif name == "supra2" then
                                            names = "도요타 수프라"
                                          elseif name == "17m760i" then
                                            names = "BMW M760i 2017"
                                          elseif name == "e46" then
                                            names = "BMW M3 E46 2005"
                                          elseif name == "z4" then
                                            names = "BMW Z4 컨버터블"
                                          elseif name == "19Z4" then
                                            names = "BMW Z4 2019"
                                          elseif name == "z4alchemist" then
                                            names = "BMW Z4 Alchemist"
                                          elseif name == "bmci" then
                                            names = "BMW M5"
                                          elseif name == "m5f90" then
                                            names = "BMW M5 신형"
                                          elseif name == "m850" then
                                            names = "BMW M850i"
                                          elseif name == "m8gte" then
                                            names = "BMW M8 GTE"
                                          elseif name == "bmwx7" then
                                            names = "BMW x7"
                                          elseif name == "m2" then
                                            names = "BMW M2 2016"
                                          elseif name == "e34touring" then
                                            names = "BMW E34 M5 투어링 1995"
                                          elseif name == "m3e46" then
                                            names = "BMW M3 E46 GTR"
                                          elseif name == "m4" then
                                            names = "BMW M4 2018"
                                          elseif name == "f82" then
                                            names = "BMW M4 F82"
                                          elseif name == "rmodm4gts" then
                                            names = "BMW M4 GTS 리버티워크"
                                          elseif name == "rmodm4" then
                                            names = "BMW M4 레이진바디킷"
                                          elseif name == "m6f13" then
                                            names = "BMW M6 그란쿠페"
                                          elseif name == "i8" then
                                            names = "BMW i8"
                                          elseif name == "rmodmi8" then
                                            names = "BMW i8 로드스터"
                                          elseif name == "mi8" then
                                            names = "BMW i8 MANSAUG"
                                          elseif name == "x5m" then
                                            names = "BMW X5M"
                                          elseif name == "x6m" then
                                            names = "BMW X6M F16"
                                          elseif name == "m5f90" then
                                            names = "BMW M5 F90 리버티워크"
                                          elseif name == "cooperworks" then
                                            names = "미니쿠퍼 JCW"
                                          elseif name == "cls2015" then
                                            names = "벤츠 CLS63 AMG"
                                          elseif name == "g63" then
                                            names = "벤츠 G63 AMG"
                                          elseif name == "g65amg" then
                                            names = "벤츠 G65 AMG"
                                          elseif name == "gclas9" then
                                            names = "벤츠 G클래스 2019"
                                          elseif name == "amggtr" then
                                            names = "벤츠 AMG GTR 2018"
                                          elseif name == "gt63s" then
                                            names = "벤츠 AMG GT63S"
                                          elseif name == "amggtsmansory" then
                                            names = "벤츠 AMG GTR 만소리"
                                          elseif name == "slsamg" then
                                            names = "벤츠 SLS AMG"
                                          elseif name == "s6brabus" then
                                            names = "벤츠 브라부스 S6"
                                          elseif name == "b63s" then
                                            names = "벤츠 B63s 브라부스"
                                          elseif name == "c63w205" then
                                            names = "벤츠 C63 AMG S 2017"
                                          elseif name == "c63coupe" then
                                            names = "벤츠 C63 AMG S 쿠페"
                                          elseif name == "schafter3" then
                                            names = "벤츠 마이바흐 S650 2018"
                                          elseif name == "s500w222" then
                                            names = "벤츠 S500 W222"
                                          elseif name == "s600w220" then
                                            names = "벤츠 S600 W220"
                                          elseif name == "benson3" then
                                            names = "벤츠 스프린터"
                                          elseif name == "gl63" then
                                            names = "벤츠 GL63 AMG"
                                          elseif name == "gle" then
                                            names = "벤츠 AMG GLE"
                                          elseif name == "mers63c" then
                                            names = "벤츠 S63 AMG 카브리올레"
                                          elseif name == "c63a" then
                                            names = "벤츠 AMG C63"
                                          elseif name == "macla" then
                                            names = "벤츠 A 클래스 2019"
                                          elseif name == "ae350" then
                                            names = "벤츠 E350 블루텍"
                                          elseif name == "mb250" then
                                            names = "벤츠 V250 2019"
                                          elseif name == "gle63s" then
                                            names = "벤츠 GLE63s AMG 2016"
                                          elseif name == "amggtsprior" then
                                            names = "벤츠 AMG GT S 프리어 에디션"
                                          elseif name == "r820" then
                                            names = "아우디 R8 2020"
                                          elseif name == "arv10" then
                                            names = "아우디 R8 2018"
                                          elseif name == "r8ppi" then
                                            names = "아우디 R8 PPI 2015"
                                          elseif name == "r8lms" then
                                            names = "아우디 R8 LMS"
                                          elseif name == "rs6" then
                                            names = "아우디 RS6"
                                          elseif name == "sentinel" then
                                            names = "아우디 S5"
                                          elseif name == "tts" then
                                            names = "아우디 TTS 2015"
                                          elseif name == "aaq4" then
                                            names = "아우디 A4 콰트로 ABT 2017"
                                          elseif name == "rs7" then
                                            names = "아우디 RS7"
                                          elseif name == "a8l" then
                                            names = "아우디 S8"
                                          elseif name == "sq72016" then
                                            names = "아우디 SQ7 2016"
                                          elseif name == "rs52018" then
                                            names = "아우디 RS5 2018"
                                          elseif name == "a6tfsi" then
                                            names = "아우디 A6 55 TFSI 콰트로 S 라인 2019"
                                          elseif name == "audiq8" then
                                            names = "아우디 Q8 2019"
                                          elseif name == "AUDsq517" then
                                            names = "아우디 SQ5 2017"
                                          elseif name == "rs318" then
                                            names = "아우디 RS3 스포츠 백 2018"
                                          elseif name == "golfp" then
                                            names = "폭스바겐 골프 R Mk7"
                                          elseif name == "17bcs" then
                                            names = "벤틀리 콘티넨탈 GT 슈퍼스포츠"
                                          elseif name == "bnteam" then
                                            names = "벤틀리 콘티넨탈 GT 인디오더"
                                          elseif name == "bcgt" then
                                            names = "벤틀리 콘티넨탈 GT 컨버터블 2014"
                                          elseif name == "bentaygast" then
                                            names = "벤틀리 벤테이가 테크 2017"
                                          elseif name == "brooklands" then
                                            names = "벤틀리 브룩 2008"
                                          elseif name == "bbentayga" then
                                            names = "벤틀리 벤테이가"
                                          elseif name == "bexp" then
                                            names = "벤틀리 EXP"
                                          elseif name == "bmm" then
                                            names = "벤틀리 뮬산 뮬리너"
                                          elseif name == "720s" then
                                            names = "맥라렌 720s"
                                          elseif name == "mv720" then
                                            names = "맥라렌 720s 볼스테이너 2018"
                                          elseif name == "675lt" then
                                            names = "맥라렌 675LT 쿠페 2016"
                                          elseif name == "570s2" then
                                            names = "맥라렌 570S 2015"
                                          elseif name == "p1" then
                                            names = "맥라렌 P1"
                                          elseif name == "p1gtr" then
                                            names = "맥라렌 P1 GTR"
                                          elseif name == "mp412c" then
                                            names = "맥라렌 MP4-12C"
                                          elseif name == "senna" then
                                            names = "맥라렌 세나 2019"
                                          elseif name == "600lt" then
                                            names = "맥라렌 600LT"
                                          elseif name == "911turbos" then
                                            names = "포르쉐 911 터보 S"
                                          elseif name == "911tbs" then
                                            names = "포르쉐 911 터보 S 쿠페"
                                          elseif name == "pcs18" then
                                            names = "포르쉐 카이엔 S 2018"
                                          elseif name == "cayenne" then
                                            names = "포르쉐 카이엔 S 터보"
                                          elseif name == "718caymans" then
                                            names = "포르쉐 718 카이맨 S"
                                          elseif name == "718boxster" then
                                            names = "포르쉐 718 박스터 S"
                                          elseif name == "panamera17turbo" then
                                            names = "포르쉐 파나 메라 터보 2017"
                                          elseif name == "918" then
                                            names = "포르쉐 918 스파이더 2015"
                                          elseif name == "p901" then
                                            names = "포르쉐 911 (964) Targa & Cabrio 1965"
                                          elseif name == "cayman16" then
                                            names = "포르쉐 카이맨GT4 2016"
                                          elseif name == "por911gt3" then
                                            names = "포르쉐 911 GT3"
                                          elseif name == "GT2RS" then
                                            names = "포르쉐 911 GT2 RS"
                                          elseif name == "993rwb" then
                                            names = "포르쉐 993 RWB"
                                          elseif name == "911r" then
                                            names = "포르쉐 911R"
                                          elseif name == "cgt" then
                                            names = "포르쉐 카레라 GT 2006"
                                          elseif name == "pm19" then
                                            names = "포르쉐 마칸 터보"
                                          elseif name == "str20" then
                                            names = "포르쉐 911 스피드스터"
                                          elseif name == "pgt3" then
                                            names = "포르쉐 911 GT3 RS"
                                          elseif name == "fct" then
                                            names = "페라리 캘리포니아 T 2015"
                                          elseif name == "f40" then
                                            names = "페라리 F40"
                                          elseif name == "f430s" then
                                            names = "페라리 F430 스쿠데리아"
                                          elseif name == "ferporto" then
                                            names = "페라리 포르토피노 2018"
                                          elseif name == "fer612" then
                                            names = "페라리 612 스카글레이터 2004"
                                          elseif name == "yFe458i1" then
                                            names = "페라리 458 이탈리아"
                                          elseif name == "yFe458s1" then
                                            names = "페라리 458 스파이더"
                                          elseif name == "lw458s" then
                                            names = "페라리 458 스파이더 리버티워크"
                                          elseif name == "4881" then
                                            names = "페라리 488 GTB"
                                          elseif name == "f8t" then
                                            names = "페라리 F8 트리뷰토"
                                          elseif name == "gtc4" then
                                            names = "페라리 GTC4"
                                          elseif name == "yFe458i2" then
                                            names = "페라리 458 스페치알레"
                                          elseif name == "yFe458s2" then
                                            names = "페라리 458 스페치알레 A"
                                          elseif name == "pista" then
                                            names = "페라리 488 피스타"
                                          elseif name == "pistas" then
                                            names = "페라리 488 피스타 스파이더"
                                          elseif name == "fm488" then
                                            names = "페라리 488 만소리 시라쿠사"
                                          elseif name == "berlinetta" then
                                            names = "페라리 F12 베를리네타"
                                          elseif name == "gtoxx" then
                                            names = "페라리 599 GTO"
                                          elseif name == "ferrari812" then
                                            names = "페라리 812 슈퍼패스트"
                                          elseif name == "f12m" then
                                            names = "페라리 F12 만소리"
                                          elseif name == "aperta" then
                                            names = "페라리 라페라리 아페르타"
                                          elseif name == "enzo" then
                                            names = "페라리 엔초"
                                          elseif name == "scuderiag" then
                                            names = "페라리 스쿠데리아 글리켄하어스"
                                          elseif name == "f60" then
                                            names = "페라리 F60 아메리카"
                                          elseif name == "nlargo" then
                                            names = "페라리 F12 N-Largo"
                                          elseif name == "sergio" then
                                            names = "페라리 세르지오"
                                          elseif name == "lp770" then
                                            names = "람보르기니 센테나리오"
                                          elseif name == "cyclone" then
                                            names = "람보르기니 센테나리오 로드스터"
                                          elseif name == "lp700r" then
                                            names = "람보르기니 아벤타도르"
                                          elseif name == "lp670" then
                                            names = "람보르기니 무르시엘라고 슈퍼벨로체"
                                          elseif name == "aventadors" then
                                            names = "람보르기니 아벤타도르S"
                                          elseif name == "rmodlp750" then
                                            names = "람보르기니 아벤타도르 슈퍼벨로체"
                                          elseif name == "lb750sv" then
                                            names = "람보르기니 아벤타도르 슈퍼벨로체"
                                          elseif name == "lamboavj" then
                                            names = "람보르기니 아벤타도르SVJ"
                                          elseif name == "lp610" then
                                            names = "람보르기니 우라칸 스파이더"
                                          elseif name == "500gtrlam" then
                                            names = "람보르기니 디아블로 GTR"
                                          elseif name == "610lb" then
                                            names = "람보르기니 우라칸"
                                          elseif name == "huraperfospy" then
                                            names = "람보르기니 우라칸 스파이더 퍼포만테"
                                          elseif name == "lbperfs" then
                                            names = "람보르기니 우라칸 스파이더 퍼포만테 리버티워크"
                                          elseif name == "rmodlp570" then
                                            names = "람보르기니 가야르도"
                                          elseif name == "gallardosuperlb" then
                                            names = "람보르기니 가야르도 슈퍼벨로체"
                                          elseif name == "urus2018" then
                                            names = "람보르기니 우루스 2018"
                                          elseif name == "lambose" then
                                            names = "람보르기니 세스토엘레멘토"
                                          elseif name == "huracanst" then
                                            names = "람보르기니 우라칸ST"
                                          elseif name == "sc18" then
                                            names = "람보르기니 SC18 알스톤"
                                          elseif name == "p7" then
                                            names = "재규어 프로젝트7"
                                          elseif name == "xkgt" then
                                            names = "재규어 XKR-S GT 2015"
                                          elseif name == "ipace" then
                                            names = "재규어 I-페이스 2016"
                                          elseif name == "fpacehm" then
                                            names = "재규어 F-페이스 하만"
                                          elseif name == "mbh" then
                                            names = "마이바흐 62S 제플린"
                                          elseif name == "twizy" then
                                            names = "르노 트위즈"
                                          elseif name == "tmax" then
                                            names = "T Express"
                                          elseif name == "gtx" then
                                            names = "플리머스 GTX 1971"
                                          elseif name == "nanoflo" then
                                            names = "NanoFlowcell Quantino"
                                          elseif name == "shotaro" then
                                            names = "나가사키 쇼타로"
                                          elseif name == "firebird" then
                                            names = "폰티악 파이어 버드 1970"
                                          elseif name == "saleens7" then
                                            names = "살룬 S7 2002"
                                          elseif name == "slingshot" then
                                            names = "폴라리스 슬링샷 2015"
                                          elseif name == "can" then
                                            names = "캔암 메버릭"
                                          elseif name == "focusrs" then
                                            names = "포드 포커스 RS"
                                          elseif name == "mst" then
                                            names = "포드 머스탱GT NFS 2013"
                                          elseif name == "20f250" then
                                            names = "포드 F-250 슈퍼듀티 2020"
                                          elseif name == "18f250" then
                                            names = "포드 F-250 XLT 슈퍼 2018"
                                          elseif name == "mgt" then
                                            names = "포드 머스탱 GT"
                                          elseif name == "gt17" then
                                            names = "포드 GT 2017"
                                          elseif name == "demon" then
                                            names = "닷지 챌린저 SRT 악마 2018"
                                          elseif name == "durango" then
                                            names = "닷지 두랑고 SRT 2018"
                                          elseif name == "cats" then
                                            names = "캐딜락 ATS-V 쿠페 2016"
                                          elseif name == "ct6" then
                                            names = "캐딜락 CT6"
                                          elseif name == "srt8" then
                                            names = "지프 SRT8"
                                          elseif name == "demonhawk" then
                                            names = "지프 악마호크"
                                          elseif name == "gmcyd" then
                                            names = "GMC 유콘 데날리 2015"
                                          elseif name == "ap2" then
                                            names = "혼다 S2000 로드스터"
                                          elseif name == "crz" then
                                            names = "혼다 CRZ"
                                          elseif name == "fk8" then
                                            names = "혼다 시빅R"
                                          elseif name == "goldwing" then
                                            names = "혼다 GL1800 골드윙 2018"
                                          elseif name == "nemesis" then
                                            names = "혼다 웨이브 125i 2010"
                                          elseif name == "na1" then
                                            names = "혼다 NSX-R (NA1) 1992"
                                          elseif name == "nc1" then
                                            names = "혼다 미드쉽"
                                          elseif name == "ody18" then
                                            names = "혼다 오딧세이"
                                          elseif name == "Wraith" then
                                            names = "롤스로이스 레이스"
                                          elseif name == "cullinan" then
                                            names = "롤스로이스 컬리넌 2019"
                                          elseif name == "rrphantom" then
                                            names = "롤스로이스 팬텀"
                                          elseif name == "rdawn" then
                                            names = "롤스로이스 던 만소리"
                                          elseif name == "p90d" then
                                            names = "테슬라 모델 X"
                                          elseif name == "models" then
                                            names = "테슬라 모델 S"
                                          elseif name == "teslapd" then
                                            names = "테슬라 모델X"
                                          elseif name == "tr22" then
                                            names = "테슬라 로드스터 2020"
                                          elseif name == "malibu" then
                                            names = "쉐보레 말리부 2018"
                                          elseif name == "exor" then
                                            names = "쉐보레 카마로 ZL1 2017"
                                          elseif name == "c7" then
                                            names = "쉐보레 콜벳 C7 2014"
                                          elseif name == "c8" then
                                            names = "쉐보레 콜벳 C8 스팅레이 2020"
                                          elseif name == "2020ss" then
                                            names = "쉐보레 카마로SS"
                                          elseif name == "c7r" then
                                            names = "쉐보레 콜벳 C7R"
                                          elseif name == "ghis2" then
                                            names = "마세라티 기블리"
                                          elseif name == "mqgts" then
                                            names = "마세라티 콰트로포르테"
                                          elseif name == "granlb" then
                                            names = "마세라티 그란투리스모 MC 튜닝"
                                          elseif name == "mlmansory" then
                                            names = "마세라티 르반떼"
                                          elseif name == "vantage" then
                                            names = "애스턴마틴 밴티지 2019"
                                          elseif name == "db11" then
                                            names = "애스턴마틴 DB11"
                                          elseif name == "cyrus" then
                                            names = "애스턴마틴 DB11 키루스"
                                          elseif name == "ast" then
                                            names = "애스턴마틴 뱅퀴시"
                                          elseif name == "one77" then
                                            names = "애스턴마틴 One-77"
                                          elseif name == "180sx" then
                                            names = "닛산 180sx"
                                          elseif name == "d1r34" then
                                            names = "닛산 R34"
                                          elseif name == "gtr" then
                                            names = "닛산 GTR 2017"
                                          elseif name == "nissantitan17" then
                                            names = "닛산 타이탄 픽업트럭"
                                          elseif name == "elegy2" then
                                            names = "닛산 스카이라인"
                                          elseif name == "tule" then
                                            names = "닛산 알마다"
                                          elseif name == "gt86rb" then
                                            names = "도요타86 GTO"
                                          elseif name == "vv60" then
                                            names = "볼보 V60 2019"
                                          elseif name == "xc90r" then
                                            names = "볼보 XC90 R 2018"
                                          elseif name == "18Velar" then
                                            names = "레인지로버 벨라 2017"
                                          elseif name == "rr12" then
                                            names = "레인지로버 2010"
                                          elseif name == "rrstart" then
                                            names = "레인지로버 보그 테크 L405"
                                          elseif name == "svr16" then
                                            names = "레인지로버 스포츠 SVR"
                                          elseif name == "exor" then
                                            names = "헤네시 카마로 엑소시스트 ZL1"
                                          elseif name == "velociraptor" then
                                            names = "헤네시 F-150 벨로시랩터"
                                          elseif name == "xnsgt" then
                                            names = "헤네시 베놈 GT"
                                          elseif name == "f4rr" then
                                            names = "아구스타 F4 RR"
                                          elseif name == "snowbike" then
                                            names = "스노우 바이크"
                                          elseif name == "akuma" then
                                            names = "아쿠마"
                                          elseif name == "bagger" then
                                            names = "베이거"
                                          elseif name == "bati" then
                                            names = "바티 801"
                                          elseif name == "bati2" then
                                            names = "바티 801RR"
                                          elseif name == "bf400" then
                                            names = "BF400"
                                          elseif name == "lectro" then
                                            names = "BMW R75 바버"
                                          elseif name == "carbonrs" then
                                            names = "카본 RS"
                                          elseif name == "cliffhanger" then
                                            names = "클리프행거"
                                          elseif name == "f131" then
                                            names = "컨페더레이트 F131 헬켓"
                                          elseif name == "double" then
                                            names = "더블 T"
                                          elseif name == "enduro" then
                                            names = "엔듀로"
                                          elseif name == "gargoyle" then
                                            names = "가고일"
                                          elseif name == "hakuchou" then
                                            names = "하쿠초우"
                                          elseif name == "daemon" then
                                            names = "할리 너클헤드"
                                          elseif name == "hexer" then
                                            names = "헥서"
                                          elseif name == "innovation" then
                                            names = "이노베이션"
                                          elseif name == "pcj" then
                                            names = "PCJ-600"
                                          elseif name == "sanchez" then
                                            names = "산체스"
                                          elseif name == "sovereign" then
                                            names = "소버린"
                                          elseif name == "vader" then
                                            names = "베이더"
                                          elseif name == "vindicator" then
                                            names = "빈디케이터"
                                          elseif name == "bs17" then
                                            names = "BMW S1000RR"
                                          elseif name == "panigale" then
                                            names = "두카티 파니갈레 R 1299"
                                          elseif name == "fixter" then
                                            names = "픽시 자전거"
                                          elseif name == "tribike" then
                                            names = "로드 자전거"
                                          elseif name == "bmx" then
                                            names = "BMX 자전거"
                                          elseif name == "scorcher" then
                                            names = "MTB 자전거"
                                          elseif name == "bugatti" then
                                            names = "부가티 베이론"
                                          elseif name == "supersport" then
                                            names = "부가티 베이론 슈퍼스포트"
                                          elseif name == "2017chiron" then
                                            names = "부가티 시론"
                                          elseif name == "bdivo" then
                                            names = "부가티 디보"
                                          elseif name == "tricolore" then
                                            names = "파가니 존다 R"
                                          elseif name == "huayrar" then
                                            names = "파가니 후아이라 로드스터"
                                          elseif name == "bc" then
                                            names = "파가니 후아이라 BC"
                                          elseif name == "lykan" then
                                            names = "W모터스 라이칸 하이퍼스포츠"
                                          elseif name == "fenyr" then
                                            names = "W모터스 Fenyr 하이퍼스포츠"
                                          elseif name == "acsr" then
                                            names = "코닉세그 아제라 R"
                                          elseif name == "regera" then
                                            names = "코닉세그 레제라"
                                          elseif name == "brabhan67" then
                                            names = "F2"
                                          elseif name == "f248" then
                                            names = "페라리 F248"
                                          elseif name == "formulaA" then
                                            names = "F1"
                                          elseif name == "l78c" then
                                            names = "로터스78"
                                          elseif name == "redbullx1" then
                                            names = "레드불"
                                          elseif name == "dvl" then
                                            names = "데빌 식스틴 프로토타입"
                                          elseif name == "exelero" then
                                            names = "마이바흐 엑셀레로"
                                          elseif name == "scaldarsi" then
                                            names = "마이바흐 스칼다르시"
                                          elseif name == "apollo" then
                                            names = "굼퍼트 아폴로 인텐사 이모지온"
                                          elseif name == "arrinera" then
                                            names = "아리네라 후에이라"
                                          elseif name == "regalia" then
                                            names = "쿼츠 레갈리아 723"
                                          elseif name == "ts1" then
                                            names = "젠보 TS1"
                                          elseif name == "lambf" then
                                            names = "람보르기니 셀레스티얼"
                                          elseif name == "zr" then
                                            names = "카시오 AMG 스틸 BBS"
                                          elseif name == "mbc" then
                                            names = "벤츠 AMG 프로젝트 원"
                                          elseif name == "mvisiongt" then
                                            names = "벤츠 AMG 비전GT 컨셉카"
                                          elseif name == "ltm" then
                                            names = "람보르기니 밀레니엄 3"
                                          elseif name == "terzo" then
                                            names = "람보르기니 테르조 콘셉트"
                                          elseif name == "fxxk" then
                                            names = "페라리 FXX K"
                                          elseif name == "f80" then
                                            names = "페라리 F80 컨셉카"
                                          elseif name == "veneno" then
                                            names = "람보르기니 베네노"
                                          elseif name == "sian2" then
                                            names = "람보르기니 시안 2020"
                                          elseif name == "avj" then
                                            names = "람보르기니 아벤타도르J 스피드스터"
                                          elseif name == "bugattila" then
                                            names = "라 부아튀르 느와르"
                                          elseif name == "bugatticentodieci" then
                                            names = "부가티 센토디에치"
                                          elseif name == "gtr2020" then
                                            names = "닛산 2020 비전그란투리스모"
                                          elseif name == "nh2r" then
                                            names = "닌자 가와사키"
                                          elseif name == "furia" then
                                            names = "코닉세그 제스코"
                                          elseif name == "bmm6" then
                                            names = "벤츠 마이바흐 비전 컨셉카"
                                          elseif name == "revolter" then
                                            names = "캐딜락 씨엘"
                                          elseif name == "lamboterzom1" then
                                            names = "람보르기니 테르조 밀레니오"
                                          elseif name == "polad" then
                                            names = "현대 아반떼AD 경찰차"
                                          elseif name == "polsnt" then
                                            names = "현대 LF쏘나타 경찰차"
                                          elseif name == "dn8polices" then
                                            names = "현대 쏘나타 DN8 경찰차"
                                          elseif name == "pstarex" then
                                            names = "현대 스타렉스 경찰차"
                                          elseif name == "unsont" then
                                            names = "현대 쏘나타 암행순찰차"
                                          elseif name == "g70police" then
                                            names = "현대 제네시스 G70 암행순찰차"
                                          elseif name == "police4" then
                                            names = "기아 스팅어 경찰차"
                                          elseif name == "bmpos8" then
                                            names = "BMW M3 F80 경찰차"
                                          elseif name == "polchirons" then
                                            names = "부가티 시론 경찰차"
                                          elseif name == "wmfenyrcops" then
                                            names = "W모터스 페니어 경찰차"
                                          elseif name == "astarex3" then
                                            names = "현대 스타렉스 하이루프 EMS 구급차"
                                          elseif name == "astarex" then
                                            names = "현대 스타렉스 EMS 구급차"
                                          elseif name == "astarex2" then
                                            names = "현대 스타렉스 EMS 환자이송차"
                                          elseif name == "firetruk" then
                                            names = "EMS 소방차"
                                          elseif name == "dn8ems" then
                                            names = "현대 쏘나타 DN8 EMS 세단"
                                          elseif name == "g70m" then
                                            names = "현대 제네시스 G70 EMS 스포츠세단"
                                          elseif name == "emsaventa" then
                                            names = "람보르기니 아벤타도르 EMS 스포츠카"
                                          elseif name == "emschiron" then
                                            names = "부가티 시론 EMS 스포츠카"
                                          elseif name == "swift" then
                                            names = "스위프트 노멀"
                                          elseif name == "swift2" then
                                            names = "스위프트 디럭스"
                                          elseif name == "volatus" then
                                            names = "볼라투스 헬리콥터"
                                          elseif name == "luxor" then
                                            names = "중형비행기 룩소르"
                                          elseif name == "miljet" then
                                            names = "중형비행기 밀젯"
                                          elseif name == "Shamal" then
                                            names = "중형비행기 샤마르"
                                          elseif name == "Velum" then
                                            names = "경비행기 베람"
                                          elseif name == "Duster" then
                                            names = "경비행기 더스터"
                                          elseif name == "Dodo" then
                                            names = "경비행기 도도"
                                          elseif name == "mammatus" then
                                            names = "경비행기 마마타스"
                                          elseif name == "suntrap" then
                                            names = "낚시배"
                                          elseif name == "poter" then
                                            names = "현대 포터2"
                                          elseif name == "bongo" then
                                            names = "기아 봉고3"
                                          elseif name == "starex" then
                                            names = "현대 스타렉스 2015"
                                          elseif name == "nexo" then
                                            names = "현대 넥쏘 2019"
                                          elseif name == "egoista" then
                                            names = "람보르기니 에고이스타"
                                          elseif name == "mohave" then
                                            names = "기아 모하비 2008"
                                          elseif name == "g70" then
                                            names = "현대 제네시스 G70"
                                          elseif name == "dn8ss" then
                                            names = "현대 DN8 센슈어스"
                                          elseif name == "mazf" then
                                            names = "마쯔다 타이키 2019"
                                          elseif name == "kart" then
                                            names = "카트"
                                          elseif name == "minia" then
                                            names = "미니 오토바이"
                                          elseif name == "skart" then
                                            names = "쇼핑 카트"
                                          elseif name == "superkart" then
                                            names = "슈퍼 카트"
                                          elseif name == "2018transam" then
                                            names = "트랜스 앰"
                                          elseif name == "mcst" then
                                            names = "맥라렌 스피드테일"
                                          elseif name == "granbird" then
                                            names = "기아 그랜버드 대형버스"
                                          elseif name == "alfieri" then
                                            names = "마세라티 알피에라 2020"
                                          elseif name == "2018s650p" then
                                            names = "벤츠 S650 마이바흐 풀만소리 리무진"
                                          elseif name == "ep9" then
                                            names = "NIO EP9 2017 EVO"
                                          elseif name == "ksport" then
                                            names = "쌍용 코란도 스포츠"
                                          else
                                            names = ""
                                          end
                                          --▲ 차량명 --                              -- 차량 가격 ▼ --
                                          if name == "radi" then
                                            vmoney = "11,000,000원"
                                          elseif name == "accent" then
                                            vmoney = "15,600,000원"
                                          elseif name == "kiagt" then
                                            vmoney = "49,000,000원"
                                          elseif name == "veln" then
                                            vmoney = "35,822,000원"
                                          elseif name == "premier" then
                                            vmoney = "26,000,000원"
                                          elseif name == "fugitive" then
                                            vmoney = "31,000,000원"
                                          elseif name == "felon" then
                                            vmoney = "75,000,000원"
                                          elseif name == "genesis" then
                                            vmoney = "35,000,000원"
                                          elseif name == "santafe" then
                                            vmoney = "39,000,000원"
                                          elseif name == "hkona" then
                                            vmoney = "25,000,000원"
                                          elseif name == "sonata" then
                                            vmoney = "31,000,000원"
                                          elseif name == "jackal" then
                                            vmoney = "36,184,000원"
                                          elseif name == "koup" then
                                            vmoney = "30,854,000원"
                                          elseif name == "kiamansory" then
                                            vmoney = "68,000,000원"
                                          elseif name == "baller2" then
                                            vmoney = "36,180,000원"
                                          elseif name == "equus" then
                                            vmoney = "110,000,000원"
                                          elseif name == "carnival" then
                                            vmoney = "56,000,000원"
                                          elseif name == "tuscani" then
                                            vmoney = "23,000,000원"
                                          elseif name == "sibal" then
                                            vmoney = "56,000,000원"
                                          elseif name == "lc500" then
                                            vmoney = "172,000,000원"
                                          elseif name == "rx450h" then
                                            vmoney = "89,000,000원"
                                          elseif name == "f620" then
                                            vmoney = "61,000,000원"
                                          elseif name == "RC350" then
                                            vmoney = "75,000,000원"
                                          elseif name == "rcf" then
                                            vmoney = "106,000,000원"
                                          elseif name == "gt86rb" then
                                            vmoney = "85,000,000원"
                                          elseif name == "ae86" then
                                            vmoney = "16,000,000원"
                                          elseif name == "camry55" then
                                            vmoney = "23,000,000원"
                                          elseif name == "cam8tun" then
                                            vmoney = "36,000,000원"
                                          elseif name == "prius" then
                                            vmoney = "16,000,000원"
                                          elseif name == "supra2" then
                                            vmoney = "26,000,000원"
                                          elseif name == "17m760i" then
                                            vmoney = "230,000,000원"
                                          elseif name == "e46" then
                                            vmoney = "56,000,000원"
                                          elseif name == "z4" then
                                            vmoney = "78,000,000원"
                                          elseif name == "19Z4" then
                                            vmoney = "82,000,000원"
                                          elseif name == "z4alchemist" then
                                            vmoney = "105,000,000원"
                                          elseif name == "bmci" then
                                            vmoney = "132,000,000원"
                                          elseif name == "m5f90" then
                                            vmoney = "145,000,000원"
                                          elseif name == "m850" then
                                            vmoney = "218,000,000원"
                                          elseif name == "m8gte" then
                                            vmoney = "248,000,000원"
                                          elseif name == "bmwx7" then
                                            vmoney = "165,000,000원"
                                          elseif name == "m2" then
                                            vmoney = "83,000,000원"
                                          elseif name == "e34touring" then
                                            vmoney = "92,500,000원"
                                          elseif name == "m3e46" then
                                            vmoney = "105,000,000원"
                                          elseif name == "m4" then
                                            vmoney = "105,000,000원"
                                          elseif name == "f82" then
                                            vmoney = "110,000,000원"
                                          elseif name == "rmodm4gts" then
                                            vmoney = "160,000,000원"
                                          elseif name == "rmodm4" then
                                            vmoney = "145,000,000원"
                                          elseif name == "m6f13" then
                                            vmoney = "180,000,000원"
                                          elseif name == "i8" then
                                            vmoney = "180,000,000원"
                                          elseif name == "rmodmi8" then
                                            vmoney = "200,000,000원"
                                          elseif name == "mi8" then
                                            vmoney = "230,000,000원"
                                          elseif name == "x5m" then
                                            vmoney = "250,000,000원"
                                          elseif name == "x6m" then
                                            vmoney = "183,000,000원"
                                          elseif name == "m5f90" then
                                            vmoney = "250,000,000원"
                                          elseif name == "cooperworks" then
                                            vmoney = "52,000,000원"
                                          elseif name == "cls2015" then
                                            vmoney = "180,000,000원"
                                          elseif name == "g63" then
                                            vmoney = "250,000,000원"
                                          elseif name == "g65amg" then
                                            vmoney = "320,000,000원"
                                          elseif name == "gclas9" then
                                            vmoney = "150,000,000원"
                                          elseif name == "amggtr" then
                                            vmoney = "280,000,000원"
                                          elseif name == "gt63s" then
                                            vmoney = "260,000,000원"
                                          elseif name == "amggtsmansory" then
                                            vmoney = "350,000,000원"
                                          elseif name == "slsamg" then
                                            vmoney = "300,000,000원"
                                          elseif name == "s6brabus" then
                                            vmoney = "380,000,000원"
                                          elseif name == "b63s" then
                                            vmoney = "160,000,000원"
                                          elseif name == "c63w205" then
                                            vmoney = "120,000,000원"
                                          elseif name == "c63coupe" then
                                            vmoney = "115,000,000원"
                                          elseif name == "schafter3" then
                                            vmoney = "260,000,000원"
                                          elseif name == "s500w222" then
                                            vmoney = "150,000,000원"
                                          elseif name == "s600w220" then
                                            vmoney = "180,000,000원"
                                          elseif name == "benson3" then
                                            vmoney = "90,000,000원"
                                          elseif name == "gl63" then
                                            vmoney = "145,000,000원"
                                          elseif name == "gle" then
                                            vmoney = "160,000,000원"
                                          elseif name == "mers63c" then
                                            vmoney = "210,000,000원"
                                          elseif name == "c63a" then
                                            vmoney = "100,000,000원"
                                          elseif name == "macla" then
                                            vmoney = "39,000,000원"
                                          elseif name == "ae350" then
                                            vmoney = "68,000,000원"
                                          elseif name == "mb250" then
                                            vmoney = "95,000,000원"
                                          elseif name == "gle63s" then
                                            vmoney = "180,000,000원"
                                          elseif name == "amggtsprior" then
                                            vmoney = "320,000,000원"
                                          elseif name == "r820" then
                                            vmoney = "265,000,000원"
                                          elseif name == "arv10" then
                                            vmoney = "249,000,000원"
                                          elseif name == "r8ppi" then
                                            vmoney = "230,000,000원"
                                          elseif name == "r8lms" then
                                            vmoney = "350,000,000원"
                                          elseif name == "rs6" then
                                            vmoney = "130,000,000원"
                                          elseif name == "sentinel" then
                                            vmoney = "95,000,000원"
                                          elseif name == "tts" then
                                            vmoney = "65,000,000원"
                                          elseif name == "aaq4" then
                                            vmoney = "55,000,000원"
                                          elseif name == "rs7" then
                                            vmoney = "185,000,000원"
                                          elseif name == "a8l" then
                                            vmoney = "190,000,000원"
                                          elseif name == "sq72016" then
                                            vmoney = "110,000,000원"
                                          elseif name == "rs52018" then
                                            vmoney = "87,000,000원"
                                          elseif name == "a6tfsi" then
                                            vmoney = "76,000,000원"
                                          elseif name == "audiq8" then
                                            vmoney = "105,000,000원"
                                          elseif name == "AUDsq517" then
                                            vmoney = "85,000,000원"
                                          elseif name == "rs318" then
                                            vmoney = "65,000,000원"
                                          elseif name == "golfp" then
                                            vmoney = "52,000,000원"
                                          elseif name == "17bcs" then
                                            vmoney = "210,000,000원"
                                          elseif name == "bnteam" then
                                            vmoney = "250,000,000원"
                                          elseif name == "bcgt" then
                                            vmoney = "260,000,000원"
                                          elseif name == "bentaygast" then
                                            vmoney = "380,000,000원"
                                          elseif name == "brooklands" then
                                            vmoney = "391,600,000원"
                                          elseif name == "bbentayga" then
                                            vmoney = "384,400,000원"
                                          elseif name == "bexp" then
                                            vmoney = "650,000,000원"
                                          elseif name == "bmm" then
                                            vmoney = "520,000,000원"
                                          elseif name == "720s" then
                                            vmoney = "370,000,000원"
                                          elseif name == "mv720" then
                                            vmoney = "490,000,000원"
                                          elseif name == "675lt" then
                                            vmoney = "320,000,000원"
                                          elseif name == "570s2" then
                                            vmoney = "250,000,000원"
                                          elseif name == "p1" then
                                            vmoney = "1,800,000,000원"
                                          elseif name == "p1gtr" then
                                            vmoney = "2,500,000,000원"
                                          elseif name == "mp412c" then
                                            vmoney = "300,000,000원"
                                          elseif name == "senna" then
                                            vmoney = "2,500,000,000원"
                                          elseif name == "600lt" then
                                            vmoney = "300,000,000원"
                                          elseif name == "911turbos" then
                                            vmoney = "320,000,000원"
                                          elseif name == "911tbs" then
                                            vmoney = "300,000,000원"
                                          elseif name == "pcs18" then
                                            vmoney = "135,000,000원"
                                          elseif name == "cayenne" then
                                            vmoney = "172,000,000원"
                                          elseif name == "718caymans" then
                                            vmoney = "120,000,000원"
                                          elseif name == "718boxster" then
                                            vmoney = "125,000,000원"
                                          elseif name == "panamera17turbo" then
                                            vmoney = "250,000,000원"
                                          elseif name == "918" then
                                            vmoney = "1,800,000,000원"
                                          elseif name == "p901" then
                                            vmoney = "3,800,000,000원"
                                          elseif name == "cayman16" then
                                            vmoney = "150,000,000원"
                                          elseif name == "por911gt3" then
                                            vmoney = "200,000,000원"
                                          elseif name == "GT2RS" then
                                            vmoney = "380,000,000원"
                                          elseif name == "993rwb" then
                                            vmoney = "250,000,000원"
                                          elseif name == "911r" then
                                            vmoney = "1,150,000,000원"
                                          elseif name == "cgt" then
                                            vmoney = "950,000,000원"
                                          elseif name == "pm19" then
                                            vmoney = "138,000,000원"
                                          elseif name == "str20" then
                                            vmoney = "165,000,000원"
                                          elseif name == "pgt3" then
                                            vmoney = "230,000,000원"
                                          elseif name == "fct" then
                                            vmoney = "350,000,000원"
                                          elseif name == "f40" then
                                            vmoney = "280,000,000원"
                                          elseif name == "f430s" then
                                            vmoney = "250,000,000원"
                                          elseif name == "ferporto" then
                                            vmoney = "380,000,000원"
                                          elseif name == "fer612" then
                                            vmoney = "350,000,000원"
                                          elseif name == "yFe458i1" then
                                            vmoney = "400,000,000원"
                                          elseif name == "yFe458s1" then
                                            vmoney = "410,000,000원"
                                          elseif name == "lw458s" then
                                            vmoney = "415,000,000원"
                                          elseif name == "4881" then
                                            vmoney = "420,000,000원"
                                          elseif name == "f8t" then
                                            vmoney = "425,000,000원"
                                          elseif name == "gtc4" then
                                            vmoney = "480,000,000원"
                                          elseif name == "yFe458i2" then
                                            vmoney = "530,000,000원"
                                          elseif name == "yFe458s2" then
                                            vmoney = "520,000,000원"
                                          elseif name == "pista" then
                                            vmoney = "560,000,000원"
                                          elseif name == "pistas" then
                                            vmoney = "610,000,000원"
                                          elseif name == "fm488" then
                                            vmoney = "480,000,000원"
                                          elseif name == "berlinetta" then
                                            vmoney = "620,000,000원"
                                          elseif name == "gtoxx" then
                                            vmoney = "650,000,000원"
                                          elseif name == "ferrari812" then
                                            vmoney = "680,000,000원"
                                          elseif name == "f12m" then
                                            vmoney = "720,000,000원"
                                          elseif name == "aperta" then
                                            vmoney = "3,500,000,000원"
                                          elseif name == "enzo" then
                                            vmoney = "3,200,000,000원"
                                          elseif name == "scuderiag" then
                                            vmoney = "8,600,000,000원"
                                          elseif name == "f60" then
                                            vmoney = "3,600,000,000원"
                                          elseif name == "nlargo" then
                                            vmoney = "560,000,000원"
                                          elseif name == "sergio" then
                                            vmoney = "350,000,000원"
                                          elseif name == "lp770" then
                                            vmoney = "3,500,000,000원"
                                          elseif name == "cyclone" then
                                            vmoney = "3,800,000,000원"
                                          elseif name == "lp700r" then
                                            vmoney = "680,000,000원"
                                          elseif name == "lp670" then
                                            vmoney = "380,000,000원"
                                          elseif name == "aventadors" then
                                            vmoney = "710,000,000원"
                                          elseif name == "rmodlp750" then
                                            vmoney = "730,000,000원"
                                          elseif name == "lb750sv" then
                                            vmoney = "750,000,000원"
                                          elseif name == "lamboavj" then
                                            vmoney = "780,000,000원"
                                          elseif name == "lp610" then
                                            vmoney = "420,000,000원"
                                          elseif name == "500gtrlam" then
                                            vmoney = "367,380,000원"
                                          elseif name == "610lb" then
                                            vmoney = "431,872,000원"
                                          elseif name == "huraperfospy" then
                                            vmoney = "450,000,000원"
                                          elseif name == "lbperfs" then
                                            vmoney = "471,872,000원"
                                          elseif name == "rmodlp570" then
                                            vmoney = "340,000,000원"
                                          elseif name == "gallardosuperlb" then
                                            vmoney = "380,000,000원"
                                          elseif name == "urus2018" then
                                            vmoney = "280,000,000원"
                                          elseif name == "lambose" then
                                            vmoney = "3,512,785,800원"
                                          elseif name == "huracanst" then
                                            vmoney = "480,000,000원"
                                          elseif name == "sc18" then
                                            vmoney = "1,530,000,000원"
                                          elseif name == "p7" then
                                            vmoney = "239,528,400원"
                                          elseif name == "xkgt" then
                                            vmoney = "260,000,000원"
                                          elseif name == "ipace" then
                                            vmoney = "130,000,000원"
                                          elseif name == "fpacehm" then
                                            vmoney = "150,000,000원"
                                          elseif name == "mbh" then
                                            vmoney = "925,000,000원"
                                          elseif name == "twizy" then
                                            vmoney = "16,500,000원"
                                          elseif name == "tmax" then
                                            vmoney = "9,500,000원"
                                          elseif name == "gtx" then
                                            vmoney = "250,000,000원"
                                          elseif name == "nanoflo" then
                                            vmoney = "230,000,000원"
                                          elseif name == "shotaro" then
                                            vmoney = "35,000,000원"
                                          elseif name == "firebird" then
                                            vmoney = "56,000,000원"
                                          elseif name == "saleens7" then
                                            vmoney = "1,450,000,000원"
                                          elseif name == "slingshot" then
                                            vmoney = "30,000,000원"
                                          elseif name == "can" then
                                            vmoney = "20,000,000원"
                                          elseif name == "focusrs" then
                                            vmoney = "51,000,000원"
                                          elseif name == "mst" then
                                            vmoney = "75,000,000원"
                                          elseif name == "20f250" then
                                            vmoney = "105,000,000원"
                                          elseif name == "18f250" then
                                            vmoney = "105,000,000원"
                                          elseif name == "mgt" then
                                            vmoney = "50,000,000원"
                                          elseif name == "gt17" then
                                            vmoney = "650,000,000원"
                                          elseif name == "demon" then
                                            vmoney = "65,000,000원"
                                          elseif name == "durango" then
                                            vmoney = "56,000,000원"
                                          elseif name == "cats" then
                                            vmoney = "110,000,000원"
                                          elseif name == "ct6" then
                                            vmoney = "108,000,000원"
                                          elseif name == "srt8" then
                                            vmoney = "93,000,000원"
                                          elseif name == "demonhawk" then
                                            vmoney = "85,000,000원"
                                          elseif name == "gmcyd" then
                                            vmoney = "85,000,000원"
                                          elseif name == "ap2" then
                                            vmoney = "21,000,000원"
                                          elseif name == "crz" then
                                            vmoney = "15,000,000원"
                                          elseif name == "fk8" then
                                            vmoney = "35,000,000원"
                                          elseif name == "goldwing" then
                                            vmoney = "37,074,900원"
                                          elseif name == "nemesis" then
                                            vmoney = "23,000,000원"
                                          elseif name == "na1" then
                                            vmoney = "13,200,000원"
                                          elseif name == "nc1" then
                                            vmoney = "76,000,000원"
                                          elseif name == "ody18" then
                                            vmoney = "43,200,000원"
                                          elseif name == "Wraith" then
                                            vmoney = "450,000,000원"
                                          elseif name == "cullinan" then
                                            vmoney = "520,000,000원"
                                          elseif name == "rrphantom" then
                                            vmoney = "720,000,000원"
                                          elseif name == "rdawn" then
                                            vmoney = "630,000,000원"
                                          elseif name == "p90d" then
                                            vmoney = "150,000,000원"
                                          elseif name == "models" then
                                            vmoney = "156,000,000원"
                                          elseif name == "teslapd" then
                                            vmoney = "135,000,000원"
                                          elseif name == "tr22" then
                                            vmoney = "250,000,000원"
                                          elseif name == "malibu" then
                                            vmoney = "36,620,000원"
                                          elseif name == "exor" then
                                            vmoney = "120,000,000원"
                                          elseif name == "c7" then
                                            vmoney = "115,000,000원"
                                          elseif name == "c8" then
                                            vmoney = "원가없음"
                                          elseif name == "2020ss" then
                                            vmoney = "56,000,000원"
                                          elseif name == "c7r" then
                                            vmoney = "125,000,000원"
                                          elseif name == "ghis2" then
                                            vmoney = "98,000,000원"
                                          elseif name == "mqgts" then
                                            vmoney = "210,000,000원"
                                          elseif name == "granlb" then
                                            vmoney = "310,000,000원"
                                          elseif name == "mlmansory" then
                                            vmoney = "150,000,000원"
                                          elseif name == "vantage" then
                                            vmoney = "235,000,000원"
                                          elseif name == "db11" then
                                            vmoney = "292,000,000원"
                                          elseif name == "cyrus" then
                                            vmoney = "320,000,000원"
                                          elseif name == "ast" then
                                            vmoney = "385,000,000원"
                                          elseif name == "one77" then
                                            vmoney = "2,400,000,000원"
                                          elseif name == "180sx" then
                                            vmoney = "15,000,000원"
                                          elseif name == "d1r34" then
                                            vmoney = "16,000,000원"
                                          elseif name == "gtr" then
                                            vmoney = "165,000,000원"
                                          elseif name == "nissantitan17" then
                                            vmoney = "55,000,000원"
                                          elseif name == "elegy2" then
                                            vmoney = "25,000,000원"
                                          elseif name == "tule" then
                                            vmoney = "28,000,000원"
                                          elseif name == "gt86rb" then
                                            vmoney = "85,000,000원"
                                          elseif name == "vv60" then
                                            vmoney = "48,000,000원"
                                          elseif name == "xc90r" then
                                            vmoney = "98,000,000원"
                                          elseif name == "18Velar" then
                                            vmoney = "125,000,000원"
                                          elseif name == "rr12" then
                                            vmoney = "240,000,000원"
                                          elseif name == "rrstart" then
                                            vmoney = "280,000,000원"
                                          elseif name == "svr16" then
                                            vmoney = "320,000,000원"
                                          elseif name == "exor" then
                                            vmoney = "115,000,000원"
                                          elseif name == "velociraptor" then
                                            vmoney = "180,000,000원"
                                          elseif name == "xnsgt" then
                                            vmoney = "650,000,000원"
                                          elseif name == "f4rr" then
                                            vmoney = "32,000,000원"
                                          elseif name == "snowbike" then
                                            vmoney = "12,000,000원"
                                          elseif name == "akuma" then
                                            vmoney = "90,000,000원"
                                          elseif name == "bagger" then
                                            vmoney = "7,000,000원"
                                          elseif name == "bati" then
                                            vmoney = "10,000,000원"
                                          elseif name == "bati2" then
                                            vmoney = "10,000,000원"
                                          elseif name == "bf400" then
                                            vmoney = "6,000,000원"
                                          elseif name == "lectro" then
                                            vmoney = "10,000,000원"
                                          elseif name == "carbonrs" then
                                            vmoney = "11,000,000원"
                                          elseif name == "cliffhanger" then
                                            vmoney = "13,000,000원"
                                          elseif name == "f131" then
                                            vmoney = "45,000,000원"
                                          elseif name == "double" then
                                            vmoney = "9,000,000원"
                                          elseif name == "enduro" then
                                            vmoney = "6,000,000원"
                                          elseif name == "gargoyle" then
                                            vmoney = "10,000,000원"
                                          elseif name == "hakuchou" then
                                            vmoney = "20,000,000원"
                                          elseif name == "daemon" then
                                            vmoney = "20,000,000원"
                                          elseif name == "hexer" then
                                            vmoney = "15,000,000원"
                                          elseif name == "innovation" then
                                            vmoney = "20,000,000원"
                                          elseif name == "pcj" then
                                            vmoney = "7,000,000원"
                                          elseif name == "sanchez" then
                                            vmoney = "3,000,000원"
                                          elseif name == "sovereign" then
                                            vmoney = "1,000,000원"
                                          elseif name == "vader" then
                                            vmoney = "7,000,000원"
                                          elseif name == "vindicator" then
                                            vmoney = "12,000,000원"
                                          elseif name == "bs17" then
                                            vmoney = "21,000,000원"
                                          elseif name == "panigale" then
                                            vmoney = "35,000,000원"
                                          elseif name == "fixter" then
                                            vmoney = "150,000원"
                                          elseif name == "tribike" then
                                            vmoney = "280,000원"
                                          elseif name == "bmx" then
                                            vmoney = "250,000원"
                                          elseif name == "scorcher" then
                                            vmoney = "230,000원"
                                          elseif name == "bugatti" then
                                            vmoney = "3,200,000,000원"
                                          elseif name == "supersport" then
                                            vmoney = "3,250,000,000원"
                                          elseif name == "2017chiron" then
                                            vmoney = "3,800,000,000원"
                                          elseif name == "bdivo" then
                                            vmoney = "6,200,000,000원"
                                          elseif name == "tricolore" then
                                            vmoney = "2,500,000,000원"
                                          elseif name == "huayrar" then
                                            vmoney = "1,800,000,000원"
                                          elseif name == "bc" then
                                            vmoney = "2,300,000,000원"
                                          elseif name == "lykan" then
                                            vmoney = "4,120,000,000원"
                                          elseif name == "fenyr" then
                                            vmoney = "4,500,000,000원"
                                          elseif name == "acsr" then
                                            vmoney = "2,500,000,000원"
                                          elseif name == "regera" then
                                            vmoney = "2,800,000,000원"
                                          elseif name == "brabhan67" then
                                            vmoney = "8,900,000,000원"
                                          elseif name == "f248" then
                                            vmoney = "16,000,000,000원"
                                          elseif name == "formulaA" then
                                            vmoney = "11,500,000,000원"
                                          elseif name == "l78c" then
                                            vmoney = "13,000,000,000원"
                                          elseif name == "redbullx1" then
                                            vmoney = "15,000,000,000원"
                                          elseif name == "dvl" then
                                            vmoney = "원가없음"
                                          elseif name == "exelero" then
                                            vmoney = "원가없음"
                                          elseif name == "scaldarsi" then
                                            vmoney = "원가없음"
                                          elseif name == "apollo" then
                                            vmoney = "원가없음"
                                          elseif name == "arrinera" then
                                            vmoney = "원가없음"
                                          elseif name == "regalia" then
                                            vmoney = "원가없음"
                                          elseif name == "ts1" then
                                            vmoney = "원가없음"
                                          elseif name == "lambf" then
                                            vmoney = "원가없음"
                                          elseif name == "zr" then
                                            vmoney = "원가없음"
                                          elseif name == "mbc" then
                                            vmoney = "원가없음"
                                          elseif name == "mvisiongt" then
                                            vmoney = "원가없음"
                                          elseif name == "ltm" then
                                            vmoney = "원가없음"
                                          elseif name == "terzo" then
                                            vmoney = "원가없음"
                                          elseif name == "fxxk" then
                                            vmoney = "원가없음"
                                          elseif name == "f80" then
                                            vmoney = "원가없음"
                                          elseif name == "veneno" then
                                            vmoney = "원가없음"
                                          elseif name == "sian2" then
                                            vmoney = "원가없음"
                                          elseif name == "avj" then
                                            vmoney = "원가없음"
                                          elseif name == "bugattila" then
                                            vmoney = "원가없음"
                                          elseif name == "bugatticentodieci" then
                                            vmoney = "원가없음"
                                          elseif name == "gtr2020" then
                                            vmoney = "원가없음"
                                          elseif name == "nh2r" then
                                            vmoney = "원가없음"
                                          elseif name == "furia" then
                                            vmoney = "원가없음"
                                          elseif name == "bmm6" then
                                            vmoney = "원가없음"
                                          elseif name == "revolter" then
                                            vmoney = "원가없음"
                                          elseif name == "lamboterzom1" then
                                            vmoney = "원가없음"
                                          elseif name == "polad" then
                                            vmoney = "원가없음"
                                          elseif name == "polsnt" then
                                            vmoney = "원가없음"
                                          elseif name == "dn8polices" then
                                            vmoney = "10,000,000원"
                                          elseif name == "pstarex" then
                                            vmoney = "35,000,000원"
                                          elseif name == "unsont" then
                                            vmoney = "50,000,000원"
                                          elseif name == "g70police" then
                                            vmoney = "80,000,000원"
                                          elseif name == "police4" then
                                            vmoney = "80,000,000원"
                                          elseif name == "bmpos8" then
                                            vmoney = "100,000,000원"
                                          elseif name == "polchirons" then
                                            vmoney = "700,000,000원"
                                          elseif name == "wmfenyrcops" then
                                            vmoney = "1,200,000,000원"
                                          elseif name == "astarex3" then
                                            vmoney = "원가없음"
                                          elseif name == "astarex" then
                                            vmoney = "20,000,000원"
                                          elseif name == "astarex2" then
                                            vmoney = "30,000,000원"
                                          elseif name == "firetruk" then
                                            vmoney = "45,000,000원"
                                          elseif name == "dn8ems" then
                                            vmoney = "50,000,000원"
                                          elseif name == "g70m" then
                                            vmoney = "100,000,000원"
                                          elseif name == "emsaventa" then
                                            vmoney = "500,000,000원"
                                          elseif name == "emschiron" then
                                            vmoney = "2,000,000,000원"
                                          elseif name == "swift" then
                                            vmoney = "650,000,000원"
                                          elseif name == "swift2" then
                                            vmoney = "820,000,000원"
                                          elseif name == "volatus" then
                                            vmoney = "1,000,000,000원"
                                          elseif name == "luxor" then
                                            vmoney = "2,000,000,000원"
                                          elseif name == "miljet" then
                                            vmoney = "1,500,000,000원"
                                          elseif name == "Shamal" then
                                            vmoney = "1,800,000,000원"
                                          elseif name == "Velum" then
                                            vmoney = "500,000,000원"
                                          elseif name == "Duster" then
                                            vmoney = "800,000,000원"
                                          elseif name == "Dodo" then
                                            vmoney = "1,000,000,000원"
                                          elseif name == "mammatus" then
                                            vmoney = "400,000,000원"
                                          elseif name == "suntrap" then
                                            vmoney = "원가없음"
                                          elseif name == "poter" then
                                            vmoney = "원가없음"
                                          elseif name == "bongo" then
                                            vmoney = "원가없음"
                                          elseif name == "starex" then
                                            vmoney = "35,000,000원"
                                          elseif name == "nexo" then
                                            vmoney = "원가없음"
                                          elseif name == "egoista" then
                                            vmoney = "원가없음"
                                          elseif name == "mohave" then
                                            vmoney = "원가없음"
                                          elseif name == "g70" then
                                            vmoney = "원가없음"
                                          elseif name == "dn8ss" then
                                            vmoney = "원가없음"
                                          elseif name == "minia" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "2018transam" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "mcst" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "granbird" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "kart" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "mazf" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "superkart" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "skart" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "alfieri" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "2018s650p" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "ep9" then
                                            vmoney = "후원차량(원가없음)"
                                          elseif name == "ksport" then
                                            vmoney = "원가없음"
                                          elseif name == "gv80" then
                                            vmoney = "원가없음"
                                          else
                                            vmoney = ""
                                          end
                                          sendToDiscord_garage(10310399, "차량 거래 내역서", "판매한 사람 : " .. my_name .. "(" .. my_id .. "번)\n\n받는 사람 : " .. GetPlayerName(target) .. "(" .. user_id .. "번)\n\n차량명 : " .. names .. "\n\n차량 원가 : " .. vmoney .. "\n\n판매 금액 : " .. comma_value(amount) .. "원", os.date("거래일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록"))
                                          vRPclient.notify(player, {"자동차 이전세 5% 공제"})
                                          vRPclient.notify(
                                            target,
                                            {
                                              "~g~" .. GetPlayerName(player) .. "님에게 " .. amount .. "원에 성공적으로 판매하였습니다!"
                                            }
                                          )
                                        else
                                          vRPclient.notify(player, {"~r~" .. GetPlayerName(target) .. "님께서 그만한 돈을 가지고 있지 않습니다."})
                                          vRPclient.notify(target, {"~r~당신은 그만한 돈을 가지고 있지 않습니다!"})
                                        end
                                      else
                                        vRPclient.notify(player, {"~r~" .. GetPlayerName(target) .. " has refused to buy the car."})
                                        vRPclient.notify(target, {"~r~You have refused to buy " .. GetPlayerName(player) .. "'s car."})
                                      end
                                    end
                                  )
                                end
                                vRP.closeMenu(player)
                              end
                            end
                          )
                        else
                          vRPclient.notify(player, {"~r~The price of the car has to be a number."})
                        end
                      end
                    )
                  else
                    vRPclient.notify(player, {"~r~That ID seems invalid."})
                  end
                else
                  vRPclient.notify(player, {"~r~No player ID selected."})
                end
              end
            )
          else
            vRPclient.notify(player, {"~r~No player nearby."})
          end
        end
      )
    end
  end,
  lang.vehicle.sellTP.description()
}

function sendToDiscord_garage(color, name, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["url"] = "https://i.imgur.com/xGCgBw1.png",
      ["footer"] = {
        ["text"] = footer
      }
    }
  }
  PerformHttpRequest(
    "https://discordapp.com/api/webhooks/685755370651779073/auLaBrFvwcWmR_bHegqJr8RapKRVntQMtkuGuE5jR5Z9hCWpoENIeYUy_LJPpAehH1H8",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

function vRP.log(file, info)
  if true then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("[%Y/%m/%d] %H:%M:%S") .. " -> " .. info .. "#")
  end
  file:close()
end

function comma_value(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
    if (k == 0) then
      break
    end
  end
  return formatted
end

local function ch_vehicle(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    -- check vehicle
    vRPclient.getNearestOwnedVehicle(
      player,
      {7},
      function(ok, vtype, name)
        if ok then
          -- build vehicle menu
          vRP.buildMenu(
            "vehicle",
            {user_id = user_id, player = player, vtype = vtype, vname = name},
            function(menu)
              menu.name = lang.vehicle.title()
              menu.css = {top = "75px", header_color = "rgba(255,125,0,0.75)"}

              for k, v in pairs(veh_actions) do
                menu[k] = {
                  function(player, choice)
                    v[1](user_id, player, vtype, name)
                  end,
                  v[2]
                }
              end

              vRP.openMenu(player, menu)
            end
          )
        else
          vRPclient.notify(player, {lang.vehicle.no_owned_near()})
        end
      end
    )
  end
end

-- ask trunk (open other user car chest)
local function ch_asktrunk(player, choice)
  vRPclient.getNearestPlayer(
    player,
    {10},
    function(nplayer)
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id ~= nil then
        vRPclient.notify(player, {lang.vehicle.asktrunk.asked()})
        vRP.request(
          nplayer,
          lang.vehicle.asktrunk.request(),
          15,
          function(nplayer, ok)
            if ok then -- request accepted, open trunk
              vRPclient.getNearestOwnedVehicle(
                nplayer,
                {7},
                function(ok, vtype, name)
                  if ok then
                    local chestname = "u" .. nuser_id .. "veh_" .. string.lower(name)
                    local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight

                    -- open chest
                    local cb_out = function(idname, amount)
                      vRPclient.notify(nplayer, {lang.inventory.give.given({vRP.getItemName(idname), amount})})
                    end

                    local cb_in = function(idname, amount)
                      vRPclient.notify(nplayer, {lang.inventory.give.received({vRP.getItemName(idname), amount})})
                    end

                    vRPclient.vc_openDoor(nplayer, {vtype, 5})
                    vRP.openChest(
                      player,
                      chestname,
                      max_weight,
                      function()
                        vRPclient.vc_closeDoor(nplayer, {vtype, 5})
                      end,
                      cb_in,
                      cb_out
                    )
                  else
                    vRPclient.notify(player, {lang.vehicle.no_owned_near()})
                    vRPclient.notify(nplayer, {lang.vehicle.no_owned_near()})
                  end
                end
              )
            else
              vRPclient.notify(player, {lang.common.request_refused()})
            end
          end
        )
      else
        vRPclient.notify(player, {lang.common.no_player_near()})
      end
    end
  )
end

local isRepairing = {}

-- repair nearest vehicle
local function ch_repair(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if isRepairing[user_id] ~= nil then
      return
    end
    if vRP.tryGetInventoryItem(user_id, "repairkit", 1, true) then
      isRepairing[user_id] = true
      vRPclient.playAnim(player, {false, {task = "WORLD_HUMAN_WELDING"}, false})
      vRPclient.progressBars(player, {15000, "차량을 수리하는 중"})
      SetTimeout(
        15000,
        function()
          isRepairing[user_id] = nil
          vRPclient.fixeNearestVehicle(player, {5})
          vRPclient.stopAnim(player, {false, true})
          vRPclient.notify(player, {"~g~[차량수리] ~w~차량수리가 완료되었습니다."})
        end
      )
    end
  end
end

local ishwRepairing = {}

-- hwrepair nearest vehicle
local function ch_hwrepair(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if ishwRepairing[user_id] ~= nil then
      return
    end
    if vRP.tryGetInventoryItem(user_id, "hwrepairkit", 1, true) then
      ishwRepairing[user_id] = true
      vRPclient.playAnim(player, {false, {task = "WORLD_HUMAN_WELDING"}, false})
      vRPclient.progressBars(player, {12000, "차량을 수리하는 중"})
      SetTimeout(
        12000,
        function()
          ishwRepairing[user_id] = nil
          vRPclient.fixeNearestVehicle(player, {5})
          vRPclient.stopAnim(player, {false, true})
          vRPclient.notify(player, {"~g~[차량수리] ~w~차량수리가 완료되었습니다."})
        end
      )
    end
  end
end

-- 렉카 수리기능
local function ch_frrepair(player, choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if ishwRepairing[user_id] ~= nil then
      return
    end
    if vRP.tryGetInventoryItem(user_id, "fr_repairkit", 1, true) then
      ishwRepairing[user_id] = true
      vRPclient.playAnim(player, {false, {task = "WORLD_HUMAN_WELDING"}, false})
      vRPclient.progressBars(player, {15000, "차량을 수리하는 중"})
      SetTimeout(
        15000,
        function()
          ishwRepairing[user_id] = nil
          vRPclient.fixeNearestVehicle(player, {5})
          vRPclient.stopAnim(player, {false, true})
          vRPclient.notify(player, {"~g~[차량수리] ~w~차량수리가 완료되었습니다."})
        end
      )
    end
  end
end

-- replace nearest vehicle
local function ch_replace(player, choice)
  vRPclient.replaceNearestVehicle(player, {7})
end

vRP.registerMenuBuilder(
  "main",
  function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
      -- add vehicle entry
      local choices = {}
      choices[lang.vehicle.title()] = {ch_vehicle}

      -- add ask trunk
      choices[lang.vehicle.asktrunk.title()] = {ch_asktrunk}

      -- add repair functions
      if vRP.hasPermission(user_id, "vehicle.repair") then
        choices[lang.vehicle.repair.title()] = {ch_repair, lang.vehicle.repair.description()}
      end

      if vRP.hasPermission(user_id, "vehicle.hwrepair") then
        choices[lang.vehicle.repair.title()] = {ch_hwrepair, lang.vehicle.repair.description()}
      end

      if vRP.hasPermission(user_id, "vehicle.frrepair") then
        choices[lang.vehicle.repair.title()] = {ch_frrepair, lang.vehicle.repair.description()}
      end      

      if vRP.hasPermission(user_id, "vehicle.replace") then
        choices[lang.vehicle.replace.title()] = {ch_replace, lang.vehicle.replace.description()}
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
    local ff = string.find(type, "_va_")
    if ff then
      vRPclient.getNearestOwnedVehicle(
        player,
        {5},
        function(ok, vtype, name)
          if ok then
            if type == "ch_va_lock" then
              veh_actions[lang.vehicle.lock.title()][1](user_id, player, vtype, name)
            elseif type == "ch_va_engine" then
              veh_actions[lang.vehicle.engine.title()][1](user_id, player, vtype, name)
            elseif type == "ch_va_trunk" then
              veh_actions[lang.vehicle.trunk.title()][1](user_id, player, vtype, name)
            elseif type == "ch_va_sell" then
              veh_actions[lang.vehicle.sellTP.title()][1](user_id, player, vtype, name)
            elseif type == "ch_va_detach_towtruck" then
              veh_actions[lang.vehicle.detach_towtruck.title()][1](user_id, player, vtype, name)
            elseif type == "ch_va_detach_cargobob" then
              veh_actions[lang.vehicle.detach_cargobob.title()][1](user_id, player, vtype, name)
            elseif type == "ch_va_detach_trailer" then
              veh_actions[lang.vehicle.detach_trailer.title()][1](user_id, player, vtype, name)
            end
          else
            vRPclient.notify(player, {lang.vehicle.no_owned_near()})
          end
        end
      )
    else
      if type == "ch_asktrunk" then
        ch_asktrunk(source, "")
      elseif type == "ch_repair" then
        if vRP.hasPermission(user_id, "vehicle.repair") then
          ch_repair(source, "")
        end
      end
    end
  end
)
