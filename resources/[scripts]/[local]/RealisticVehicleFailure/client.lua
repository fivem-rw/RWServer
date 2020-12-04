------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--	
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--

local deformationMultiplier = 5.0			-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch
local weaponsDamageMultiplier = 1.0			-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
local damageFactorEngine = 1.0					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
local damageFactorBody = 100.0					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
local damageFactorPetrolTank = 64.0				-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 64
local cascadingFailureSpeedFactor = 8.0			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8
local degradingHealthSpeedFactor = 0.05			-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving.
local degradingFailureThreshold = 800.0			-- Below this value, slow health degradation will set in
local cascadingFailureThreshold = 350.0			-- Below this value, health cascading failure will set in
local engineSafeGuard = 100.0					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.
local displayBlips = true						-- Show blips for mechanics locations


-- id=446 for wrench icon, id=72 for spraycan icon
local mechanics = {
	{name="준비중", id=446, r=25.0, x=437.0,   y=3568.0,  z=38.0}		-- Auto Shop, Grand Senora Desert
}

local fixMessages = {
	"You put the oil plug back in",
	"You stopped the oil leak using chewing gum",
	"You repaired the oil tube with gaffer tape",
	"You tightened the oil pan screw and stopped the dripping",
	"You kicked the engine and it magically came back to life",
	"You removed some rust from the spark tube",
	"You yelled at your vehicle, and it somehow had an effect"
}
local fixMessageCount = 7
local fixMessagePos = math.random(fixMessageCount)

local noFixMessages = {
	"You checked the oil plug. It's still there",
	"You looked at your engine, it seemed fine",
	"You made sure that the gaffer tape was still holding the engine together",
	"You turned up the radio volume. It just drowned out the weird engine noises",
	"You added rust-preventer to the spark tube. It made no difference",
	"Never fix something that ain't broken they said. You didn't listen. At least it didn't get worse"
}
local noFixMessageCount = 6
local noFixMessagePos = math.random(noFixMessageCount)

local pedInVehicleLast=false
local lastVehicle
local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0

local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0

local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0

local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0

-- Display blips on map
Citizen.CreateThread(function()
	if (displayBlips == true) then
	  for _, item in pairs(mechanics) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	  end
	end
end)
  
RegisterNetEvent('iens:repair')
AddEventHandler('iens:repair', function()
	if isPedInVehicle() then
		local ped = GetPlayerPed(-1)		
		local vehicle = GetVehiclePedIsIn(ped, false)
		if IsNearMechanic() then
			SetVehicleUndriveable(vehicle,false)
			SetVehicleFixed(vehicle)
			healthBodyLast=1000.0
			healthEngineLast=1000.0
			healthPetrolTankLast=1000.0
			SetVehicleEngineOn(vehicle, true, false )
			notification("~g~The mechanic repaired your car!")
			return
		end
		if GetVehicleEngineHealth(vehicle) < cascadingFailureThreshold + 5 then
			if GetVehicleOilLevel(vehicle) > 0 then
				SetVehicleUndriveable(vehicle,false)
				SetVehicleEngineHealth(vehicle, cascadingFailureThreshold + 5)
				SetVehiclePetrolTankHealth(vehicle, 750.0)
				healthEngineLast=cascadingFailureThreshold +5
				healthPetrolTankLast=750.0
					SetVehicleEngineOn(vehicle, true, false )
				SetVehicleOilLevel(vehicle,(GetVehicleOilLevel(vehicle)/3)-0.5)
				notification("~g~" .. fixMessages[fixMessagePos] .. ", now get to a mechanic!")
				fixMessagePos = fixMessagePos + 1
				if fixMessagePos > fixMessageCount then fixMessagePos = 1 end
			else
				notification("~r~Your vehicle was too badly damaged. Unable to repair!")
			end
		else
			notification("~y~" .. noFixMessages[noFixMessagePos] )
			noFixMessagePos = noFixMessagePos + 1
			if noFixMessagePos > noFixMessageCount then noFixMessagePos = 1 end
		end
	else
		notification("~y~You must be in a vehicle to be able to repair it")
	end
end)

RegisterNetEvent('iens:notAllowed')
AddEventHandler('iens:notAllowed', function()
	notification("~r~You don't have permission to repair vehicles")
end)

function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end

function IsNearMechanic()
	local ped = GetPlayerPed(-1)
	local pedLocation = GetEntityCoords(ped, 0)
	for _, item in pairs(mechanics) do
		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  pedLocation["x"], pedLocation["y"], pedLocation["z"], true)
		if distance <= item.r then
			return true
		end
	end
end

function isPedInVehicle()
	local ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
	if IsPedInAnyVehicle(ped, false) then
		-- Check if ped is in driver seat
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			local class = GetVehicleClass(vehicle)
			-- We don't want planes, helicopters, bicycles and trains
			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
				return true
			end
		end
	end
	return false
