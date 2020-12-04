local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","prisoner")


-- 블린님 설정 부분
local nodongja = "prison.whitelist" -- 죄수 퍼미션 선언
local jjabsae = "kys.whitelisted" -- 교도관 퍼미션 선언

local ticket = "prison_ticket_1" -- 티켓 아이디
local price = 500000 -- 티켓 한장당 금액
local drillp = 300000 -- 드릴 대여 비용
-- 여기까지

RegisterServerEvent('nodong:getminnerOnPalet')
AddEventHandler('nodong:getminnerOnPalet', function()
	local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
	if vRP.hasPermission({user_id,nodongja}) then
		TriggerClientEvent("nodong:getminnerOnPalet", player)
	else
   vRPclient.notify(player,{"~r~당신은 권한이 없습니다!"})
    end
end)

RegisterServerEvent('nodong:checkper')
AddEventHandler('nodong:checkper', function()
	local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
		if vRP.hasPermission({user_id,nodongja}) then
		TriggerClientEvent("nodong:continue", player)
    vRP.tryFullPayment({user_id,drillp})
     vRPclient.notify(player,{"[ 드릴 대여 ]\n드릴 대여금액 ~r~"..comma_value(drillp).."원~w~이 지불되었습니다."})
	else
   vRPclient.notify(player,{"~r~당신은 권한이 없습니다!"})
    end
end)


RegisterServerEvent('reward:ticket')
AddEventHandler('reward:ticket', function()
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,nodongja}) then
vRP.giveInventoryItem({user_id,ticket, 1})
else
vRPclient.notify(player,{"~r~당신은 권한이 없습니다!"})
end
end)

RegisterServerEvent('ticket:sell')
AddEventHandler('ticket:sell', function()
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id,jjabsae}) then
   local fprice = price*10
if vRP.tryGetInventoryItem({user_id,ticket, 10}) then
vRP.giveBankMoney({user_id,fprice})
vRPclient.notify(user_id,{"[ 티켓 정산 ]\n티켓 정산으로 ~g~"..comma_value(fprice).."원~w~이 입금되었습니다."})
else
vRPclient.notify(user_id,{"~r~티켓이 없습니다."})
end
else
vRPclient.notify(user_id,{"~r~당신은 권한이 없습니다!"})
end
end)

RegisterServerEvent('re:drillp')
AddEventHandler('re:drillp', function()
	local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  local reprice = drillp * 0.65
	if vRP.hasPermission({user_id,nodongja}) then
    vRP.giveBankMoney({user_id,reprice})
  vRPclient.notify(user_id,{"[ 드릴 대여 ]\n드릴 대여 수수료 제외\n~g~"..comma_value(reprice).."원~w~을 돌려받았습니다."})
    end
end)

RegisterServerEvent("check:human")
AddEventHandler("check:human", function(nearRock, modelRock)
	local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  vRPclient.getNearestPlayer(player,{2},function(nplayer)
local nuser_id = vRP.getUserId({nplayer})
      if nuser_id ~= nil then
  vRPclient.notify(player,{"~r~[ 교정 본부 ]~w~\n주변 사람과 거리를 두세요!"})
  vRPclient.notify(player,{"~r~[ 교정 본부 ]~w~\n복사 의심행위로 100초간 노역이 불가능합니다."})
else
  TriggerClientEvent("continue:human", player)
  end
end)
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

--MADE IN REALWORLD 2020 MODERATOR @EUNYUL