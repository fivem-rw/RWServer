local items = {}

MySQL.createCommand("vRP/add_vehicle", "INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle) VALUES(@user_id,@vehicle)")
MySQL.createCommand("vRP/get_vehicle", "select * from vrp_user_vehicles where user_id=@user_id and vehicle=@vehicle")

local function openBoxAnim(player)
  local seq = {
    {"anim@heists@box_carry@", "run", 1},
    {"anim@heists@box_carry@", "walk", 1},
    {"anim@heists@box_carry@", "run", 1}
  }

  vRPclient.playAnim(player, {true, seq, false})
end

local function save_idle_custom(player, custom, skinId, skinboxId)
  local r_idle = {}

  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data then
      if data.skinitem_idle == nil then
        data.skinitem_idle = custom
      end

      if skinId ~= nil then
        data.skinitem_skinid = skinId
      end

      if skinboxId ~= nil then
        data.skinitem_skinboxid = skinboxId
      end

      for k, v in pairs(data.skinitem_idle) do
        --r_idle[k] = v
      end
    end
  end

  return r_idle
end

local function rollback_idle_custom(player)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    local data = vRP.getUserDataTable(user_id)
    if data then
      local skinId = data.skinitem_skinid
      local skinboxId = data.skinitem_skinboxid
      if data.skinitem_idle ~= nil and data.skinitem_skinid ~= nil then
        vRPclient.setCustomization(player, {data.skinitem_idle})
        data.skinitem_idle = nil
        data.skinitem_skinid = nil
        data.skinitem_skinboxid = nil
        return skinId, skinboxId
      end
    end
  end
  return false
end

items["skinbox"] = {
  function(args)
    local n = args[2] or ""
    return "👔 스킨박스#" .. n
  end,
  "스킨이 보관된 상자",
  function(args)
    return {
      ["*스킨착용하기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          local isValid = false
          if data.skinitem_idle ~= nil then
            vRPclient.notify(player, {"~r~이미 스킨을 착용했습니다."})
            return
          end
          for k, v in pairs(data.inventory) do
            if k == args[1] .. "|" .. args[2] then
              local name, description, weight = vRP.getItemDefinition(k)
              if name ~= nil and v.type == "skin" and v.content then
                vRPclient.getCustomization(
                  player,
                  {},
                  function(custom, valid)
                    if custom and valid and vRP.tryGetInventoryItem(user_id, k, 1, true, false, true) then
                      local idle_copy = {}
                      idle_copy = save_idle_custom(player, custom, v.content[1], k)
                      idle_copy.modelhash = GetHashKey(v.content[1])
                      vRPclient.setCustomization(player, {idle_copy})
                      vRPclient.notify(player, {"~g~스킨 착용 완료"})
                      isValid = true
                    else
                      vRPclient.notify(player, {"~r~스킨을 착용할 수 없습니다."})
                    end
                  end
                )
                break
              end
            end
          end
          SetTimeout(
            2000,
            function()
              if not isValid then
                vRPclient.notify(player, {"~r~스킨 착용 실패"})
              end
            end
          )
        end
      }
    }
  end,
  0.1,
  "skin"
}

items["skinbox_return"] = {
  "👛 스킨포장키트",
  "스킨을 포장할 수 있는 키트",
  function(args)
    return {
      ["*스킨포장하기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          vRPclient.getCustomization(
            player,
            {},
            function(custom, valid)
              if custom and valid and vRP.getInventoryItemAmount(user_id, "skinbox_return") > 0 then
                local skinId, skinboxId = rollback_idle_custom(player)
                if skinId and skinboxId then
                  vRP.tryGetInventoryItem(user_id, "skinbox_return", 1, true, false, true)
                  vRP.giveInventoryItem(user_id, skinboxId, 1, {type = "skin", content = {skinId}}, true, false, true)
                  vRPclient.notify(player, {"~g~스킨 포장 완료"})
                else
                  vRPclient.notify(player, {"~r~스킨을 포장할 수 없습니다."})
                end
              else
                vRPclient.notify(player, {"~r~스킨 포장 실패."})
              end
            end
          )
        end
      }
    }
  end,
  0.1,
  "skin"
}

