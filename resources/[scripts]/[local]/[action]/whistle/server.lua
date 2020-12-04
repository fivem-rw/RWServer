RegisterServerEvent("whistle:Get")
AddEventHandler(
	"whistle:Get",
	function(event, targetID)
		TriggerClientEvent("whistle:Status", targetID, event, source)
	end
)

RegisterServerEvent("whistle:Send")
AddEventHandler(
	"whistle:Send",
	function(event, targetID, whistle)
		TriggerClientEvent(event, targetID, whistle)
	end
)

RegisterServerEvent("whistle:Hands")
AddEventHandler(
	"whistle:Hands",
	function(event, targetID, whistle)
		TriggerClientEvent(event, targetID, whistle)
	end
)
