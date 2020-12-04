local robbing = false
local bank = ""
local secondsRemaining = 0

function bank_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

local banks = {
	["Lindsay Circus"] = {
		position = { ['x'] = -705.94110107422, ['y'] = -915.48120117188, ['z'] = 18.215589523315 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Lindsay Circus LTD Gas Station",
		lastrobbed = 0
	},
	["Prosperity St"] = {
		position = { ['x'] = -1487.1322021484, ['y'] = -375.54638671875, ['z'] = 39.163433074951 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Prosperity St Robs Liquor",
		lastrobbed = 0
	},
	["Barbareno Road Great Ocean"] = {
		position = { ['x'] = -3241.7280273438, ['y'] = 999.95611572266, ['z'] = 11.830716133118 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Barbareno Road(Great Ocean) 24/7 Supermarket",
		lastrobbed = 0
	},
	["North Rockford Dr"] = {
		position = { ['x'] = -1828.9028320313, ['y'] = 798.63702392578, ['z'] = 137.18780517578 },
		reward = 100 + math.random(800,1500),
		nameofbank = "North Rockford Dr LTD Gas Station",
		lastrobbed = 0
	},
	["Great Ocean Hway East"] = {
		position = { ['x'] = 1727.6282958984, ['y'] = 6414.7607421875, ['z'] = 34.037220001221 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Great Ocean Hway East 24/7 Supermarket",
		lastrobbed = 0
	},
	["Alhambra Dr Sandy"] = {
		position = { ['x'] = 1960.3529052734, ['y'] = 3739.4997558594, ['z'] = 31.343742370605 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Alhambra Dr Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Palomino Fwy Reststop"] = {
		position = { ['x'] = 2549.2858886719, ['y'] = 384.96740722656, ['z'] = 107.62294769287 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Palomino Fwy Reststop 24/7 Supermarket",
		lastrobbed = 0
	},
	["Clinton Ave"] = {
		position = { ['x'] = 372.36227416992, ['y'] = 325.90933227539, ['z'] = 102.56638336182 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Clinton Ave 24/7 Supermarket",
		lastrobbed = 0
	},
	["Grove St/Davis St"] = {
		position = { ['x'] = -47.860702514648, ['y'] = -1759.3477783203, ['z'] = 28.421016693115 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Grove St/Davis St LTD Gas Station",
		lastrobbed = 0
	},
	["Innocence Blvd"] = {
		position = { ['x'] = 24.360492706299, ['y'] = -1347.8098144531, ['z'] = 28.497026443481 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Innocence Blvd 24/7 Supermarket",
		lastrobbed = 0
	},
	["San Andreas Ave"] = {
		position = { ['x'] = -1220.7747802734, ['y'] = -915.93646240234, ['z'] = 10.326335906982 },
		reward = 100 + math.random(800,1500),
		nameofbank = "San Andreas Ave Robs Liquor",
		lastrobbed = 0
	},
	["Route 68 Outside Sandy"] = {
		position = { ['x'] = 1169.2320556641, ['y'] = 2717.8083496094, ['z'] = 36.157665252686 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Route 68 Outside Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Great Ocean Hway"] = {
		position = { ['x'] = -2959.6359863281, ['y'] = 387.15356445313, ['z'] = 13.043292999268 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Great Ocean Hway Robs Liquor",
		lastrobbed = 0
	},
	["Inseno Rd Great Ocean"] = {
		position = { ['x'] = -3038.9475097656, ['y'] = 584.53924560547, ['z'] = 6.9089307785034 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Inseno Rd Great Ocean 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Grapeseed Main St"] = {
		position = { ['x'] = 1707.8717041016, ['y'] = 4920.2475585938, ['z'] = 41.063678741455 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Grapeseed Main St 24/7 Supermarket",
		lastrobbed = 0
	},	
	["Algonquin Blvd"] = {
		position = { ['x'] = 1392.9791259766, ['y'] = 3606.5573730469, ['z'] = 33.980918884277 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Algonquin Blvd Ace Liquors",
		lastrobbed = 0
	},	
	["Panorama Dr"] = {
		position = { ['x'] = 1982.5057373047, ['y'] = 3053.4697265625, ['z'] = 46.215065002441 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Panorama Dr Yellow Jack Inn",
		lastrobbed = 0
	},	
	["Senora Fwy Sandy"] = {
		position = { ['x'] = 2678.1394042969, ['y'] = 3279.3344726563, ['z'] = 54.241130828857 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Senora Fwy Sandy 24/7 Supermarket",
		lastrobbed = 0
	},
	["Mirror Park Blvd"] = {
		position = { ['x'] = 1159.5697021484, ['y'] = -314.11761474609, ['z'] = 68.205139160156 },
		reward = 100 + math.random(800,1500),
		nameofbank = "Mirror Park Blvd LTD Gas Station",
		lastrobbed = 0
	},	
	["El Rancho Blvd"] = {
		position = { ['x'] = 1134.2387695313, ['y'] = -982.76049804688, ['z'] = 45.415843963623 },
		reward = 100 + math.random(800,1500),
		nameofbank = "El Rancho Blvd Robs Liquor",
		lastrobbed = 0
	}	
}


RegisterNetEvent('es_bank:currentlyrobbing')
AddEventHandler('es_bank:currentlyrobbing', function(robb)
	robbing = true
	bank = robb
	secondsRemaining = 180
end)

RegisterNetEvent('es_bank:toofarlocal')
AddEventHandler('es_bank:toofarlocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "The robbery was cancelled, you will receive nothing.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('es_bank:playerdiedlocal')
AddEventHandler('es_bank:playerdiedlocal', function(robb)
	robbing = false
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "The robbery was cancelled, you died!.")
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)


RegisterNetEvent('es_bank:robberycomplete')
AddEventHandler('es_bank:robberycomplete', function(reward)
	robbing = false
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, "Robbery done, you received:^2" .. reward)
	bank = ""
	secondsRemaining = 0
	incircle = false
end)

Citizen.CreateThread(function()
	while true do
		if robbing then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if IsPlayerWantedLevelGreater(PlayerId(),0) or ArePlayerFlashingStarsAboutToDrop(PlayerId()) then
					local wanted = GetPlayerWantedLevel(PlayerId())
					Citizen.Wait(5000)
				    SetPlayerWantedLevel(PlayerId(), wanted, 3)
					SetPlayerWantedLevelNow(PlayerId(), 3)
				end
			end
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 278)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Robbable Store")
		EndTextCommandSetBlipName(blip)
	end
end)
incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(banks)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not robbing then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)
					
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 2)then
						if (incircle == false) then
							bank_DisplayHelpText("Press ~INPUT_CONTEXT~ to rob ~b~" .. v.nameofbank .. "~w~ beware, the police will be alerted!")
						end
						incircle = true
						if(IsControlJustReleased(1, 51))then
							TriggerServerEvent('es_bank:rob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 2)then
						incircle = false
					end
				end
			end
		end

		if robbing then
		    SetPlayerWantedLevel(PlayerId(), 4, 4)
            SetPlayerWantedLevelNow(PlayerId(), 4)
			
			bank_drawTxt(0.66, 1.44, 1.0,1.0,0.4, "Robbing store: ~r~" .. secondsRemaining .. "~w~ seconds remaining", 255, 255, 255, 255)
			
			local pos2 = banks[bank].position
			local ped = GetPlayerPed(-1)
			
            if IsEntityDead(ped) then
			TriggerServerEvent('es_bank:playerdied', bank)
			elseif (Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 6)then
				TriggerServerEvent('es_bank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)