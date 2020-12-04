local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")
vRPcs = {}
Tunnel.bindInterface("paycheck", vRPcs)

local zste = 4781
local casino = 281
local sb = 2040
local cbs = 2878
local palace = 3298

function vRPcs.salary()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "helper.paycheck") then
    local pay = 3000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRP.giveInventoryItem(user_id, "special_foodbox", 1, true)
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "스태프 고정 월급", false, "[월급]\n ~g~" .. format_num(pay) .. " 원이 지급 되었습니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~고정 스태프 혜택으로 음식상자 1개가 추가 지급 되었습니다."})
  end
  if vRP.hasPermission(user_id, "staft.bonus") then
    local pay = 2000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "스태프 보너스 월급", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "police1.paycheck") then
    local pay = 7800000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "police2.paycheck") then
    local pay = 6500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "police3.paycheck") then
    local pay = 5750000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "police4.paycheck") then
    local pay = 5200000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "police5.paycheck") then
    local pay = 3940000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "police6.paycheck") then
    local pay = 4680000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "police7.paycheck") then
    local pay = 4420000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "police8.paycheck") then
    local pay = 4200000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "police9.paycheck") then
    local pay = 3900000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  -- 교정본부
  if vRP.hasPermission(user_id, "kys1.paycheck") then
    local pay = 15000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "kys2.paycheck") then
    local pay = 14000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "kys001.paycheck") then
    local pay = 13500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end  
  if vRP.hasPermission(user_id, "kys3.paycheck") then
    local pay = 13000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "kys002.paycheck") then
    local pay = 12500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end  
  if vRP.hasPermission(user_id, "kys4.paycheck") then
    local pay = 12000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end      
  if vRP.hasPermission(user_id, "kys5.paycheck") then
    local pay = 11000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end            
  if vRP.hasPermission(user_id, "kys6.paycheck") then
    local pay = 10000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end       
  if vRP.hasPermission(user_id, "kys7.paycheck") then
    local pay = 9000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end     
  if vRP.hasPermission(user_id, "kys8.paycheck") then
    local pay = 8000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end     
  if vRP.hasPermission(user_id, "kys9.paycheck") then
    local pay = 7000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_AMMUNATION", 1, "리얼월드 경찰청", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end     
  -- EMS Paychecks
  if vRP.hasPermission(user_id, "ems1.paycheck") then
    local pay = 12000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ems2.paycheck") then
    local pay = 11000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ems01.paycheck") then
    local pay = 10000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end  
  if vRP.hasPermission(user_id, "ems3.paycheck") then
    local pay = 9000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ems02.paycheck") then
    local pay = 8000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end  
  if vRP.hasPermission(user_id, "ems4.paycheck") then
    local pay = 7000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ems5.paycheck") then
    local pay = 6500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ems6.paycheck") then
    local pay = 6000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ems7.paycheck") then
    local pay = 5500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ems8.paycheck") then
    local pay = 5000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "emsky.paycheck") then
    local pay = 4000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_CALL911", 1, "리얼월드 의료국", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  -- end EMS Paychecks
  if vRP.hasPermission(user_id, "mafia1.paycheck") then
    local pay = 5000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "mafia2.paycheck") then
    local pay = 4000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "mafia3.paycheck") then
    local pay = 3000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "mafia4.paycheck") then
    local pay = 2000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "mafia5.paycheck") then
    local pay = 1000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "mafia6.paycheck") then
    local pay = 700000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "mafia7.paycheck") then
    local pay = 500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "mafia8.paycheck") then
    local pay = 300000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "마피아", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh1.paycheck") then
    local pay = 5000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh2.paycheck") then
    local pay = 4000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh3.paycheck") then
    local pay = 3000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh4.paycheck") then
    local pay = 2000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh5.paycheck") then
    local pay = 1000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh6.paycheck") then
    local pay = 700000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh7.paycheck") then
    local pay = 500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "shh8.paycheck") then
    local pay = 300000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "삼합회", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "daiso.paycheck") then
    local pay = 10000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_ABIGAIL", 1, "리얼 다이소", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gm1.paycheck") then
    local pay = 10000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_ANDREAS", 1, "에르지오", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gm2.paycheck") then
    local pay = 7000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "에르지오", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gm3.paycheck") then
    local pay = 6000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "에르지오", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gm4.paycheck") then
    local pay = 4000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "에르지오", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gm5.paycheck") then
    local pay = 3000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "에르지오", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gm6.paycheck") then
    local pay = 2000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "에르지오", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gm7.paycheck") then
    local pay = 1100000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "에르지오", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow1.paycheck") then
    local pay = 7500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow2.paycheck") then
    local pay = 5500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow3.paycheck") then
    local pay = 4000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow4.paycheck") then
    local pay = 3500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow5.paycheck") then
    local pay = 3000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow6.paycheck") then
    local pay = 2500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow7.paycheck") then
    local pay = 2000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "tow8.paycheck") then
    local pay = 1500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "월드렉카", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  -- 방송국 팩션 시작
  if vRP.hasPermission(user_id, "realcbs1.paycheck") then
    local pay = 4500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs2.paycheck") then
    local pay = 3500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs3.paycheck") then
    local pay = 3000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs4.paycheck") then
    local pay = 2800000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs5.paycheck") then
    local pay = 2500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs6.paycheck") then
    local pay = 2300000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs7.paycheck") then
    local pay = 2000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs8.paycheck") then
    local pay = 1500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs9.paycheck") then
    local pay = 1300000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "realcbs10.paycheck") then
    local pay = 1000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼문화방송", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  -- 방송국 팩션 종료
  if vRP.hasPermission(user_id, "president1.paycheck") then
    local pay = 20000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 대통령", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "president2.paycheck") then
    local pay = 8000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "대통령 비서", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "president3.paycheck") then
    local pay = 5000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "대통령 경호원", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gov1.paycheck") then
    local pay = 15000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국무총리", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "gov2.paycheck") then
    local pay = 10000000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국회의원", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "citizen.paycheck") then
    local pay = 200000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "실업자 지원금", false, "지원금: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "delivery.paycheck") then
    local pay = 150000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_DAVE", 1, "배달의민족 본사", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "medical.paycheck") then
    local pay = 200000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 의료수송원", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "ups.paycheck") then
    local pay = 100000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 택배기사", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "repair.paycheck") then
    local pay = 250000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_ASHLEY", 1, "마스타 정비 협동조합", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "uber.paycheck") then
    local pay = 250000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_ALL_PLAYERS_CONF", 1, "카카오 택시", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "uber2.paycheck") then
    local pay = 1800000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_ALL_PLAYERS_CONF", 1, "카카오 택시", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "trucker.paycheck") then
    local pay = 500000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 트럭기사", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "domino.paycheck") then
    local pay = 200000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "피자배달부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "trash.paycheck") then
    local pay = 300000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "환경미화원", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  if vRP.hasPermission(user_id, "bankdriver.paycheck") then
    local pay = 200000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
    vRPclient.notify(source, {"~b~현재 소득세율은 8% 입니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "현금호송원", false, "월급: ~g~" .. format_num(pay) .. " 원"})
    vRP.giveBankMoney(user_id, pay - tax)
  end
  --[[if vRP.hasPermission(user_id, "user.paycheck") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼월드 여름축제", false, "~p~[축제 기간 BONUS]\n~w~썸머 페스티벌 상자 1개가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "festival_box", 1, true)
  end ]]     
  if vRP.hasPermission(user_id, "title.gold.paycheck") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "RICH&RICH", false, "~o~[칭호 혜택]\n~w~오래된 금괴 미션 티켓 1개가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "special_goldmticket", 1, true)
  end    
  if vRP.hasPermission(user_id, "redmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 1개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "gift_box", 1, true)
  end
  if vRP.hasPermission(user_id, "acemember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 2개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "gift_box", 2, true)
  end
  if vRP.hasPermission(user_id, "royalmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 3개가 추가 지급 되었습니다."})    
    vRP.giveInventoryItem(user_id, "gift_box", 3, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 음식상자 1개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "special_foodbox", 1, true)
  end
  if vRP.hasPermission(user_id, "noblemember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 4개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "gift_box", 4, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 음식상자 1개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "special_foodbox", 1, true)
  end
  if vRP.hasPermission(user_id, "firstmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 5개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "gift_box", 5, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 음식상자 2개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "special_foodbox", 2, true)
  end
  if vRP.hasPermission(user_id, "firstfmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 6개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "gift_box", 6, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 음식상자 2개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "special_foodbox", 2, true)
  end
  if vRP.hasPermission(user_id, "trinitymember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 7개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "gift_box", 7, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 음식상자 3개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "special_foodbox", 3, true)
  end
  if vRP.hasPermission(user_id, "crownmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 리얼박스 8개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "gift_box", 8, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 음식상자 4개가 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "special_foodbox", 4, true)
  end    
  -- 추첨티켓 임시
  if vRP.hasPermission(user_id, "redmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 매일 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_basic", 1, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 100,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,100000)
  end
  if vRP.hasPermission(user_id, "acemember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 매일 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_basic", 2, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 300,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,300000)
  end
  if vRP.hasPermission(user_id, "royalmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 매일 추첨티켓이 추가 지급 되었습니다."})    
    vRP.giveInventoryItem(user_id, "lottery_ticket_basic", 3, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 600,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,600000)
  end
  if vRP.hasPermission(user_id, "noblemember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 고급 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_advanced", 1, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 1,000,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,1000000)
  end
  if vRP.hasPermission(user_id, "firstmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 고급 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_advanced", 1, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 1,500,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,1500000)
  end
  if vRP.hasPermission(user_id, "firstfmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 고급 추첨티켓이 추가 지급 되었습니다."})
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 2,000,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,2000000)
    vRP.giveInventoryItem(user_id, "lottery_ticket_advanced", 2, true)
  end
  if vRP.hasPermission(user_id, "trinitymember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 VIP 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_vip", 1, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 3,500,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,3500000)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 고급 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_advanced", 1, true)
  end
  if vRP.hasPermission(user_id, "crownmember.money") then
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 박스", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 VIP 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_vip", 1, true)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "리얼 월드", false, "~o~[BONUS MONEY]\n~w~후원등급 혜택으로 5,000,000원이 지급 되었습니다."})
    vRP.giveBankMoney(user_id,5000000)
    vRPclient.notifyPicture(source, {"CHAR_BANK_BOL", 1, "알쏭달쏭 음식상자", false, "~o~[BONUS ITEM]\n~w~후원등급 혜택으로 고급 추첨티켓이 추가 지급 되었습니다."})
    vRP.giveInventoryItem(user_id, "lottery_ticket_advanced", 2, true)
  end   
end

function vRPcs.bonus()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "vip.paycheck") then
    --	vRP.giveBankMoney(user_id,20000)
    vRP.giveCredit(user_id, 1000)
    --vRPclient.notify(source,{"V I P 보너스 : ~g~20,000"})
    vRPclient.notify(source, {"V I P 보너스 : ~g~1,000 크레딧"})
  end
  if vRP.hasPermission(user_id, "premium.paycheck") then
    --	vRP.giveBankMoney(user_id,20000)
    vRP.giveCredit(user_id, 1000)
    --vRPclient.notify(source,{"VIP 보너스 : ~g~20,000"})
    vRPclient.notify(source, {"Premium  보너스 : ~g~1,000 크레딧"})
  end
  if vRP.hasPermission(user_id, "ultimate.paycheck") then
    --	vRP.giveBankMoney(user_id,20000)
    vRP.giveCredit(user_id, 3000)
    --vRPclient.notify(source,{"VIP 보너스 : ~g~20,000"})
    vRPclient.notify(source, {"Ultimate 보너스 : ~g~3,000 크레딧"})
  end
  if vRP.hasPermission(user_id, "diamond.paycheck") then
    --	vRP.giveBankMoney(user_id,20000)
    vRP.giveCredit(user_id, 3500)
    --vRPclient.notify(source,{"VIP 보너스 : ~g~20,000"})
    vRPclient.notify(source, {"다이아몬드 보너스 : ~g~3,500 크레딧"})
  end
  if vRP.hasPermission(user_id, "gold.chatrules") then
    --	vRP.giveBankMoney(user_id,20000)
    vRP.giveCredit(user_id, 1500)
    --vRPclient.notify(source,{"VIP 보너스 : ~g~20,000"})
    vRPclient.notify(source, {"골드 보너스 : ~g~1,500 크레딧"})
  end

  if vRP.hasPermission(user_id, "user.paycheck") then
    local money = vRP.getBankMoney(user_id)
    --local tax = math.ceil(money/100*0.08)
    local health = 5000
    vRP.setBankMoney(user_id, money - health)
    MySQL.execute("vRP/add_hi", {hi = health})
    vRPclient.notify(source, {"건강보험료 : ~r~5,000"})
    if vRP.tryDepositToCompany(user_id, 2040, 18000) then
      vRPclient.notify(source, {"통신비 : ~r~18,000"})
    end
    if money >= 100000000 then
      local tax1 = math.ceil(money / 10000000)
      local tax2 = math.ceil(tax1 * 2000)
      vRP.setBankMoney(user_id, money - tax2)
      MySQL.execute("vRP/add_tax", {statecoffers = tax2})
      vRPclient.notify(source, {"리얼월드 재산세 : ~r~" .. tax2 .. ""})
      if money >= 1000000000 then
        local tax1 = math.ceil(money / 1000000000)
        local tax2 = math.ceil(tax1 * 80000)
        MySQL.execute("vRP/add_tax", {statecoffers = tax2})
      end
    end
  end
