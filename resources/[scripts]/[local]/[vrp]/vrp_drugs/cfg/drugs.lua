--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
local cfg = {}

--[[
TO MAKE A DRUG ADD IT TO cfg.drugs LIKE SO:
  ["itemid"] = {
    name = "Name", -- item name
    desc = "Some description.", -- item description
    choices = function(args) -- create choices
	  local menu = {} -- creates menu
      menu["Choice"] = {function(player,choice) -- menu choice function
  	    local user_id = vRP.getUserId({player}) -- get user id
  	    if user_id ~= nil then -- check user_id not nil
  	      if vRP.tryGetInventoryItem({user_id,"itemid",1,false}) then -- get item
            -- vRP.varyHunger({user_id,30}) -- optional
            -- vRP.varyThirst({user_id,-70}) -- optional
  		    -- vRPclient.varyHealth(player,{10}) -- optional
  		    vRPclient.notify(player,{"~g~Smoking weed."}) -- notify use
  		    local seq = { -- this should be the sequence of animation
  		    }
  		    vRPclient.playAnim(player,{true,seq,false}) -- play animation sequence
  		    SetTimeout(10000,function() -- here a timeout to for effect to start
  		      Dclient.playMovement(player,{"MOVE_M@DRUNK@SLIGHTLYDRUNK",true,true,false,false}) -- start movement effect, check client.lua for info about the function
  		      Dclient.playScreenEffect(player, {"DMT_flight", 120}) -- start screen effect, check client.lua for info about the function
  		    end)
  		    SetTimeout(120000,function() -- here a timeout for movement effect to end, screen effect has timer on function
  			  Dclient.resetMovement(player,{false}) -- stop movement effect
  		    end)
  		    vRP.closeMenu({player}) -- close menu
  		  end
  	    end
  	  end}
	  return menu -- return choices
    end,
	weight = 0.1 -- item weight
  },
]]
cfg.drugs = {
  ["testtest"] = {
    name = "돔 페리뇽 로제",
    desc = "",
    choices = function(args)
      local menu = {}
      menu["Smoke"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "weed", 1, false}) then
              vRPclient.varyHealth(player, {25})
              vRPclient.notify(player, {"~g~Smoking weed."})
              local seq = {
                {"mp_player_int_uppersmoke", "mp_player_int_smoke_enter", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke_exit", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              SetTimeout(
                10000,
                function()
                  Dclient.playMovement(player, {"MOVE_M@DRUNK@SLIGHTLYDRUNK", true, true, false, false})
                  Dclient.playScreenEffect(player, {"DMT_flight", 120})
                end
              )
              SetTimeout(
                120000,
                function()
                  Dclient.resetMovement(player, {false})
                end
              )
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.1
  },
  ["sighmirnoff"] = {
    name = "스미노프",
    desc = "Very strong vodka.",
    choices = function(args)
      local menu = {}
      menu["Drink"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "sighmirnoff", 1, false}) then
              vRP.varyHunger({user_id, 30})
              vRP.varyThirst({user_id, -70})
              vRPclient.varyHealth(player, {10})

              vRPclient.notify(player, {"~b~Drinking Sighmirnoff."})
              local seq = {
                {"mp_player_intdrink", "intro_bottle", 1},
                {"mp_player_intdrink", "loop_bottle", 1},
                {"mp_player_intdrink", "outro_bottle", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              SetTimeout(
                5000,
                function()
                  Dclient.playMovement(player, {"MOVE_M@DRUNK@VERYDRUNK", true, true, false, false})
                  Dclient.playScreenEffect(player, {"Rampage", 120})
                  SetTimeout(
                    120000,
                    function()
                      Dclient.resetMovement(player, {false})
                    end
                  )
                end
              )
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.5
  },
  ["adb"] = {
    name = "아르망 드 브리냑",
    desc = "초고가 샴페인",
    choices = function(args)
      local menu = {}
      menu["마시기"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "adb", 1, false}) then
              vRP.varyHunger({user_id, 30})
              vRP.varyThirst({user_id, -70})
              vRPclient.varyHealth(player, {10})

              vRPclient.notify(player, {"~b~아르망 드 브리냑을 마셨습니다."})
              local seq = {
                {"mp_player_intdrink", "intro_bottle", 1},
                {"mp_player_intdrink", "loop_bottle", 1},
                {"mp_player_intdrink", "outro_bottle", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              SetTimeout(
                5000,
                function()
                  Dclient.playMovement(player, {"MOVE_M@DRUNK@VERYDRUNK", true, true, false, false})
                  Dclient.playScreenEffect(player, {"Rampage", 120})
                  SetTimeout(
                    120000,
                    function()
                      Dclient.resetMovement(player, {false})
                    end
                  )
                end
              )
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 3.2
  },
  ["weed"] = {
    name = "🍂 대마초",
    desc = "뽕맛을 느낄 수 있습니다.",
    choices = function(args)
      local menu = {}
      menu["*태우기"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "weed", 1, false}) then
              vRPclient.varyHealth(player, {25})
              vRPclient.notify(player, {"~g~뽕맛이 느껴진다!!"})
              local seq = {
                {"mp_player_int_uppersmoke", "mp_player_int_smoke_enter", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke", 1},
                {"mp_player_int_uppersmoke", "mp_player_int_smoke_exit", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              SetTimeout(
                10000,
                function()
                  Dclient.playMovement(player, {"MOVE_M@DRUNK@SLIGHTLYDRUNK", true, true, false, false})
                  Dclient.playScreenEffect(player, {"DMT_flight", 120})
                end
              )
              SetTimeout(
                120000,
                function()
                  Dclient.resetMovement(player, {false})
                end
              )
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.1
  },
  ["lsd"] = {
    name = "💫 LSD",
    desc = "뽕맛을 느낄 수 있습니다.",
    choices = function(args)
      local menu = {}
      menu["*흡입하기"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "lsd", 1, false}) then
              vRP.varyHunger({user_id, 30})
              vRP.varyThirst({user_id, -70})
              vRPclient.varyHealth(player, {10})

              vRPclient.notify(player, {"~b~뽕맛이 느껴진다!!"})
              local seq = {
                {"mp_player_intdrink", "intro_bottle", 1},
                {"mp_player_intdrink", "loop_bottle", 1},
                {"mp_player_intdrink", "outro_bottle", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              SetTimeout(
                5000,
                function()
                  Dclient.playMovement(player, {"MOVE_M@DRUNK@VERYDRUNK", true, true, false, false})
                  Dclient.playScreenEffect(player, {"HeistLocate", 120})
                  SetTimeout(
                    120000,
                    function()
                      Dclient.resetMovement(player, {false})
                    end
                  )
                end
              )
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.1
  },
  ["cocaine"] = {
    name = "💫 코카인",
    desc = "뽕맛을 느낄 수 있습니다.",
    choices = function(args)
      local menu = {}
      menu["*흡입하기"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "cocaine", 1, false}) then
              vRP.varyHunger({user_id, 30})
              vRP.varyThirst({user_id, -70})
              vRPclient.varyHealth(player, {25})

              vRPclient.notify(player, {"~b~극한의 뽕맛이 느껴진다!!"})
              local seq = {
                {"mp_player_intdrink", "intro_bottle", 1},
                {"mp_player_intdrink", "loop_bottle", 1},
                {"mp_player_intdrink", "outro_bottle", 1}
              }
              vRPclient.playAnim(player, {true, seq, false})
              SetTimeout(
                5000,
                function()
                  Dclient.playMovement(player, {"MOVE_M@DRUNK@VERYDRUNK", true, true, false, false})
                  Dclient.playScreenEffect(player, {"HeistLocate", 120})
                  Dclient.playScreenEffect(player, {"DMT_flight", 120})
                  SetTimeout(
                    120000,
                    function()
                      Dclient.resetMovement(player, {false})
                    end
                  )
                end
              )
              vRP.closeMenu({player})
            end
          end
        end
      }
      return menu
    end,
    weight = 0.1
  }
}

return cfg
