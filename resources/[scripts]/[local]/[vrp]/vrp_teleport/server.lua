---------------------------------------------------------
------------- VRP Teleport, RealWorld MAC ---------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_teleportS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_teleport")
vrp_teleportC = Tunnel.getInterface("vrp_teleport", "vrp_teleport")
Tunnel.bindInterface("vrp_teleport", vrp_teleportS)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

RegisterCommand(
	"tp",
	function(source, args)
		local player = source
		local user_id = vRP.getUserId({player})
		if not player or not user_id then
			return
		end
		if not args[1] then
			return
		end
		if not vRP.hasPermission({user_id, "admin.godmode"}) then
			return
		end
		if args[1] == "set" then
			if not args[2] or tonumber(args[2]) == nil then
				vRPclient.notify(player, {"~r~범위를 입력해주세요."})
				return
			end
			local ped = GetPlayerPed(player)
			local range = tonumber(args[2])
			vrp_teleportC.set(-1, {player, range})
		elseif args[1] == "unset" then
			vrp_teleportC.unset(-1, {player})
		elseif args[1] == "go" then
			if args[2] then
				arrPos = stringsplit(args[2], ",")
				if #arrPos >= 3 then
					vrp_teleportC.go(-1, {player, tonumber(arrPos[1]), tonumber(arrPos[2]), tonumber(arrPos[3]), true})
				else
					vRPclient.notify(player, {"~r~올바른 좌표가 아닙니다."})
				end
			else
				vrp_teleportC.getTPCoords(
					player,
					{},
					function(coords)
						if coords then
							vrp_teleportC.go(-1, {player, coords[1], coords[2], coords[3]})
						else
							vRPclient.notify(player, {"~r~지정된 웨이포인트가 없습니다."})
						end
					end
				)
			end
		elseif args[1] == "go2" then
			vrp_teleportC.go2(-1, {player, tonumber(args[2]), tonumber(args[3]), tonumber(args[4]), tonumber(args[5])})
		elseif args[1] == "go3" then
			vrp_teleportC.go3(-1, {player, args[2]})
		elseif args[1] == "goback" then
			vrp_teleportC.goback(-1, {player})
		end
	end
)
