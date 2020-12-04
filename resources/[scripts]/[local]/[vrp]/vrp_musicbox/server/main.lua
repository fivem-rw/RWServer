---------------------------------------------------------
------------ VRP Musicbox, RealWorld MAC ----------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_musicboxS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_musicbox")
vrp_musicboxC = Tunnel.getInterface("vrp_musicbox", "vrp_musicbox")
Tunnel.bindInterface("vrp_musicbox", vrp_musicboxS)

mBoxList = {}
playerList = {}

perm = "musicbox.player"

function getCalcRange(v)
	if v <= 0 then
		return 0
	end
	return (v / 2) + (v / 5)
end

function vrp_musicboxS.newBox(id, volume, user_id)
	--print("newBox", id, volume, range)
	if user_id == nil and source then
		user_id = vRP.getUserId({source})
	end
	local range = getCalcRange(volume)
	playerList[id] = {user_id = user_id, status = 0, serverStatus = 0, clientStatus = 0, playTime = 0, volume = volume, range = range}
	vrp_musicboxC.newBox(-1, {id, playerList[id]})
	return playerList[id]
end

function vrp_musicboxS.pickup(id)
	--print("pickup", id)

	local user_id = vRP.getUserId({source})
	if not vRP.hasPermission({user_id, perm}) then
		return false
	end

	if playerList[id] == nil then
		vrp_musicboxS.newBox(id, Config.defaultVolume, user_id)
	end
	playerList[id].user_id = user_id
	vRPclient.playAnim(source, {true, {{"pickup_object", "pickup_low", 1}}, false})
	return playerList[id]
end

function vrp_musicboxS.play(id, videoId)
	--print("play", id, videoId)
	if playerList[id] ~= nil then
		playerList[id].videoId = videoId
		playerList[id].serverStatus = 1
		playerList[id].status = 1
	--vrp_musicboxC.playMusic(-1, {id, playerList[id]})
	end
	--print("play", id, videoId)
end

function vrp_musicboxS.stop(id)
	if playerList[id] ~= nil then
		playerList[id].serverStatus = 0
		playerList[id].status = 0
		playerList[id].playTime = 0
		vrp_musicboxC.stopMusic(-1, {id, playerList[id]})
	end
	--print("stop", id)
end

function vrp_musicboxS.delBox(id)
	playerList[id] = nil
	vrp_musicboxC.delBox(-1, {id})
	--print("del")
end

function vrp_musicboxS.volumeUp(id)
	--print("volumeUp")
	if playerList[id] ~= nil then
		playerList[id].volume = playerList[id].volume + 5
		if playerList[id].volume > 100 then
			playerList[id].volume = 100
		end
		return {playerList[id].volume, playerList[id].range}
	end
	return false
end

function vrp_musicboxS.volumeDown(id)
	--print("volumeDown")
	if playerList[id] ~= nil then
		playerList[id].volume = playerList[id].volume - 5
		if playerList[id].volume < 0 then
			playerList[id].volume = 0
		end
		return {playerList[id].volume, playerList[id].range}
	end
	return false
end

function vrp_musicboxS.rangeUp(id)
	--print("volumeUp")
	if playerList[id] ~= nil then
		playerList[id].range = playerList[id].range + 5
		if playerList[id].range > 50 then
			playerList[id].range = 50
		end
		return {playerList[id].volume, playerList[id].range}
	end
	return false
end

function vrp_musicboxS.rangeDown(id)
	--print("volumeUp")
	if playerList[id] ~= nil then
		playerList[id].range = playerList[id].range - 5
		if playerList[id].range < 0 then
			playerList[id].range = 0
		end
		return {playerList[id].volume, playerList[id].range}
	end
	return false
end

function vrp_musicboxS.updateBoxCoords(id, coords)
	local user_id = vRP.getUserId({source})
	if playerList[id] ~= nil and coords ~= nil then
		playerList[id].coords = coords
		vrp_musicboxC.updateBoxCoords(-1, {id, playerList[id].coords})
	--print(id, playerList[id].coords)
	end
end

function vrp_musicboxS.updatePlayTime(id, time)
	if time == nil then
		time = 0
	end
	if playerList[id] ~= nil and playerList[id].serverStatus == 1 then
		if playerList[id].playTime < time then
			playerList[id].playTime = time
			vrp_musicboxC.updatePlayTime(-1, {id, playerList[id].playTime})
		end
	end
end

function vrp_musicboxS.checkPerm()
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, perm}) then
		return true
	end
	return false
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
			vrp_musicboxC.updatePlayerList(-1, {playerList})
		end
	end
)
