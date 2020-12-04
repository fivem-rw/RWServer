Citizen.CreateThread(
	function()
		while true do
			TriggerServerEvent("vRP:Discord")
			Citizen.Wait(30000)
		end
	end
)

RegisterNetEvent("vRP:Discord-rich")
AddEventHandler(
	"vRP:Discord-rich",
	function(user_id, faction, name)
		SetDiscordAppId(685878240199573514)
		-- Discord app ID
		SetDiscordRichPresenceAsset("logo") -- PNG file
		SetDiscordRichPresenceAssetText("리얼월드 S2") -- PNG text desc
		--SetDiscordRichPresenceAssetSmall("logo2") -- PNG small
		SetDiscordRichPresenceAssetSmallText("") -- PNG text desc2
		--SetRichPresence("" .. name .. " (" .. user_id .. "번)")
	end
)
