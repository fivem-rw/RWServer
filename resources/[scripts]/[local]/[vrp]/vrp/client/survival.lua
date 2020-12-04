function tvRP.varyHealth(variation)
  local ped = GetPlayerPed(-1)
  local n = math.floor(GetEntityHealth(ped) + variation)
  ClearEntityLastDamageEntity(ped)
  SetEntityHealth(ped, n)
end

function tvRP.getHealth()
  return GetEntityHealth(GetPlayerPed(-1))
end

function tvRP.setHealth(health)
  local ped = GetPlayerPed(-1)
  local n = math.floor(health)
  ClearEntityLastDamageEntity(ped)
  SetEntityHealth(ped, n)
end

function tvRP.setFriendlyFire(flag)
  NetworkSetFriendlyFireOption(flag)
  SetCanAttackFriendly(GetPlayerPed(-1), flag, flag)
end

function tvRP.setPolice(flag)
  local player = PlayerId()
  SetPoliceIgnorePlayer(player, not flag)
  SetDispatchCopsForPlayer(player, flag)
end

-- impact thirst and hunger when the player is running (every 5 seconds)
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(5000)

      if IsPlayerPlaying(PlayerId()) then
        local ped = GetPlayerPed(-1)

        -- variations for one minute
        local vthirst = 0
        local vhunger = 0

        -- on foot, increase thirst/hunger in function of velocity
        if IsPedOnFoot(ped) and not tvRP.isNoclip() then
          local factor = math.min(tvRP.getSpeed(), 10)

          vthirst = vthirst + 1 * factor
          vhunger = vhunger + 0.5 * factor
        end

        -- in melee combat, increase
        if IsPedInMeleeCombat(ped) then
          vthirst = vthirst + 10
          vhunger = vhunger + 5
        end

        -- injured, hurt, increase
        if IsPedHurt(ped) or IsPedInjured(ped) then
          vthirst = vthirst + 2
          vhunger = vhunger + 1
        end

        -- do variation
        if vthirst ~= 0 then
          vRPserver.varyThirst({vthirst / 12.0})
        end

        if vhunger ~= 0 then
          vRPserver.varyHunger({vhunger / 12.0})
        end
      end
    end
  end
)

-- COMA SYSTEM

local isEnable = true

local in_coma = false
local coma_left = cfg.coma_duration * 60

local in_die = false
local die_left = cfg.die_duration * 60

Citizen.CreateThread(
  function()
    -- coma thread
    while true do
      Citizen.Wait(0)
      if isEnable then
        local ped = GetPlayerPed(-1)
        local health = GetEntityHealth(ped)
        if in_die then
          if die_left > 0 then
            SetEntityHealth(ped, cfg.die_threshold)
          else
            in_die = false
            SetTextChatEnabled(true)
            ClearPedBloodDamage(ped)
            tvRP.setHealth(0)
            tvRP.setRagdoll(false)
            tvRP.stopScreenEffect(cfg.coma_effect)
            tvRP.stopScreenEffect(cfg.die_effect)
            tvRP.giveWeapons({}, true)
            SetTimeout(
              5000,
              function()
                coma_left = cfg.coma_duration * 60
                die_left = cfg.die_duration * 60
                vRP.notify({"새로운 삶이 시작되었습니다."})
              end
            )
          end
        elseif in_coma then
          if health > cfg.coma_threshold then
            in_coma = false
            SetTextChatEnabled(true)
            ClearPedBloodDamage(ped)
            tvRP.setRagdoll(false)
            tvRP.stopScreenEffect(cfg.coma_effect)
            coma_left = cfg.coma_duration * 60
            local x, y, z = tvRP.getPosition()
            NetworkResurrectLocalPlayer(x, y, z, true, true, false)
            Citizen.Wait(0)
          elseif coma_left <= 0 then
            in_coma = false
            tvRP.stopScreenEffect(cfg.coma_effect)
            coma_left = cfg.coma_duration * 60
            in_die = true
            SetTextChatEnabled(false)
            ApplyPedDamagePack(ped, "Fall", 100, 100)
            tvRP.playScreenEffect(cfg.die_effect, -1)
          else
            SetEntityHealth(ped, cfg.coma_threshold)
          end
        else
          if health <= cfg.coma_threshold and coma_left > 0 and die_left > 0 then
            if IsEntityDead(ped) then
              local x, y, z = tvRP.getPosition()
              NetworkResurrectLocalPlayer(x, y, z, true, true, false)
              Citizen.Wait(0)
            end
            in_coma = true
            vRPserver.updateHealth({cfg.coma_threshold})
            SetEntityHealth(ped, cfg.coma_threshold)
            tvRP.playScreenEffect(cfg.coma_effect, -1)
            tvRP.ejectVehicle()
            tvRP.setRagdoll(true)
          end
        end
      end
    end
  end
)

function tvRP.setSurvival(enable)
  isEnable = enable
end

function tvRP.isInComa()
  return in_coma
end

function tvRP.isInDie()
  return in_die
end

function tvRP.getDieLeft()
  return die_left
end

-- kill the player if in coma
function tvRP.killComa()
  if in_coma then
    coma_left = 0
  end
end

Citizen.CreateThread(
  function()
    -- coma decrease thread
    while true do
      Citizen.Wait(1000)
      if in_coma then
        coma_left = coma_left - 1
      end
      if in_die then
        die_left = die_left - 1
      end
    end
  end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10000)
			local ped = GetPlayerPed(-1)
			local health = GetEntityHealth(ped)
			if in_coma then
				local x, y, z = tvRP.getPosition()
				NetworkResurrectLocalPlayer(x, y, z, true, true, false)
				Citizen.Wait(0)
				SetEntityHealth(ped, cfg.coma_threshold)
				Citizen.Wait(20000)
			end
		end
	end
)

Citizen.CreateThread(
  function()
    -- disable health regen, conflicts with coma system
    while true do
      Citizen.Wait(100)
      SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
    end
  end
)

Citizen.CreateThread(
  function()
    local effect = false
    local ped = GetPlayerPed(-1)
    while true do
      if in_die then
        vRP.notify({"~r~[사망소식] ~w~당신은 사망했습니다. ~r~" .. math.floor(die_left) .. "초~w~후 다시 태어납니다."})
        if effect then
          StopScreenEffect("Rampage")
          effect = false
        end
        Citizen.Wait(10000)
      else
        local Health = GetEntityHealth(ped)
        if Health > cfg.die_threshold and Health < cfg.warning_threshold then
          if not effect then
            StartScreenEffect("Rampage", 0, true)
            effect = true
          end
          if Health > cfg.coma_threshold then
            SetEntityHealth(ped, GetEntityHealth(ped) - 1)
            vRP.notify({"~r~[체력부족]~w~ 진통제를 복용해서 체력을 회복해주세요!"})
          end
          ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
          Citizen.Wait(7000)
        else
          if effect then
            StopScreenEffect("Rampage")
            effect = false
          end
        end
      end
      Citizen.Wait(0)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      if not IsControlPressed(0, 21) and IsControlJustReleased(1, 118) and not IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        vRPserver.revive()
      end
      Citizen.Wait(0)
    end
  end
)
