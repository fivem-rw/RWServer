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
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_basic_menu")
BMclient = Tunnel.getInterface("vrp_basic_menu", "vrp_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barbershop", "vrp_basic_menu")
Tunnel.bindInterface("vrp_basic_menu", vRPbm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local police_cfg = module("vrp", "cfg/police")
local lang = Lang.new(module("vrp", "cfg/lang/" .. cfg.lang) or {})

function vRP.prslog(file, info)
  if true then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c") .. " => " .. info .. "\n")
  end
  file:close()
end

-- LOG FUNCTION
function vRPbm.logInfoToFile(file, info)
  if true then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c") .. " => " .. info .. "\n")
  end
  file:close()
end
-- MAKE CHOICES
--toggle service
local choice_service = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service = "onservice"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service}) then
        vRP.removeUserGroup({user_id, service})
        if vRP.hasMission({player}) then
          vRP.stopMission({player})
        end
        vRPclient.notify(player, {"~r~Off service"})
      else
        vRP.addUserGroup({user_id, service})
        vRPclient.notify(player, {"~g~On service"})
      end
    end
  end,
  "Go on/off service"
}

-- teleport waypoint
local choice_tptowaypoint = {
  function(player, choice)
    TriggerClientEvent("TpToWaypoint", player)
  end,
  "웨이포인트로 텔레포트합니다."
}

-- fix barbershop green hair for now
local ch_fixhair = {
  function(player, choice)
    local custom = {}
    local user_id = vRP.getUserId({player})
    vRP.getUData(
      {
        user_id,
        "vRP:head:overlay",
        function(value)
          if value ~= nil then
            custom = json.decode(value)
            vRPbsC.setOverlay(player, {custom, true})
          end
        end
      }
    )
  end,
  "헤어컷 업데이트"
}

local prison = "kyojung.blips" -- 교도관 퍼미션 선언
local prison2 = "chatrules.subae" -- 죄수 퍼미션 선언

RegisterServerEvent("blips:checkper")
AddEventHandler(
  "blips:checkper",
  function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasPermission({user_id, prison}) then -- 교도관 퍼미션 선언
      TriggerClientEvent("showBlips:ky", player)
      vRPclient.notify(player, {"~g~[ 교정본부 진입 ]~w~\n위치표시가 ~g~활성화~w~ 되었습니다."})
    end
  end
)

RegisterServerEvent("block:checkper")
AddEventHandler(
  "block:checkper",
  function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if vRP.hasPermission({user_id, prison2}) then -- 죄수 퍼미션
      TriggerClientEvent("block:run", player)
      vRPclient.notify(player, {"~r~[ 교정본부 진입 ]~w~\n점프가 ~r~비활성화~w~ 되었습니다."})
    end
  end
)

--toggle blips
local ch_blips = {
  function(player, choice)
    TriggerClientEvent("showBlips", player)
  end,
  "빌립스[ON/OFF]"
}

local spikes = {}
local ch_spikes = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    BMclient.isCloseToSpikes(
      player,
      {},
      function(closeby)
        if closeby and (spikes[player] or vRP.hasPermission({user_id, "admin.spikes"})) then
          BMclient.removeSpikes(player, {})
          spikes[player] = false
        elseif closeby and not spikes[player] and not vRP.hasPermission({user_id, "admin.spikes"}) then
          vRPclient.notify(player, {"~r~한 세트의 스파이크만 운반 할 수 있습니다!"})
        elseif not closeby and spikes[player] and not vRP.hasPermission({user_id, "admin.spikes"}) then
          vRPclient.notify(player, {"~r~한 세트의 스파이크만 배포 할 수 있습니다!"})
        elseif not closeby and (not spikes[player] or vRP.hasPermission({user_id, "admin.spikes"})) then
          BMclient.setSpikesOnGround(player, {})
          spikes[player] = true
        end
      end
    )
  end,
  "Toggle spikes."
}

local ch_sprites = {
  function(player, choice)
    TriggerClientEvent("showSprites", player)
  end,
  "Toggle sprites."
}

local ch_deleteveh = {
  function(player, choice)
    BMclient.deleteVehicleInFrontOrInside(player, {5.0})
  end,
  "Delete nearest car."
}

--client function
local ch_crun = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "Function:",
        "",
        function(player, stringToRun)
          stringToRun = stringToRun or ""
          TriggerClientEvent("RunCode:RunStringLocally", player, stringToRun)
        end
      }
    )
  end,
  "Run client function."
}

function vRPbm.logInfoToFile(file, info)
  if true then
    return
  end
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c") .. " => " .. info .. "\n")
  end
  file:close()
end
local choice_service = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service = "emsservice"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service}) then
        vRP.removeUserGroup({user_id, service})
        vRPclient.notify(player, {"~r~더 이상 호출을 받지 않습니다."})
      else
        vRP.addUserGroup({user_id, service})
        vRPclient.notify(player, {"~g~지금부터 호출을 받을 수 있습니다."})
      end
    end
  end,
  "EMS 호출 ON/OFF"
}

-- 퍼스트렉카 출근/퇴근

local frk_tc01 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local frk_01 = "퍼스트렉카 회장"
    local frk_02 = "퍼스트렉카 회장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, frk_01}) then
        vRP.removeUserGroup({user_id, frk_01})
        vRP.addUserGroup({user_id, frk_02})
        vRPclient.notify(player, {"~r~[퇴근]~w~퍼스트렉카 회장"})
      else
        if vRP.hasGroup({user_id, frk_02}) then
          vRP.removeUserGroup({user_id, frk_01})
          vRP.addUserGroup({user_id, frk_01})
          vRPclient.notify(player, {"~g~[출근]~w~퍼스트렉카 회장"})
        end
      end
    end
  end,
  "[출/퇴근]퍼스트렉카 회장"
}

local frk_tc02 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local frk_03 = "퍼스트렉카 사장"
    local frk_04 = "퍼스트렉카 사장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, frk_03}) then
        vRP.removeUserGroup({user_id, frk_03})
        vRP.addUserGroup({user_id, frk_04})
        vRPclient.notify(player, {"~r~[퇴근]~w~퍼스트렉카 사장"})
      else
        if vRP.hasGroup({user_id, frk_04}) then
          vRP.removeUserGroup({user_id, frk_04})
          vRP.addUserGroup({user_id, frk_03})
          vRPclient.notify(player, {"~g~[출근]~w~퍼스트렉카 사장"})
        end
      end
    end
  end,
  "[출/퇴근]퍼스트렉카 사장"
}

local frk_tc03 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local frk_05 = "퍼스트렉카 부사장"
    local frk_06 = "퍼스트렉카 부사장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, frk_05}) then
        vRP.removeUserGroup({user_id, frk_05})
        vRP.addUserGroup({user_id, frk_06})
        vRPclient.notify(player, {"~r~[퇴근]~w~퍼스트렉카 부사장"})
      else
        if vRP.hasGroup({user_id, frk_06}) then
          vRP.removeUserGroup({user_id, frk_06})
          vRP.addUserGroup({user_id, frk_05})
          vRPclient.notify(player, {"~g~[출근]~w~퍼스트렉카 부사장"})
        end
      end
    end
  end,
  "[출/퇴근]퍼스트렉카 부사장"
}

local frk_tc04 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local frk_07 = "퍼스트렉카 상무이사"
    local frk_08 = "퍼스트렉카 상무이사[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, frk_07}) then
        vRP.removeUserGroup({user_id, frk_07})
        vRP.addUserGroup({user_id, frk_08})
        vRPclient.notify(player, {"~r~[퇴근]~w~퍼스트렉카 상무이사"})
      else
        if vRP.hasGroup({user_id, frk_08}) then
          vRP.removeUserGroup({user_id, frk_08})
          vRP.addUserGroup({user_id, frk_07})
          vRPclient.notify(player, {"~g~[출근]~w~퍼스트렉카 전무이사"})
        end
      end
    end
  end,
  "[출/퇴근]퍼스트렉카 전무이사"
}

local frk_tc05 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local frk_09 = "퍼스트렉카 상무이사"
    local frk_10 = "퍼스트렉카 상무이사[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, frk_09}) then
        vRP.removeUserGroup({user_id, frk_09})
        vRP.addUserGroup({user_id, frk_10})
        vRPclient.notify(player, {"~r~[퇴근]~w~퍼스트렉카 상무이사"})
      else
        if vRP.hasGroup({user_id, frk_10}) then
          vRP.removeUserGroup({user_id, frk_10})
          vRP.addUserGroup({user_id, frk_09})
          vRPclient.notify(player, {"~g~[출근]~w~퍼스트렉카 상무이사"})
        end
      end
    end
  end,
  "[출/퇴근]퍼스트렉카 상무이사"
}

local frk_tc06 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local frk_11 = "퍼스트렉카 사원"
    local frk_12 = "퍼스트렉카 사원[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, frk_11}) then
        vRP.removeUserGroup({user_id, frk_11})
        vRP.addUserGroup({user_id, frk_12})
        vRPclient.notify(player, {"~r~[퇴근]~w~퍼스트렉카 사원"})
      else
        if vRP.hasGroup({user_id, frk_12}) then
          vRP.removeUserGroup({user_id, frk_12})
          vRP.addUserGroup({user_id, frk_11})
          vRPclient.notify(player, {"~g~[출근]~w~퍼스트렉카 사원"})
        end
      end
    end
  end,
  "[출/퇴근]퍼스트렉카 사원"
}

local frk_tc07 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local frk_13 = "퍼스트렉카 인턴"
    local frk_14 = "퍼스트렉카 인턴[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, frk_13}) then
        vRP.removeUserGroup({user_id, frk_13})
        vRP.addUserGroup({user_id, frk_14})
        vRPclient.notify(player, {"~r~[퇴근]~w~퍼스트렉카 인턴"})
      else
        if vRP.hasGroup({user_id, frk_14}) then
          vRP.removeUserGroup({user_id, frk_14})
          vRP.addUserGroup({user_id, frk_13})
          vRPclient.notify(player, {"~g~[출근]~w~퍼스트렉카 인턴"})
        end
      end
    end
  end,
  "[출/퇴근]퍼스트렉카 인턴"
}

-- 교정본부 준비

local kys001_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kys001 = "교정 이사관"
    local kys002 = "교정 이사관[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kys001}) then
        vRP.removeUserGroup({user_id, kys001})
        vRP.addUserGroup({user_id, kys002})
        vRPclient.notify(player, {"~r~[퇴근]~w~교정 이사관"})
      else
        if vRP.hasGroup({user_id, kys002}) then
          vRP.removeUserGroup({user_id, kys002})
          vRP.addUserGroup({user_id, kys001})
          vRPclient.notify(player, {"~g~[출근]~w~교정 이사관"})
        end
      end
    end
  end,
  "[출/퇴근]교정 이사관"
}

local kys002_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kys003 = "서기관"
    local kys004 = "서기관[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kys003}) then
        vRP.removeUserGroup({user_id, kys003})
        vRP.addUserGroup({user_id, kys004})
        vRPclient.notify(player, {"~r~[퇴근]~w~서기관"})
      else
        if vRP.hasGroup({user_id, kys004}) then
          vRP.removeUserGroup({user_id, kys004})
          vRP.addUserGroup({user_id, kys003})
          vRPclient.notify(player, {"~g~[출근]~w~서기관"})
        end
      end
    end
  end,
  "[출/퇴근]서기관"
}

local kys1_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kys1 = "교정 본부장"
    local kys2 = "교정 본부장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kys1}) then
        vRP.removeUserGroup({user_id, kys1})
        vRP.addUserGroup({user_id, kys2})
        vRPclient.notify(player, {"~r~[퇴근]~w~교정 본부장"})
      else
        if vRP.hasGroup({user_id, kys2}) then
          vRP.removeUserGroup({user_id, kys2})
          vRP.addUserGroup({user_id, kys1})
          vRPclient.notify(player, {"~g~[출근]~w~교정 본부장"})
        end
      end
    end
  end,
  "[출/퇴근]교정 본부장"
}

local kys2_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kys3 = "교정 부본부장"
    local kys4 = "교정 부본부장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kys3}) then
        vRP.removeUserGroup({user_id, kys3})
        vRP.addUserGroup({user_id, kys4})
        vRPclient.notify(player, {"~r~[퇴근]~w~교정 부본부장"})
      else
        if vRP.hasGroup({user_id, kys4}) then
          vRP.removeUserGroup({user_id, kys4})
          vRP.addUserGroup({user_id, kys3})
          vRPclient.notify(player, {"~g~[출근]~w~교정 부본부장"})
        end
      end
    end
  end,
  "[출/퇴근]교정 부본부장"
}

local kys3_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kyss5 = "교정 과장"
    local kyss6 = "교정 과장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kyss5}) then
        vRP.removeUserGroup({user_id, kyss5})
        vRP.addUserGroup({user_id, kyss6})
        vRPclient.notify(player, {"~r~[퇴근]~w~교정 과장"})
      else
        if vRP.hasGroup({user_id, kyss6}) then
          vRP.removeUserGroup({user_id, kyss6})
          vRP.addUserGroup({user_id, kyss5})
          vRPclient.notify(player, {"~g~[출근]~w~교정 과장"})
        end
      end
    end
  end,
  "[출/퇴근]교정 과장"
}

local kys4_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kyss7 = "교정관"
    local kyss8 = "교정관[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kyss7}) then
        vRP.removeUserGroup({user_id, kyss7})
        vRP.addUserGroup({user_id, kyss8})
        vRPclient.notify(player, {"~r~[퇴근]~w~교정관"})
      else
        if vRP.hasGroup({user_id, kyss8}) then
          vRP.removeUserGroup({user_id, kyss8})
          vRP.addUserGroup({user_id, kyss7})
          vRPclient.notify(player, {"~g~[출근]~w~교정관"})
        end
      end
    end
  end,
  "[출/퇴근]교정관"
}

