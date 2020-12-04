-- You have issues? Use Github

-- Checks if the person is a cop or not (Works fine, Not the best but it works.)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)

        TriggerServerEvent('utk_oh:CheckCop')
    end
end)
RegisterNetEvent('utk_oh:IsCop')
AddEventHandler('utk_oh:IsCop', function()
    IsCop = true
end)
RegisterNetEvent('utk_oh:IsNOTCop')
AddEventHandler('utk_oh:IsNOTCop', function()
    IsCop = false
end)

function LocalPed()
	return GetPlayerPed(-1)
end

IsCop = false
incircle = false
timer = 0
bombtimer = 0

PoliceDoors = {}
UTK = {
    doorchecks = {
        {x = 257.10, y = 220.30, z = 106.28, he = 339.733, h = GetHashKey("hei_v_ilev_bk_gate_pris"), h1 = "hei_v_ilev_bk_gate_pris", h2 = "hei_v_ilev_bk_gate_molten", status = 0},
        {x = 236.91, y = 227.50, z = 106.29, he = 340.000, h = GetHashKey("v_ilev_bk_door"), status = 0},
        {x = 262.35, y = 223.00, z = 107.05, he = 249.731, h = GetHashKey("hei_v_ilev_bk_gate2_pris"), status = 0},
        {x = 252.72, y = 220.95, z = 101.68, he = 160.278, h = GetHashKey("hei_v_ilev_bk_safegate_pris"), h1 = "hei_v_ilev_bk_safegate_pris", h2 = "hei_v_ilev_bk_safegate_molten", status = 0},
        {x = 261.01, y = 215.01, z = 101.68, he = 250.082, h = GetHashKey("hei_v_ilev_bk_safegate_pris"), h1 = "hei_v_ilev_bk_safegate_pris", h2 = "hei_v_ilev_bk_safegate_molten", status = 0},
        {x = 253.92, y = 224.56, z = 101.88, he = 160.000, h = GetHashKey("v_ilev_bk_vaultdoor"), status = 0,}
    },
    enablesupersilent = false,
    enablextras = true,
    disableinput = false,
    hackfinish = false,
    initiator = false,
    stage0break = false,
    stage1break = false,
    stage2break = false,
    stage4break = false,
    stagelootbreak = false,
    startloot = false,
    grabber= false,
    info = {},
    loudstart = {x = 257.10, y = 220.30, z = 106.28, type = "hei_v_ilev_bk_gate_pris", h = 339.733},
    silentstart = {x = 236.91, y = 227.50, z = 106.29, type = "v_ilev_bk_door", h = 340.00},
    inside1 = {x = 252.72, y = 220.95, z = 101.68, type = "hei_v_ilev_bk_safegate_pris", h = 160.278},
    inside2 = {x = 261.01, y = 215.01, z = 101.68, h = 250.082},
    card1 = {x = 262.35, y = 223.00, z = 107.05},
    card2 = {x = 252.80, y = 228.55, z = 102.50},
    hack1 = {x = 262.35, y = 223.00, z = 107.05, type = "hei_v_ilev_bk_gate2_pris", h = 249.731},
    hack2 = {x = 252.80, y = 228.55, z = 102.50},
    vault = {x = 253.92, y = 224.56, z = 101.88, type = "v_ilev_bk_vaultdoor"},
    thermal1 = {x = 252.82, y = 221.07, z = 101.60},
    thermal2 = {x = 261.22, y = 215.43, z = 101.68},
    lockpick1 = {x = 252.82, y = 221.07, z = 101.60},
    lockpick2 = {x = 261.22, y = 215.43, z = 101.68},
    cash1 = {x = 257.40, y = 215.15, z = 101.68},
    cash2 = {x = 262.32, y = 213.31, z = 101.68},
    cash3 = {x = 263.54, y = 216.23, z = 101.68},
    gold = {x = 266.36, y = 215.31, z = 101.68},
    dia = {x = 265.11, y = 212.05, z = 101.68},
    clean = {x = -1869.98, y = 2064.09, z = 135.54},
    cur = 7,
    starttimer = false,
    vaulttime = 0,
    searchlocations = {
        {coords = {x = 233.40, y = 221.53, z = 110.40}, status = false},
        {coords = {x = 240.93, y = 211.12, z = 110.40}, status = false},
        {coords = {x = 246.54, y = 208.86, z = 110.40}, status = false},
        {coords = {x = 264.33, y = 212.16, z = 110.40}, status = false},
        {coords = {x = 252.87, y = 222.36, z = 106.35}, status = false},
        {coords = {x = 249.71, y = 227.84, z = 106.35}, status = false},
        {coords = {x = 244.80, y = 229.70, z = 106.35}, status = false}
    },
    obj = {
        {x = 257.40, y = 215.15, z = 100.68, h = 269934519},
        {x = 262.32, y = 213.31, z = 100.68, h = 269934519},
        {x = 263.54, y = 216.23, z = 100.68, h = 269934519},
        {x = 266.36, y = 215.31, z = 100.68, h = 2007413986},
        {x = 265.11, y = 212.05, z = 100.68, h = 881130828}
    },
    emptyobjs = {
        {x = 257.40, y = 215.15, z = 100.68, h = 769923921},
        {x = 262.32, y = 213.31, z = 100.68, h = 769923921},
        {x = 263.54, y = 216.23, z = 100.68, h = 769923921},
        {x = 266.36, y = 215.31, z = 100.68, h = 2714348429},
        {x = 265.11, y = 212.05, z = 100.68, h = 2714348429}
    },
    checks = {
        hack1 = false,
        hack2 = false,
        thermal1 = false,
        thermal2 = false,
        id1 = false,
        id2 = false,
        idfound = false,
        grab1 = false,
        grab2 = false,
        grab3 = false,
        grab4 = false,
        grab5 = false
    },
    alarmblip
}
UTK.searchinfo = {
    random = math.random(1, UTK.cur),
    found = false
}
local GrabBag = nil
local PlaySound = false
local program = 0
local scaleform = nil
local lives = 5
local ClickReturn
local SorF = false
local Hacking = false
local Ipfinished = false
local UsingComputer = false
local text
local RouletteWords = {
    "GMRTKGHL",
    "QORTKGHL",
    "EHRTKGHL",
    "WKQTOEMF",
    "ABSOLUTE",
    "KOREAURA",
    "DOCTRINE",
    "IMPERIUS",
    "DELIRIUM",
    "WUNGLOVE",
    "HWAYANG2",
    "KYUNGJIN",
    "BOMDIEZZ",
    "MAETHRIL"
}
local output = nil

function UTK:GetInfo()
	TriggerServerEvent('utk_oh:GetData')
end
RegisterNetEvent('utk_oh:GetData')
AddEventHandler('utk_oh:GetData', function(ret)
    UTK.info = ret
    UTK:HandleInfo()
end)

RegisterNetEvent('utk_oh:GetDoors')
AddEventHandler('utk_oh:GetDoors', function(ret)
    output = ret
end)

RegisterNetEvent('utk_oh:startevent')
AddEventHandler('utk_oh:startevent', function(ret)
    output = ret
end)

RegisterNetEvent('utk_oh:checkItem')
AddEventHandler('utk_oh:checkItem', function(ret)
    output = ret
end)

RegisterNetEvent('utk_oh:gettotalcash')
AddEventHandler('utk_oh:gettotalcash', function(ret)
    output = ret
end)