end
function vRPcs.chuseok()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "user.paycheck") then
    vRP.giveBankMoney(user_id, 300000)
    vRP.giveInventoryItem(user_id, "randommoney", 3, true)
    vRPclient.notify(source, {"~g~와사비망고가 토사물을 배출하고 도망갔습니다! ~r~확인해보세요!"})
  end
end
function vRPcs.autohottime()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "user.paycheck") then
    vRP.giveBankMoney(user_id, 30000000)
    --vRP.giveInventoryItem(user_id,"randommoney",20,true)
    vRPclient.notify(source, {"핫타임 보상 : \n~g~30,000,000"})
  end
end
function vRPcs.autohottime2()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "user.paycheck") then
    vRP.giveBankMoney(user_id, 100000000)
    vRP.giveInventoryItem({user_id, "randommoney", 10, true})
    vRPclient.notify(source, {"와사비망고 : \n~r~진심으로 죄송합니다."})
  end
end
function vRPcs.army()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "elysiumarmy1.paycheck") then
    local pay = 1400000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy2.paycheck") then
    local pay = 1350000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy3.paycheck") then
    local pay = 1300000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy4.paycheck") then
    local pay = 1200000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy5.paycheck") then
    local pay = 1150000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy6.paycheck") then
    local pay = 1100000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy7.paycheck") then
    local pay = 1060000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy8.paycheck") then
    local pay = 1030000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy9.paycheck") then
    local pay = 990000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy10.paycheck") then
    local pay = 960000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy11.paycheck") then
    local pay = 930000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy12.paycheck") then
    local pay = 900000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy13.paycheck") then
    local pay = 850000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy14.paycheck") then
    local pay = 800000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy15.paycheck") then
    local pay = 750000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy16.paycheck") then
    local pay = 700000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy17.paycheck") then
    local pay = 650000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy18.paycheck") then
    local pay = 600000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
  if vRP.hasPermission(user_id, "elysiumarmy19.paycheck") then
    local pay = 550000
    vRP.giveBankMoney(user_id, tonumber(pay))
    MySQL.execute("vRP/del_army", {army = tonumber(pay)})
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "리얼월드 국방부", false, "월급: ~g~" .. format_num(pay) .. " 원"})
  end
