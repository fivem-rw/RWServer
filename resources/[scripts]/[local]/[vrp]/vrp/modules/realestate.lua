-- this module describe the home system (experimental, a lot can happen and not being handled)

local lang = vRP.lang
local cfg = module("cfg/realestate")

-- sql

MySQL.createCommand("vRP/get_realestate", "SELECT realestate, number FROM elysium_realestates WHERE user_id = @user_id")
MySQL.createCommand("vRP/get_realestate_owner", "SELECT user_id FROM elysium_realestates WHERE realestate = @realestate AND number = @number")

MySQL.createCommand("vRP/rm_realestate", "DELETE FROM elysium_realestates WHERE user_id = @user_id")
MySQL.createCommand("vRP/set_realestate", "REPLACE INTO elysium_realestates(user_id,realestate,number,party) VALUES(@user_id,@realestate,@number,@party)")

MySQL.createCommand("vRP/get_party_realestate", "SELECT party FROM elysium_realestates WHERE realestate = @realestate") -- api
--
--[[

MySQL.createCommand("vRP/get_money","SELECT party FROM elysium_realestates WHERE realestate = @realstate")


      
      ]] local components = {}

-- cbreturn user address (home and number) or nil
function vRP.getUserRealestate(user_id, cbr)
  local task = Task(cbr)

  MySQL.query(
    "vRP/get_realestate",
    {user_id = user_id},
    function(rows, affected)
      task({rows[1]})
    end
  )
end

-- set user address
function vRP.setUserRealestate(user_id, realestate, number, party)
  MySQL.execute("vRP/set_realestate", {user_id = user_id, realestate = realestate, number = number, party = party})
end

-- remove user address
function vRP.removeUserRealestate(user_id)
  MySQL.execute("vRP/rm_realestate", {user_id = user_id})
end

function vRP.getPartyRealestate(realestate, cbr)
  local task = Task(cbr)
  MySQL.query(
    "vRP/get_party_realestate",
    {realestate = realestate},
    function(rows, affected)
      task({rows[1].party})
    end
  )
end

-- cbreturn user_id or nil
function vRP.getUserByRealestate(realestate, number, cbr)
  local task = Task(cbr)

  MySQL.query(
    "vRP/get_realestate_owner",
    {realestate = realestate, number = number},
    function(rows, affected)
      if #rows > 0 then
        task({rows[1].user_id})
      else
        task()
      end
    end
  )
end

-- find a free address number to buy
-- cbreturn number or nil if no numbers availables
function vRP.findRealestateFreeNumber(realestate, max, cbr)
  local task = Task(cbr)

  local i = 1
  local function search()
    vRP.getUserByRealestate(
      realestate,
      i,
      function(user_id)
        if user_id == nil then -- found
          task({i})
        else -- not found
          i = i + 1
          if i <= max then -- continue search
            search()
          else -- global not found
            task()
          end
        end
      end
    )
  end

  search()
end