function UTK:HandleInfo()
	if self.info.stage == 0 then
		Citizen.CreateThread(function()
			while true do
				local coords = GetEntityCoords(PlayerPedId())

					local dst = GetDistanceBetweenCoords(coords, self.loudstart.x, self.loudstart.y, self.loudstart.z, true)

					if dst <= 6 and IsCop == false then
						DrawText3D(self.loudstart.x, self.loudstart.y, self.loudstart.z, Config.text.loudstart, 0.40)
						if dst <= 1 and IsControlJustReleased(0,38) then
							output = nil
							TriggerServerEvent('utk_oh:startevent', 1)
							while output == nil do 
								Wait(0)
							end
							if output == true then
								UTK.initiator = true
								self.info.stage = 1
								self.info.style = 1
								self.currentplant = 0
								self:Plant()
							elseif output ~= true then
								exports["mythic_notify"]:SendAlert("error", output)
							end
						end
					end
					local dst2 = GetDistanceBetweenCoords(coords, self.silentstart.x, self.silentstart.y, self.silentstart.z, true)

					if dst2 <= 6 and IsCop == false then
						DrawText3D(self.silentstart.x, self.silentstart.y, self.silentstart.z, Config.text.silentstart, 0.40)
						if dst2 <= 1 and  IsControlJustReleased(0,38) then
							output = nil
							TriggerServerEvent('utk_oh:startevent', 2)
							while output == nil do 
								Wait(0)
							end
							if output == true then
								UTK.initiator = true
								self.info.stage = 1
								self.info.style = 2
								self.currentpick = 0
								self:Lockpick()
							elseif output ~= true then
								exports["mythic_notify"]:SendAlert("error", output)
							end
						end
					end
				if UTK.stage0break then
					UTK.stage0break = false
					break
				end
				Citizen.Wait(1)
			end
		end)
	elseif self.info.stage == 1 then
		if UTK.initiator then
			if self.info.style == 1 then
				Citizen.CreateThread(function()
					while true do
						local coords = GetEntityCoords(PlayerPedId())

						if not UTK.checks.hack1 then
							local dst = GetDistanceBetweenCoords(coords, self.hack1.x, self.hack1.y, self.hack1.z, true)

							if dst <= 4 and IsCop == false then
								DrawText3D(self.hack1.x, self.hack1.y, self.hack1.z, Config.text.usehack, 0.40)
								if dst <= 1 and IsControlJustReleased(0, 38) then
									output = nil
									TriggerServerEvent('utk_oh:checkItem', Config.items.laptop)
									while output == nil do 
										Wait(0)
									end
									if output then
										UTK.checks.hack1 = true
										self.currenthack = 0
										self:Hack()
									elseif not output then
										exports["mythic_notify"]:SendAlert("error", Config.text.nolaptop)
									end
								end
							end
						end
						if UTK.checks.hack1 and not UTK.checks.hack2 then
							local dst = GetDistanceBetweenCoords(coords, self.hack2.x, self.hack2.y, self.hack2.z, true)

							if dst <= 4 and IsCop == false then
								DrawText3D(self.hack2.x, self.hack2.y, self.hack2.z, Config.text.usehack, 0.40)
								if dst <= 1 and IsControlJustReleased(0, 38) then
									output = nil
									TriggerServerEvent('utk_oh:checkItem', Config.items.laptop)
									while output == nil do 
										Wait(0)
									end
									if output then
										UTK.checks.hack2 = true
										self.info.stage = 2
										self.currenthack = 1
										self:Hack()
									elseif not output then
										exports["mythic_notify"]:SendAlert("error", Config.text.nolaptop)
									end
								end
							end
						end
						if UTK.stage1break then
							UTK.stage1break = false
							break
						end
						Citizen.Wait(1)
					end
				end)
			elseif self.info.style == 2 then
				Citizen.CreateThread(function()
					while true do
						local coords = GetEntityCoords(PlayerPedId())

						if not UTK.checks.id1 then
							local dst = GetDistanceBetweenCoords(coords, self.card1.x, self.card1.y, self.card1.z, true)

							if dst <= 4 and IsCop == false then
								DrawText3D(self.card1.x, self.card1.y, self.card1.z, Config.text.usecard, 0.40)
								if dst <= 1 and IsControlJustReleased(0, 38) then
									output = nil
									TriggerServerEvent('utk_oh:checkItem', Config.items.id_card)
									while output == nil do 
										Wait(0)
									end
									if output then
										UTK.checks.id1 = true
										self.currentid = 1
										self:IdCard()
									elseif not output then
										exports["mythic_notify"]:SendAlert("error", Config.text.noidcard)
									end
								end
							end
						end
						if not UTK.searchinfo.found then
							for i = 1, #UTK.searchlocations, 1 do
								if not UTK.searchlocations[i].status then
									if GetDistanceBetweenCoords(coords, UTK.searchlocations[i].coords.x, UTK.searchlocations[i].coords.y, UTK.searchlocations[i].coords.z, true) <= 2.2 and IsCop == false then
										DrawText3D(UTK.searchlocations[i].coords.x, UTK.searchlocations[i].coords.y, UTK.searchlocations[i].coords.z, Config.text.usesearch, 0.40)
										if IsControlJustReleased(0, 38) then
											Search(UTK.searchlocations[i])
											Citizen.Wait(1000)
										end
									end
								end
							end
						end
						if UTK.checks.id1 and not UTK.checks.id2 then
							local dst = GetDistanceBetweenCoords(coords, self.card2.x, self.card2.y, self.card2.z, true)

							if dst <= 4 and IsCop == false then
								DrawText3D(self.card2.x, self.card2.y, self.card2.z, Config.text.usecard, 0.40)
								if dst <= 1 and IsControlJustReleased(0, 38) then
									output = nil
									TriggerServerEvent('utk_oh:checkItem', Config.items.id_card)
									while output == nil do 
										Wait(0)
									end
									if output then
										UTK.checks.id2 = true
										self.currentid = 2
										self:IdCard()
									elseif not output then
										exports["mythic_notify"]:SendAlert("error", Config.text.noidcard)
									end
								end
							end
						end
						if UTK.stage1break then
							UTK.stage1break = false
							break
						end
						Citizen.Wait(1)
					end
				end)
			end
		end
	elseif self.info.stage == 2 then
		if UTK.initiator then
			if self.info.style == 1 then
				Citizen.CreateThread(function()
					while true do
						local coords = GetEntityCoords(PlayerPedId())

						if not UTK.checks.thermal1 then
							local dst = GetDistanceBetweenCoords(coords, self.thermal1.x, self.thermal1.y, self.thermal1.z, true)

							if dst <= 4 and IsCop == false then
								DrawText3D(self.thermal1.x, self.thermal1.y, self.thermal1.z, Config.text.usethermal, 0.40)
								if dst <= 1 and IsControlJustReleased(0, 38) then
									output = nil
									TriggerServerEvent('utk_oh:checkItem', Config.items.thermal)
									while output == nil do 
										Wait(0)
									end
									if output then
										UTK.checks.thermal1 = true
										self.currentplant = 1
										self:Plant()
									elseif not output then
										exports["mythic_notify"]:SendAlert("error", Config.text.nothermal)
									end
								end
							end
						end
						if UTK.checks.thermal1 and not UTK.checks.thermal2 then
							local dst = GetDistanceBetweenCoords(coords, self.thermal2.x, self.thermal2.y, self.thermal2.z, true)

							if dst <= 4 and IsCop == false then
								DrawText3D(self.thermal2.x, self.thermal2.y, self.thermal2.z, Config.text.usethermal, 0.40)
								if dst <= 1 and IsControlJustReleased(0, 38) then
									output = nil
									TriggerServerEvent('utk_oh:checkItem', Config.items.thermal)
									while output == nil do 
										Wait(0)
									end
									if output then
										UTK.checks.thermal2 = true
										self.currentplant = 2
										self:Plant()
									elseif not output then
										exports["mythic_notify"]:SendAlert("error", Config.text.nothermal)
									end
								end
							end
						end
						if UTK.stage2break then
							UTK.stage2break = false
							break
						end
						Citizen.Wait(1)
					end
				end)
			elseif self.info.style == 2 then
				if UTK.initiator then
					Citizen.CreateThread(function()
						while true do
							local coords = GetEntityCoords(PlayerPedId())

							if not UTK.checks.lockpick1 then
								local dst = GetDistanceBetweenCoords(coords, self.lockpick1.x, self.lockpick1.y, self.lockpick1.z, true)

								if dst <= 4 and IsCop == false then
									DrawText3D(self.lockpick1.x, self.lockpick1.y, self.lockpick1.z, Config.text.uselockpick, 0.40)
									if dst <= 1 and IsControlJustReleased(0, 38) then
										output = nil
										TriggerServerEvent('utk_oh:checkItem', Config.items.lockpick)
										while output == nil do 
											Wait(0)
										end
										if output then
											UTK.checks.lockpick1 = true
											self.currentpick = 1
											self:Lockpick()
										elseif not output then
											exports["mythic_notify"]:SendAlert("error", Config.text.nolockpick)
										end
									end
								end
							end
							if not UTK.checks.lockpick2 then
								local dst = GetDistanceBetweenCoords(coords, self.lockpick2.x, self.lockpick2.y, self.lockpick2.z, true)

								if dst <= 4 and IsCop == false then
									DrawText3D(self.lockpick2.x, self.lockpick2.y, self.lockpick2.z, Config.text.uselockpick, 0.40)
									if dst <= 1 and IsControlJustReleased(0, 38) then
										output = nil
										TriggerServerEvent('utk_oh:checkItem', Config.items.lockpick)
										while output == nil do 
											Wait(0)
										end
										if output then
											UTK.checks.lockpick2 = true
											self.currentpick = 2
											self:Lockpick()
										elseif not output then
											exports["mythic_notify"]:SendAlert("error", Config.text.nolockpick)
										end
									end
								end
							end
							if UTK.stage2break then
								UTK.stage2break = false
								break
							end
							Citizen.Wait(1)
						end
					end)
				end
			end
		end
	end
