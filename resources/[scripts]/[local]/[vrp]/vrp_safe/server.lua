MySQL.createCommand = function(name, query)
  if MySQL.commands == nil then
    MySQL.commands = {}
  end
  MySQL.commands[name] = query
end
MySQL.query = function(name, params, callback)
  local query = MySQL.commands[name]
  if params == nil then
    params = {}
  end
  if type(callback) ~= "function" then
    callback = function()
    end
  end
  MySQL.Async.fetchAll(query, params, callback)
end
MySQL.execute = function(name, params, callback)
  local query = MySQL.commands[name]
  if params == nil then
    params = {}
  end
  if type(callback) ~= "function" then
    callback = function()
    end
  end
  MySQL.Async.execute(query, params, callback)
end

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_newbie")
vrp_newbieC = Tunnel.getInterface("vrp_newbie", "vrp_newbie")

vrp_newbieS = {}
Tunnel.bindInterface("vrp_newbie", vrp_newbieS)

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/newbie_bonus_get" .. rand, "SELECT * FROM vrp_newbie_bonus WHERE user_id = @user_id")
MySQL.createCommand("vRP/newbie_bonus_new" .. rand, "INSERT INTO vrp_newbie_bonus(user_id,code) VALUES(@user_id,@code); SELECT LAST_INSERT_ID() AS id")
MySQL.createCommand("vRP/newbie_bonus_update" .. rand, "UPDATE vrp_newbie_bonus SET state = @state WHERE user_id = @user_id")

function vrp_newbieS.callTaxi(x, y, z)
  vRPclient.notify(source, {"~y~택시를 호출했습니다."})
  vRP.sendServiceAlert({source, "택시", x, y, z, "뉴비택시호출"})
end

function vrp_newbieS.getCode()
  local player = source
  local user_id = vRP.getUserId({player})
  local code = nil
  MySQL.query(
    "vRP/newbie_bonus_get" .. rand,
    {user_id = user_id},
    function(rows, affected)
      if #rows > 0 then
        if rows[1].state == 0 then
          code = rows[1].code
        elseif rows[1].state == 1 then
          vRPclient.notify(player, {"~g~이미 인증이 완료되었습니다. 오른쪽에 지원받기에서 지원을 받으세요."})
        elseif rows[1].state == 2 then
          vRPclient.notify(player, {"~w~인증 메세지: ~g~뉴비인증#" .. rows[1].code})
        end
      else
        math.randomseed(os.time())
        code = math.random(111111, 999999)
        MySQL.query(
          "vRP/newbie_bonus_new" .. rand,
          {user_id = user_id, code = code},
          function(rows, affected)
          end
        )
      end
      if code ~= nil then
        vRPclient.notify(player, {"~w~리얼월드 디스코드: ~y~https://discord.gg/realw"})
        vRPclient.notify(player, {"~w~아래의 메세지를 리얼월드 디스코드의 뉴비인증채널에 입력하세요"})
        vRPclient.notify(player, {"~w~입력할 메세지: ~g~뉴비인증#" .. code})
      end
    end
  )
end

function vrp_newbieS.getBonus()
  local player = source
  local user_id = vRP.getUserId({player})
  local code = nil
  MySQL.query(
    "vRP/newbie_bonus_get" .. rand,
    {user_id = user_id},
    function(rows, affected)
      if #rows > 0 then
        if rows[1].state == 0 then
          code = rows[1].code
        elseif rows[1].state == 1 then
          MySQL.execute("vRP/newbie_bonus_update" .. rand, {user_id = user_id, state = 2})
          vRP.giveInventoryItem({user_id, "newbie_box", 3, true})
          vRPclient.notify(player, {"~w~뉴비지원아이템을 받았습니다. 휴대폰에서 가방을 확인하세요."})
        elseif rows[1].state == 2 then
          vRPclient.notify(player, {"~r~이미 뉴비지원아이템을 받았습니다."})
        end
      else
        math.randomseed(os.time())
        code = math.random(111111, 999999)
        MySQL.query(
          "vRP/newbie_bonus_new" .. rand,
          {user_id = user_id, code = code},
          function(rows, affected)
          end
        )
      end
      if code ~= nil then
        vRPclient.notify(player, {"~r~리얼월드 디스코드 인증이 완료 되지 않았습니다."})
      end
    end
  )
end

local rented = {}

local rentCarType = {
  ["rent1"] = {id = "accent", price = 10 * 10000, time = 10 * 60},
  ["rent2"] = {id = "koup", price = 15 * 10000, time = 10 * 60},
  ["rent3"] = {id = "veln", price = 30 * 10000, time = 10 * 60},
  ["rent4"] = {id = "kiagt", price = 40 * 10000, time = 10 * 60},
  ["rent5"] = {id = "genesis", price = 40 * 10000, time = 10 * 60}
}

function vrp_newbieS.rent(type, x, y, z)
  local user_id = vRP.getUserId({source})
  if rented[source] ~= nil and rented[source].endTime < os.time() then
    rented[source] = nil
  end
  if rented[source] == nil then
    local carInfo = rentCarType[type]
    if carInfo ~= nil then
      if vRP.tryPayment({user_id, carInfo.price}) then
        vrp_newbieC.spawnRentCar(source, {carInfo.id, x, y, z, carInfo.time})
      else
        vRPclient.notify(source, {"~r~렌트할 현금이 부족합니다."})
      end
    end
  else
    vRPclient.notify(source, {"~r~이미 렌트한 차량이 있습니다 반납 후 이용해주세요."})
  end
end
function vrp_newbieS.rentDone(netId, carId, time)
  if netId ~= nil then
    rented[source] = {
      carId = carId,
      netId = netId,
      startTime = os.time(),
      endTime = os.time() + time
    }
    vRPclient.notify(source, {"~g~차량을 렌트함."})
  end
end
function vrp_newbieS.rentReturn(netId)
  local done = false
  if netId ~= nil then
    for k, v in pairs(rented) do
      if v.netId == netId then
        rented[k] = nil
        done = true
        break
      end
    end
  end
  if done then
    vrp_newbieC.deleteRentCar(source, {netId})
    vRPclient.notify(source, {"~g~차량을 반납했습니다."})
  else
    vRPclient.notify(source, {"~r~차량을 반납할 수 없습니다."})
  end
end
