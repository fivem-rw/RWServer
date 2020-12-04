local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","prisons")

--블린님 설정 부분
local prison2 = "prison.whitelist" -- 죄수 퍼미션 선언
--여기까지

RegisterServerEvent('block:checkper')
AddEventHandler('block:checkper', function()
	local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
		if vRP.hasPermission({user_id,prison2}) then -- 죄수 퍼미션
		TriggerClientEvent('block:run', player)
    vRPclient.notify(player,{"~r~[ 교정본부 진입 ]~w~\n점프가 ~r~비활성화~w~ 되었습니다."})
    end
end)

--@EUNYUL