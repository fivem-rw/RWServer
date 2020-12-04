-- a basic trade implementation

local lang = vRP.lang
local cfg = module("cfg/trades")
local trade_types = cfg.trade_types
local trades = cfg.trades

local trade_menus = {}

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

-- build trade menus
local function build_trade_menus()
  for gtype, mitems in pairs(trade_types) do
    local trade_menu = {
      name = gtype,
      css = {top = "75px", header_color = "rgba(0,255,125,0.75)"}
    }

    -- build trade items
    local kitems = {}

    -- item choice
    local trade_choice = function(player, choice)
      local idname = kitems[choice][1]
      local item = vRP.items[idname]
      local price = kitems[choice][2]
      if item then
        local user_id = vRP.getUserId(player)
        if user_id ~= nil then
          vRP.prompt(
            player,
            item.name .. "을(를) 몇개 판매하시겠습니까?",
            "",
            function(player, amount)
              local amount = parseInt(amount)
              if amount > 0 then
                if vRP.tryGetInventoryItem(user_id, idname, amount, true) then
                  local totalPrice = amount * price
                  vRPclient.notify(player, {"~g~" .. item.name .. "을(를) " .. amount .. "개 판매 해 " .. comma_value(totalPrice) .. "원을 받았습니다!"})
                  vRP.giveMoney(user_id, totalPrice)
                end
              else
                vRPclient.notify(player, {lang.common.invalid_value()})
              end
            end
          )
        end
      end
    end

    for k, v in pairs(mitems) do
      local item = vRP.items[k]
      if item then
        kitems[item.name] = {k, math.max(v, 0)} -- idname/price
        trade_menu[item.name] = {trade_choice, "1개당 판매 가격 : " .. comma_value(v) .. "원"}
      end
    end

    trade_menus[gtype] = trade_menu
  end
end

local first_build = true

local function build_client_trades(source)
  -- prebuild the trade menu once (all items should be defined now)
  if first_build then
    build_trade_menus()
    first_build = false
  end

  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k, v in pairs(trades) do
      local gtype, x, y, z = table.unpack(v)
      local group = trade_types[gtype]
      local menu = trade_menus[gtype]

      if group and menu then -- check trade type
        local gcfg = group._config

        local function trade_enter()
          local user_id = vRP.getUserId(source)
          if user_id ~= nil and vRP.hasPermissions(user_id, gcfg.permissions or {}) then
            vRP.openMenu(source, menu)
          end
        end

        local function trade_leave()
          vRP.closeMenu(source)
        end

        vRPclient.addMarker(source, {x, y, z - 1, 1.2, 1.2, 0.2, 0, 255, 125, 125, 150})

        vRP.setArea(source, "vRP:trade" .. k, x, y, z, 0.6, 1.5, trade_enter, trade_leave)
      end
    end
  end
end

AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    if first_spawn then
      build_client_trades(source)
    end
  end
)

function log(file, info)
  if true then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c") .. " => " .. info .. "\n")
  end
  file:close()
end