end
function vRPcs.loan()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "user.paycheck") then
    local money = tonumber(vRP.getLoan(user_id))
    local loan = math.ceil(money / 100 * 6)
    local bankmoney = tonumber(vRP.getBankMoney(user_id))
    local CR = vRP.getCR(user_id)
    if money > 0 then
      if bankmoney > 0 then
        vRPclient.notifyPicture(
          source,
          {"CHAR_BANK_MAZE", 1, "리얼월드 중앙은행", false, "대출 이자 6% : ~r~" .. format_num(loan) .. " 원"}
        )
        vRPclient.notify(source, {"은행 대출 이자 : ~r~" .. loan .. ""})
        vRP.setBankMoney(user_id, math.ceil(bankmoney - loan))

        if CR > 1 then
          vRP.setCR(user_id, CR - 0.05)
        else
          if CR <= 1 then
            vRP.setCR(user_id, 1)
            vRPclient.notify(source, {"더 이상 신용등급이 좋아질 수 없습니다!"})
          end
        end
      else
        vRP.setCR(user_id, CR + 0.20)
        vRPclient.notify(source, {"계좌에 이자를 갚을 충분한 금액이 없습니다!"})
        vRPclient.notify(source, {"신용등급이 \n~r~하락~w~하였습니다! ~r~(0.20 포인트)"})
      end
    else
    end
  end