end


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(50)
		local ped = GetPlayerPed(-1)
		if isPedInVehicle() then
			vehicle = GetVehiclePedIsIn(ped, false)
			healthEngineCurrent = GetVehicleEngineHealth(vehicle)
			if healthEngineCurrent == 1000 then healthBodyLast = 1000.0 end
			healthEngineNew = healthEngineCurrent
			healthEngineDelta = healthEngineLast - healthEngineCurrent
			healthEngineDeltaScaled = healthEngineDelta * damageFactorEngine
			
			healthBodyCurrent = GetVehicleBodyHealth(vehicle)
			if healthBodyCurrent == 1000 then healthBodyLast = 1000.0 end
			healthBodyNew = healthBodyCurrent
			healthBodyDelta = healthBodyLast - healthBodyCurrent
			healthBodyDeltaScaled = healthBodyDelta * damageFactorBody
			
			healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
			if healthPetrolTankCurrent == 1000 then healthPetrolTankLast = 1000.0 end
			healthPetrolTankNew = healthPetrolTankCurrent 
			healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
			healthPetrolTankDeltaScaled = healthPetrolTankDelta * damageFactorPetrolTank
			
			if healthEngineCurrent > engineSafeGuard+1 then
				SetVehicleUndriveable(vehicle,false)
			end

			if healthEngineCurrent <= engineSafeGuard+1 then
				SetVehicleUndriveable(vehicle,true)
			end

			-- If ped spawned a new vehicle while in a vehicle or teleported from one vehicle to another, handle as if we just entered the car
			if vehicle ~= lastVehicle then
				pedInVehicleLast = false
			end


			if pedInVehicleLast == true then
				-- Damage happened while in the car, can be multiplied

				-- Only do calculations if any damage is present on the car. Prevents weird behavior when fixing using trainer or other script
				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then

					-- Combine the delta values
					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled--[[, healthBodyDeltaScaled]], healthPetrolTankDeltaScaled)

					-- If huge damage, scale back a bit
					if healthEngineCombinedDelta > (healthEngineCurrent - engineSafeGuard) then
						healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
					end

					-- If complete damage, but not catastrophic (ie. explosion territory) pull back a bit, to give a couple of seconds og engine runtime before dying
					if healthEngineCombinedDelta > healthEngineCurrent then
						healthEngineCombinedDelta = healthEngineCurrent - (cascadingFailureThreshold / 5)
					end



					------- Calculate new value

					healthEngineNew = healthEngineLast - healthEngineCombinedDelta


					------- Sanity Check on new values and further manipulations

					-- If somewhat damaged, slowly degrade until slightly before cascading failure sets in, then stop

					if healthEngineNew > (cascadingFailureThreshold + 5) and healthEngineNew < degradingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.038 * degradingHealthSpeedFactor)
					end
	
					-- If Damage is near catastrophic, cascade the failure
					if healthEngineNew < cascadingFailureThreshold then
						healthEngineNew = healthEngineNew-(0.1 * cascadingFailureSpeedFactor)
					end

					-- Prevent Engine going to or below zero. Ensures you can reenter a damaged car. 
					if healthEngineNew < engineSafeGuard then
						healthEngineNew = engineSafeGuard 
					end

					-- Prevent Explosions
					if healthPetrolTankCurrent < 750 then
						healthPetrolTankNew = 750.0
					end

					-- Prevent negative body damage.
					if healthBodyNew < 0  then
						healthBodyNew = 0.0
					end
				end
			else
				-- Just got in the vehicle. Damage can not be multiplied this round

				-- Set vehicle handling data
				if deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', deformationMultiplier) end
				if weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', weaponsDamageMultiplier/damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody
				
				-- If body damage catastrophic, reset somewhat so we can get new damage to multiply
				if healthBodyCurrent < cascadingFailureThreshold then
					healthBodyNew = cascadingFailureThreshold
				end
				pedInVehicleLast = true
			end

			-- set the actual new values
			if healthEngineNew ~= healthEngineCurrent then SetVehicleEngineHealth(vehicle, healthEngineNew) end
			if healthBodyNew ~= healthBodyCurrent then SetVehicleBodyHealth(vehicle, healthBodyNew) end
			if healthPetrolTankNew ~= healthPetrolTankCurrent then SetVehiclePetrolTankHealth(vehicle, healthPetrolTankNew) end

			-- Store current values, so we can calculate delta next time around
			healthEngineLast = healthEngineNew
			healthBodyLast = healthBodyNew
			healthPetrolTankLast = healthPetrolTankNew
			lastVehicle=vehicle
		else
			if pedInVehicleLast == true then
				-- We just got out of the car
				if weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fWeaponDamageMult', weaponsDamageMultiplier) end	-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor	
			end
			pedInVehicleLast = false
		end
	end
end)

