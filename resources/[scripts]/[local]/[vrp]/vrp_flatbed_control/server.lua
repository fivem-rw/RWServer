---------------------------------------------------------
------------ VRP FlatbedControl, RealWorld MAC ----------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_flatbed_controlS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_flatbed_control")
vrp_flatbed_controlC = Tunnel.getInterface("vrp_flatbed_control", "vrp_flatbed_control")
Tunnel.bindInterface("vrp_flatbed_control", vrp_flatbed_controlS)

math.randomseed(os.time())
local rand = math.random(1, 100000)

MySQL.createCommand("vRP/flatbed_get_id" .. rand, "SELECT * FROM vrp_user_identities WHERE registration = @plate limit 1")
MySQL.createCommand("vRP/flatbed_direct_get_money" .. rand, "SELECT user_id,wallet,bank FROM vrp_user_moneys WHERE user_id = @user_id")
MySQL.createCommand("vRP/flatbed_direct_pay_wallet" .. rand, "update vrp_user_moneys set wallet = wallet-(@price) WHERE user_id = @user_id")
MySQL.createCommand("vRP/flatbed_direct_pay_bank" .. rand, "update vrp_user_moneys set bank = bank-(@price) WHERE user_id = @user_id")

local price = 5000000
local priceFeeRate = 30

local function paymentDone(player, targetPlayer, pveh, veh, plate, isDiv)
  local user_id = vRP.getUserId({player})
  if not user_id then
    return
  end
  local targetPrice = price
  local price2 = targetPrice - parseInt(targetPrice / 100 * priceFeeRate)
  if isDiv then
    targetPrice = parseInt(targetPrice / 2)
    price2 = parseInt(price2 / 2)
  end
  vRP.giveBankMoney({user_id, price2})
  vRPclient.notify(player, {"~g~" .. plate .. " 차량을 압류했습니다.\n~r~" .. format_num(price2) .. "원을 ~w~받았습니다."})
  if targetPlayer then
    vRPclient.notify(targetPlayer, {"~y~당신의 차량이 압류되었습니다.\n~r~" .. format_num(targetPrice) .. "원이 ~w~지불되었습니다."})
    TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[차량/압류] ^2" .. GetPlayerName(targetPlayer) .. "^0님의 ^2" .. plate .. "^0차량이 압류되었습니다.")
  else
    TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[차량/압류] ^2" .. plate .. "^0차량이 압류되었습니다.")
  end
  vrp_flatbed_controlC.confirmProcess(player, {pveh, veh})
end

function vrp_flatbed_controlS.process(pveh, veh, plate)
  local pveh = pveh
  local veh = veh
  local player = source
  local user_id = vRP.getUserId({player})
  if not user_id then
    return
  end
  if user_id ~= 1 then
  --return
  end

  plate = plate:gsub(" ", "")
  plate = string.sub(plate, 2, string.len(plate))

  if not vRP.hasPermission({user_id, "gm.whitelisted"}) then
    vRPclient.notify(player, {"~r~당신은 차량을 압류할 권한이 없습니다."})
    return
  end

  MySQL.query(
    "vRP/flatbed_get_id" .. rand,
    {plate = plate},
    function(rows, affected)
      if rows and #rows > 0 then
        local userInfo = rows[1]
        local targetUserId = userInfo.user_id
        local targetPlayer = vRP.getUserSource({targetUserId})
        if targetPlayer then
          local tmp = vRP.getUserTmpTable({targetUserId})
          if tmp and parseInt(tmp.wallet) ~= nil and parseInt(tmp.bank) ~= nil then
            if parseInt(tmp.bank) >= price and vRP.tryWithdraw({targetUserId, price}) and vRP.tryPayment({targetUserId, price}) then
              paymentDone(player, targetPlayer, pveh, veh, plate)
            elseif parseInt(tmp.wallet) >= price and vRP.tryPayment({targetUserId, price}) then
              paymentDone(player, targetPlayer, pveh, veh, plate)
            else
              vRP.setBankMoney({targetUserId, tmp.bank - parseInt(price / 2)})
              paymentDone(player, targetPlayer, pveh, veh, plate, true)
            end
          end
        else
          MySQL.query(
            "vRP/flatbed_direct_get_money" .. rand,
            {user_id = targetUserId},
            function(rows, affected)
              if rows and #rows > 0 then
                local userMoneyInfo = rows[1]
                userMoneyInfo.wallet = parseInt(userMoneyInfo.wallet)
                userMoneyInfo.bank = parseInt(userMoneyInfo.bank)
                if userMoneyInfo.bank and userMoneyInfo.bank >= price then
                  MySQL.execute(
                    "vRP/flatbed_direct_pay_bank" .. rand,
                    {
                      user_id = targetUserId,
                      price = price
                    }
                  )
                  paymentDone(player, nil, pveh, veh, plate)
                elseif userMoneyInfo.wallet and userMoneyInfo.wallet >= price then
                  MySQL.execute(
                    "vRP/flatbed_direct_pay_wallet" .. rand,
                    {
                      user_id = targetUserId,
                      price = price
                    }
                  )
                  paymentDone(player, nil, pveh, veh, plate)
                else
                  MySQL.execute(
                    "vRP/flatbed_direct_pay_bank" .. rand,
                    {
                      user_id = targetUserId,
                      price = parseInt(price / 2)
                    }
                  )
                  paymentDone(player, nil, pveh, veh, plate, true)
                end
              end
            end
          )
        end
      end
    end
  )
end