local kys5_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kyss9 = "교감"
    local kyss10 = "교감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kyss9}) then
        vRP.removeUserGroup({user_id, kyss9})
        vRP.addUserGroup({user_id, kyss10})
        vRPclient.notify(player, {"~r~[퇴근]~w~교감"})
      else
        if vRP.hasGroup({user_id, kyss10}) then
          vRP.removeUserGroup({user_id, kyss10})
          vRP.addUserGroup({user_id, kyss9})
          vRPclient.notify(player, {"~g~[출근]~w~교감"})
        end
      end
    end
  end,
  "[출/퇴근]교감"
}

local kys6_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kyss11 = "교위관"
    local kyss12 = "교위관[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kyss11}) then
        vRP.removeUserGroup({user_id, kyss11})
        vRP.addUserGroup({user_id, kyss12})
        vRPclient.notify(player, {"~r~[퇴근]~w~교위관"})
      else
        if vRP.hasGroup({user_id, kyss12}) then
          vRP.removeUserGroup({user_id, kyss12})
          vRP.addUserGroup({user_id, kyss11})
          vRPclient.notify(player, {"~g~[출근]~w~교위관"})
        end
      end
    end
  end,
  "[출/퇴근]교위관"
}

local kys7_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kyss13 = "교사관"
    local kyss14 = "교사관[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kyss13}) then
        vRP.removeUserGroup({user_id, kyss13})
        vRP.addUserGroup({user_id, kyss14})
        vRPclient.notify(player, {"~r~[퇴근]~w~교사관"})
      else
        if vRP.hasGroup({user_id, kyss14}) then
          vRP.removeUserGroup({user_id, kyss14})
          vRP.addUserGroup({user_id, kyss13})
          vRPclient.notify(player, {"~g~[출근]~w~교사관"})
        end
      end
    end
  end,
  "[출/퇴근]교사관"
}

local kys8_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kyss15 = "교도관"
    local kyss16 = "교도관[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kyss15}) then
        vRP.removeUserGroup({user_id, kyss15})
        vRP.addUserGroup({user_id, kyss16})
        vRPclient.notify(player, {"~r~[퇴근]~w~교도관"})
      else
        if vRP.hasGroup({user_id, kyss16}) then
          vRP.removeUserGroup({user_id, kyss16})
          vRP.addUserGroup({user_id, kyss15})
          vRPclient.notify(player, {"~g~[출근]~w~교도관"})
        end
      end
    end
  end,
  "[출/퇴근]교도관"
}

local kys9_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local kyss17 = "교정본부 훈련생"
    local kyss18 = "교정본부 훈련생[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, kyss17}) then
        vRP.removeUserGroup({user_id, kyss17})
        vRP.addUserGroup({user_id, kyss18})
        vRPclient.notify(player, {"~r~[퇴근]~w~교정본부 훈련생"})
      else
        if vRP.hasGroup({user_id, kyss18}) then
          vRP.removeUserGroup({user_id, kyss18})
          vRP.addUserGroup({user_id, kyss17})
          vRPclient.notify(player, {"~g~[출근]~w~교정본부 훈련생"})
        end
      end
    end
  end,
  "[출/퇴근]교정본부 훈련생"
}

---

