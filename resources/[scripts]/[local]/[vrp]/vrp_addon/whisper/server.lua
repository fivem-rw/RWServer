
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_whisper")

local mihaita = {}
local nisip = {}
--[[
    Script Oficial Creat de [GSG]-TibiNyte
    Sistem de whisper 
    Nu postati altundeva fara acordul meu , TibiNyte
    Discord : TibiNyte#3088
]]


RegisterCommand("w", function(player, args, msg)
    local user_id = vRP.getUserId({player})
    local targetid = parseInt(args[1])
    local raspuns = ''
	
	for k in pairs(args) do
		if (k>=2) then
			raspuns = raspuns..args[k]..' '
		end
	end

    if user_id == targetid then
        TriggerClientEvent("chatMessage", player , "[^7귓속말^0] 자신에게는 귓속말을 할 수 없습니다.")
    else
    if msg:len() > 5 then
        if user_id then
        local sursatarg = vRP.getUserSource({targetid})
			if sursatarg then
				for k in pairs (mihaita) do -- sterge tabelul mihaita ( cel unde este stocat target_id ) pentru ca a fost trimis un nou whisper si variabilele trebuie schimbate
					mihaita[k] = nil
				end
				for k in pairs (nisip) do -- sterge tabelul mihaita ( cel unde este stocat user_id ) pentru ca a fost trimis un nou whisper si variabilele trebuie schimbate
					nisip[k] = nil
				end
				table.insert(mihaita, targetid) --Adauga noua variabila in tabelul mihaita  ( target_id )
				table.insert(nisip , user_id) -- Adauga noua variabila in tabelul nisip (user_id)
				TriggerClientEvent("chatMessage", sursatarg , "⬇ ^3귓속말 | "..user_id.." | "..GetPlayerName(player).."님의 귓속말^0:"..raspuns.."")
				TriggerClientEvent("chatMessage", player ,  "⬆ ^3귓속말 | "..targetid.." | "..GetPlayerName(sursatarg).."님에게 귓속말^0:"..raspuns.."")
            else
				TriggerClientEvent("chatMessage", player , "[^7귓속말^0] ^4접속중인 사용자가 아닙니다.")
            end
        end
    else
        TriggerClientEvent("chatMessage", player , "[^7귓속말^0] ^45글자 이상 입력해주세요.")
    end
end
end)