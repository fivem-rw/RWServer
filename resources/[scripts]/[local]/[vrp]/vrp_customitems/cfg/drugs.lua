local cfg = {}
local useUserIds = {}
local cooltime = 10

cfg.drugs = {
  ["lucky_potion1"] = {
    name = "🔮 행운의 물약",
    desc = "행운을 가져다주는 물약<br>지속시간: 10초",
    choices = function(args)
      local idname = args[1]
      local menu = {}
      menu["*마시기"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          local name = vRP.getItemName({idname})
          if user_id ~= nil then
            if useUserIds[user_id] and useUserIds[user_id] > os.time() - cooltime then
              vRPclient.notify(player, {"~r~잠시 후에 이용가능합니다."})
              return
            end
            if vRP.tryGetInventoryItem({user_id, idname, 1, false}) then
              Dclient.playEffect(player, {10, 1.5})
              useUserIds[user_id] = os.time() + 10
              vRPclient.notify(player, {"~b~" .. name .. " 마심."})
              local seq = {
                {"mp_player_intdrink", "intro_bottle", 1},
                {"mp_player_intdrink", "loop_bottle", 1},
                {"mp_player_intdrink", "outro_bottle", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              TriggerEvent("lucky_potion:drink", user_id, 10)
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.0
  },
  ["lucky_potion2"] = {
    name = "🔮 강화된 행운의 물약",
    desc = "행운을 가져다주는 물약<br>지속시간: 20초",
    choices = function(args)
      local idname = args[1]
      local menu = {}
      menu["*마시기"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          local name = vRP.getItemName({idname})
          if user_id ~= nil then
            if useUserIds[user_id] and useUserIds[user_id] > os.time() - cooltime then
              vRPclient.notify(player, {"~r~잠시 후에 이용가능합니다."})
              return
            end
            if vRP.tryGetInventoryItem({user_id, idname, 1, false}) then
              Dclient.playEffect(player, {20, 3.0})
              useUserIds[user_id] = os.time() + 20
              vRPclient.notify(player, {"~b~" .. name .. " 마심."})
              local seq = {
                {"mp_player_intdrink", "intro_bottle", 1},
                {"mp_player_intdrink", "loop_bottle", 1},
                {"mp_player_intdrink", "outro_bottle", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              TriggerEvent("lucky_potion:drink", user_id, 20)
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.0
  },
  ["lucky_potion3"] = {
    name = "🔮 강력한 행운의 물약",
    desc = "행운을 가져다주는 물약<br>지속시간: 30초",
    choices = function(args)
      local idname = args[1]
      local menu = {}
      menu["*마시기"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          local name = vRP.getItemName({idname})
          if user_id ~= nil then
            if useUserIds[user_id] and useUserIds[user_id] > os.time() - cooltime then
              vRPclient.notify(player, {"~r~잠시 후에 이용가능합니다."})
              return
            end
            if vRP.tryGetInventoryItem({user_id, idname, 1, false}) then
              Dclient.playEffect(player, {30, 5.0})
              useUserIds[user_id] = os.time() + 30
              vRPclient.notify(player, {"~b~" .. name .. " 마심."})
              local seq = {
                {"mp_player_intdrink", "intro_bottle", 1},
                {"mp_player_intdrink", "loop_bottle", 1},
                {"mp_player_intdrink", "outro_bottle", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              TriggerEvent("lucky_potion:drink", user_id, 30)
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.0
  }
}

return cfg
