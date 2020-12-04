local user_title = module("cfg/user_title")

local items = {}

local function openBoxAnim(player)
  local seq = {
    {"mp_arresting", "uncuff", 1},
    {"a_uncuff", "uncuff", 1}
  }
  vRPclient.playAnim(player, {true, seq, false})
end

local function title_enable(player, user_id, type)
  local group = user_title.titles[type].group
  if vRP.hasGroup(user_id, user_title.checkGroup) then
    vRPclient.notify(player, {"~r~이미 칭호를 사용중입니다. 해제키트로 먼저 칭호를 해제해주세요."})
  else
    openBoxAnim(player)
    vRPclient.notify(player, {"🉐 칭호 적용중..."})
    Wait(1000)
    if vRP.tryGetInventoryItem(user_id, type, 1) then
      vRP.addUserGroup(user_id, user_title.checkGroup)
      vRP.addUserGroup(user_id, group)
      vRPclient.notify(player, {"~g~칭호를 적용했습니다."})
    else
      vRPclient.notify(player, {"~r~칭호 적용을 실패하였습니다."})
    end
    vRP.closeMenu(player)
  end
end

local function title_disable(player, user_id, type)
  if vRP.hasGroup(user_id, user_title.checkGroup) then
    openBoxAnim(player)
    vRPclient.notify(player, {"🔲 칭호를 해제중..."})
    Wait(1000)
    local setType = nil
    local setGroup = nil
    for k, v in pairs(user_title.titles) do
      if vRP.hasGroup(user_id, v.group) then
        setType = k
        setGroup = v.group
      end
    end
    if setType == nil or not vRP.tryGetInventoryItem(user_id, "titlebox_return", 1) then
      vRPclient.notify(player, {"~r~칭호를 해제할 수 없습니다."})
    else
      vRPclient.notify(player, {"~g~칭호가 해제되었습니다."})
      vRP.removeUserGroup(user_id, user_title.checkGroup)
      vRP.removeUserGroup(user_id, setGroup)
      vRP.giveInventoryItem(user_id, setType, 1, true)
    end
  else
    vRPclient.notify(player, {"~r~사용중인 칭호가 없습니다."})
  end
end

items["titlebox_random"] = {
  "🉐 랜덤칭호상자",
  "'일반'칭호부터 '유일'칭호까지 랜덤지급상자",
  function(args)
    return {
      ["*칭호상자열기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            openBoxAnim(player)
            vRPclient.notify(player, {"🉐 칭호상자를 여는중..."})
            Wait(5000)
            vRP.openTitleBox(user_id, args[1])
            vRP.closeMenu(player)
          end
        end
      }
    }
  end,
  0.0
}

items["titlebox_return"] = {
  "🔲 칭호해제키트",
  "장착된 칭호를 해제하고 가방에 보관할 수 있는 키트",
  function(args)
    return {
      ["*칭호해제하기"] = {
        function(player, choice)
          local user_id = vRP.getUserId(player)
          if user_id ~= nil then
            title_disable(player, user_id, args[1])
          end
        end
      }
    }
  end,
  0.1
}

for k, v in pairs(user_title.titles) do
  items[k] = {
    v.name,
    "",
    function(args)
      return {
        ["*칭호장착하기"] = {
          function(player, choice)
            local user_id = vRP.getUserId(player)
            if user_id ~= nil then
              title_enable(player, user_id, args[1])
            end
          end
        }
      }
    end,
    0.0
  }
end

return items
