local user_title = module("cfg/user_title")

function vRP.getUserTitle()
  return user_title
end

local usersTitleBoxTime = {}
local usersTitleBoxSetTime = 10

function vRP.openTitleBox(user_id, item_name)
  local player = vRP.getUserSource(user_id)
  if player ~= nil then
    if usersTitleBoxTime[user_id] == nil then
      usersTitleBoxTime[user_id] = 0
    else
      if usersTitleBoxTime[user_id] > os.time() - usersTitleBoxSetTime then
        local remain = usersTitleBoxTime[user_id] - (os.time() - usersTitleBoxSetTime)
        vRPclient.notify(player, {"~r~상자는 잠시 후에 열 수 있습니다."})
        return
      end
    end
    usersTitleBoxTime[user_id] = os.time()

    math.randomseed(os.time() + math.random(1, 100000))
    local rand = math.random(1, 100000)
    local div = nil
    if rand >= 99900 then
      div = "unique"
    elseif rand >= 99000 then
      div = "rare"
    elseif rand >= 80000 then
      div = "advanced"
    elseif rand <= 30000 then
      div = "basic"
    end
    if div ~= nil then
      local arrDiv = {}
      local i = 0
      for k, v in pairs(user_title.titles) do
        if v.div == div then
          i = i + 1
          arrDiv[i] = k
        end
      end

      math.randomseed(os.time() + math.random(1, 100000))
      local rrand = math.random(1, i)

      local newType = arrDiv[rrand]
      local newTypeInfo = user_title.titles[newType]

      if vRP.tryGetInventoryItem(user_id, item_name, 1) then
        vRPclient.notify(player, {"~g~상자를 열었습니다."})
        vRP.giveInventoryItem(user_id, newType, 1, true)
        vRPclient.notify(player, {"~g~상자에서 " .. newTypeInfo.name .. "이(가) 나왔습니다!"})
        TriggerClientEvent("chatMessage", -1, "랜덤칭호상자 ", {0, 255, 255}, "^0" .. GetPlayerName(player) .. "^0님의 상자에서 ^2" .. newTypeInfo.name .. "^0이(가) 나왔습니다!")
      end
    else
      vRPclient.notify(player, {"~w~상자가 비어있습니다. 다음엔 잘나오겠죠!!"})
    end
  end
end
