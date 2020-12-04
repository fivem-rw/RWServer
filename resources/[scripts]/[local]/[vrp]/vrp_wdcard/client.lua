vrp_wdcardC = {}
Tunnel.bindInterface("vrp_wdcard", vrp_wdcardC)
Proxy.addInterface("vrp_wdcard", vrp_wdcardC)
vRP = Proxy.getInterface("vRP")
vrp_wdcardS = Tunnel.getInterface("vrp_wdcard", "vrp_wdcard")

Citizen.CreateThread(
	function()
		SetNuiFocus(false)
	end
)

function vrp_wdcardC.open()
	SendNUIMessage(
		{
			action = "open"
		}
	)
	SetNuiFocus(true, true)
end
function vrp_wdcardC.close()
	SendNUIMessage(
		{
			action = "close"
		}
	)
	SetNuiFocus(false)
end
function vrp_wdcardC.setPoint()
	vrp_wdcardC.close()
	vRP.notify({"~g~결혼식장 위치가 표시되었습니다."})
	SetNewWaypoint(-1466.357421875, -1467.5756835938)
end

RegisterNUICallback(
	"hide",
	function(data, cb)
		SetNuiFocus(false)
	end
)

RegisterNUICallback(
	"setPoint",
	function(data, cb)
		vrp_wdcardC.setPoint()
	end
)