items["skinbox_random"] = {
  function(args)
    local n = args[2] or ""
    return "👔 스킨랜덤상자#" .. n
  end,
  "스킨박스 랜덤 추첨 상자",
  function(args)
    return {
      ["*상자 열기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          openBoxAnim(player)
          for k, v in pairs(data.inventory) do
            if k == args[1] .. "|" .. args[2] then
              local name, description, weight = vRP.getItemDefinition(k)
              if name ~= nil and v.type == "skinbox_random" and v.content then
                if vRP.tryGetInventoryItem(user_id, k, 1, true, false, true) then
                  math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
                  local num = math.random(1, #v.content)
                  if v.content[num] ~= nil then
                    local itemData = {}
                    itemData.type = "skin"
                    itemData.content = {v.content[num][1]}
                    vRP.getDataitemId(
                      itemData,
                      "skinbox_" .. v.content[num][1],
                      function(id)
                        if parseInt(id) > 0 then
                          vRP.giveInventoryItem(user_id, "skinbox" .. "|" .. id, v.content[num][2], itemData, true)
                          vRPclient.notify(player, {"~g~스킨랜덤상자에서 👔 스킨박스#" .. id .. "(" .. v.content[num][1] .. ")" .. "가 나왔습니다!"})
                          TriggerClientEvent("chatMessage", -1, "스킨랜덤상자", {0, 255, 255}, "^3" .. GetPlayerName(player) .. "^0님의 스킨랜덤상자에서 ^2👔 스킨박스#" .. id .. "(" .. v.content[num][1] .. ")^0가 나왔습니다!")
                        end
                      end
                    )
                  end
                end
              end
            end
          end
        end
      }
    }
  end,
  0.1,
  "skinbox_random"
}

items["smaskbox"] = {
  function(args)
    local n = args[2] or ""
    return "🐹 특별마스크박스#" .. n
  end,
  "특별마스크가 보관된 상자",
  function(args)
    return {
      ["*마스크착용하기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          local isValid = false
          if data.smaskitem_idle ~= nil then
            vRPclient.notify(player, {"~r~이미 마스크를 착용했습니다."})
            return
          end
          for k, v in pairs(data.inventory) do
            if k == args[1] .. "|" .. args[2] then
              local name, description, weight = vRP.getItemDefinition(k)
              if name ~= nil and v.type == "smaskbox" and v.content then
                if vRP.tryGetInventoryItem(user_id, k, 1, true, false, true) then
                  data.smaskitem_idle = v.content[1]
                  vRPclient.setSpecialMaskOn(player, {{id = v.content[1]}})
                  vRPclient.notify(player, {"~g~마스크 착용 완료"})
                  isValid = true
                else
                  vRPclient.notify(player, {"~r~마스크를 착용할 수 없습니다."})
                end
                break
              end
            end
          end
          SetTimeout(
            2000,
            function()
              if not isValid then
                vRPclient.notify(player, {"~r~마스크 착용 실패"})
              end
            end
          )
        end
      }
    }
  end,
  0.1,
  "smaskbox"
}

items["smaskbox_random"] = {
  function(args)
    local n = args[2] or ""
    return "🐹 특별마스크랜덤상자#" .. n
  end,
  "특별마스크박스 랜덤 추첨 상자",
  function(args)
    return {
      ["*상자 열기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          openBoxAnim(player)
          for k, v in pairs(data.inventory) do
            if k == args[1] .. "|" .. args[2] then
              local name, description, weight = vRP.getItemDefinition(k)
              if name ~= nil and v.type == "smaskbox_random" and v.content then
                if vRP.tryGetInventoryItem(user_id, k, 1, true, false, true) then
                  math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
                  local num = math.random(1, #v.content)
                  if v.content[num] ~= nil then
                    local itemData = {}
                    itemData.type = "smaskbox"
                    itemData.content = {v.content[num][1]}
                    vRP.getDataitemId(
                      itemData,
                      "smaskbox_" .. v.content[num][1],
                      function(id)
                        if parseInt(id) > 0 then
                          vRP.giveInventoryItem(user_id, "smaskbox" .. "|" .. id, v.content[num][2], itemData, true)
                          vRPclient.notify(player, {"~g~특별마스크랜덤상자에서 🐹 특별마스크박스#" .. id .. "(" .. v.content[num][1] .. ")" .. "가 나왔습니다!"})
                          TriggerClientEvent("chatMessage", -1, "특별마스크랜덤상자", {0, 255, 255}, "^3" .. GetPlayerName(player) .. "^0님의 특별마스크랜덤상자에서 ^2🐹 특별마스크박스#" .. id .. "(" .. v.content[num][1] .. ")^0가 나왔습니다!")
                        end
                      end
                    )
                  end
                end
              end
            end
          end
        end
      }
    }
  end,
  0.1,
  "smaskbox_random"
}

items["maskbox_return"] = {
  "👛 마스크포장키트",
  "마스크를 포장할 수 있는 키트",
  function(args)
    return {
      ["*마스크포장하기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          if data.smaskitem_idle == nil then
            vRPclient.notify(player, {"~r~마스크를 착용한 상태가 아닙니다."})
            return
          end
          if vRP.tryGetInventoryItem(user_id, "maskbox_return", 1, true, false, true) then
            local itemData = {}
            itemData.type = "smaskbox"
            itemData.content = {data.smaskitem_idle}
            vRP.getDataitemId(
              itemData,
              "smaskbox_" .. data.smaskitem_idle,
              function(id)
                if parseInt(id) > 0 then
                  vRP.giveInventoryItem(user_id, "smaskbox" .. "|" .. id, 1, itemData, true)
                end
              end
            )
            data.smaskitem_idle = nil
            vRPclient.setSpecialMaskOff(player, {})
            vRPclient.notify(player, {"~g~마스크 포장 완료"})
          else
            vRPclient.notify(player, {"~r~마스크 포장 실패."})
          end
        end
      }
    }
  end,
  0.1
}

items["carbox"] = {
  function(args)
    local n = args[2] or ""
    return "🚗 차량지급권#" .. n
  end,
  "차량을 받을 수 있는 티켓",
  function(args)
    return {
      ["*차량 받기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          openBoxAnim(player)
          for k, v in pairs(data.inventory) do
            if k == args[1] .. "|" .. args[2] then
              local name, description, weight = vRP.getItemDefinition(k)
              if name ~= nil and v.type == "carbox" and v.content and v.content[1] ~= nil then
                MySQL.query(
                  "vRP/get_vehicle",
                  {user_id = user_id, vehicle = v.content[1]},
                  function(rows, affected)
                    if #rows > 0 then
                      vRPclient.notify(player, {"~r~이미 ~w~" .. v.content[1] .. " ~r~차량을 소유하고 있습니다."})
                    else
                      if vRP.tryGetInventoryItem(user_id, k, 1, true, false, true) then
                        MySQL.execute("vRP/add_vehicle", {user_id = user_id, vehicle = v.content[1]})
                        vRPclient.notify(player, {"~g~차량지급권을 사용하여 ~w~" .. v.content[1] .. "~g~차량을 지급받았습니다."})
                      end
                    end
                  end
                )
              end
            end
          end
        end
      }
    }
  end,
  0.1,
  "carbox"
}

items["carbox_random"] = {
  function(args)
    local n = args[2] or ""
    return "🚗 차량랜덤상자#" .. n
  end,
  "차량지급권 랜덤 추첨 상자",
  function(args)
    return {
      ["*상자 열기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          openBoxAnim(player)
          for k, v in pairs(data.inventory) do
            if k == args[1] .. "|" .. args[2] then
              local name, description, weight = vRP.getItemDefinition(k)
              if name ~= nil and v.type == "carbox_random" and v.content then
                if vRP.tryGetInventoryItem(user_id, k, 1, true, false, true) then
                  math.randomseed(os.time() + math.random(1, 100000) + tonumber(player))
                  local num = math.random(1, #v.content)
                  if v.content[num] ~= nil then
                    local itemData = {}
                    itemData.type = "carbox"
                    itemData.content = {v.content[num][1]}
                    vRP.getDataitemId(
                      itemData,
                      "carbox_" .. v.content[num][1],
                      function(id)
                        if parseInt(id) > 0 then
                          vRP.giveInventoryItem(user_id, "carbox" .. "|" .. id, v.content[num][2], itemData, true)
                          vRPclient.notify(player, {"~g~차량랜덤상자에서 🚗 차량지급권#" .. id .. "(" .. v.content[num][1] .. ")" .. "가 나왔습니다!"})
                          TriggerClientEvent("chatMessage", -1, "차량랜덤상자", {0, 255, 255}, "^3" .. GetPlayerName(player) .. "^0님의 차량랜덤상자에서 ^2🚗 차량지급권#" .. id .. "(" .. v.content[num][1] .. ")^0가 나왔습니다!")
                        end
                      end
                    )
                  end
                end
              end
            end
          end
        end
      }
    }
  end,
  0.1,
  "carbox_random"
}

items["wdcard"] = {
  function(args)
    local n = args[2] or ""
    return "💌 청첩장#" .. n
  end,
  "우리 결혼합니다 !!",
  function(args)
    return {
      ["*청첩장 확인"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          local data = vRP.getUserDataTable(user_id)
          openBoxAnim(player)
          TriggerEvent("proxy_vrp_wdcard:open", player)
        end
      }
    }
  end,
  0.0,
  "wdcard"
}

return items