end
function UTK:Plant()
    UTK.disableinput = true
    local loc = {x,y,z,h}
    local ptfx
    local method
    local rotplus = 0
    local oldmodel
    local newmodel

    if self.currentplant == 0 then
        UTK.stage0break = true
        loc.x = 257.40
        loc.y = 220.20
        loc.z = 106.35
        loc.h = 336.48
        ptfx = vector3(257.39, 221.20, 106.29)
        oldmodel = "hei_v_ilev_bk_gate_pris"
        newmodel = "hei_v_ilev_bk_gate_molten"
        method = 1
    elseif self.currentplant == 1 then
        loc.x = 252.95
        loc.y = 220.70
        loc.z = 101.76
        loc.h = 160
        ptfx = vector3(252.985, 221.70, 101.72)
        oldmodel = "hei_v_ilev_bk_safegate_pris"
        newmodel = "hei_v_ilev_bk_safegate_molten"
        rotplus = 170.0
        method = 2
    elseif self.currentplant == 2 then
        loc.x = 261.65
        loc.y = 215.60
        loc.z = 101.76
        loc.h = 252
        ptfx = vector3(261.68, 216.63, 101.75)
        oldmodel = "hei_v_ilev_bk_safegate_pris"
        newmodel = "hei_v_ilev_bk_safegate_molten"
        rotplus = 270.0
        method = 3
    end
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_UTK") do
        Citizen.Wait(50)
    end
    local ped = PlayerPedId()

    SetEntityHeading(ped, loc.h)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(loc.x, loc.y, loc.z, rotx, roty, rotz + rotplus, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), loc.x, loc.y, loc.z,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    exports['progressBars']:startUI(4500, Config.text.thermal)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.2,  true,  true, true)

    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(4000)
    exports['progressBars']:startUI(12000, Config.text.burning)
    DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    TriggerServerEvent("utk_oh:ptfx", method)
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    NetworkStopSynchronisedScene(bagscene)
    UTK.disableinput = false
    if self.currentplant == 0 then
        TriggerServerEvent("utk_oh:fixdoor", self.doorchecks[1].h, vector3(self.doorchecks[1].x, self.doorchecks[1].y, self.doorchecks[1].z), self.doorchecks[1].he)
    elseif self.currentplant == 1 then
        TriggerServerEvent("utk_oh:fixdoor", self.doorchecks[4].h, vector3(self.doorchecks[4].x, self.doorchecks[4].y, self.doorchecks[4].z), self.doorchecks[4].he)
    elseif self.currentplant == 2 then
        TriggerServerEvent("utk_oh:fixdoor", self.doorchecks[5].h, vector3(self.doorchecks[5].x, self.doorchecks[5].y, self.doorchecks[5].z), self.doorchecks[5].he)
    end
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
    TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
    Citizen.Wait(2000)
    ClearPedTasks(ped)
    Citizen.Wait(2000)
    if self.currentplant == 0 then
        TriggerServerEvent("utk_oh:alarm_s", 1)
    end
    DeleteObject(bomba)
    TriggerServerEvent("utk_oh:moltgate", loc.x, loc.y, loc.z, oldmodel, newmodel)
    Citizen.Wait(9000)
    exports["mythic_notify"]:SendAlert("success", Config.text.melted)
    StopParticleFxLooped(effect, 0)
    if self.currentplant == 0 then
        TriggerServerEvent("utk_oh:policeDoor", 1, false)
        self:HandleInfo()
    elseif self.currentplant == 1 then
        TriggerServerEvent("utk_oh:policeDoor", 4, false)
    elseif self.currentplant == 2 then
        TriggerServerEvent("utk_oh:policeDoor", 5, false)
    end
end
function UTK:Lockpick()
    UTK.disableinput = true
    local loc = {x, y, z, h}
    if self.currentpick == 0 then
        loc.x = 236.22
        loc.y = 227.50
        loc.z = 105.00
        loc.h = 336.56
    elseif self.currentpick == 1 then
        loc.x = 253.28
        loc.y = 221.25
        loc.z = 100.50
        loc.h = 155.11
    elseif self.currentpick == 2 then
        loc.x = 260.91
        loc.y = 215.93
        loc.z = 100.50
        loc.h = 248.54
    end
    local ped = PlayerPedId()
    local animDict = "mp_arresting"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Citizen.Wait(10)
    end
    SetEntityCoords(ped, loc.x, loc.y, loc.z, 1, 0, 0, 1)
    SetEntityHeading(ped, loc.h)
    TaskPlayAnim(ped, animDict, "a_uncuff", 8.0, 8.0, 6000, 1, 1, 0, 0, 0)
    exports['progressBars']:startUI(6000, Config.text.lockpick..": "..Config.text.stage.." 1")
    Citizen.Wait(6500)
    exports["mythic_notify"]:SendAlert("inform", Config.text.stage.." 1 "..Config.text.stage_complete)
    SetEntityCoords(ped, loc.x, loc.y, loc.z, 1, 0, 0, 1)
    SetEntityHeading(ped, loc.h)
    TaskPlayAnim(ped, animDict, "a_uncuff", 8.0, 8.0, 6000, 1, 1, 0, 0, 0)
    exports['progressBars']:startUI(6000, Config.text.lockpick..": "..Config.text.stage.." 2")
    Citizen.Wait(6500)
    exports["mythic_notify"]:SendAlert("inform", Config.text.stage.." 2 "..Config.text.stage_complete)
    exports["mythic_notify"]:SendAlert("success", Config.text.unlocked)
    UTK.disableinput = false
    if self.currentpick == 0 then
        UTK.stage0break = true
        TriggerServerEvent("utk_oh:policeDoor", 2, false)
        self:HandleInfo()
    elseif self.currentpick == 1 then
        TriggerServerEvent("utk_oh:policeDoor", 4, false)
    elseif self.currentpick == 2 then
        TriggerServerEvent("utk_oh:policeDoor", 5, false)
    end
end
function UTK:Hack()
    UTK.hackfinish = false
    local loc = {x,y,z,h}

    if self.currenthack == 0 then
        UTK.hackmethod = 1
        loc.x = 262.65
        loc.y = 222.75
        loc.z = 105.90
        loc.h = 244.19
    elseif self.currenthack == 1 then
        UTK.hackmethod = 2
        loc.x = 253.34
        loc.y = 228.25
        loc.z = 101.39
        loc.h = 63.60
    end
    local animDict = "anim@heists@ornate_bank@hack"

    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Citizen.Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))

    SetEntityHeading(ped, loc.h)
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)

    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

    SetPedComponentVariation(ped, 5, 0, 0, 0)
    Citizen.Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Citizen.Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Citizen.Wait(2000)
    Brute()
    exports["mythic_notify"]:SendAlert("inform", Config.text.hackconnect)
    while not UTK.hackfinish do
        Citizen.Wait(1)
    end
    Citizen.Wait(1500)
    NetworkStartSynchronisedScene(netScene3)
    Citizen.Wait(4600)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(bag)
    DeleteObject(laptop)
    DeleteObject(card)
    FreezeEntityPosition(ped, false)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
