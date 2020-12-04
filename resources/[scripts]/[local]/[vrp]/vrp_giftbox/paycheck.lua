Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(cfg.global.paytime * 1000)
			TriggerServerEvent("vRP:gbpaycheck")
		end
	end
)