RegisterServerEvent("tackle:tryTackle")
AddEventHandler(
	"tackle:tryTackle",
	function(target)
		if target and source then
			TriggerClientEvent("tackle:getTackled", target, source)
			TriggerClientEvent("tackle:playTackle", source)
		end
	end
)