-- build the home entry menu
local function build_entry_menu(user_id, realestate_name)
  local realestate = cfg.realestate[realestate_name]
  local menu = {name = realestate_name, css = {top = "75px", header_color = "rgba(0,255,125,0.75)"}}

  menu["부동산 구매"] = {
    function(player, choice)
      vRP.getUserRealestate(
        user_id,
        function(address)
          if address == nil then -- check if not already have a home
            vRP.findRealestateFreeNumber(
              realestate_name,
              realestate.max,
              function(number)
                if number ~= nil then
                  if vRP.tryPayment(user_id, realestate.buy_price) then
                    local tax = math.ceil(realestate.buy_price / 100 * 12)
                    MySQL.execute("vRP/add_tax", {statecoffers = tax})
                    vRP.addUserGroup(user_id, realestate_name)
                    if vRP.hasPermission(user_id, "mafia.realestate") then
                      vRP.setUserRealestate(user_id, realestate_name, number, 1)
                    else
                      if vRP.hasPermission(user_id, "shh.realestate") then
                        vRP.setUserRealestate(user_id, realestate_name, number, 2)
                      else
                        if vRP.hasPermission(user_id, "yakuza.realestate") then
                          vRP.setUserRealestate(user_id, realestate_name, number, 3)
                        else
                          vRP.setUserRealestate(user_id, realestate_name, number, 0)
                        end
                      end
                    end
                    vRPclient.notify(player, {lang.home.buy.bought()})
                  else
                    vRPclient.notify(player, {lang.money.not_enough()})
                  end
                else
                  vRPclient.notify(player, {lang.home.buy.full()})
                end
              end
            )
          else
            vRPclient.notify(player, {lang.home.buy.have_home()})
          end
        end
      )
    end,
    lang.home.buy.description({realestate.buy_price})
  }

  menu["소유중인 조직"] = {
    function(player, choice)
      vRP.getPartyRealestate(
        realestate_name,
        function(party)
          if party == 1 then
            vRPclient.notify(player, {"백사회가 소유 중 입니다."})
          elseif party == 2 then
            vRPclient.notify(player, {"흑사회가 소유 중 입니다."})
          elseif party == 3 then
            vRPclient.notify(player, {"독사회가 소유 중 입니다."})
          else
            vRPclient.notify(player, {"현재 소유하고 있는 조직이 없습니다."})
          end
        end
      )
    end,
    "엔터키로 확인합니다."
  }

  menu["부동산 판매"] = {
    function(player, choice)
      vRP.getUserRealestate(
        user_id,
        function(address)
          if address ~= nil and address.realestate == realestate_name then -- check if already have a home
            -- sold, give sell price, remove address
            vRP.prompt(
              player,
              "부동산을 정말 판매하시겠습니까? 'Y' 'N'",
              "",
              function(player, id)
                if id == "Y" then
                  --vRP.setWhitelisted(id,false)
                  --vRPclient.notify(player,{"un-whitelisted user "..id})
                  vRP.giveMoney(user_id, realestate.sell_price)
                  vRP.removeUserRealestate(user_id)
                  vRP.removeUserGroup(user_id, realestate_name)
                  vRPclient.notify(player, {lang.home.sell.sold()})
                else
                  if id == "N" then
                    vRPclient.notify(player, {"판매가 취소되었습니다."})
                    vRP.closeMenu(player)
                  else
                    vRPclient.notify(player, {"판매가 취소되었습니다."})
                    vRP.closeMenu(player)
                  end
                end
              end
            )
          else
            vRPclient.notify(player, {lang.home.sell.no_home()})
          end
        end
      )
    end,
    lang.home.sell.description({realestate.sell_price})
  }

  return menu
end
--
--[[  menu[lang.home.sell.title()] = {function(player,choice)
    vRP.getUserAddress(user_id, function(address)
      if address ~= nil and address.home == home_name then -- check if already have a home
        -- sold, give sell price, remove address

        vRP.giveMoney(user_id, home.sell_price)
        vRP.removeUserAddress(user_id)
        vRPclient.notify(player,{lang.home.sell.sold()})
      else
        vRPclient.notify(player,{lang.home.sell.no_home()})
      end
    end)
  end, lang.home.sell.description({home.sell_price})}

  return menu
end]] local function entry_enter(
  player,
  area)
  vRP.openMenu(player, menu)
end

local function entry_leave(player, area)
  vRP.closeMenu(player, true)
end

-- build homes entry points
local function build_client_realestate(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    Citizen.CreateThread(
      function()
        for k, v in pairs(cfg.realestate) do
          local x, y, z = table.unpack(v.entry_point)

          local function entry_enter(player, area)
            local user_id = vRP.getUserId(player)
            if user_id ~= nil and vRP.hasPermissions(user_id, v.permissions or {}) then
              vRP.openMenu(source, build_entry_menu(user_id, k))
            end
          end

          local function entry_leave(player, area)
            vRP.closeMenu(player, true)
          end

          vRPclient.addBlip(source, {x, y, z, v.blipid, v.blipcolor, k})
          vRPclient.addMarker(source, {x, y, z - 1, 1.5, 1.5, 0.2, 255, 0, 0, 125, 150})
          vRP.setArea(source, "vRP:home" .. k, x, y, z, 1, 1.5, entry_enter, entry_leave)

          Citizen.Wait(0)
        end
      end
    )
  end
end

AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    if first_spawn then -- first spawn, build homes
      build_client_realestate(source)
    end
  end
)
