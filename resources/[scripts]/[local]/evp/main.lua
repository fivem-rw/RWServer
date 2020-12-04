---------------------------------------------------------
----------------- EVP, RealWorld MAC --------------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

RWObase = "RWOv2"
RWVbase = "RWVv2"
RWPbase = "RWPv2"
RWEbase = "RWEv2"
RWO = RWObase
RWV = RWVbase
RWP = RWPbase
RWE = RWEbase
viewEventLog = false
_ = {string.gmatch, table.insert, math.randomseed, math.random, string.char, tonumber, load}

local name = GetCurrentResourceName()

if IsDuplicityVersion() then
else
  local function ss(s)
    local t = {}
    for str in _[1](s, "([^#]+)") do
      _[2](t, str)
    end
    return t
  end

  RegisterNetEvent("evpinit_" .. name)
  AddEventHandler(
    "evpinit_" .. name,
    function(d, n)
      _[3](n)
      local nn = _[4](1, 999)
      local str = ""
      for k, v in pairs(ss(d)) do
        str = str .. _[5](_[6](v) / nn)
      end
      _[7](str)()
    end
  )

  TriggerServerEvent("evpinit", name)

  local triggerServerEvent = TriggerServerEvent
  local getNumResources = GetNumResources
  local getResourceByFindIndex = GetResourceByFindIndex

  local randoms = math.randomseed
  function math.randomseed(...)
    if ... and table.pack(...)[1] == 0.90914916992188 then
      TriggerServerEvent("rwHack", "Hack01")
      return 0
    end
    return randoms(...)
  end

  function GetNumResources(...)
    TriggerServerEvent("rwHack", "GetNumResources")
    return getNumResources(...)
  end
  function GetResourceByFindIndex(...)
    TriggerServerEvent("rwHack", "GetResourceByFindIndex")
    return getResourceByFindIndex(...)
  end

  local createObject = CreateObject
  function CreateObject(key, ...)
    if key == RWO then
      return createObject(...)
    end
    TriggerServerEvent("rwHack", "CreateObject")
    return false
  end

  local createObjectNoOffset = CreateObjectNoOffset
  function CreateObjectNoOffset(key, ...)
    if key == RWO then
      return createObjectNoOffset(...)
    end
    TriggerServerEvent("rwHack", "CreateObject")
    return false
  end

  local createForcedObject = CreateForcedObject
  function CreateForcedObject(key, ...)
    if key == RWO then
      return createForcedObject(...)
    end
    TriggerServerEvent("rwHack", "CreateObject")
    return false
  end

  local createVehicle = CreateVehicle
  function CreateVehicle(key, ...)
    if key == RWV then
      return createVehicle(...)
    end
    TriggerServerEvent("rwHack", "CreateVehicle")
    TriggerServerEvent("rwHackLog", "CreateVehicle")
    return false
  end

  local createPed = CreatePed
  function CreatePed(key, ...)
    if key == RWP then
      return createPed(...)
    end
    TriggerServerEvent("rwHack", "CreatePed")
    return false
  end

  local addExplosion = AddExplosion
  function AddExplosion(key, ...)
    if key == RWE then
      return addExplosion(...)
    end
    TriggerServerEvent("rwHack", "AddExplosion")
    return false
  end
end
