----------------- vRP Bagpack Respawn
----------------- FiveM RealWorld MAC
----------------- https://discord.gg/realw

vrp_bagpack_respawnC = {}
Tunnel.bindInterface("vrp_bagpack_respawn", vrp_bagpack_respawnC)
Proxy.addInterface("vrp_bagpack_respawn", vrp_bagpack_respawnC)
vRP = Proxy.getInterface("vRP")
vrp_bagpack_respawnS = Tunnel.getInterface("vrp_bagpack_respawn", "vrp_bagpack_respawn")

local index = 9
local saveSkin = {}
local gd = 0
local gt = 0
local gp = 0

function vrp_bagpack_respawnC.setSkin(ind, ar1, ar2, ar3)
	local ped = GetPlayerPed(-1)
	SetPedComponentVariation(ped, ind, ar1, ar2, ar3)
end

function vrp_bagpack_respawnC.getCode()
	print(gd,gt,gp)
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10)
			local ped = GetPlayerPed(-1)
			gd = GetPedDrawableVariation(ped, index)
			gt = GetPedTextureVariation(ped, index)
			gp = GetPedPaletteVariation(ped, index)
			if saveSkin and saveSkin[1] then
				if gd == 0 and gt == 1 and gp == 2 then
					SetPedComponentVariation(ped, index, saveSkin[1], saveSkin[2], saveSkin[3])
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			local ped = GetPlayerPed(-1)
			if gd == 0 and gt == 1 and gp == 2 then
				saveSkin = {}
			else
				saveSkin = {gd, gt, gp}
			end
		end
	end
)
