--[[]
			Increased Player Agility & Ability
					By Silence

				but Server side stuff.
--]]
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

perm = "parkour.player"

RegisterCommand(
	"parkour",
	function(source, args, rawCommand)
		local user_id = vRP.getUserId({source})
		if vRP.hasPermission({user_id, perm}) then
			if (tostring(args[1]) == "start") then
				TriggerClientEvent("Parkour:KeybindsToggleTrue.cl", source, 0)
			elseif (tostring(args[1]) == "stop") then
				TriggerClientEvent("Parkour:KeybindsToggleFalse.cl", source, 0)
			elseif (tostring(args[1]) == "noti") then
				TriggerClientEvent("Parkour:NotifToggle.cl", source, 0)
			elseif (tostring(args[1])) ~= nil then
				TriggerClientEvent("chatMessage", source, "^1 Parkour: Error, Wrong Command must use /parkour <start/stop/noti>")
			end
		end
	end
)
