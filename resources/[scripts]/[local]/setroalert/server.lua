msg = ""
RegisterCommand('工地', function(source, args, user)
	if (IsPlayerAceAllowed(source, "command")) then
			for i,v in pairs(args) do
				msg = msg .. " " .. v
			end
			TriggerClientEvent("alert", -1, msg)
			msg = ""
    end
end)

--i could really use some head rn ngl