local police1_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service1 = "치안총감"
    local service2 = "치안총감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service1}) then
        vRP.removeUserGroup({user_id, service1})
        vRP.addUserGroup({user_id, service2})
        vRPclient.notify(player, {"~r~치안총감 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service2}) then
          vRP.addUserGroup({user_id, service1})
          vRP.removeUserGroup({user_id, service2})
          vRPclient.notify(player, {"~g~치안총감 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]치안총감"
}

local police2_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service3 = "치안정감"
    local service4 = "치안정감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service3}) then
        vRP.removeUserGroup({user_id, service3})
        vRP.addUserGroup({user_id, service4})
        vRPclient.notify(player, {"~r~치안정감 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service4}) then
          vRP.addUserGroup({user_id, service3})
          vRP.removeUserGroup({user_id, service4})
          vRPclient.notify(player, {"~g~치안정감 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]치안정감"
}

local police3_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service5 = "치안감"
    local service6 = "치안감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service5}) then
        vRP.removeUserGroup({user_id, service5})
        vRP.addUserGroup({user_id, service6})
        vRPclient.notify(player, {"~r~치안감 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service6}) then
          vRP.addUserGroup({user_id, service5})
          vRP.removeUserGroup({user_id, service6})
          vRPclient.notify(player, {"~g~치안감 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]치안감"
}

local polices1_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local servicess1 = "경무관"
    local servicess2 = "경무관[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, servicess1}) then
        vRP.removeUserGroup({user_id, servicess1})
        vRP.addUserGroup({user_id, servicess2})
        vRPclient.notify(player, {"~r~경무관 퇴근완료"})
      else
        if vRP.hasGroup({user_id, servicess2}) then
          vRP.addUserGroup({user_id, servicess1})
          vRP.removeUserGroup({user_id, servicess2})
          vRPclient.notify(player, {"~g~경무관 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]경무관"
}

local police4_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service7 = "경정"
    local service8 = "경정[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service7}) then
        vRP.removeUserGroup({user_id, service7})
        vRP.addUserGroup({user_id, service8})
        vRPclient.notify(player, {"~w~[리얼월드]경정 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service8}) then
          vRP.addUserGroup({user_id, service7})
          vRP.removeUserGroup({user_id, service8})
          vRPclient.notify(player, {"~w~[리얼월드]경정 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]경정"
}

local police5_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service9 = "경감"
    local service10 = "경감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service9}) then
        vRP.removeUserGroup({user_id, service9})
        vRP.addUserGroup({user_id, service10})
        vRPclient.notify(player, {"~w~[리얼월드]경감 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service10}) then
          vRP.addUserGroup({user_id, service9})
          vRP.removeUserGroup({user_id, service10})
          vRPclient.notify(player, {"~w~[리얼월드]경감 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]경감"
}

local police6_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service11 = "경위"
    local service12 = "경위[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service11}) then
        vRP.removeUserGroup({user_id, service11})
        vRP.addUserGroup({user_id, service12})
        vRPclient.notify(player, {"~w~[리얼월드]경위 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service12}) then
          vRP.addUserGroup({user_id, service11})
          vRP.removeUserGroup({user_id, service12})
          vRPclient.notify(player, {"~w~[리얼월드]경위 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]경위"
}

local police7_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service13 = "경사"
    local service14 = "경사[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service13}) then
        vRP.removeUserGroup({user_id, service13})
        vRP.addUserGroup({user_id, service14})
        vRPclient.notify(player, {"~w~[리얼월드]경사 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service14}) then
          vRP.addUserGroup({user_id, service13})
          vRP.removeUserGroup({user_id, service14})
          vRPclient.notify(player, {"~w~[리얼월드]경사 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]경사"
}

local police8_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service15 = "경장"
    local service16 = "경장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service15}) then
        vRP.removeUserGroup({user_id, service15})
        vRP.addUserGroup({user_id, service16})
        vRPclient.notify(player, {"~w~[리얼월드]경장 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service16}) then
          vRP.addUserGroup({user_id, service15})
          vRP.removeUserGroup({user_id, service16})
          vRPclient.notify(player, {"~w~[리얼월드]경장 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]경장"
}

local police9_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service17 = "순경"
    local service18 = "순경[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service17}) then
        vRP.removeUserGroup({user_id, service17})
        vRP.addUserGroup({user_id, service18})
        vRPclient.notify(player, {"~w~[리얼월드]순경 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service18}) then
          vRP.addUserGroup({user_id, service17})
          vRP.removeUserGroup({user_id, service18})
          vRPclient.notify(player, {"~w~[리얼월드]순경 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]순경"
}

local police10_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local blips1 = "파출소장"
    local blips2 = "파출소장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, blips1}) then
        vRP.removeUserGroup({user_id, blips1})
        vRP.addUserGroup({user_id, blips2})
        vRPclient.notify(player, {"~w~[리얼월드]파출소장 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, blips2}) then
          vRP.addUserGroup({user_id, blips1})
          vRP.removeUserGroup({user_id, blips2})
          vRPclient.notify(player, {"~w~[리얼월드]파출소장 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]파출소장"
}

local police10_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local blips3 = "파출대원"
    local blips4 = "파출대원[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, blips3}) then
        vRP.removeUserGroup({user_id, blips3})
        vRP.addUserGroup({user_id, blips4})
        vRPclient.notify(player, {"~w~[리얼월드]파출대원 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, blips4}) then
          vRP.addUserGroup({user_id, blips3})
          vRP.removeUserGroup({user_id, blips4})
          vRPclient.notify(player, {"~w~[리얼월드]파출소장 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]파출소장"
}

-- 스태프 출근 퇴근

local staff_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local staff1 = "스태프"
    local staff2 = "helper"
    local staff3 = "스태프[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, staff1}) then
        vRP.removeUserGroup({user_id, staff1})
        vRP.removeUserGroup({user_id, staff2})
        vRP.addUserGroup({user_id, staff3})
        vRPclient.notify(player, {"~r~스태프 퇴근완료"})
      else
        if vRP.hasGroup({user_id, staff3}) then
          vRP.addUserGroup({user_id, staff1})
          vRP.addUserGroup({user_id, staff2})
          vRP.removeUserGroup({user_id, staff3})
          vRPclient.notify(player, {"~g~스태프 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]스태프"
}

local imstaff_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local staff4 = "임시스태프"
    local staff5 = "helper"
    local staff6 = "임시스태프[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, staff4}) then
        vRP.removeUserGroup({user_id, staff4})
        vRP.removeUserGroup({user_id, staff5})
        vRP.addUserGroup({user_id, staff6})
        vRPclient.notify(player, {"~r~임시스태프 퇴근완료"})
      else
        if vRP.hasGroup({user_id, staff6}) then
          vRP.addUserGroup({user_id, staff4})
          vRP.addUserGroup({user_id, staff5})
          vRP.removeUserGroup({user_id, staff6})
          vRPclient.notify(player, {"~g~임시스태프 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]임시스태프"
}

local staffboss_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local staffboss1 = "스태프장"
    local staffboss2 = "helper"
    local staffboss3 = "스태프장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, staffboss1}) then
        vRP.removeUserGroup({user_id, staffboss1})
        vRP.removeUserGroup({user_id, staffboss2})
        vRP.addUserGroup({user_id, staffboss3})
        vRPclient.notify(player, {"~r~스태프장 퇴근완료"})
      else
        if vRP.hasGroup({user_id, staffboss3}) then
          vRP.addUserGroup({user_id, staffboss1})
          vRP.addUserGroup({user_id, staffboss2})
          vRP.removeUserGroup({user_id, staffboss3})
          vRPclient.notify(player, {"~g~스태프장 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]스태프장"
}

-- 스태프 출근 퇴근 완료

-- EMS 출근 퇴근

local ems01_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service01 = "소방감"
    local service02 = "소방감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service01}) then
        vRP.removeUserGroup({user_id, service01})
        vRP.addUserGroup({user_id, service02})
        vRPclient.notify(player, {"~r~소방감 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service02}) then
          vRP.addUserGroup({user_id, service01})
          vRP.removeUserGroup({user_id, service02})
          vRPclient.notify(player, {"~g~소방감 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방감"
}

local ems02_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service03 = "소방정"
    local service04 = "소방정[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service03}) then
        vRP.removeUserGroup({user_id, service03})
        vRP.addUserGroup({user_id, service04})
        vRPclient.notify(player, {"~r~소방정 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service04}) then
          vRP.addUserGroup({user_id, service03})
          vRP.removeUserGroup({user_id, service04})
          vRPclient.notify(player, {"~g~소방정 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방정"
}

local ems1_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service1 = "소방총감"
    local service2 = "소방총감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service1}) then
        vRP.removeUserGroup({user_id, service1})
        vRP.addUserGroup({user_id, service2})
        vRPclient.notify(player, {"~r~소방총감 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service2}) then
          vRP.addUserGroup({user_id, service1})
          vRP.removeUserGroup({user_id, service2})
          vRPclient.notify(player, {"~g~소방총감 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방총감"
}

local ems2_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service3 = "소방정감"
    local service4 = "소방정감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service3}) then
        vRP.removeUserGroup({user_id, service3})
        vRP.addUserGroup({user_id, service4})
        vRPclient.notify(player, {"~r~소방정감 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service4}) then
          vRP.addUserGroup({user_id, service3})
          vRP.removeUserGroup({user_id, service4})
          vRPclient.notify(player, {"~g~소방정감 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방정감"
}

local ems3_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service5 = "소방준감"
    local service6 = "소방준감[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service5}) then
        vRP.removeUserGroup({user_id, service5})
        vRP.addUserGroup({user_id, service6})
        vRPclient.notify(player, {"~r~소방준감 퇴근완료"})
      else
        if vRP.hasGroup({user_id, service6}) then
          vRP.addUserGroup({user_id, service5})
          vRP.removeUserGroup({user_id, service6})
          vRPclient.notify(player, {"~g~소방준감 출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방준감"
}

local ems4_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service7 = "소방령"
    local service8 = "소방령[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service7}) then
        vRP.removeUserGroup({user_id, service7})
        vRP.addUserGroup({user_id, service8})
        vRPclient.notify(player, {"~w~[리얼월드]소방령 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service8}) then
          vRP.addUserGroup({user_id, service7})
          vRP.removeUserGroup({user_id, service8})
          vRPclient.notify(player, {"~w~[리얼월드]소방령 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방령"
}

local ems5_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service9 = "소방경"
    local service10 = "소방경[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service9}) then
        vRP.removeUserGroup({user_id, service9})
        vRP.addUserGroup({user_id, service10})
        vRPclient.notify(player, {"~w~[리얼월드]소방경 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service10}) then
          vRP.addUserGroup({user_id, service9})
          vRP.removeUserGroup({user_id, service10})
          vRPclient.notify(player, {"~w~[리얼월드]소방경 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방경"
}

local ems6_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service11 = "소방위"
    local service12 = "소방위[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service11}) then
        vRP.removeUserGroup({user_id, service11})
        vRP.addUserGroup({user_id, service12})
        vRPclient.notify(player, {"~w~[리얼월드]소방위 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service12}) then
          vRP.addUserGroup({user_id, service11})
          vRP.removeUserGroup({user_id, service12})
          vRPclient.notify(player, {"~w~[리얼월드]소방위 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방위"
}

local ems7_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service13 = "소방장"
    local service14 = "소방장[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service13}) then
        vRP.removeUserGroup({user_id, service13})
        vRP.addUserGroup({user_id, service14})
        vRPclient.notify(player, {"~w~[리얼월드]소방장 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service14}) then
          vRP.addUserGroup({user_id, service13})
          vRP.removeUserGroup({user_id, service14})
          vRPclient.notify(player, {"~w~[리얼월드]소방장 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방장"
}

local ems8_tc = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local service15 = "소방대원"
    local service16 = "소방대원[퇴근]"
    if user_id ~= nil then
      if vRP.hasGroup({user_id, service15}) then
        vRP.removeUserGroup({user_id, service15})
        vRP.addUserGroup({user_id, service16})
        vRPclient.notify(player, {"~w~[리얼월드]소방대원 ~r~퇴근완료"})
      else
        if vRP.hasGroup({user_id, service16}) then
          vRP.addUserGroup({user_id, service15})
          vRP.removeUserGroup({user_id, service16})
          vRPclient.notify(player, {"~w~[리얼월드]소방대원 ~g~출근완료"})
        end
      end
    end
  end,
  "[출/퇴근]소방대원"
}

--server function
local ch_srun = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "Function:",
        "",
        function(player, stringToRun)
          stringToRun = stringToRun or ""
          TriggerEvent("RunCode:RunStringRemotelly", stringToRun)
        end
      }
    )
  end,
  "Run server function."
}

--police weapons // comment out the weapons if you dont want to give weapons.
local police_weapons = {}
police_weapons["Equip"] = {
  function(player, choice)
    vRPclient.giveWeapons(
      player,
      {
        {
          ["WEAPON_COMBATPISTOL"] = {ammo = 200},
          ["WEAPON_PUMPSHOTGUN"] = {ammo = 200},
          ["WEAPON_NIGHTSTICK"] = {ammo = 200},
          ["WEAPON_STUNGUN"] = {ammo = 200}
        },
        true
      }
    )
    BMclient.setArmour(player, {100, true})
  end
}

--store money
local choice_store_money = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      local amount = vRP.getMoney({user_id})
      if vRP.tryPayment({user_id, amount}) then -- unpack the money
        vRP.giveInventoryItem({user_id, "money", amount, true})
      end
    end
  end,
  "Store your money in your inventory."
}

--medkit storage
local emergency_medkit = {}
emergency_medkit["Take"] = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    vRP.giveInventoryItem({user_id, "medkit", 25, true})
    vRP.giveInventoryItem({user_id, "pills", 25, true})
  end
}

--heal me
local emergency_heal = {}
emergency_heal["Heal"] = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    vRPclient.setHealth(player, {1000})
  end
}

--loot corpse
local choice_loot = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      vRPclient.getNearestPlayer(
        player,
        {10},
        function(nplayer)
          local nuser_id = vRP.getUserId({nplayer})
          if nuser_id ~= nil then
            vRPclient.isInComa(
              nplayer,
              {},
              function(in_coma)
                if in_coma then
                  local revive_seq = {
                    {"amb@medic@standing@kneel@enter", "enter", 1},
                    {"amb@medic@standing@kneel@idle_a", "idle_a", 1},
                    {"amb@medic@standing@kneel@exit", "exit", 1}
                  }
                  vRPbm.logInfoToFile("logs/lootlog.txt", user_id .. " 가 " .. nuser_id .. "을 루팅하였음")
                  vRPclient.playAnim(player, {false, revive_seq, false}) -- anim
                  SetTimeout(
                    15000,
                    function()
                      if math.random(1, 10) == 1 then
                        local ndata = vRP.getUserDataTable({nuser_id})
                        if ndata ~= nil then
                          if ndata.inventory ~= nil then -- gives inventory items
                            vRP.clearInventory({nuser_id})
                            for k, v in pairs(ndata.inventory) do
                              vRP.giveInventoryItem({user_id, k, v.amount, true})
                            end
                          end
                        end
                        local nmoney = vRP.getMoney({nuser_id})
                        if vRP.tryPayment({nuser_id, nmoney}) then
                          vRP.giveMoney({user_id, nmoney})
                        end
                        vRPclient.notify(nplayer, {"~r~근처의 다른 플레이어가 나의 가방에서 소지품을 가져감."})
                        vRPclient.notify(player, {"~g~해당 플레이어 가방의 소지품을 획득했습니다."})
                      else
                        vRPclient.notify(nplayer, {"~g~근처의 다른 플레이어가 나의 가방 탐색을 실패함."})
                        vRPclient.notify(player, {"~r~가방 탐색을 실패하였습니다."})
                      end
                    end
                  )
                  vRPclient.stopAnim(player, {false})
                else
                  vRPclient.notify(player, {lang.emergency.menu.revive.not_in_coma()})
                end
              end
            )
          else
            vRPclient.notify(player, {lang.common.no_player_near()})
          end
        end
      )
    end
  end,
  "근처의 무기력한 플레이어의 가방 소지품을 탐색합니다."
}

-- hack player
local ch_hack = {
  function(player, choice)
    -- get nearest player
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      vRPclient.getNearestPlayer(
        player,
        {25},
        function(nplayer)
          if nplayer ~= nil then
            local nuser_id = vRP.getUserId({nplayer})
            if nuser_id ~= nil then
              -- prompt number
              local nbank = vRP.getBankMoney({nuser_id})
              local amount = math.floor(nbank * 0.01)
              local nvalue = nbank - amount
              if math.random(1, 100) == 1 then
                vRP.setBankMoney({nuser_id, nvalue})
                vRPclient.notify(nplayer, {"Hacked ~r~" .. amount .. "."})
                vRP.giveInventoryItem({user_id, "dirty_money", amount, true})
              else
                vRPclient.notify(nplayer, {"~g~Hacking attempt failed."})
                vRPclient.notify(player, {"~r~Hacking attempt failed."})
              end
            else
              vRPclient.notify(player, {lang.common.no_player_near()})
            end
          else
            vRPclient.notify(player, {lang.common.no_player_near()})
          end
        end
      )
    end
  end,
  "Hack closest player."
}

-- mug player
local ch_mug = {
  function(player, choice)
    -- get nearest player
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      vRPclient.getNearestPlayer(
        player,
        {10},
        function(nplayer)
          if nplayer ~= nil then
            local nuser_id = vRP.getUserId({nplayer})
            if nuser_id ~= nil then
              -- prompt number
              local nmoney = vRP.getMoney({nuser_id})
              local amount = nmoney
              if math.random(1, 3) == 1 then
                if vRP.tryPayment({nuser_id, amount}) then
                  vRPclient.notify(nplayer, {"Mugged ~r~" .. amount .. "."})
                  vRP.giveInventoryItem({user_id, "dirty_money", amount, true})
                else
                  vRPclient.notify(player, {lang.money.not_enough()})
                end
              else
                vRPclient.notify(nplayer, {"~g~Mugging attempt failed."})
                vRPclient.notify(player, {"~r~Mugging attempt failed."})
              end
            else
              vRPclient.notify(player, {lang.common.no_player_near()})
            end
          else
            vRPclient.notify(player, {lang.common.no_player_near()})
          end
        end
      )
    end
  end,
  "Mug closest player."
}

-- drag player
local ch_drag = {
  function(player, choice)
    -- get nearest player
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      vRPclient.getNearestPlayer(
        player,
        {1.5},
        function(nplayer)
          vRPclient.isHandcuffed(
            player,
            {},
            function(handcuffed)
              if handcuffed then
                vRPclient.notify(player, {"당신은 해당 플레이어를 끌고가기 할 수 있는 상태가 아닙니다."})
              else
                if nplayer ~= nil then
                  local nuser_id = vRP.getUserId({nplayer})
                  if nuser_id ~= nil then
                    if not vRP.hasPermission({user_id, "player.ban"}) and vRP.hasPermission({nuser_id, "player.ban"}) then
                      vRPclient.notify(player, {"당신은 해당 플레이어를 끌고갈 수 없습니다."})
                    else
                      TriggerClientEvent("dr:drag", nplayer, player)
                    end
                  else
                    vRPclient.notify(player, {lang.common.no_player_near()})
                  end
                else
                  vRPclient.notify(player, {lang.common.no_player_near()})
                end
              end
            end
          )
        end
      )
    end
  end,
  "근처의 플레이어를 끌고갑니다."
}

-- player check
local choice_player_check = {
  function(player, choice)
    vRPclient.getNearestPlayer(
      player,
      {5},
      function(nplayer)
        local nuser_id = vRP.getUserId({nplayer})
        if nuser_id ~= nil then
          vRPclient.notify(nplayer, {lang.police.menu.check.checked()})
          vRPclient.getWeapons(
            nplayer,
            {},
            function(weapons)
              -- prepare display data (money, items, weapons)
              local money = vRP.getMoney({nuser_id})
              local items = ""
              local data = vRP.getUserDataTable({nuser_id})
              if data and data.inventory then
                for k, v in pairs(data.inventory) do
                  local item_name = vRP.getItemName({k})
                  if item_name then
                    items = items .. "<br />" .. item_name .. " (" .. v.amount .. ")"
                  end
                end
              end

              local weapons_info = ""
              for k, v in pairs(weapons) do
                weapons_info = weapons_info .. "<br />" .. k .. " (" .. v.ammo .. ")"
              end

              vRPclient.setDiv(player, {"police_check", ".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }", lang.police.menu.check.info({money, items, weapons_info})})
              -- request to hide div
              vRP.request(
                {
                  player,
                  lang.police.menu.check.request_hide(),
                  1000,
                  function(player, ok)
                    vRPclient.removeDiv(player, {"police_check"})
                  end
                }
              )
            end
          )
        else
          vRPclient.notify(player, {lang.common.no_player_near()})
        end
      end
    )
  end,
  lang.police.menu.check.description()
}

-- player store weapons
local store_weapons_cd = {}
function storeWeaponsCooldown()
  for user_id, cd in pairs(store_weapons_cd) do
    if cd > 0 then
      store_weapons_cd[user_id] = cd - 1
    end
  end
  SetTimeout(
    1000,
    function()
      storeWeaponsCooldown()
    end
  )
end
storeWeaponsCooldown()
local choice_store_weapons = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if (store_weapons_cd[user_id] == nil or store_weapons_cd[user_id] == 0) and user_id ~= nil then
      store_weapons_cd[user_id] = 5
      vRPclient.getWeapons(
        player,
        {},
        function(weapons)
          for k, v in pairs(weapons) do
            vRP.giveInventoryItem({user_id, "wbody|" .. k, 1, true})
            if v.ammo > 0 then
              vRP.giveInventoryItem({user_id, "wammo|" .. k, v.ammo, true})
            end
          end
          -- clear all weapons
          vRPclient.giveWeapons(player, {{}, true})
        end
      )
    else
      vRPclient.notify(player, {"~r~이미 무기를 가지고 있습니다."})
    end
  end,
  lang.police.menu.store_weapons.description()
}

-- store armor
local choice_store_armor = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      BMclient.getArmour(
        player,
        {},
        function(armour)
          if armour > 95 then
            vRP.giveInventoryItem({user_id, "body_armor", 1, true})
            -- clear armor
            BMclient.setArmour(player, {0, false})
          else
            vRPclient.notify(player, {"~r~손상된 방탄복은 보관할 수 없습니다!"})
          end
        end
      )
    end
  end,
  "손상되지 않은 방탄복을 보관하십시오."
}

local choice_skin_update = {
  function(player, choice)
    local _player = player
    local user_id = vRP.getUserId({_player})
    if user_id ~= nil then
      local data = vRP.getUserDataTable({user_id})
      if data.skinitem_skinid ~= nil then
        local idle_copy = {}
        idle_copy.modelhash = GetHashKey(data.skinitem_skinid)
        vRPclient.setCustomization(_player, {idle_copy})
        vRPclient.notify(_player, {"~g~스킨 착용 업데이트"})
      else
        vRPclient.notify(_player, {"~r~착용한 스킨이 없습니다!"})
      end
    end
  end,
  "스킨의 착용상태를 업데이트 합니다."
}

local choice_mask_update = {
  function(player, choice)
    local _player = player
    local user_id = vRP.getUserId({_player})
    if user_id ~= nil then
      local data = vRP.getUserDataTable({user_id})
      if data.smaskitem_idle ~= nil then
        vRPclient.setSpecialMaskOn(_player, {{id = data.smaskitem_idle}})
        vRPclient.notify(_player, {"~g~마스크 착용 업데이트"})
      else
        vRPclient.notify(_player, {"~r~착용한 마스크가 없습니다!"})
      end
    end
  end,
  "마스크의 착용상태를 업데이트 합니다."
}

local unjailed = {}
local change_jail_time = {}

function jail_clock(target_id, timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k, v in pairs(users) do
    if tonumber(k) == tonumber(target_id) then
      online = true
    end
  end
  if online then
    if change_jail_time[target_id] ~= nil then
      timer = change_jail_time[target_id]
      change_jail_time[target_id] = nil
    end
    if unjailed[target_id] ~= nil then
      timer = 0
      unjailed[target_id] = nil
    end
    if timer > 0 then
      vRPclient.notify(target, {"~r~남은 구금 시간 : " .. timer .. "분"})
      vRP.setUData({tonumber(target_id), "vRP:jail:time", json.encode(timer)})
      SetTimeout(
        60 * 1000,
        function()
          vRP.setHunger({tonumber(target_id), 0})
          vRP.setThirst({tonumber(target_id), 0})
          jail_clock(tonumber(target_id), timer - 1)
        end
      )
    else
      BMclient.loadFreeze(target, {false, true, true})
      SetTimeout(
        10000,
        function()
          BMclient.loadFreeze(target, {false, false, false})
        end
      )
      change_jail_time[target_id] = nil
      unjailed[target_id] = nil
      vRPclient.unjail(target)
      vRPclient.teleport(target, police_cfg.jails_ex.outside)
      vRPclient.setHandcuffed(target, {false})
      vRPclient.notify(target, {"~b~자유를 얻었습니다."})
      TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^6[교정본부알림] ^2" .. GetPlayerName(target) .. " ^0수감자가 자유를 얻었다!")
      vRP.setUData({tonumber(target_id), "vRP:jail:time", json.encode(-1)})
    end
  end
end

-- dynamic jail
local ch_jail = {
  function(player, choice)
    vRPclient.getNearestPlayers(
      player,
      {15},
      function(nplayers)
        local user_list = ""
        for k, v in pairs(nplayers) do
          user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
        end
        if user_list ~= "" or true then
          vRP.prompt(
            {
              player,
              "플레이어ID:" .. user_list,
              "",
              function(player, target_id)
                if target_id ~= nil and target_id ~= "" then
                  local target = vRP.getUserSource({tonumber(target_id)})
                  local target_name = GetPlayerName(target)
                  if target ~= nil then
                    vRP.getUData(
                      {
                        tonumber(target_id),
                        "vRP:jail:time",
                        function(value)
                          if value ~= nil then
                            if player == target then
                              vRPclient.notify(player, {"~r~자신은 구금시킬 수 없습니다."})
                            else
                              custom = json.decode(value)
                              if custom ~= nil and tonumber(custom) > 0 then
                                vRP.prompt(
                                  {
                                    player,
                                    "구금시간변경(분): [현재:" .. tonumber(custom) .. "분]",
                                    "",
                                    function(player, jail_time)
                                      if jail_time ~= nil and jail_time ~= "" then
                                        if tonumber(jail_time) > 10000 then
                                          jail_time = 10000
                                        end
                                        if tonumber(jail_time) < 1 then
                                          jail_time = 1
                                        end
                                        local new_jail_time = tonumber(jail_time)
                                        if new_jail_time < 0 then
                                          new_jail_time = 0
                                        end
                                        change_jail_time[tonumber(target_id)] = new_jail_time
                                        vRP.setUData({tonumber(target_id), "vRP:jail:time", json.encode(new_jail_time)})
                                        vRPclient.notify(player, {"~r~해당 플레이어는 이미 구금상태 입니다."})
                                        vRPclient.notify(player, {"~w~구금 시간을 변경합니다.\n이전: " .. custom .. "분 => 변경: " .. new_jail_time .. "분"})
                                        vRPclient.notify(target, {"~w~구금 시간이 변경되었습니다.\n이전: " .. custom .. "분 => 변경: " .. new_jail_time .. "분"})
                                      else
                                        vRPclient.notify(player, {"~r~구금시간변경 취소."})
                                      end
                                    end
                                  }
                                )
                              else
                                vRP.prompt(
                                  {
                                    player,
                                    "구금시간(분): [최대:10000분]",
                                    "",
                                    function(player, jail_time)
                                      jail_time = tonumber(jail_time)
                                      if jail_time then
                                        if jail_time > 10000 then
                                          jail_time = 10000
                                        end
                                        if jail_time < 1 then
                                          jail_time = 1
                                        end
                                        BMclient.loadFreeze(target, {false, true, true})
                                        SetTimeout(
                                          10000,
                                          function()
                                            BMclient.loadFreeze(target, {false, false, false})
                                          end
                                        )
                                        TriggerClientEvent("dr:undrag", target, player)
                                        vRPclient.notify(player, {"~b~플레이어를 감옥에 보냈습니다. 곧 감옥으로 이송됩니다."})
                                        SetTimeout(
                                          5000,
                                          function()
                                            local jailCoords = police_cfg.jails_ex.inside
                                            vRPclient.jail(target, {jailCoords[1], jailCoords[2], jailCoords[3], 100})
                                            vRPclient.setHandcuffed(target, {true})
                                            vRPclient.notify(target, {"~r~당신은 감옥에 보내졌습니다."})
                                            vRP.setHunger({tonumber(target_id), 0})
                                            vRP.setThirst({tonumber(target_id), 0})
                                            jail_clock(tonumber(target_id), jail_time)
                                            local user_id = vRP.getUserId({player})
                                            local my_name = GetPlayerName(player)
                                            TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^6[교정본부알림] ^0교도소에 ^2" .. GetPlayerName(target) .. "^0 신입이 들어왔다!")
                                            vRPbm.logInfoToFile("logs/jailLog.txt", user_id .. " jailed " .. target_id .. " for " .. jail_time .. " minutes")
                                            vRPbm.sendToDiscord_police(16711680, "구금 보고서", "처리 경찰관 : " .. my_name .. "(" .. user_id .. "번)\n\n구금 수용자 : " .. target_name .. "(" .. target_id .. "번)\n\n구금 시간 : " .. jail_time .. "분", os.date("구금 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
                                          end
                                        )
                                      else
                                        vRPclient.notify(player, {"~r~구금 취소."})
                                      end
                                    end
                                  }
                                )
                              end
                            end
                          end
                        end
                      }
                    )
                  else
                    vRPclient.notify(player, {"~r~해당 ID가 유효하지 않습니다."})
                  end
                else
                  vRPclient.notify(player, {"~r~플레이어ID를 입력해주세요."})
                end
              end
            }
          )
        else
          vRPclient.notify(player, {"~r~근처에 플레이어가 없습니다."})
        end
      end
    )
  end,
  "근처 플레이어를 감옥에 보냅니다."
}

function vRPbm.sendToDiscord_police(color, name, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["url"] = "https://i.imgur.com/xGCgBw1.png",
      ["footer"] = {
        ["text"] = footer
      }
    }
  }
  PerformHttpRequest(
    "https://discordapp.com/api/webhooks/682672364361875465/ej-qwZHLMdNItloaONja528moEk5DiKY4g2gHKP1_5JNHEtw5Ozugjn1hAIlUh2L78_Z",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

-- dynamic unjail
local ch_unjail = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "플레이어ID:",
        "",
        function(player, target_id)
          if target_id ~= nil and target_id ~= "" then
            vRP.getUData(
              {
                tonumber(target_id),
                "vRP:jail:time",
                function(value)
                  if value ~= nil then
                    custom = json.decode(value)
                    local user_id = vRP.getUserId({player})
                    if custom ~= nil and tonumber(custom) > 0 or vRP.hasPermission({user_id, "admin.easy_unjail"}) then
                      local target = vRP.getUserSource({tonumber(target_id)})
                      if target ~= nil and player ~= target then
                        unjailed[tonumber(target_id)] = true
                        vRPclient.notify(player, {"~g~해당 플레이어를 출소 시켰습니다."})
                        vRPclient.notify(target, {"~g~당신은 곧 출소할 예정입니다."})
                        vRPbm.logInfoToFile("logs/jailLog.txt", user_id .. " freed " .. target_id .. " from a " .. custom .. " minutes sentence")
                      else
                        vRPclient.notify(player, {"~r~플레이어ID가 존재하지 않습니다."})
                      end
                    else
                      vRPclient.notify(player, {"~r~해당 플레이어는 구금상태가 아닙니다."})
                    end
                  end
                end
              }
            )
          else
            vRPclient.notify(player, {"~r~플레이어ID를 입력해주세요."})
          end
        end
      }
    )
  end,
  "구금된 플레이어를 풀어줍니다."
}

local unrtalk = {}
local change_rtalk_time = {}

function rtalk_clock(target_id, timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k, v in pairs(users) do
    if tonumber(k) == tonumber(target_id) then
      online = true
    end
  end
  if online then
    if change_rtalk_time[target_id] ~= nil then
      timer = change_rtalk_time[target_id]
      change_rtalk_time[target_id] = nil
    end
    if unrtalk[target_id] ~= nil then
      timer = 0
      unrtalk[target_id] = nil
    end
    if timer > 0 then
      vRPclient.rtalk(target)
      vRPclient.notify(target, {"~r~남은 입막음 시간 : " .. timer .. "분"})
      vRP.setUData({tonumber(target_id), "vRP:rtalk:time", json.encode(timer)})
      SetTimeout(
        60 * 1000,
        function()
          rtalk_clock(tonumber(target_id), timer - 1)
        end
      )
    else
      change_rtalk_time[target_id] = nil
      unrtalk[target_id] = nil
      vRPclient.unrtalk(target)
      vRPclient.notify(target, {"~b~당신의 입막음이 풀렸습니다."})
      vRP.setUData({tonumber(target_id), "vRP:rtalk:time", json.encode(-1)})
    end
  end
end

local ch_rtalk = {
  function(player, choice)
    vRPclient.getNearestPlayers(
      player,
      {15},
      function(nplayers)
        local user_list = ""
        for k, v in pairs(nplayers) do
          user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
        end
        if user_list ~= "" or true then
          vRP.prompt(
            {
              player,
              "플레이어ID:" .. user_list,
              "",
              function(player, target_id)
                if target_id ~= nil and target_id ~= "" then
                  local target = vRP.getUserSource({tonumber(target_id)})
                  local target_name = GetPlayerName(target)
                  if target ~= nil then
                    vRP.getUData(
                      {
                        tonumber(target_id),
                        "vRP:rtalk:time",
                        function(value)
                          if value ~= nil then
                            if player == target then
                              vRPclient.notify(player, {"~r~자신에겐 사용할 수 없습니다."})
                            else
                              custom = json.decode(value)
                              if custom ~= nil and tonumber(custom) > 0 then
                                vRP.prompt(
                                  {
                                    player,
                                    "입막음시간변경(분): [현재:" .. tonumber(custom) .. "분]",
                                    "",
                                    function(player, rtalk_time)
                                      if rtalk_time ~= nil and rtalk_time ~= "" then
                                        if tonumber(rtalk_time) > 10000 then
                                          rtalk_time = 10000
                                        end
                                        if tonumber(rtalk_time) < 1 then
                                          rtalk_time = 1
                                        end
                                        local new_rtalk_time = tonumber(rtalk_time)
                                        if new_rtalk_time < 0 then
                                          new_rtalk_time = 0
                                        end
                                        change_jail_time[tonumber(target_id)] = new_rtalk_time
                                        vRP.setUData({tonumber(target_id), "vRP:rtalk:time", json.encode(new_rtalk_time)})
                                        vRPclient.notify(player, {"~r~해당 플레이어는 이미 입막음상태 입니다."})
                                        vRPclient.notify(player, {"~w~입막음 시간을 변경합니다.\n이전: " .. custom .. "분 => 변경: " .. new_rtalk_time .. "분"})
                                        vRPclient.notify(target, {"~w~입막음 시간이 변경되었습니다.\n이전: " .. custom .. "분 => 변경: " .. new_rtalk_time .. "분"})
                                      else
                                        vRPclient.notify(player, {"~r~입막음시간변경 취소."})
                                      end
                                    end
                                  }
                                )
                              else
                                vRP.prompt(
                                  {
                                    player,
                                    "입막음시간(분): [최대:10000분]",
                                    "",
                                    function(player, rtalk_time)
                                      if rtalk_time ~= nil and rtalk_time ~= "" then
                                        if tonumber(rtalk_time) > 10000 then
                                          rtalk_time = 10000
                                        end
                                        if tonumber(rtalk_time) < 1 then
                                          rtalk_time = 1
                                        end
                                        vRPclient.rtalk(target)
                                        vRPclient.notify(player, {"~b~플레이어의 입을 틀어막았습니다."})
                                        SetTimeout(
                                          1000,
                                          function()
                                            vRPclient.notify(target, {"~r~상대방이 당신의 입을 틀어 막았습니다. 말하기와 채팅이 제한됩니다."})
                                            rtalk_clock(tonumber(target_id), tonumber(rtalk_time))
                                          end
                                        )
                                      else
                                        vRPclient.notify(player, {"~r~입막음 취소."})
                                      end
                                    end
                                  }
                                )
                              end
                            end
                          end
                        end
                      }
                    )
                  else
                    vRPclient.notify(player, {"~r~해당 ID가 유효하지 않습니다."})
                  end
                else
                  vRPclient.notify(player, {"~r~플레이어ID를 입력해주세요."})
                end
              end
            }
          )
        else
          vRPclient.notify(player, {"~r~근처에 플레이어가 없습니다."})
        end
      end
    )
  end,
  "근처 플레이어의 입을 틀어막습니다."
}

local ch_unrtalk = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "플레이어ID:",
        "",
        function(player, target_id)
          if target_id ~= nil and target_id ~= "" then
            vRP.getUData(
              {
                tonumber(target_id),
                "vRP:rtalk:time",
                function(value)
                  if value ~= nil then
                    custom = json.decode(value)
                    local user_id = vRP.getUserId({player})
                    if custom ~= nil and tonumber(custom) > 0 or vRP.hasPermission({user_id, "admin.easy_unjail"}) then
                      local target = vRP.getUserSource({tonumber(target_id)})
                      if target ~= nil then
                        if player == target then
                          vRPclient.notify(player, {"~r~자신에겐 사용할 수 없습니다."})
                        else
                          unrtalk[tonumber(target_id)] = true
                          vRPclient.notify(player, {"~g~해당 플레이어의 입막음을 해제했습니다."})
                          vRPclient.notify(target, {"~g~당신은 곧 입막음이 풀립니다."})
                        end
                      else
                        vRPclient.notify(player, {"~r~플레이어ID가 존재하지 않습니다."})
                      end
                    else
                      vRPclient.notify(player, {"~r~해당 플레이어는 입막음상태가 아닙니다."})
                    end
                  end
                end
              }
            )
          else
            vRPclient.notify(player, {"~r~플레이어ID를 입력해주세요."})
          end
        end
      }
    )
  end,
  "입막음상태의 플레이어를 풀어줍니다."
}

local ch_kys_alarm_on = {
  function(player, choice)
    TriggerEvent("vrp_prisoncontrol:g_alarm_on")
  end,
  "교정국의 긴급알람을 켭니다."
}

local ch_kys_alarm_off = {
  function(player, choice)
    TriggerEvent("vrp_prisoncontrol:g_alarm_off")
  end,
  "교정국의 긴급알람을 끕니다."
}

local ch_kys_screen_on = {
  function(player, choice)
    TriggerEvent("vrp_prisoncontrol:g_screen_on")
  end,
  "교정국의 스크린을 켭니다."
}

local ch_kys_screen_off = {
  function(player, choice)
    TriggerEvent("vrp_prisoncontrol:g_screen_off")
  end,
  "교정국의 스크린을 끕니다."
}

-- (server) called when a logged player spawn to check for vRP:jail in user_data
AddEventHandler(
  "vRP:playerSpawn",
  function(user_id, source, first_spawn)
    local target = vRP.getUserSource({user_id})
    SetTimeout(
      10000,
      function()
        local custom = {}
        vRP.getUData(
          {
            user_id,
            "vRP:jail:time",
            function(value)
              if value ~= nil then
                custom = json.decode(value)
                if custom ~= nil and tonumber(custom) > 0 then
                  local jailCoords = police_cfg.jails_ex.inside
                  vRPclient.jail(target, {jailCoords[1], jailCoords[2], jailCoords[3], 100})
                  vRPclient.setHandcuffed(target, {true})
                  vRP.setHunger({tonumber(user_id), 0})
                  vRP.setThirst({tonumber(user_id), 0})
                  vRPbm.logInfoToFile("logs/jailLog.txt", user_id .. " has been sent back to jail for " .. custom .. " minutes to complete his sentence")
                  jail_clock(tonumber(user_id), tonumber(custom))
                end
              end
            end
          }
        )
        vRP.getUData(
          {
            user_id,
            "vRP:rtalk:time",
            function(value)
              if value ~= nil then
                local dvalue = json.decode(value)
                if dvalue ~= nil and tonumber(dvalue) > 0 then
                  vRPclient.rtalk(target)
                  rtalk_clock(tonumber(user_id), tonumber(dvalue))
                end
              end
            end
          }
        )
      end
    )
  end
)

-- dynamic fine
local ch_fine = {
  function(player, choice)
    vRPclient.getNearestPlayers(
      player,
      {15},
      function(nplayers)
        local user_list = ""
        for k, v in pairs(nplayers) do
          user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. GetPlayerName(k) .. " | "
        end
        if user_list ~= "" then
          vRP.prompt(
            {
              player,
              "가까운 플레이어:" .. user_list,
              "",
              function(player, target_id)
                if target_id ~= nil and target_id ~= "" then
                  vRP.prompt(
                    {
                      player,
                      "금액:",
                      "",
                      function(player, fine)
                        if fine ~= nil and fine ~= "" then
                          fine = tonumber(fine)
                          vRP.prompt(
                            {
                              player,
                              "벌금 사유:",
                              "",
                              function(player, reason)
                                if reason ~= nil and reason ~= "" then
                                  local target = vRP.getUserSource({tonumber(target_id)})
                                  local target_name = GetPlayerName(target)
                                  if target ~= nil then
                                    if fine == nil or fine < 100 then
                                      fine = 100
                                    end
                                    if vRP.tryFullPayment({tonumber(target_id), tonumber(fine)}) then
                                      local user_id = vRP.getUserId({player})
                                      local name = GetPlayerName(player)
                                      local tax = math.ceil(fine / 100 * 90)
                                      vRP.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason, fine})})
                                      vRPclient.notify(player, {lang.police.menu.fine.fined({reason, fine})})
                                      vRPclient.notify(target, {lang.police.menu.fine.notify_fined({reason, fine})})
                                      vRPclient.notify(player, {"벌금의 50% 지급"})
                                      vRP.giveBankMoney({user_id, math.ceil(fine / 100 * 50)})
                                      vRP.addTax({tax})
                                      vRPbm.logInfoToFile("logs/fineLog.txt", user_id .. " fined " .. target_id .. " the amount of " .. fine .. " for " .. reason)
                                      vRPbm.sendToDiscord_police2(16711680, "벌금 보고서", "처리 경찰관: " .. name .. "(" .. user_id .. "번)\n\n벌금 대상 : " .. target_name .. "(" .. target_id .. "번)\n\n벌금 금액: " .. fine .. "원\n\n벌금 사유: " .. reason .. "", os.date("처리 일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
                                      vRP.closeMenu({player})
                                    else
                                      vRPclient.notify(player, {lang.money.not_enough()})
                                    end
                                  else
                                    vRPclient.notify(player, {"~r~해당 ID가 유효하지 않습니다."})
                                  end
                                else
                                  vRPclient.notify(player, {"~r~사유를 적어주세요."})
                                end
                              end
                            }
                          )
                        else
                          vRPclient.notify(player, {"~r~올바르지 않은 금액."})
                        end
                      end
                    }
                  )
                else
                  vRPclient.notify(player, {"~r~플레이어ID를 선택해주세요."})
                end
              end
            }
          )
        else
          vRPclient.notify(player, {"~r~근처에 플레이어가 없습니다."})
        end
      end
    )
  end,
  "플레이어에게 벌금을 부여합니다."
}

function vRPbm.sendToDiscord_police2(color, name, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["url"] = "https://i.imgur.com/xGCgBw1.png",
      ["footer"] = {
        ["text"] = footer
      }
    }
  }
  PerformHttpRequest(
    "https://discordapp.com/api/webhooks/682674167933304890/Vew5e-XRqqPlSDiUiLXZjqeuzPTrZxxyDw5hT1fVQ65yNLgGzx0ErHQv4Axbqz4k5QzX",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

-- improved handcuff
local ch_handcuff = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id == nil then
      return
    end
    vRPclient.getNearestPlayer(
      player,
      {1.5},
      function(nplayer)
        vRPclient.isHandcuffed(
          player,
          {},
          function(handcuffed)
            if handcuffed then
              vRPclient.notify(player, {"당신은 수갑을 채울 수 있는 상태가 아닙니다."})
            else
              local nuser_id = vRP.getUserId({nplayer})
              if nuser_id ~= nil then
                if not vRP.hasPermission({user_id, "player.ban"}) and vRP.hasPermission({nuser_id, "player.ban"}) then
                  vRPclient.notify(player, {"당신은 해당 플레이어에게 수갑을 채울 수 없습니다."})
                else
                  vRPclient.isHandcuffed(
                    nplayer,
                    {},
                    function(handcuffed)
                      if handcuffed ~= nil then
                        vRPclient.toggleHandcuff(nplayer, {not handcuffed})
                        vRPclient.Handcuffer(player, {not handcuffed})
                      end
                    end
                  )
                  vRP.closeMenu({nplayer})
                end
              else
                vRPclient.notify(player, {lang.common.no_player_near()})
              end
            end
          end
        )
      end
    )
  end,
  lang.police.menu.handcuff.description()
}

-- admin god mode
local gods = {}
function task_god()
  SetTimeout(10000, task_god)

  for k, v in pairs(gods) do
    if k and v then
      vRP.setHunger({k, 0})
      vRP.setThirst({k, 0})

      local player = vRP.getUserSource({k})
      if player ~= nil then
        vRPclient.setHealth(player, {200})
      end
    end
  end
end
task_god()

local ch_godmode = {
  function(player, choice)
    local player = player
    local user_id = vRP.getUserId({player})
    if user_id ~= nil then
      if gods[user_id] then
        gods[user_id] = nil
        vRPclient.notify(player, {"~r~무적모드 비활성화"})
      else
        gods[user_id] = true
        vRPclient.notify(player, {"~g~무적모드 활성화"})
      end
    end
  end,
  "무적모드 활성화/비활성화"
}

function vRPbm.chargePhoneNumber(user_id, phone)
  local player = vRP.getUserSource({user_id})
  local directory_name = vRP.getPhoneDirectoryName({user_id, phone})
  if directory_name == "unknown" then
    directory_name = phone
  end
  vRP.prompt(
    {
      player,
      "Amount to be charged to " .. directory_name .. ":",
      "0",
      function(player, charge)
        if charge ~= nil and charge ~= "" and tonumber(charge) > 0 then
          vRP.getUserByPhone(
            {
              phone,
              function(target_id)
                if target_id ~= nil then
                  if charge ~= nil and charge ~= "" then
                    local target = vRP.getUserSource({target_id})
                    if target ~= nil then
                      vRP.getUserIdentity(
                        {
                          user_id,
                          function(identity)
                            local my_directory_name = vRP.getPhoneDirectoryName({target_id, identity.phone})
                            if my_directory_name == "unknown" then
                              my_directory_name = identity.phone
                            end
                            local text = "~b~" .. my_directory_name .. "~w~ is charging you ~r~" .. charge .. "~w~ for his services."
                            vRP.request(
                              {
                                target,
                                text,
                                600,
                                function(req_player, ok)
                                  if ok then
                                    local target_bank = vRP.getBankMoney({target_id}) - tonumber(charge)
                                    local my_bank = vRP.getBankMoney({user_id}) + tonumber(charge)
                                    if target_bank > 0 then
                                      vRP.setBankMoney({user_id, my_bank})
                                      vRP.setBankMoney({target_id, target_bank})
                                      vRPclient.notify(player, {"You charged ~y~" .. charge .. " ~w~from ~b~" .. directory_name .. "~w~ for your services."})
                                      vRPclient.notify(target, {"~b~" .. my_directory_name .. "~w~ charged you ~r~" .. charge .. "~w~ for his services."})
                                      --vRPbm.logInfoToFile("logs/mchargeLog.txt",user_id .. " mobile charged "..target_id.." the amount of " .. charge .. ", user bank post-payment for "..user_id.." equals "..my_bank.." and for "..user_id.." equals "..target_bank)
                                      vRP.closeMenu({player})
                                    else
                                      vRPclient.notify(target, {lang.money.not_enough()})
                                      vRPclient.notify(player, {"~b~" .. directory_name .. "~w~ tried to, but~r~ can't~w~ pay for your services."})
                                    end
                                  else
                                    vRPclient.notify(player, {"~b~" .. directory_name .. "~r~ refused~w~ to pay for your services."})
                                  end
                                end
                              }
                            )
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~You can't make charges to offline players."})
                    end
                  else
                    vRPclient.notify(player, {"~r~Your charge has to have a value."})
                  end
                else
                  vRPclient.notify(player, {"~r~That phone number seems invalid."})
                end
              end
            }
          )
        else
          vRPclient.notify(player, {"~r~The value has to be bigger than 0."})
        end
      end
    }
  )
end

function vRPbm.payPhoneNumber(user_id, phone)
  local player = vRP.getUserSource({user_id})
  local name = GetPlayerName(player)
  local directory_name = vRP.getPhoneDirectoryName({user_id, phone})
  if directory_name == "unknown" then
    directory_name = phone
  end
  vRP.prompt(
    {
      player,
      directory_name .. " 계좌로 보낼 금액을 입력:",
      "",
      function(player, transfer)
        if transfer ~= nil and transfer ~= "" and tonumber(transfer) > 0 then
          vRP.getUserByPhone(
            {
              phone,
              function(target_id)
                local my_bank = vRP.getBankMoney({user_id}) - tonumber(transfer)
                if target_id ~= nil then
                  if my_bank >= 0 then
                    local target = vRP.getUserSource({target_id})
                    local target_name = GetPlayerName(target)
                    if target ~= nil then
                      vRP.setBankMoney({user_id, my_bank})
                      vRPclient.notify(player, {"~g" .. directory_name .. "~You tranfered ~r~$" .. transfer .. " ~g~to ~b~"})
                      local target_bank = vRP.getBankMoney({target_id}) + tonumber(transfer)
                      vRP.setBankMoney({target_id, target_bank})
                      vRPbm.logInfoToFile("logs/mpayLog.txt", user_id .. " mobile paid " .. target_id .. " the amount of " .. transfer .. ", user bank post-payment for " .. user_id .. " equals $" .. my_bank .. " and for " .. user_id .. " equals $" .. target_bank)
                      vRPbm.sendToDiscord_moneybank(16711680, "계좌 이체 내역서", "보내는 사람 : " .. name .. "(" .. user_id .. "번)\n\n받는 사람 : " .. target_name .. "(" .. target_id .. "번)\n\n송금한 금액 : " .. transfer .. "원", os.date("송금일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))
                      vRP.getUserIdentity(
                        {
                          user_id,
                          function(identity)
                            local my_directory_name = vRP.getPhoneDirectoryName({target_id, identity.phone})
                            if my_directory_name == "unknown" then
                              my_directory_name = identity.phone
                            end
                            vRPclient.notify(target, {"~o~[보낸이]\n" .. my_directory_name .. "\n~p~[받은 금액]\n~w~" .. format_num(transfer) .. "원"})
                          end
                        }
                      )
                      vRP.closeMenu({player})
                    else
                      vRPclient.notify(player, {"~r~해당 유저는 로그오프 입니다.."})
                    end
                  else
                    vRPclient.notify(player, {lang.money.not_enough()})
                  end
                else
                  vRPclient.notify(player, {"~r~정확한 계좌번호를 입력해주세요!"})
                end
              end
            }
          )
        else
          vRPclient.notify(player, {"~r~값이 너무 큽니다!"})
        end
      end
    }
  )
end

function vRPbm.sendToDiscord_moneybank(color, name, message, footer)
  local embed = {
    {
      ["color"] = color,
      ["title"] = "**" .. name .. "**",
      ["description"] = message,
      ["url"] = "https://i.imgur.com/xGCgBw1.png",
      ["footer"] = {
        ["text"] = footer
      }
    }
  }
  PerformHttpRequest(
    "https://discordapp.com/api/webhooks/682652392852160521/IziK7O1lHkPZKXfwfjVfQrGhxkKTdSkleJVzb92Li7CbkjLQZf_ziaI_UGelXg0iK90-",
    function(err, text, headers)
    end,
    "POST",
    json.encode({embeds = embed}),
    {["Content-Type"] = "application/json"}
  )
end

-- mobilepay
local ch_mobilepay = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local menu = {}
    menu.name = lang.phone.directory.title()
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player)
      vRP.openMainMenu({player})
    end -- nest menu
    menu["번호 직접 입력"] = {
      -- payment function
      function(player, choice)
        vRP.prompt(
          {
            player,
            "전화번호(계좌):",
            "",
            function(player, phone)
              if phone ~= nil and phone ~= "" then
                vRPbm.payPhoneNumber(user_id, phone)
              else
                vRPclient.notify(player, {"~r~올바르지 않은 전화번호 입니다."})
              end
            end
          }
        )
      end,
      "전화번호(계좌)를 직접 입력합니다."
    }
    local directory = vRP.getPhoneDirectory({user_id})
    for k, v in pairs(directory) do
      menu[k] = {
        -- payment function
        function(player, choice)
          vRPbm.payPhoneNumber(user_id, v)
        end,
        v
      } -- number as description
    end
    vRP.openMenu({player, menu})
  end,
  "돈을 송금합니다."
}

-- mobilecharge
local ch_mobilecharge = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local menu = {}
    menu.name = lang.phone.directory.title()
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player)
      vRP.openMainMenu({player})
    end -- nest menu
    menu["번호 직접 입력"] = {
      -- payment function
      function(player, choice)
        vRP.prompt(
          {
            player,
            "전화번호(계좌) :",
            "",
            function(player, phone)
              if phone ~= nil and phone ~= "" then
                vRPbm.chargePhoneNumber(user_id, phone)
              else
                vRPclient.notify(player, {"~r~올바르지 않은 전화번호 입니다."})
              end
            end
          }
        )
      end,
      "전화번호(계좌)를 직접 입력합니다."
    }
    local directory = vRP.getPhoneDirectory({user_id})
    for k, v in pairs(directory) do
      menu[k] = {
        -- payment function
        function(player, choice)
          vRPbm.chargePhoneNumber(user_id, v)
        end,
        v
      } -- number as description
    end
    vRP.openMenu({player, menu})
  end,
  "Charge money trough phone."
}

-- spawn vehicle
local ch_spawnveh = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "Vehicle Model:",
        "",
        function(player, model)
          if model ~= nil and model ~= "" then
            BMclient.spawnVehicle(player, {model})
          else
            vRPclient.notify(player, {"~r~차량 모델을 입력해야합니다."})
          end
        end
      }
    )
  end,
  "차량을 소환"
}

local ch_loan = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "대상 고유번호",
        "",
        function(player, v)
          v = parseInt(v)
          if v ~= nil then
            local user_id = vRP.getUserId({tonumber(player)})
            local loanlimit = vRP.getLoanLimit({tonumber(v)})
            if user_id ~= nil then
              vRP.prompt(
                {
                  player,
                  "대출 금액 (현재 고객 대출한도: " .. loanlimit .. " )",
                  "",
                  function(player, loan)
                    if loan ~= nil then
                      local target = vRP.getUserSource({tonumber(v)})
                      if target ~= nil then
                        vRP.request(
                          {
                            target,
                            "금융설계사 " .. GetPlayerName(player) .. "님께서 이자 6% " .. loan .. " 대출 계약을 요청합니다.",
                            30,
                            function(target, ok)
                              if ok then
                                local ll = tonumber(vRP.getLoanLimit({tonumber(v)}))
                                local CR = tonumber(vRP.getCR({tonumber(v)}))
                                local loanper = tonumber(loan) / 100 * 6
                                local AL = tonumber(vRP.getLoan({tonumber(v)}))
                                if (tonumber(loan) <= tonumber(ll)) then
                                  vRP.setLoan({v, math.ceil(tonumber(AL) + tonumber(loan) + loanper)})
                                  vRP.setLoanLimit({v, loanlimit - loan})
                                  vRP.setCR({v, CR + 0.10})
                                  vRP.giveBankMoney({v, tonumber(loan)})
                                  vRPclient.notify(player, {"~g~고객이 대출 계약을 수락하였습니다!"})
                                  vRPclient.notify(target, {"~g~대출 계약을 수락하였습니다!"})
                                  vRPclient.notifyPicture(target, {"CHAR_BANK_MAZE", 1, "어비스 중앙은행", false, "대출금 지급 : ~g~" .. loan .. ""})
                                  vRPclient.notify(target, {"대출금 중도 및 전액상환은 ATM에서 가능합니다."})
                                  vRPclient.notify(target, {"대출로 인하여 신용등급이 \n~r~하락~w~하였습니다!\n~r~(0.10 포인트)"})
                                else
                                  vRPclient.notify(player, {"~r~고객의 대출한도가 부족합니다."})
                                  vRPclient.notify(target, {"~r~대출한도가 부족합니다!"})
                                end
                              else
                                vRPclient.notify(player, {"~r~고객이 대출 계약 요청을 거절하였습니다."})
                                vRPclient.notify(target, {"~r~대출 계약 요청을 거절하였습니다."})
                              end
                            end
                          }
                        )
                      else
                      end
                    else
                      vRPclient.notify(player, {"~r~대출 실패"})
                    end
                  end
                }
              )
            end
          else
            vRPclient.notify(player, {"~r~대출 실패"})
          end
        end
      }
    )
  end,
  "대출을 계약합니다."
}

local ch_loanlimitedit = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "대상 고유번호 (기존 대출한도 20% 이내 수정 요망)",
        "",
        function(player, v)
          v = parseInt(v)
          if v ~= nil then
            local user_id = vRP.getUserId({player})
            local loanlimit = tonumber(vRP.getLoanLimit({tonumber(v)}))
            local CR1 = tonumber(vRP.getCR({tonumber(v)}))
            local CR2 = math.ceil(CR1 * 10 ^ 2 - 0.5) / 10 ^ 2
            if user_id ~= nil then
              vRP.prompt(
                {
                  player,
                  "변경할 대출한도 (현재 고객 대출한도/신용등급 : " .. loanlimit .. " " .. CR2 .. " 등급)",
                  "",
                  function(player, newloanlimit)
                    if newloanlimit then
                      --end
                      --end
                      vRP.setLoanLimit({v, math.ceil(tonumber(newloanlimit))})
                      vRPclient.notify(player, {"고객의 대출한도를 \n" .. newloanlimit .. "로 수정하였습니다."})
                    else
                      vRPclient.notify(player, {"~r~조회 실패"})
                    end
                  end
                }
              )
            end
          else
            vRPclient.notify(player, {"~r~조회 실패"})
          end
        end
      }
    )
  end,
  "대출한도를 조정합니다."
}

local ch_CRcheck = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "Vehicle Model:",
        "",
        function(player, target_id)
          if target_id ~= nil and target_id ~= "" then
            local checkCR1 = vRP.getCR({tonumber(target_id)})
            local checkCR2 = math.ceil(checkCR1 * 10 ^ 2 - 0.5) / 10 ^ 2
            vRPclient.notify(player, {"조회하신 고객의 신용등급은\n~y~" .. checkCR2 .. " 등급 ~w~ 입니다."})
          else
            vRPclient.notify(player, {"~r~조회 실패"})
          end
        end
      }
    )
  end,
  "신용등급 조회합니다."
}

local ch_loanlimitcheck = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "Vehicle Model:",
        "",
        function(player, target_id)
          if target_id ~= nil and target_id ~= "" then
            local loanlimit = vRP.getLoanLimit({tonumber(target_id)})
            vRPclient.notify(player, {"조회하신 고객의 대출한도은\n~y~" .. math.ceil(loanlimit) .. " ~w~ 입니다."})
          else
            vRPclient.notify(player, {"~r~조회 실패"})
          end
        end
      }
    )
  end,
  "대출한도를 조회합니다."
}

local ch_loancheck = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "Vehicle Model:",
        "",
        function(player, target_id)
          if target_id ~= nil and target_id ~= "" then
            local loan = vRP.getLoan({tonumber(target_id)})
            vRPclient.notify(player, {"조회하신 고객의 기대출은\n~y~" .. loan .. " ~w~ 입니다."})
          else
            vRPclient.notify(player, {"~r~조회 실패"})
          end
        end
      }
    )
  end,
  "기대출을 조회합니다."
}

local ch_prsaw1 = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "영장발부 사유 :",
        "",
        function(player, reason)
          if reason ~= nil and reason ~= "" then
            local user_id = vRP.getUserId({player})
            vRP.giveInventoryItem({user_id, "aw1", 1, true})
            vRP.prslog("logs/prslog.txt", " " .. user_id .. " 구속영장 | " .. reason)
            vRPclient.notify(player, {"구속영장이 발부되었습니다. 인벤토리를 확인하세요."})
          else
            vRPclient.notify(player, {"~r~발부 실패"})
          end
        end
      }
    )
  end,
  "구속영장을 발부합니다."
}

local ch_prsaw2 = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "영장발부 사유 :",
        "",
        function(player, reason)
          if reason ~= nil and reason ~= "" then
            local user_id = vRP.getUserId({player})
            vRP.giveInventoryItem({user_id, "aw2", 1, true})
            vRP.prslog("logs/prslog.txt", " " .. user_id .. " 체포영장 | " .. reason)
            vRPclient.notify(player, {"체포영장이 발부되었습니다. 인벤토리를 확인하세요."})
          else
            vRPclient.notify(player, {"~r~발부 실패"})
          end
        end
      }
    )
  end,
  "체포영장을 발부합니다."
}

local ch_prsaw3 = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "영장발부 사유 :",
        "",
        function(player, reason)
          if reason ~= nil and reason ~= "" then
            local user_id = vRP.getUserId({player})
            vRP.giveInventoryItem({user_id, "aw3", 1, true})
            vRP.prslog("logs/prslog.txt", " " .. user_id .. " 수색영장 | " .. reason)
            vRPclient.notify(player, {"수색영장이 발부되었습니다. 인벤토리를 확인하세요."})
          else
            vRPclient.notify(player, {"~r~발부 실패"})
          end
        end
      }
    )
  end,
  "수색영장을 발부합니다."
}

local ch_prsaw4 = {
  function(player, choice)
    vRP.prompt(
      {
        player,
        "영장발부 사유 :",
        "",
        function(player, reason)
          if reason ~= nil and reason ~= "" then
            local user_id = vRP.getUserId({player})
            vRP.giveInventoryItem({user_id, "aw4", 1, true})
            vRP.prslog("logs/prslog.txt", " " .. user_id .. " 수배영장 | " .. reason)
            vRPclient.notify(player, {"수배영장이 발부되었습니다. 인벤토리를 확인하세요."})
          else
            vRPclient.notify(player, {"~r~발부 실패"})
          end
        end
      }
    )
  end,
  "수배영장을 발부합니다."
}

local ch_company1 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if vRP.hasPermission({user_id, "elysium.company.akh.executive"}) then
      vRP.getUserCompany(
        {
          1,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
    if vRP.hasPermission({user_id, "elysium.company.kst.executive"}) then
      vRP.getUserCompany(
        {
          4825,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
    if vRP.hasPermission({user_id, "elysium.company.taxi.executive"}) then
      vRP.getUserCompany(
        {
          4728,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
    if vRP.hasPermission({user_id, "elysium.company.zste.executive"}) then
      vRP.getUserCompany(
        {
          4781,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
    if vRP.hasPermission({user_id, "elysium.company.sb.executive"}) then
      vRP.getUserCompany(
        {
          2040,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
    if vRP.hasPermission({user_id, "elysium.company.palace.executive"}) then
      vRP.getUserCompany(
        {
          3298,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
    if vRP.hasPermission({user_id, "elysium.company.cbs.executive"}) then
      vRP.getUserCompany(
        {
          2878,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
    if vRP.hasPermission({user_id, "elysium.company.casino.executive"}) then
      vRP.getUserCompany(
        {
          281,
          function(company)
            if company ~= nil then
              name = htmlEntities.encode(company.name)
              capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 자산 :",
                  capital .. "",
                  function(player, reason)
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
  end,
  "회사 자산을 확인합니다."
}

local ch_company2 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if vRP.hasPermission({user_id, "elysium.company.akh"}) then
      local company_id = 1
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                                vRPclient.notify(player, {"~r~입금 완료."})
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.kst"}) then
      local company_id = 4825
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRPclient.notify(player, {"~r~입금 완료."})
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.zste"}) then
      local company_id = 4781
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRPclient.notify(player, {"~r~입금 완료."})
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.taxi"}) then
      local company_id = 4728
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRPclient.notify(player, {"~r~입금 완료."})
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.sb"}) then
      local company_id = 2040
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRPclient.notify(player, {"~r~입금 완료."})
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.palace"}) then
      local company_id = 3298
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRPclient.notify(player, {"~r~입금 완료."})
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.cbs"}) then
      local company_id = 2878
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRPclient.notify(player, {"~r~입금 완료."})
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.casino"}) then
      local company_id = 281
      vRP.getUserCompany(
        {
          company_id,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에 얼마를 입금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil then
                      vRP.prompt(
                        {
                          player,
                          name .. " 자금의 출처는 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil then
                              if vRP.tryDepositToCompany({user_id, company_id, tonumber(price)}) then
                                vRPclient.notify(player, {"~r~입금 완료."})
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 입금 | " .. reason .. " | 고유번호 " .. user_id)
                              else
                                vRPclient.notify(player, {"~r~입금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~자금 출처를 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~정확한 금액을 입력해주세요."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
  end,
  "법인 계좌에 입금합니다."
}

local ch_company3 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if vRP.hasPermission({user_id, "elysium.company.akh.executive"}) then
      local withdrawcompanyid = 1
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.kst.executive"}) then
      local withdrawcompanyid = 4825
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason .. " | " .. user_id)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.zste.executive"}) then
      local withdrawcompanyid = 6
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason .. " | " .. user_id)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.taxi.executive"}) then
      local withdrawcompanyid = 4728
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason .. " | " .. user_id)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.sb.executive"}) then
      local withdrawcompanyid = 2040
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason .. " | " .. user_id)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.palace.executive"}) then
      local withdrawcompanyid = 3298
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason .. " | " .. user_id)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.cbs.executive"}) then
      local withdrawcompanyid = 2878
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason .. " | " .. user_id)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end

    if vRP.hasPermission({user_id, "elysium.company.casino.executive"}) then
      local withdrawcompanyid = 281
      vRP.getUserCompany(
        {
          withdrawcompanyid,
          function(company)
            if company ~= nil then
              local name = htmlEntities.encode(company.name)
              local capital = htmlEntities.encode(company.capital)
              vRP.prompt(
                {
                  player,
                  name .. " 계좌에서 얼마를 출금하시겠습니까? :",
                  "",
                  function(player, price)
                    if price ~= nil and tonumber(price) <= tonumber(capital) then
                      vRP.prompt(
                        {
                          player,
                          name .. " 사용 목적은 어떻게 됩니까? :",
                          "",
                          function(player, reason)
                            if reason ~= nil or reason == "" then
                              if vRP.tryWithdrawToCompany({user_id, withdrawcompanyid, tonumber(price)}) then
                                vRP.prslog("logs/companylog.txt", name .. " " .. price .. " 출금 | " .. reason .. " | " .. user_id)
                                vRPclient.notify(player, {"~r~출금 완료."})
                              else
                                vRPclient.notify(player, {"~r~출금 실패."})
                              end
                            else
                              vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                            end
                          end
                        }
                      )
                    else
                      vRPclient.notify(player, {"~r~회사 자산이 부족하거나 잘못된 금액입니다."})
                    end
                  end
                }
              )
            else
              vRPclient.notify(player, {"~r~회사를 소유하고 있지 않습니다."})
            end
          end
        }
      )
    end
  end,
  "법인 계좌에서 출금합니다."
}

local ch_president1 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    vRP.getTax(
      {
        function(tax)
          alltax = tonumber(tax.statecoffers)
          if alltax ~= nil then
            vRP.prompt(
              {
                player,
                "국고 :",
                alltax .. "",
                function(player, reason)
                end
              }
            )
          else
          end
        end
      }
    )
  end,
  "정부 예산을 확인합니다."
}

local ch_president2 = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    vRP.getTax(
      {
        function(tax)
          alltax = tonumber(tax.statecoffers)
          vRP.prompt(
            {
              player,
              "국고에서 얼마를 출금하시겠습니까? 최대 " .. alltax .. " :",
              "",
              function(player, price)
                if price ~= nil and tonumber(price) <= alltax then
                  vRP.prompt(
                    {
                      player,
                      "사용 목적은 어떻게 됩니까? :",
                      "",
                      function(player, reason)
                        if reason ~= nil then
                          if vRP.tryWithdrawToTax({user_id, tonumber(price)}) then
                            vRP.prslog("logs/taxlog.txt", "총리부 국고 | " .. price .. " 출금 | " .. reason)
                            vRPclient.notify(player, {"~r~출금 완료."})
                          else
                            vRPclient.notify(player, {"~r~출금 실패."})
                          end
                        else
                          vRPclient.notify(player, {"~r~사용 목적을 정확히 입력해주세요."})
                        end
                      end
                    }
                  )
                else
                  vRPclient.notify(player, {"~r~국고가 부족하거나 잘못된 금액입니다."})
                end
              end
            }
          )
        end
      }
    )
  end,
  "정부 예산을 출금합니다."
}

-- lockpick vehicle
local ch_lockpickveh = {
  function(player, choice)
    BMclient.lockpickVehicle(player, {20, true}) -- 20s to lockpick, allow to carjack unlocked vehicles (has to be true for NoCarJack Compatibility)
  end,
  "Lockpick closest vehicle."
}

-- dynamic freeze
local ch_freeze = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    if vRP.hasPermission({user_id, "admin.bm_freeze"}) then
      vRP.prompt(
        {
          player,
          "Player ID:",
          "",
          function(player, target_id)
            if target_id ~= nil and target_id ~= "" then
              local target = vRP.getUserSource({tonumber(target_id)})
              if target ~= nil then
                vRPclient.notify(player, {"~g~해당 플레이어를 고정 동결/해제 했습니다."})
                BMclient.loadFreeze(target, {true, true, true})
              else
                vRPclient.notify(player, {"~r~해당 ID가 유효하지 않습니다."})
              end
            else
              vRPclient.notify(player, {"~r~플레이어ID를 입력해주세요."})
            end
          end
        }
      )
    else
      vRPclient.getNearestPlayer(
        player,
        {10},
        function(nplayer)
          local nuser_id = vRP.getUserId({nplayer})
          if nuser_id ~= nil then
            vRPclient.notify(player, {"~g~해당 플레이어를 고정 동결/해제 했습니다."})
            BMclient.loadFreeze(nplayer, {true, false, false})
          else
            vRPclient.notify(player, {lang.common.no_player_near()})
          end
        end
      )
    end
  end,
  "플레이어를 얼립니다."
}

-- lockpicking item
vRP.defInventoryItem(
  {
    "lockpicking_kit",
    "Lockpicking Kit",
    "Used to lockpick vehicles.", -- add it for sale to vrp/cfg/markets.lua if you want to use it
    function(args)
      local choices = {}

      choices["Lockpick"] = {
        function(player, choice)
          local user_id = vRP.getUserId({player})
          if user_id ~= nil then
            if vRP.tryGetInventoryItem({user_id, "lockpicking_kit", 1, true}) then
              BMclient.lockpickVehicle(player, {20, true}) -- 20s to lockpick, allow to carjack unlocked vehicles (has to be true for NoCarJack Compatibility)
              vRP.closeMenu({player})
            end
          end
        end,
        "Lockpick closest vehicle."
      }

      return choices
    end,
    5.00
  }
)

-- ADD STATIC MENU CHOICES // STATIC MENUS NEED TO BE ADDED AT vRP/cfg/gui.lua
vRP.addStaticMenuChoices({"police_weapons", police_weapons}) -- police gear
vRP.addStaticMenuChoices({"emergency_medkit", emergency_medkit}) -- pills and medkits
vRP.addStaticMenuChoices({"emergency_heal", emergency_heal}) -- heal button

-- REMEMBER TO ADD THE PERMISSIONS FOR WHAT YOU WANT TO USE
-- CREATES PLAYER SUBMENU AND ADD CHOICES

local ch_loan_menu = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local menu = {}
    menu.name = "LOAN"
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player)
      vRP.openMainMenu({player})
    end -- nest menu

    if vRP.hasPermission({user_id, "elysium.bankjob"}) then
      menu["기대출 조회"] = ch_loancheck
    end

    if vRP.hasPermission({user_id, "elysium.bankjob"}) then
      menu["대출한도 조회"] = ch_loanlimitcheck
    end

    if vRP.hasPermission({user_id, "elysium.bankjob"}) then
      menu["신용등급 조회"] = ch_CRcheck
    end

    if vRP.hasPermission({user_id, "elysium.bankjob"}) then
      menu["대출한도 조정"] = ch_loanlimitedit
    end

    if vRP.hasPermission({user_id, "elysium.bankjob"}) then
      menu["대출 계약"] = ch_loan
    end

    vRP.openMenu({player, menu})
  end
}

local ch_company_menu = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local menu = {}
    if vRP.hasPermission({user_id, "elysium.company.akh"}) then
      companyid = 1
    end
    if vRP.hasPermission({user_id, "elysium.company.kst"}) then
      companyid = 4825
    end
    if vRP.hasPermission({user_id, "elysium.company.zste"}) then
      companyid = 6
    end
    if vRP.hasPermission({user_id, "elysium.company.sb"}) then
      companyid = 2040
    end
    if vRP.hasPermission({user_id, "elysium.company.palace"}) then
      companyid = 3298
    end
    if vRP.hasPermission({user_id, "elysium.company.cbs"}) then
      companyid = 4912
    end
    if vRP.hasPermission({user_id, "elysium.company.casino"}) then
      companyid = 281
    end
    if vRP.hasPermission({user_id, "elysium.company.taxi"}) then
      companyid = 4728
    end
    vRP.getUserCompany(
      {
        companyid,
        function(company)
          menu.name = company.name
          menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
          menu.onclose = function(player)
            vRP.openMainMenu({player})
          end -- nest menu

          if vRP.hasPermission({user_id, "elysium.company.ceo"}) then
            menu["법인 계좌 조회"] = ch_company1
          end

          if vRP.hasPermission({user_id, "elysium.company"}) then
            menu["법인 계좌 입금"] = ch_company2
          end

          if vRP.hasPermission({user_id, "elysium.company.ceo"}) then
            menu["법인 계좌 출금"] = ch_company3
          end
          vRP.openMenu({player, menu})
        end
      }
    )
  end
}

local ch_prs_menu = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local menu = {}
    menu.name = "검찰"
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player)
      vRP.openMainMenu({player})
    end -- nest menu

    if vRP.hasPermission({user_id, "elysium.prsjob"}) then
      menu["구속영장 발부"] = ch_prsaw1
    end

    if vRP.hasPermission({user_id, "elysium.prsjob"}) then
      menu["체포영장 발부"] = ch_prsaw2
    end

    if vRP.hasPermission({user_id, "elysium.prsjob"}) then
      menu["수색영장 발부"] = ch_prsaw3
    end

    if vRP.hasPermission({user_id, "elysium.prsjob"}) then
      menu["수배영장 발부"] = ch_prsaw4
    end

    vRP.openMenu({player, menu})
  end
}

local ch_president_menu = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local menu = {}
    menu.name = "총리부"
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player)
      vRP.openMainMenu({player})
    end -- nest menu

    if vRP.hasPermission({user_id, "elysium.president"}) then
      menu["예산 조회"] = ch_president1
    end

    if vRP.hasPermission({user_id, "elysium.president"}) then
      menu["예산 출금"] = ch_president2
    end

    vRP.openMenu({player, menu})
  end
}

local ch_player_menu = {
  function(player, choice)
    local user_id = vRP.getUserId({player})
    local menu = {}
    menu.name = "플레이어"
    menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player)
      vRP.openMainMenu({player})
    end -- nest menu

    if vRP.hasPermission({user_id, "player.store_weapons"}) or true then
      menu["헤어컷 업데이트"] = ch_fixhair
    end

    if vRP.hasPermission({user_id, "player.store_weapons"}) or true then
      menu["무기 가방에넣기"] = choice_store_weapons -- store player weapons, like police store weapons from vrp
    end

    if vRP.hasPermission({user_id, "player.store_armor"}) or true then
      menu["방탄복 가방에넣기"] = choice_store_armor -- store player armor
    end

    if vRP.hasPermission({user_id, "player.store_weapons"}) or true then
      menu["스킨 착용 업데이트"] = choice_skin_update
    end

    if vRP.hasPermission({user_id, "player.store_weapons"}) or true then
      menu["마스크 착용 업데이트"] = choice_mask_update
    end

    if vRP.hasPermission({user_id, "player.loot"}) then
    --menu["소지품 탐색"] = choice_loot -- take the items of nearest player in coma
    end

    if vRP.hasPermission({user_id, "mugger.mug"}) then
    --menu["머그"] = ch_mug -- steal nearest player wallet
    end

    if vRP.hasPermission({user_id, "hacker.hack"}) then
    --menu["계좌 해킹"] = ch_hack --  1 in 100 chance of stealing 1% of nearest player bank
    end

    if vRP.hasPermission({user_id, "carjacker.lockpick"}) then
      menu["차량 잠금풀기"] = ch_lockpickveh -- opens a locked vehicle
    end

    if vRP.hasPermission({user_id, "player.check"}) then
      menu["*소지품 확인"] = choice_player_check -- checks nearest player inventory, like police check from vrp
    end

    vRP.openMenu({player, menu})
  end
}

-- REGISTER MAIN MENU CHOICES
vRP.registerMenuBuilder(
  {
    "main",
    function(add, data)
      local user_id = vRP.getUserId({data.player})
      if user_id ~= nil then
        local choices = {}

        if vRP.hasPermission({user_id, "player.player_menu"}) then
          choices["*플레이어"] = ch_player_menu -- opens player submenu
        end

        if vRP.hasPermission({user_id, "elysium.bankjob"}) then
          choices["*금융업"] = ch_loan_menu -- opens player submenu
        end

        if vRP.hasPermission({user_id, "realworld.emssystem"}) then
          choices["*검찰"] = ch_prs_menu -- opens player submenu
        end

        if vRP.hasPermission({user_id, "elysium.president"}) then
          choices["*총리부"] = ch_president_menu -- opens player submenu
        end

        if vRP.hasPermission({user_id, "elysium.company"}) then
          choices["*회사"] = ch_company_menu -- opens player submenu
        end

        add(choices)
      end
    end
  }
)

-- RESGISTER ADMIN MENU CHOICES
vRP.registerMenuBuilder(
  {
    "admin",
    function(add, data)
      local user_id = vRP.getUserId({data.player})
      if user_id ~= nil then
        local choices = {}

        if vRP.hasPermission({user_id, "admin.deleteveh"}) then
          choices["차량 삭제"] = ch_deleteveh -- Delete nearest vehicle (Fixed pull request https://github.com/Sighmir/vrp_basic_menu/pull/11/files/419405349ca0ad2a215df90cfcf656e7aa0f5e9c from benjatw)
        end

        if vRP.hasPermission({user_id, "admin.spawnveh"}) then
          choices["차량 소환"] = ch_spawnveh -- Spawn a vehicle model
        end

        if vRP.hasPermission({user_id, "admin.godmode"}) then
          choices["**[관리자]무적 모드"] = ch_godmode -- Toggles admin godmode (Disable the default admin.god permission to use this!)
        end

        if vRP.hasPermission({user_id, "player.tptowaypoint"}) then
          choices["*웨이포인트로 텔포"] = choice_tptowaypoint -- teleport user to map blip
        end

        if vRP.hasPermission({user_id, "player.freeze"}) then
          choices["*플레이어 얼리기"] = ch_freeze
        end

        if vRP.hasPermission({user_id, "player.blips"}) then
          choices["**[관리자]빌립스(ON/OFF)"] = ch_blips -- turn on map blips and sprites
        end

        if vRP.hasPermission({user_id, "staffboss.tc"}) then
          choices["[출/퇴근]스태프장"] = staffboss_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "staff.tc"}) then
          choices["[출/퇴근]스태프"] = staff_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "imstaff.tc"}) then
          choices["[출/퇴근]임시스태프"] = imstaff_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems01.tc"}) then
          choices["[출/퇴근]소방감"] = ems01_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems02.tc"}) then
          choices["[출/퇴근]소방정"] = ems02_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems1.tc"}) then
          choices["[출/퇴근]소방총감"] = ems1_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems2.tc"}) then
          choices["[출/퇴근]소방정감"] = ems2_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems3.tc"}) then
          choices["[출/퇴근]소방준감"] = ems3_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems4.tc"}) then
          choices["[출/퇴근]소방령"] = ems4_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems5.tc"}) then
          choices["[출/퇴근]소방경"] = ems5_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems6.tc"}) then
          choices["[출/퇴근]소방위"] = ems6_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems7.tc"}) then
          choices["[출/퇴근]소방장"] = ems7_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "ems8.tc"}) then
          choices["[출/퇴근]소방대원"] = ems8_tc -- Fines closeby player
        end

        add(choices)
      end
    end
  }
)

-- REGISTER POLICE MENU CHOICES
vRP.registerMenuBuilder(
  {
    "police",
    function(add, data)
      local user_id = vRP.getUserId({data.player})
      if user_id ~= nil then
        local choices = {}

        if vRP.hasPermission({user_id, "police.easy_jail"}) then
          choices["*구금 하기"] = ch_jail -- Send a nearby handcuffed player to jail with prompt for choice and user_list
        end

        if vRP.hasPermission({user_id, "police.easy_unjail"}) then
          choices["*구금 해제하기"] = ch_unjail -- Un jails chosen player if he is jailed (Use admin.easy_unjail as permission to have this in admin menu working in non jailed players)
        end

        if vRP.hasPermission({user_id, "police.easy_jail"}) then
          choices["*주둥이락"] = ch_rtalk
        end

        if vRP.hasPermission({user_id, "police.easy_unjail"}) then
          choices["*주둥이락해제"] = ch_unrtalk
        end

        if vRP.hasPermission({user_id, "kys.cloakroom"}) then
          choices["교정국알람 켜기"] = ch_kys_alarm_on
        end

        if vRP.hasPermission({user_id, "kys.cloakroom"}) then
          choices["교정국알람 끄기"] = ch_kys_alarm_off
        end

        if vRP.hasPermission({user_id, "kys.cloakroom"}) then
          choices["교정국스크린 켜기"] = ch_kys_screen_on
        end

        if vRP.hasPermission({user_id, "kys.cloakroom"}) then
          choices["교정국스크린 끄기"] = ch_kys_screen_off
        end

        if vRP.hasPermission({user_id, "police.easy_fine"}) then
          choices["*벌금 부여하기"] = ch_fine -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "frk_tc01"}) then
          choices["[출/퇴근]퍼스트렉카 회장"] = frk_tc01 -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "frk_tc02"}) then
          choices["[출/퇴근]퍼스트렉카 사장"] = frk_tc02 -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "frk_tc03"}) then
          choices["[출/퇴근]퍼스트렉카 부사장"] = frk_tc03 -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "frk_tc04"}) then
          choices["[출/퇴근]퍼스트렉카 전무이사"] = frk_tc04 -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "frk_tc05"}) then
          choices["[출/퇴근]퍼스트렉카 상무이사"] = frk_tc05 -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "frk_tc06"}) then
          choices["[출/퇴근]퍼스트렉카 사원"] = frk_tc06 -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "frk_tc07"}) then
          choices["[출/퇴근]퍼스트렉카 인턴"] = frk_tc07 -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys001.tc"}) then
          choices["[출/퇴근]교정 이사관"] = kys001_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys002.tc"}) then
          choices["[출/퇴근]서기관"] = kys002_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys1.tc"}) then
          choices["[출/퇴근]교정 본부장"] = kys1_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys2.tc"}) then
          choices["[출/퇴근]교정 부본부장"] = kys2_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys3.tc"}) then
          choices["[출/퇴근]교정 과장"] = kys3_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys4.tc"}) then
          choices["[출/퇴근]교정관"] = kys4_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys5.tc"}) then
          choices["[출/퇴근]교감"] = kys5_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys6.tc"}) then
          choices["[출/퇴근]교위관"] = kys6_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys7.tc"}) then
          choices["[출/퇴근]교사관"] = kys7_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys8.tc"}) then
          choices["[출/퇴근]교도관"] = kys8_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "kys9.tc"}) then
          choices["[출/퇴근]교정본부 훈련생"] = kys9_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police1.tc"}) then
          choices["[출/퇴근]치안총감"] = police1_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police2.tc"}) then
          choices["[출/퇴근]치안정감"] = police2_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police3.tc"}) then
          choices["[출/퇴근]치안감"] = police3_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "polices1_tc"}) then
          choices["[출/퇴근]경무관"] = polices1_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police4.tc"}) then
          choices["[출/퇴근]경정"] = police4_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police5.tc"}) then
          choices["[출/퇴근]경감"] = police5_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police6.tc"}) then
          choices["[출/퇴근]경위"] = police6_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police7.tc"}) then
          choices["[출/퇴근]경사"] = police7_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police8.tc"}) then
          choices["[출/퇴근]경장"] = police8_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police9.tc"}) then
          choices["[출/퇴근]순경"] = police9_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police10.tc"}) then
          choices["[출/퇴근]파출소장"] = police10_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police11.tc"}) then
          choices["[출/퇴근]파출대원"] = police11_tc -- Fines closeby player
        end

        if vRP.hasPermission({user_id, "police.easy_cuff"}) then
          choices["**수갑 채우기"] = ch_handcuff -- Toggle cuffs AND CLOSE MENU for nearby player
        end

        if vRP.hasPermission({user_id, "police.spikes"}) then
          choices["스파이크 설치"] = ch_spikes -- Toggle spikes
        end

        if vRP.hasPermission({user_id, "police.drag"}) then
          choices["**끌고 가기"] = ch_drag -- Drags closest handcuffed player
        end

        add(choices)
      end
    end
  }
)