end

function vRPcs.realestate()
  local user_id = vRP.getUserId(source)
  if vRP.hasPermission(user_id, "realestate.clubsakura") then
    local pay = 300000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "Club Sakura", false, "수익: ~g~" .. format_num(pay) .. " 원"})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
  if vRP.hasPermission(user_id, "realestate.lindsaycircusltd") then
    local pay = 160000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(
      source,
      {"CHAR_BANK_MAZE", 1, "Lindsay Circus LTD", false, "수익: ~g~" .. format_num(pay) .. " 원"}
    )
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
  if vRP.hasPermission(user_id, "realestate.northrockfordron") then
    local pay = 70000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(
      source,
      {"CHAR_BANK_MAZE", 1, "North Rockford RON", false, "수익: ~g~" .. format_num(pay) .. " 원"}
    )
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
  if vRP.hasPermission(user_id, "realestate.vclub") then
    local pay = 280000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "V club", false, "수익 ~g~" .. format_num(pay) .. " 원"})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
  if vRP.hasPermission(user_id, "realestate.richmanhotel") then
    local pay = 820000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "Richman Hotel", false, "수익 ~g~" .. format_num(pay) .. " 원"})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
  if vRP.hasPermission(user_id, "realestate.vanillaunicorn") then
    local pay = 340000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(
      source,
      {"CHAR_BANK_MAZE", 1, "Vanilla Unicorn", false, "수익 ~g~" .. format_num(pay) .. " 원"}
    )
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
  if vRP.hasPermission(user_id, "realestate.casino") then
    local pay = 1600000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(source, {"CHAR_BANK_MAZE", 1, "Casino", false, "수익 ~g~" .. format_num(pay) .. " 원"})
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
  if vRP.hasPermission(user_id, "realestate.vinewoodtattooshop") then
    local pay = 20000
    local tax = math.ceil(pay / 100 * 8)
    MySQL.execute("vRP/add_tax", {statecoffers = tax})
    vRP.giveBankMoney(user_id, pay - tax)
    vRPclient.notifyPicture(
      source,
      {"CHAR_BANK_MAZE", 1, "Vinewood Tattoo Shop", false, "수익 ~g~" .. format_num(pay) .. " 원"}
    )
    vRPclient.notify(source, {"리얼월드 소득세 : ~r~" .. tax .. ""})
  end
end

--[[
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if os.date("%X") == "06:00:00" then
        Citizen.Wait(3000)
        TriggerClientEvent("chatMessage", -1, "핫타임 안내", {0, 255, 255}, "^*^4 핫타임이 지급되었습니다!")
        TriggerClientEvent("autohottime", -1)
      end
      if os.date("%X") == "18:30:00" then
        Citizen.Wait(3000)
        TriggerClientEvent("chatMessage", -1, "^4리얼월드 관리팀", {0, 255, 255}, "^*^8 서버 피해 보상이 지급되었습니다.")
        TriggerClientEvent("autohottime2", -1)
      end
      if os.date("%X") == "20:00:00" then
        Citizen.Wait(3000)
        TriggerClientEvent("chatMessage", -1, "핫타임 안내", {0, 255, 255}, "^*^4핫타임 보상이 지급되었어요!")
        TriggerClientEvent("autohottime", -1)
      end
    end
  end
)
]] --