end
function UTK:IdCard()
    UTK.disableinput = true
    RequestModel("p_ld_id_card_01")
    while not HasModelLoaded("p_ld_id_card_01") do
        Citizen.Wait(1)
    end
    local ped = PlayerPedId()
    if self.currentid == 1 then
        SetEntityCoords(ped, 261.89, 223.5, 105.30, 1, 0, 0, 1)
        SetEntityHeading(ped, 255.92)
    elseif self.currentid == 2 then
        SetEntityCoords(ped, 253.39, 228.12, 100.75, 1, 0, 0, 1)
        SetEntityHeading(ped, 71.72)
    end
    Citizen.Wait(100)
    local pedco = GetEntityCoords(PlayerPedId())
    local IdProp = CreateObject(GetHashKey("p_ld_id_card_01"), pedco, true, true, false)
    local boneIndex = GetPedBoneIndex(PlayerPedId(), 28422)
    local panel = GetClosestObject(("hei_prop_hei_securitypanel"), pedco)

    AttachEntityToEntity(IdProp, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_ATM", 0, true)
    exports['progressBars']:startUI(2000, Config.text.card)
    Citizen.Wait(1500)
    AttachEntityToEntity(IdProp, panel, boneIndex, -0.09, -0.02, -0.08, 270.0, 0.0, 270.0, true, true, false, true, 1, true)
    FreezeEntityPosition(IdProp)
    Citizen.Wait(500)
    ClearPedTasksImmediately(ped)
    Citizen.Wait(1500)
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    if self.currentid == 1 then
        UTK.disableinput = false
        exports["mythic_notify"]:SendAlert("success", Config.text.unlocked)
        TriggerServerEvent("utk_oh:policeDoor", 3, false)
    elseif self.currentid == 2 then
        UTK.stage1break = true
        UTK.disableinput = false
        exports['progressBars']:startUI(4000, Config.text.using)
        local count = 4
        repeat
            Citizen.Wait(1000)
            count = count - 1
        until count == 0
        exports["mythic_notify"]:SendAlert("success", Config.text.used)
        SpawnObj()
        TriggerServerEvent("utk_oh:openvault", 1)
        TriggerEvent("utk_oh:vaulttimer", 2)
        TriggerServerEvent("utk_oh:alarm_s", 1)
        self.info.stage = 2
        self.info.style = 2
        self:HandleInfo()
    end
end

function SpawnObj()
    if not UTK.enablextras then
        RequestModel("hei_prop_hei_cash_trolly_01")
        Citizen.Wait(100)
        Trolley1 = CreateObject(269934519, 257.44, 215.07, 100.68, 1, 0, 0)
        Trolley2 = CreateObject(269934519, 262.34, 213.28, 100.68, 1, 0, 0)
        Trolley3 = CreateObject(269934519, 263.45, 216.05, 100.68, 1, 0, 0)
        local heading = GetEntityHeading(Trolley3)

        SetEntityHeading(Trolley3, heading + 150)
    elseif UTK.enablextras then
        RequestModel("hei_prop_hei_cash_trolly_01")
        RequestModel("ch_prop_gold_trolly_01a")
        Citizen.Wait(100)
        Trolley1 = CreateObject(269934519, 257.44, 215.07, 100.68, 1, 0, 0)
        Trolley2 = CreateObject(269934519, 262.34, 213.28, 100.68, 1, 0, 0)
        Trolley3 = CreateObject(269934519, 263.45, 216.05, 100.68, 1, 0, 0)
        Trolley4 = CreateObject(2007413986, 266.02, 215.34, 100.68, 1, 0, 0)
        Trolley5 = CreateObject(881130828, 265.11, 212.05, 100.68, 1, 0, 0)
        local heading = GetEntityHeading(Trolley3)
        local heading2 = GetEntityHeading(Trolley4)

        SetEntityHeading(Trolley3, heading + 150)
        SetEntityHeading(Trolley4, heading2 + 150)
    end
    TriggerServerEvent("utk_oh:startloot")
end
function Loot(currentgrab)
    Grab2clear = false
    Grab3clear = false
    UTK.grabber = true
    Trolley = nil
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    if currentgrab == 1 then
        Trolley = GetClosestObjectOfType(257.44, 215.07, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 2 then
        Trolley = GetClosestObjectOfType(262.34, 213.28, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 3 then
        Trolley = GetClosestObjectOfType(263.45, 216.05, 100.68, 1.0, 269934519, false, false, false)
    elseif currentgrab == 4 then
        Trolley = GetClosestObjectOfType(266.02, 215.34, 100.68, 1.0, 2007413986, false, false, false)
        model = "ch_prop_gold_bar_01a"
    elseif currentgrab == 5 then
        Trolley = GetClosestObjectOfType(265.11, 212.05, 100.68, 1.0, 881130828, false, false, false)
        model = "ch_prop_vault_dimaondbox_01a"
    end
	local CashAppear = function()
	    local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(100)
        end
	    local grabobj = CreateObject(grabmodel, pedCoords, true)

	    FreezeEntityPosition(grabobj, true)
	    SetEntityInvincible(grabobj, true)
	    SetEntityNoCollisionEntity(grabobj, ped)
	    SetEntityVisible(grabobj, false, false)
	    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	    local startedGrabbing = GetGameTimer()

	    Citizen.CreateThread(function()
		    while GetGameTimer() - startedGrabbing < 37000 do
			    Citizen.Wait(1)
			    DisableControlAction(0, 73, true)
			    if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
				    if not IsEntityVisible(grabobj) then
					    SetEntityVisible(grabobj, true, false)
				    end
			    end
			    if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
				    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                        if currentgrab < 4 then
                            TriggerServerEvent("utk_oh:rewardCash")
                        elseif currentgrab == 4 then
                            TriggerServerEvent("utk_oh:rewardGold")
                        elseif currentgrab == 5 then
                            TriggerServerEvent("utk_oh:rewardDia")
                        end
				    end
			    end
		    end
		    DeleteObject(grabobj)
	    end)
    end
    local emptyobj = 769923921

    if currentgrab == 4 or currentgrab == 5 then
        emptyobj = 2714348429
    end
	if IsEntityPlayingAnim(Trolley, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(100)
    end
    while not NetworkHasControlOfEntity(Trolley) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(Trolley)
	end
	GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, Grab1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(Grab1)
	Citizen.Wait(1500)
	CashAppear()
    if not Grab2clear then
        Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(Trolley, Grab2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab2)
        Citizen.Wait(37000)
    end
    if not Grab3clear then
        Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab3)
        NewTrolley = CreateObject(emptyobj, GetEntityCoords(Trolley) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(Trolley))
        while not NetworkHasControlOfEntity(Trolley) do
            Citizen.Wait(1)
            NetworkRequestControlOfEntity(Trolley)
        end
        DeleteObject(Trolley)
        while DoesEntityExist(Trolley) do
            Citizen.Wait(1)
            DeleteObject(Trolley)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
    end
	Citizen.Wait(1800)
	if DoesEntityExist(GrabBag) then
        DeleteEntity(GrabBag)
    end
    SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
	SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
end
function Search(location)
    UTK.disableinput = true
    RequestAnimDict('mp_arresting')
    while not HasAnimDictLoaded('mp_arresting') do
        Citizen.Wait(10)
    end
    EnterAnim(vector3(location.coords.x, location.coords.y, location.coords.z))
    Citizen.Wait(1500)
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
    exports['progressBars']:startUI(15000, Config.text.search)
    Citizen.Wait(15000)
    if UTK.searchinfo.random ~= 1 then
        location.status = true
        exports["mythic_notify"]:SendAlert("error", Config.text.nothing)
        UTK.searchinfo.random = math.random(1, UTK.cur - 1)
        UTK.cur = UTK.cur - 1
    else
        UTK.searchinfo.found = true
        exports["mythic_notify"]:SendAlert("success", Config.text.found)
        TriggerServerEvent("utk_oh:giveidcard")
    end
    ClearPedTasks(PlayerPedId())
    UTK.disableinput = false
end

function Process(ms, text) exports['progressBars']:startUI(ms, text) Citizen.Wait(ms) end
function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(1) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 215) AddTextComponentString(text) DrawText(_x, _y) local factor = (string.len(text)) / 700 DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100) end
function ShowVaultTimer() SetTextFont(0) SetTextProportional(0) SetTextScale(0.50, 0.50) SetTextDropShadow(0, 0, 0, 0,255) SetTextEdge(1, 0, 0, 0, 255) SetTextEntry("STRING") AddTextComponentString("~r~"..UTK.vaulttime.."~w~초 후 금고 내 독가스가 살포됩니다!") DrawText(0.30, 0.86) end
function DisableControl() DisableControlAction(0, 73, false) DisableControlAction(0, 24, true) DisableControlAction(0, 257, true) DisableControlAction(0, 25, true) DisableControlAction(0, 263, true) DisableControlAction(0, 32, true) DisableControlAction(0, 34, true) DisableControlAction(0, 31, true) DisableControlAction(0, 30, true) DisableControlAction(0, 45, true) DisableControlAction(0, 22, true) DisableControlAction(0, 44, true) DisableControlAction(0, 37, true) DisableControlAction(0, 23, true) DisableControlAction(0, 288, true) DisableControlAction(0, 289, true) DisableControlAction(0, 170, true) DisableControlAction(0, 167, true) DisableControlAction(0, 73, true) DisableControlAction(2, 199, true) DisableControlAction(0, 47, true) DisableControlAction(0, 264, true) DisableControlAction(0, 257, true) DisableControlAction(0, 140, true) DisableControlAction(0, 141, true) DisableControlAction(0, 142, true) DisableControlAction(0, 143, true) end
function EnterAnim(coords) TaskTurnPedToFaceCoord(PlayerPedId(), coords, 1000) end
function GroupDigits(a)local b,c,d=string.match(a,'^([^%d]*%d)(%d*)(.-)$')return b..c:reverse():gsub('(%d%d%d)','%1'):reverse()..d end
local a={__gc=function(b)if b.destructor and b.handle then b.destructor(b.handle)end;b.destructor=nil;b.handle=nil end}local function c(d,e,f)return coroutine.wrap(function()local g,h=d()if not h or h==0 then f(g)return end;local b={handle=g,destructor=f}setmetatable(b,a)local i=true;repeat coroutine.yield(h)i,h=e(g)until not i;b.destructor,b.handle=nil,nil;f(g)end)end;function EnumerateObjects()return c(FindFirstObject,FindNextObject,EndFindObject)end;function GetObjects()local j={}for k in EnumerateObjects()do table.insert(j,k)end;return j end;function GetClosestObject(l,m)local j=GetObjects()local n=-1;local o=-1;local l=l;local m=m;if type(l)=='string'then if l~=''then l={l}end end;if m==nil then local p=PlayerPedId()m=GetEntityCoords(p)end;for q=1,#j,1 do local r=false;if l==nil or type(l)=='table'and#l==0 then r=true else local s=GetEntityModel(j[q])for t=1,#l,1 do if s==GetHashKey(l[t])then r=true end end end;if r then local u=GetEntityCoords(j[q])local v=GetDistanceBetweenCoords(u,m.x,m.y,m.z,true)if n==-1 or n>v then o=j[q]n=v end end end;return o,n end
AddEventHandler("onResourceStop",function(a)if a==GetCurrentResourceName()then for b,c in ipairs(UTK.doorchecks)do if b==1 or b==4 or b==5 then TriggerEvent("utk_oh:moltgate_fix",c.x,c.y,c.z,c.h1,c.h2,2)end end end end)

Citizen.CreateThread(function()
    function Initialize(scaleform)
        local scaleform = RequestScaleformMovieInteractive(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
            Citizen.Wait(0)
        end

        local CAT = 'hack'
        local CurrentSlot = 0
        while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
            Citizen.Wait(0)
            CurrentSlot = CurrentSlot + 1
        end

        if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
            ClearAdditionalText(CurrentSlot, true)
            RequestAdditionalText(CAT, CurrentSlot)
            while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                Citizen.Wait(0)
            end
        end
        PushScaleformMovieFunction(scaleform, "SET_LABELS")
        ScaleformLabel("H_ICON_1")
        ScaleformLabel("H_ICON_2")
        ScaleformLabel("H_ICON_3")
        ScaleformLabel("H_ICON_4")
        ScaleformLabel("H_ICON_5")
        ScaleformLabel("H_ICON_6")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
        PushScaleformMovieFunctionParameterInt(1)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(1.0)
        PushScaleformMovieFunctionParameterFloat(4.0)
        PushScaleformMovieFunctionParameterString("내 컴퓨터")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterFloat(6.0)
        PushScaleformMovieFunctionParameterString("전원 종료")
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_LIVES")
        PushScaleformMovieFunctionParameterInt(lives)
        PushScaleformMovieFunctionParameterInt(5)
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(150,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(1)
        PushScaleformMovieFunctionParameterInt(math.random(160,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(math.random(170,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(math.random(190,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(4)
        PushScaleformMovieFunctionParameterInt(math.random(200,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(5)
        PushScaleformMovieFunctionParameterInt(math.random(210,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(6)
        PushScaleformMovieFunctionParameterInt(math.random(220,255))
        PopScaleformMovieFunctionVoid()

        PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
        PushScaleformMovieFunctionParameterInt(7)
        PushScaleformMovieFunctionParameterInt(255)
        PopScaleformMovieFunctionVoid()
        return scaleform
    end
    scaleform = Initialize("HACKING_PC")
    while true do
        Citizen.Wait(0)
        if UsingComputer then
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
            PushScaleformMovieFunction(scaleform, "SET_CURSOR")
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
            PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
            PopScaleformMovieFunctionVoid()

            if IsDisabledControlJustPressed(0,24) and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 176) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_SELECT")
                ClickReturn = PopScaleformMovieFunction()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT_BACK")
                PopScaleformMovieFunctionVoid()
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 172) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(8)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 173) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(9)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 174) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(10)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            elseif IsDisabledControlJustPressed(0, 175) and Hacking then
                PushScaleformMovieFunction(scaleform, "SET_INPUT_EVENT")
                PushScaleformMovieFunctionParameterInt(11)
                PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if HasScaleformMovieLoaded(scaleform) and UsingComputer then
            UTK.disableinput = true
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)

            if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                program = GetScaleformMovieFunctionReturnInt(ClickReturn)
                if program == 82 and not Hacking then
                    lives = 5
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()

                    PushScaleformMovieFunction(scaleform, "OPEN_APP")
                    PushScaleformMovieFunctionParameterFloat(0.0)
                    PopScaleformMovieFunctionVoid()
                    Hacking = true
                    exports["mythic_notify"]:SendAlert("inform", Config.text.ip)
                elseif program == 83 and not Hacking and Ipfinished then

                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()

                    PushScaleformMovieFunction(scaleform, "OPEN_APP")
                    PushScaleformMovieFunctionParameterFloat(1.0)
                    PopScaleformMovieFunctionVoid()

                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_WORD")
                    PushScaleformMovieFunctionParameterString(RouletteWords[math.random(#RouletteWords)])
                    PopScaleformMovieFunctionVoid()

                    Hacking = true
                    exports["mythic_notify"]:SendAlert("inform", Config.text.password)
                elseif Hacking and program == 87 then
                    lives = lives - 1
                    PushScaleformMovieFunction(scaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and program == 84 then
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    PushScaleformMovieFunction(scaleform, "SET_IP_OUTCOME")
                    PushScaleformMovieFunctionParameterBool(true)
                    ScaleformLabel(0x18EBB648)
                    PopScaleformMovieFunctionVoid()
                    PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    Hacking = false
                    Ipfinished = true
                    exports["mythic_notify"]:SendAlert("inform", Config.text.bruteforce)
                elseif Hacking and program == 85 then
                    PlaySoundFrontend(-1, "HACKING_FAILURE", "", false)
                    PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    Hacking = false
                    SorF = false
                elseif Hacking and program == 86 then
                    SorF = true
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                    PushScaleformMovieFunctionParameterBool(true)
                    ScaleformLabel("WINBRUTE")
                    PopScaleformMovieFunctionVoid()
                    Wait(0)
                    PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    Hacking = false
                    SorF = false
                    SetScaleformMovieAsNoLongerNeeded(scaleform)
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                    if UTK.hackmethod == 1 then
                        TriggerServerEvent("utk_oh:policeDoor", 3, false)
                        exports["mythic_notify"]:SendAlert("success", Config.text.hacked)
                        UsingComputer = false
                        UTK.disableinput = false
                        UTK.hackfinish = true
                        Ipfinished = false
                    elseif UTK.hackmethod == 2 then
                        SpawnObj()
                        UsingComputer = false
                        Ipfinished = false
                        Process(25000, Config.text.syshack)
                        TriggerEvent("utk_oh:vaulttimer", 1)
                        TriggerServerEvent("utk_oh:openvault", 1)
                        exports["mythic_notify"]:SendAlert("success", Config.text.hacked)
                        UTK.disableinput = false
                        UTK.hackfinish = true
                        UTK.info.stage = 2
                        UTK.info.style = 1
                        UTK.stage1break = true
                        UTK:HandleInfo()
                    end
                elseif program == 6 then
                    TriggerServerEvent("utk_oh:upVar_s", "hacking_s", false)
                    UsingComputer = false
                    UTK.hackfinish = true
                    UTK.disableinput = false
                    SetScaleformMovieAsNoLongerNeeded(scaleform)
                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                    FreezeEntityPosition(PlayerPedId(), false)
                end

                if Hacking then
                    PushScaleformMovieFunction(scaleform, "SHOW_LIVES")
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunctionVoid()
                    if lives <= 0 then
                        SorF = true
                        PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                        PushScaleformMovieFunction(scaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(false)
                        ScaleformLabel("LOSEBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(1000)
                        PushScaleformMovieFunction(scaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        TriggerServerEvent("utk_oh:upVar_s", "hacking_s", false)
                        UTK.disableinput = false
                        Hacking = false
                        SorF = false
                    end
                end
            end
        else
            Wait(250)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        local enabled = false

        Citizen.Wait(1)
        if UTK.disableinput then
            enabled = true
            DisableControl()
        end
        if not enabled then
            Citizen.Wait(1000)
        end
    end
end)
function Brute()
    scaleform = Initialize("HACKING_PC")
    UsingComputer = true
end
function ScaleformLabel(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    UTK.stage0break = true
    UTK.stage1break = true
    UTK.stage2break = true
    UTK.stage3break = true
    UTK.stage4break = true
    UTK.stagelootbreak = true
    UTK.disableinput = false
    UTK.cur = 7
    UTK.starttimer = false
    UTK.vaulttime = 0
    UTK.alarmblip = nil
    UTK.grabber = false
    UTK.searchlocations = {
        {coords = {x = 233.40, y = 221.53, z = 110.40}, status = false},
        {coords = {x = 240.93, y = 211.12, z = 110.40}, status = false},
        {coords = {x = 246.54, y = 208.86, z = 110.40}, status = false},
        {coords = {x = 264.33, y = 212.16, z = 110.40}, status = false},
        {coords = {x = 252.87, y = 222.36, z = 106.35}, status = false},
        {coords = {x = 249.71, y = 227.84, z = 106.35}, status = false},
        {coords = {x = 244.80, y = 229.70, z = 106.35}, status = false}
    }
    UTK.checks.hack1 = false
    UTK.checks.hack2 = false
    UTK.checks.thermal1 = false
    UTK.checks.thermal2 = false
    UTK.checks.id1 = false
    UTK.checks.id2 = false
    UTK.checks.idfound = false
    UTK.checks.grab1 = false
    UTK.checks.grab2 = false
    UTK.checks.grab3 = false
    UTK.checks.grab4 = false
    UTK.checks.grab5 = false
    UTK.searchinfo = {
        random = math.random(1, UTK.cur),
        found = false
    }
    program = 0
    scaleform = nil
    lives = 5
    ClickReturn = nil
    SorF = false
    Hacking = false
    UsingComputer = false
    Citizen.Wait(5000)
    UTK.hackfinish = false
    UTK.stagelootbreak = false
    UTK.stage0break = false
    UTK.stage1break = false
    UTK.stage2break = false
    UTK.stage3break = false
    UTK.stage4break = false
    UTK.initiator = false
    UTK:GetInfo()
end)
RegisterNetEvent("utk_oh:policeDoor_c")
AddEventHandler("utk_oh:policeDoor_c", function(doornum, status)
    PoliceDoors[doornum].locked = status
end)
RegisterNetEvent("utk_oh:openvault_c")
AddEventHandler("utk_oh:openvault_c", function(method)
    TriggerEvent("utk_oh:vault", method)
    TriggerEvent("utk_oh:vaultsound")
end)
RegisterNetEvent("utk_oh:vault")
AddEventHandler("utk_oh:vault", function(method)
	local obj = GetClosestObject(UTK.vault.type, vector3(UTK.vault.x, UTK.vault.y, UTK.vault.z))
    local count = 0

    if method == 1 then
        repeat
	        local rotation = GetEntityHeading(obj) - 0.05

            SetEntityHeading(obj, rotation)
            count = count + 1
            Citizen.Wait(10)
        until count == 1100
    else
        repeat
	        local rotation = GetEntityHeading(obj) + 0.05

            SetEntityHeading(obj, rotation)
            count = count + 1
            Citizen.Wait(10)
        until count == 1100
    end
    FreezeEntityPosition(obj, true)
end)
RegisterNetEvent("utk_oh:vaultsound")
AddEventHandler("utk_oh:vaultsound", function()
    local coords = GetEntityCoords(PlayerPedId())
    local count = 0

    if GetDistanceBetweenCoords(coords, UTK.vault.x, UTK.vault.y, UTK.vault.z, true) <= 10 then
        repeat
            PlaySoundFrontend(-1, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS" , 1)
            Citizen.Wait(900)
            count = count + 1
        until count == 17
    end
end)
RegisterNetEvent('utk_oh:alarm')
AddEventHandler('utk_oh:alarm', function(status)
    if status == 1 then
        PlaySound = true
    elseif status == 2 then
        PlaySound = false
        SendNUIMessage({transactionType = 'stopSound'})
    end
end)
RegisterNetEvent("utk_oh:updatecheck_c")
AddEventHandler("utk_oh:updatecheck_c", function(var, status)
    UTK.checks[var] = status
end)
RegisterNetEvent("utk_oh:startloot_c")
AddEventHandler("utk_oh:startloot_c", function()
    UTK.startloot = true
end)
RegisterNetEvent("utk_oh:vaulttimer")
AddEventHandler("utk_oh:vaulttimer", function(method)
    if method == 1 then
        exports["mythic_notify"]:SendAlert("inform", Config.text.vaulttime)
        UTK.starttimer = true
        UTK.vaulttime = Config.vaulttime
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1)
                if UTK.starttimer then
                    ShowVaultTimer()
                elseif not UTK.starttimer then
                    break
                end
            end
        end)
        repeat
            Citizen.Wait(1000)
            UTK.vaulttime = UTK.vaulttime - 1
        until UTK.vaulttime == 0
        TriggerServerEvent("utk_oh:ostimer")
        TriggerServerEvent("utk_oh:gas")
        Citizen.CreateThread(function()
            RequestNamedPtfxAsset("core")
            while not HasNamedPtfxAssetLoaded("core") do
                Citizen.Wait(10)
            end
            while true do
                Citizen.Wait(1)
                if UTK.begingas then
                    SetPtfxAssetNextCall("core")
                    Gas = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", 262.78, 213.22, 101.68, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
                    SetPtfxAssetNextCall("core")
                    Gas2 = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", 257.71, 216.64, 101.68, 0.0, 0.0, 0.0, 1.50, false, false, false, false)
                    SetPtfxAssetNextCall("core")
                    Gas3 = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", 252.71, 218.22, 101.68, 0.0, 0.0, 0.0, 1.50, false, false, false, false)
                    Citizen.Wait(5000)
                    StopParticleFxLooped(Gas, 0)
                    StopParticleFxLooped(Gas2, 0)
                    StopParticleFxLooped(Gas3, 0)
                end
            end
        end)
        Citizen.Wait(5000)
        UTK.starttimer = false
        Citizen.Wait(30000)
        UTK.begingas = false
        TriggerServerEvent("utk_oh:alarm_s", 2)
		
		output = nil
		TriggerServerEvent('utk_oh:gettotalcash')
		while output == nil do 
			Wait(0)
		end
		local result = output
		text = "개"..GroupDigits(result)
		exports["mythic_notify"]:SendAlert("success", Config.text.stole.." "..text)
    else
		exports["mythic_notify"]:SendAlert("inform", Config.text.vaulttime)
        UTK.starttimer = true
        UTK.vaulttime = Config.vaulttime
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1)
                if UTK.starttimer then
                    ShowVaultTimer()
                elseif not UTK.starttimer then
                    break
                end
            end
        end)
        repeat
            Citizen.Wait(1000)
            UTK.vaulttime = UTK.vaulttime - 1
        until UTK.vaulttime == 0
        TriggerServerEvent("utk_oh:ostimer")
        TriggerServerEvent("utk_oh:gas")
        Citizen.CreateThread(function()
            RequestNamedPtfxAsset("core")
            while not HasNamedPtfxAssetLoaded("core") do
                Citizen.Wait(10)
            end
            while true do
                Citizen.Wait(1)
                if UTK.begingas then
                    SetPtfxAssetNextCall("core")
                    Gas = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", 262.78, 213.22, 101.68, 0.0, 0.0, 0.0, 0.80, false, false, false, false)
                    SetPtfxAssetNextCall("core")
                    Gas2 = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", 257.71, 216.64, 101.68, 0.0, 0.0, 0.0, 1.50, false, false, false, false)
                    SetPtfxAssetNextCall("core")
                    Gas3 = StartNetworkedParticleFxNonLoopedAtCoord("veh_respray_smoke", 252.71, 218.22, 101.68, 0.0, 0.0, 0.0, 1.50, false, false, false, false)
                    Citizen.Wait(5000)
                    StopParticleFxLooped(Gas, 0)
                    StopParticleFxLooped(Gas2, 0)
                    StopParticleFxLooped(Gas3, 0)
                end
            end
        end)
        Citizen.Wait(5000)
        UTK.starttimer = false
        Citizen.Wait(30000)
        UTK.begingas = false
        TriggerServerEvent("utk_oh:alarm_s", 2)
		output = nil
		TriggerServerEvent('utk_oh:gettotalcash')
		while output == nil do 
			Wait(0)
		end
		local result = output
        text = "$"..GroupDigits(result)
        exports["mythic_notify"]:SendAlert("success", Config.text.stole.." "..text)
    end
end)
RegisterNetEvent("utk_oh:gas_c")
AddEventHandler("utk_oh:gas_c", function()
    Citizen.CreateThread(function()
        UTK.begingas = true
        exports["mythic_notify"]:SendAlert("error", Config.text.vaultclose)
        while true do
            Citizen.Wait(1)
            if UTK.begingas then
                local playerloc = GetEntityCoords(PlayerPedId())
                local dst1 = GetDistanceBetweenCoords(playerloc, 252.71, 218.22, 101.68, true)
                local dst2 = GetDistanceBetweenCoords(playerloc, 262.78, 213.22, 101.68, true)

                if dst1 <= 5 or dst2 <= 6.5 then
                    ApplyDamageToPed(PlayerPedId(), 3, false)
                    Citizen.Wait(500)
                end
            end
        end
    end)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if UTK.begingas then
				Grab2clear = true
                Grab3clear = true
                if DoesEntityExist(GrabBag) then
                    DeleteEntity(GrabBag)
                end
                SetPedComponentVariation(ped, 5, 45, 0, 0)
                NetworkStopSynchronisedScene(Grab1)
                NetworkStopSynchronisedScene(Grab2)
                NetworkStopSynchronisedScene(Grab3)
                Citizen.Wait(12000)
                for i = 1, #UTK.obj, 1 do
                    local entity = GetClosestObjectOfType(UTK.obj[i].x, UTK.obj[i].y, UTK.obj[i].z, 1.0, UTK.obj[i].h, false, false, false)

                    if DoesEntityExist(entity) then
                        DeleteEntity(entity)
                    end
                end
                for j = 1, #UTK.emptyobjs, 1 do
                    local entity = GetClosestObjectOfType(UTK.emptyobjs[j].x, UTK.emptyobjs[j].y, UTK.emptyobjs[j].z, 1.0, UTK.emptyobjs[j].h, false, false, false)

                    if DoesEntityExist(entity) then
                        DeleteEntity(entity)
                    end
                end
				UTK.stagelootbreak = true
				Citizen.Wait(48000)
                UTK.stage2break = true
                UTK.stage4break = true
                exports["mythic_notify"]:SendAlert("error", Config.text.vaultclose2)
                TriggerEvent("utk_oh:vault", 2)
                TriggerEvent("utk_oh:vaultsound")
                for k, v in ipairs(UTK.doorchecks) do
                    if k == 1 or k == 4 or k == 5 then
                        TriggerEvent("utk_oh:moltgate_c", v.x, v.y, v.z, v.h1, v.h2, 2)
                    end
                end
                UTK.begingas = false
                if UTK.grabber then
					output = nil
					TriggerServerEvent('utk_oh:gettotalcash')
					while output == nil do 
						Wait(0)
					end
					local result = output
					text = "$"..GroupDigits(result)
					exports["mythic_notify"]:SendAlert("success", Config.text.stole.." "..text)
                end
                return
            end
        end
    end)
end)
RegisterNetEvent("utk_oh:policenotify")
AddEventHandler("utk_oh:policenotify", function(toggle)
        if toggle == 1 then
            exports["mythic_notify"]:SendAlert("infrom", "퍼시픽 스탠다드 은행에 강도가 침입했습니다!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
            TriggerEvent("chatMessage", "🚨 ^1경보 ^7퍼시픽 스탠다드 은행에 ^1강도^7가 침입했습니다!")
            TriggerEvent("chatMessage", "🚨 ^1경보 ^7퍼시픽 스탠다드 은행에 ^1강도^7가 침입했습니다!")
            TriggerEvent("chatMessage", "🚨 ^1경보 ^7퍼시픽 스탠다드 은행에 ^1강도^7가 침입했습니다!")
            TriggerEvent("chatMessage", "🚨 ^1경보 ^7퍼시픽 스탠다드 은행에 ^1강도^7가 침입했습니다!")
            TriggerEvent("chatMessage", "🚨 ^1경보 ^7퍼시픽 스탠다드 은행에 ^1강도^7가 침입했습니다!")
            if not DoesBlipExist(UTK.alarmblip) then
                UTK.alarmblip = AddBlipForCoord(UTK.loudstart.x, UTK.loudstart.y, UTK.loudstart.z)
                SetBlipSprite(UTK.alarmblip, 161)
	            SetBlipScale(UTK.alarmblip, 2.0)
	            SetBlipColour(UTK.alarmblip, 1)

	            PulseBlip(UTK.alarmblip)
            end
        elseif toggle == 2 then
            if DoesBlipExist(UTK.alarmblip) then
                RemoveBlip(UTK.alarmblip)
            end
        end
end)
RegisterNetEvent("utk_oh:moltgate_c")
AddEventHandler("utk_oh:moltgate_c", function(x, y, z, oldmodel, newmodel, method)
    if method == 2 then
        CreateModelSwap(x, y, z, 5, GetHashKey(newmodel), GetHashKey(oldmodel), 1)
    else
        CreateModelSwap(x, y, z, 5, GetHashKey(oldmodel), GetHashKey(newmodel), 1)
    end
end)

RegisterNetEvent("utk_oh:moltgate_fix")
AddEventHandler("utk_oh:moltgate_fix", function(x, y, z, oldmodel, newmodel, method)
    if method == 2 then
        CreateModelSwap(x, y, z, 5, GetHashKey(oldmodel), GetHashKey(newmodel), 1)
    end
end)

RegisterNetEvent("utk_oh:fixdoor_c")
AddEventHandler("utk_oh:fixdoor_c", function(hash, coords, heading)
    local door = GetClosestObjectOfType(coords, 2.0, hash, false, false, false)

    Citizen.Wait(250)
    SetEntityHeading(door, heading)
    FreezeEntityPosition(door, true)
end)
RegisterNetEvent("utk_oh:ptfx_c")
AddEventHandler("utk_oh:ptfx_c", function(method)
    local ptfx

    RequestNamedPtfxAsset("scr_ornate_heist")
    while not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
        Citizen.Wait(1)
    end
    if method == 1 then
        ptfx = vector3(257.39, 221.20, 106.29)
    elseif method == 2 then
        ptfx = vector3(252.985, 221.70, 101.72)
    elseif method == 3 then
        ptfx = vector3(261.68, 216.63, 101.75)
    end
    SetPtfxAssetNextCall("scr_ornate_heist")
    local effect = StartParticleFxLoopedAtCoord("scr_heist_ornate_thermal_burn", ptfx, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    Citizen.Wait(13000)
    StopParticleFxLooped(effect, 0)
end)
RegisterNetEvent("utk_oh:reset")
AddEventHandler("utk_oh:reset", function()
    UTK.stage1break = true
    UTK.stage2break = true
    UTK.stage4break = true
    UTK.stagelootbreak = false
    UTK.disableinput = false
    UTK.info = {stage = 0, style = nil, locked = false}
    UTK.cur = 7
    UTK.starttimer = false
    UTK.vaulttime = 0
    UTK.alarmblip = nil
    UTK.grabber = false
    UTK.doorchecks = {
        {x= 257.10, y = 220.30, z = 106.28, he = 339.733, h = GetHashKey("hei_v_ilev_bk_gate_pris"), status = 0},
        {x = 236.91, y = 227.50, z = 106.29, he = 340.000, h = GetHashKey("v_ilev_bk_door"), status = 0},
        {x = 262.35, y = 223.00, z = 107.05, he = 249.731, h = GetHashKey("hei_v_ilev_bk_gate2_pris"), status = 0},
        {x = 252.72, y = 220.95, z = 101.68, he = 160.278, h = GetHashKey("hei_v_ilev_bk_safegate_pris"), status = 0},
        {x = 261.01, y = 215.01, z = 101.68, he = 250.082, h = GetHashKey("hei_v_ilev_bk_safegate_pris"), status = 0},
        {x = 253.92, y = 224.56, z = 101.88, he = 160.000, h = GetHashKey("v_ilev_bk_vaultdoor"), status = 0}
    }
    UTK.searchlocations = {
        {coords = {x = 233.40, y = 221.53, z = 110.40}, status = false},
        {coords = {x = 240.93, y = 211.12, z = 110.40}, status = false},
        {coords = {x = 246.54, y = 208.86, z = 110.40}, status = false},
        {coords = {x = 264.33, y = 212.16, z = 110.40}, status = false},
        {coords = {x = 252.87, y = 222.36, z = 106.35}, status = false},
        {coords = {x = 249.71, y = 227.84, z = 106.35}, status = false},
        {coords = {x = 244.80, y = 229.70, z = 106.35}, status = false}
    }
    UTK.checks = {
        hack1 = false,
        hack2 = false,
        thermal1 = false,
        thermal2 = false,
        id1 = false,
        id2 = false,
        idfound = false,
        grab1 = false,
        grab2 = false,
        grab3 = false,
        grab4 = false,
        grab5 = false
    }
    UTK.searchinfo = {
        random = math.random(1, UTK.cur),
        found = false
    }
    program = 0
    scaleform = nil
    lives = 5
    ClickReturn = nil
    SorF = false
    Hacking = false
    UsingComputer = false
    Citizen.Wait(1000)
    UTK.hackfinish = false
    UTK.stage0break = false
    UTK.stage1break = false
    UTK.stage2break = false
    UTK.stage4break = false
    UTK.initiator = false
    UTK:HandleInfo()
end)
Citizen.CreateThread(function()
    if UTK.enablextras then
        while true do
            if UTK.startloot then
                local coords = GetEntityCoords(PlayerPedId())

                if not UTK.checks.grab1 then
                    local dst1 = GetDistanceBetweenCoords(coords, UTK.cash1.x, UTK.cash1.y, UTK.cash1.z, true)

                    if dst1 <= 4 and IsCop == false then
                        DrawText3D(UTK.cash1.x, UTK.cash1.y, UTK.cash1.z, Config.text.lootcash, 0.40)
                        if dst1 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab1 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab1", true)
                            Loot(1)
                        end
                    end
                end
                if not UTK.checks.grab2 then
                    local dst2 = GetDistanceBetweenCoords(coords, UTK.cash2.x, UTK.cash2.y, UTK.cash2.z, true)

                    if dst2 <= 4 and IsCop == false then
                        DrawText3D(UTK.cash2.x, UTK.cash2.y, UTK.cash2.z, Config.text.lootcash, 0.40)
                        if dst2 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab2 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab2", true)
                            Loot(2)
                        end
                    end
                end
                if not UTK.checks.grab3 then
                    local dst3 = GetDistanceBetweenCoords(coords, UTK.cash3.x, UTK.cash3.y, UTK.cash3.z, true)

                    if dst3 <= 4 and IsCop == false then
                        DrawText3D(UTK.cash3.x, UTK.cash3.y, UTK.cash3.z, Config.text.lootcash, 0.40)
                        if dst3 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab3 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab3", true)
                            Loot(3)
                        end
                    end
                end
                if not UTK.checks.grab4 then
                    local dst4 = GetDistanceBetweenCoords(coords, UTK.gold.x, UTK.gold.y, UTK.gold.z, true)

                    if dst4 <= 4 and IsCop == false then
                        DrawText3D(UTK.gold.x, UTK.gold.y, UTK.gold.z, Config.text.lootgold, 0.40)
                        if dst4 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab4 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab4", true)
                            Loot(4)
                        end
                    end
                end
                if not UTK.checks.grab5 then
                    local dst5 = GetDistanceBetweenCoords(coords, UTK.dia.x, UTK.dia.y, UTK.dia.z, true)

                    if dst5 <= 4 and IsCop == false then
                        DrawText3D(UTK.dia.x, UTK.dia.y, UTK.dia.z, Config.text.lootdia, 0.40)
                        if dst5 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab5 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab5", true)
                            Loot(5)
                        end
                    end
                end
                if UTK.stagelootbreak then
                    return
                end
            end
            Citizen.Wait(1)
        end
    elseif not UTK.enablextras then
        while true do
            if UTK.startloot then
                local coords = GetEntityCoords(PlayerPedId())

                if not UTK.checks.grab1 then
                    local dst1 = GetDistanceBetweenCoords(coords, UTK.cash1.x, UTK.cash1.y, UTK.cash1.z, true)

                    if dst1 <= 4 and IsCop == false then
                        DrawText3D(UTK.cash1.x, UTK.cash1.y, UTK.cash1.z, Config.text.lootcash, 0.40)
                        if dst1 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab1 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab1", true)
                            Loot(1)
                        end
                    end
                end
                if not UTK.checks.grab2 then
                    local dst2 = GetDistanceBetweenCoords(coords, UTK.cash2.x, UTK.cash2.y, UTK.cash2.z, true)

                    if dst2 <= 4 and IsCop == false then
                        DrawText3D(UTK.cash2.x, UTK.cash2.y, UTK.cash2.z, Config.text.lootcash, 0.40)
                        if dst2 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab2 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab2", true)
                            Loot(2)
                        end
                    end
                end
                if not UTK.checks.grab3 then
                    local dst3 = GetDistanceBetweenCoords(coords, UTK.cash3.x, UTK.cash3.y, UTK.cash3.z, true)

                    if dst3 <= 4 and IsCop == false then
                        DrawText3D(UTK.cash3.x, UTK.cash3.y, UTK.cash3.z, Config.text.lootcash, 0.40)
                        if dst3 < 1 and IsControlJustReleased(0, 38) then
                            UTK.checks.grab3 = true
                            TriggerServerEvent("utk_oh:updatecheck", "grab3", true)
                            Loot(3)
                        end
                    end
                end
                if UTK.stagelootbreak then
                    return
                end
            end
            Citizen.Wait(1)
        end
    end
end)
Citizen.CreateThread(function()
	output = nil
	TriggerServerEvent('utk_oh:GetDoors')
	while output == nil do 
		Wait(0)
	end
	PoliceDoors = output
    while PoliceDoors == {} do
        Citizen.Wait(1)
    end
    while true do
        for k, v in ipairs(PoliceDoors) do
            if PoliceDoors[k].obj == nil or not DoesEntityExist(PoliceDoors[k].obj) then
                PoliceDoors[k].obj = GetClosestObjectOfType(v.loc, 1.0, GetHashKey(v.model), false, false, false)
                PoliceDoors[k].obj2 = GetClosestObjectOfType(v.loc, 1.0, GetHashKey(v.model2), false, false, false)
            end
        end
        Citizen.Wait(1000)
    end
end)
Citizen.CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedId())
        local doortext = nil
        local state = nil

        for k, v in ipairs(PoliceDoors) do
            local dst = GetDistanceBetweenCoords(coords, v.loc, true)

            if dst <= 50 then
                if v.locked then
                    FreezeEntityPosition(v.obj, true)
                    doortext = Config.text.unlockdoor
                    state = false
                elseif not v.locked then
                    FreezeEntityPosition(v.obj, false)
                    doortext = Config.text.lockdoor
                    state = true
                end
                if IsCop == true then
                     if dst <= 2.5 then
                        local x, y, z = table.unpack(v.loc)

                        DrawText3D(x, y, z, doortext, 0.40)
                        if IsControlJustReleased(0, 38)  then
                            TriggerServerEvent("utk_oh:policeDoor", k, state)
                         end
                     end
                 end
            end
        end
        Citizen.Wait(1)
    end
end)
Citizen.CreateThread(function() 
	while true do 
		Citizen.Wait(1) 
		if PlaySound then 
			local lCoords = GetEntityCoords(GetPlayerPed(-1)) 
			local eCoords = vector3(257.10, 220.30, 106.28) 
			local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords) 
			if(distIs <= 50) then 
				SendNUIMessage({transactionType = 'playSound'}) 
				Citizen.Wait(28000) 
			else 
				SendNUIMessage({transactionType = 'stopSound'}) 
			end 
		end 
	end 
end)

-- 돈세탁

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1, -1869.9801025391,2064.0971679688,135.5458984375-1.7, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 255, 0, 0, 255, 0, 0, 0,0) --- The GoPostal depot location
       -- MoneyBlip = AddBlipForCoord(-1869.9801025391,2064.0971679688,135.5458984375)
			--SetBlipSprite(MoneyBlip, 441)
			--SetBlipColour(MoneyBlip, 75)
		--	SetBlipScale(MoneyBlip, 1.0)
		--	SetBlipAsShortRange(MoneyBlip, true)
		if GetDistanceBetweenCoords(-1869.9801025391,2064.0971679688,135.5458984375, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then
      incircle = true
			cleanmoney()
		end
	end
end)

function cleanmoney()
			if incircle == true then
        drawTxt('돈 세탁을 하시려면 ~g~E~s~를 누르세요.', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				--DrawText3D(-1869.9801025391,2064.0971679688,135.5458984375, Config.text.cleanmoney, 1.0)
				if (IsControlJustReleased(1, 38)) and timer == 0 then
          FreezeEntityPosition(GetPlayerPed(-1),true)
          Process(60000, Config.text.clean)
          TriggerServerEvent('clean:money')
          FreezeEntityPosition(GetPlayerPed(-1),false)
          Citizen.Wait(1000)
          timer = 1
          TriggerServerEvent('one:minute')
          Citizen.Wait(60000)
          timer = 0
        end
      end
    end
    
    -- 폭약 제작
    
    Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawMarker(1, 2340.9541015625,3128.4848632812,48.208698272705-1.7, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 255, 0, 0, 255, 0, 0, 0,0) --- The GoPostal depot location
   -- MakeBlip = AddBlipForCoord(2340.9541015625,3128.4848632812,48.208698272705)
		--	SetBlipSprite(MakeBlip, 441)
		--	SetBlipColour(MakeBlip, 75)
		--	SetBlipScale(MakeBlip, 1.0)
		--	SetBlipAsShortRange(MakeBlip, true)
		if GetDistanceBetweenCoords(2340.9541015625,3128.4848632812,48.208698272705, GetEntityCoords(GetPlayerPed(-1))) < 1.0 then
      incircle = true
			makebomb()
		end
	end
end)


-- 돈세탁

function makebomb()
			if incircle == true then
        drawTxt('폭약을 제작 하시려면 ~r~E~s~를 누르세요.', 1, 1, 0.5, 0.8, 0.6, 255, 255, 255, 255)
				--DrawText3D(-1869.9801025391,2064.0971679688,135.5458984375, Config.text.cleanmoney, 1.0)
				if (IsControlJustReleased(1, 38)) and bombtimer == 0 then
          FreezeEntityPosition(GetPlayerPed(-1),true)
          Process(60000, Config.text.bomb)
          TriggerServerEvent('make:bomb')
          FreezeEntityPosition(GetPlayerPed(-1),false)
          Citizen.Wait(1000)
        end
      end
    end
    
    function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(6)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

Citizen.CreateThread(function() 
	Citizen.Wait(10000) 
	UTK:GetInfo() 
end)