-- REGISTER PHONE MENU CHOICES
-- TO USE THIS FUNCTION YOU NEED TO HAVE THE ORIGINAL vRP UPDATED TO THE LASTEST VERSION
vRP.registerMenuBuilder(
  {
    "phone",
    function(add) -- phone menu is created on server start, so it has no permissions.
      local choices = {} -- Comment the choices you want to disable by adding -- in front of them.

      choices["계좌 이체"] = ch_mobilepay -- transfer money through phone
      --choices["이체 요청"] = ch_mobilecharge -- charge money through phone

      add(choices)
    end
  }
)

function vRPbm.drag()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, "police.drag"}) then
    if ch_drag[1] ~= nil and type(ch_drag[1]) == "function" then
      ch_drag[1](source)
    end
  else
    vRPclient.notify(source, {"당신은 권한이 없습니다."})
  end
end

function vRPbm.cuff()
  local user_id = vRP.getUserId({source})
  if vRP.hasPermission({user_id, "police.easy_cuff"}) then
    if ch_handcuff[1] ~= nil and type(ch_handcuff[1]) == "function" then
      ch_handcuff[1](source)
    end
  else
    vRPclient.notify(source, {"당신은 권한이 없습니다."})
  end
end

RegisterNetEvent("proxy_vrp_basic_menu:action")
AddEventHandler(
  "proxy_vrp_basic_menu:action",
  function(type)
    local player = source
    local user_id = vRP.getUserId({player})
    if not user_id then
      return
    end
    if type == "ch_godmode" then
      if vRP.hasPermission({user_id, "admin.godmode"}) then
        ch_godmode[1](source, "")
      end
    elseif type == "ch_blips" then
      if vRP.hasPermission({user_id, "player.blips"}) then
        ch_blips[1](source, "")
      end
    elseif type == "choice_tptowaypoint" then
      if vRP.hasPermission({user_id, "player.tptowaypoint"}) then
        choice_tptowaypoint[1](source, "")
      end
    elseif type == "ch_freeze" then
      if vRP.hasPermission({user_id, "player.freeze"}) then
        ch_freeze[1](source, "")
      end
    elseif type == "ch_mission_cancel" then
      vRP.stopMission({source})
    elseif type == "ch_jobwork_on" then
      local getJobType = vRP.getUserGroupByType({user_id, "job"})
      if getJobType ~= utf8replace(getJobType, {["["] = ""}) then
        local newJobType = utf8replace(getJobType, {["["] = "", ["퇴"] = "", ["근"] = "", ["]"] = ""})
        vRP.removeUserGroup({user_id, getJobType})
        vRP.addUserGroup({user_id, newJobType})
        vRPclient.notify(player, {"~g~[출근]~w~" .. newJobType})
      end
    elseif type == "ch_jobwork_off" then
      local getJobType = vRP.getUserGroupByType({user_id, "job"})
      if getJobType == utf8replace(getJobType, {["["] = ""}) then
        local newJobType = getJobType .. "[퇴근]"
        if vRP.isExistGroup({newJobType}) then
          vRP.removeUserGroup({user_id, getJobType})
          vRP.addUserGroup({user_id, newJobType})
          vRPclient.notify(player, {"~r~[퇴근]~w~" .. getJobType})
        end
      end
    elseif type == "ch_fixhair" then
      ch_fixhair[1](source, "")
    elseif type == "choice_skin_update" then
      choice_skin_update[1](source, "")
    elseif type == "choice_mask_update" then
      choice_mask_update[1](source, "")
    elseif type == "choice_store_weapons" then
      choice_store_weapons[1](source, "")
    elseif type == "choice_store_armor" then
      choice_store_armor[1](source, "")
    elseif type == "ch_deleteveh" then
      if vRP.hasPermission({user_id, "admin.deleteveh"}) then
        ch_deleteveh[1](source, "")
      end
    elseif type == "ch_jail" then
      if vRP.hasPermission({user_id, "police.easy_jail"}) then
        ch_jail[1](source, "")
      end
    elseif type == "ch_unjail" then
      if vRP.hasPermission({user_id, "police.easy_unjail"}) then
        ch_unjail[1](source, "")
      end
    elseif type == "ch_rtalk" then
      if vRP.hasPermission({user_id, "police.easy_jail"}) then
        ch_rtalk[1](source, "")
      end
    elseif type == "ch_unrtalk" then
      if vRP.hasPermission({user_id, "police.easy_unjail"}) then
        ch_unrtalk[1](source, "")
      end
    elseif type == "ch_kys_alarm_on" then
      if vRP.hasPermission({user_id, "kys.cloakroom"}) then
        ch_kys_alarm_on[1](source, "")
      end
    elseif type == "ch_kys_alarm_off" then
      if vRP.hasPermission({user_id, "kys.cloakroom"}) then
        ch_kys_alarm_off[1](source, "")
      end
    elseif type == "ch_kys_screen_on" then
      if vRP.hasPermission({user_id, "kys.cloakroom"}) then
        ch_kys_screen_on[1](source, "")
      end
    elseif type == "ch_kys_screen_off" then
      if vRP.hasPermission({user_id, "kys.cloakroom"}) then
        ch_kys_screen_off[1](source, "")
      end
    elseif type == "ch_fine" then
      if vRP.hasPermission({user_id, "police.easy_fine"}) then
        ch_fine[1](source, "")
      end
    elseif type == "ch_handcuff" then
      if vRP.hasPermission({user_id, "police.easy_cuff"}) then
        ch_handcuff[1](source, "")
      end
    elseif type == "ch_spikes" then
      if vRP.hasPermission({user_id, "police.spikes"}) then
        ch_spikes[1](source, "")
      end
    elseif type == "ch_drag" then
      if vRP.hasPermission({user_id, "police.drag"}) then
        ch_drag[1](source, "")
      end
    end
  end
)
