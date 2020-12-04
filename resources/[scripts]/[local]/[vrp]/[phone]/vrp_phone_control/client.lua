vrp_phone_controlC = {}
Tunnel.bindInterface("vrp_phone_control", vrp_phone_controlC)
Proxy.addInterface("vrp_phone_control", vrp_phone_controlC)
vRP = Proxy.getInterface("vRP")
vrp_phone_controlS = Tunnel.getInterface("vrp_phone_control", "vrp_phone_control")

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if IsControlJustPressed(3, 311) and IsControlPressed(0, 21) then
				vRP.togglePhone()
			elseif IsControlJustPressed(3, 311) then
				TriggerEvent("gcPhone:togglePhone")
			end
		end
	end
)
