----------------- vRP Bag
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_bag")

local show = false
local temp_inventory = nil
local temp_weight = nil
local temp_maxWeight = nil
local cooldown = 0
local isRestControl = false
local isProcess = false

local PlayerProps = {}

function LoadAnim(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(10)
  end
end

function LoadPropDict(model)
  while not HasModelLoaded(GetHashKey(model)) do
    RequestModel(GetHashKey(model))
    Wait(10)
  end
end

function DestroyAllProps()
  for _, v in pairs(PlayerProps) do
    DeleteEntity(v)
  end
  PlayerHasProp = false
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
  local Player = PlayerPedId()
  local x, y, z = table.unpack(GetEntityCoords(Player))

  if not HasModelLoaded(prop1) then
    LoadPropDict(prop1)
  end

  prop = CreateObject(RWO, GetHashKey(prop1), x, y, z + 0.2, true, true, true)
  AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
  table.insert(PlayerProps, prop)
  PlayerHasProp = true
  SetModelAsNoLongerNeeded(prop1)
end

function openGui(inventory, weight, maxWeight)
  if show == false and not isProcess then
    isProcess = true
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = true,
        inventory = inventory,
        weight = weight,
        maxWeight = maxWeight
      }
    )
    ClearPedSecondaryTask(GetPlayerPed(-1))
    local ChosenDict = "missheistdocksprep1hold_cellphone"
    LoadAnim(ChosenDict)
    TaskPlayAnim(GetPlayerPed(-1), ChosenDict, "static", 2.0, 2.0, -1, 51, 0, false, false, false)
    RemoveAnimDict(ChosenDict)
    AddPropToPlayer("prop_ld_suitcase_01", 57005, 0.39, 0.0, 0.0, 0.0, 266.0, 60.0)
    Wait(500)
    isProcess = false
  end
end

function closeGui()
  if show and not isProcess then
    isProcess = true
    show = false
    SetNuiFocus(false)
    SendNUIMessage({show = false})

    ClearPedSecondaryTask(GetPlayerPed(-1))
    DestroyAllProps()

    Wait(500)

    isProcess = false
  end
end

function refreshGui(inventory, weight, maxWeight)
  if show then
    SendNUIMessage(
      {
        refresh = true,
        inventory = inventory,
        weight = weight,
        maxWeight = maxWeight
      }
    )
  end
end

RegisterNetEvent("vrp_bag:openGui")
AddEventHandler(
  "vrp_bag:openGui",
  function()
    if cooldown > 0 and temp_inventory ~= nil and temp_weight ~= nil and temp_maxWeight ~= nil then
      openGui(temp_inventory, temp_weight, temp_maxWeight)
    else
      TriggerServerEvent("vrp_bag:openGui")
    end
  end
)

RegisterNetEvent("vrp_bag:atualizarInventario")
AddEventHandler(
  "vrp_bag:atualizarInventario",
  function(inventory, weight, pesoMaximo)
    cooldown = Config.AntiSpaam
    temp_inventory = inventory
    temp_weight = weight
    temp_maxWeight = pesoMaximo
  end
)

RegisterNetEvent("vrp_bag:UINotification")
AddEventHandler(
  "vrp_bag:UINotification",
  function(type, title, message)
    show = true
    SetNuiFocus(true, true)
    SendNUIMessage(
      {
        show = true,
        notification = true,
        type = type,
        title = title,
        message = message
      }
    )
  end
)

RegisterNetEvent("vrp_bag:closeGui")
AddEventHandler(
  "vrp_bag:closeGui",
  function()
    closeGui()
  end
)

RegisterNetEvent("vrp_bag:refreshGui")
AddEventHandler(
  "vrp_bag:refreshGui",
  function()
    refreshGui(temp_inventory, temp_weight, temp_maxWeight)
  end
)

RegisterNetEvent("vrp_bag:objectForAnimation")
AddEventHandler(
  "vrp_bag:objectForAnimation",
  function(type)
    local ped = GetPlayerPed(-1)
    DeleteObject(object)
    bone = GetPedBoneIndex(ped, 60309)
    coords = GetEntityCoords(ped)
    modelHash = GetHashKey(type)

    RequestModel(modelHash)
    object = CreateObject(RWO, modelHash, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(object, ped, bone, 0.1, 0.0, 0.0, 1.0, 1.0, 1.0, 1, 1, 0, 0, 2, 1)
    Citizen.Wait(2500)
    DeleteObject(object)
  end
)

RegisterNUICallback(
  "close",
  function(data)
    closeGui()
  end
)

RegisterNUICallback(
  "customAction",
  function(data)
    cooldown = 0
    TriggerServerEvent("vrp_bag:customAction", data)
  end
)

RegisterNUICallback(
  "useItem",
  function(data)
    cooldown = 0
    TriggerServerEvent("vrp_bag:useItem", data)
  end
)

RegisterNUICallback(
  "dropItem",
  function(data)
    cooldown = 0
    TriggerServerEvent("vrp_bag:dropItem", data)
  end
)

RegisterNUICallback(
  "giveItem",
  function(data)
    cooldown = 0
    TriggerServerEvent("vrp_bag:giveItem", data)
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1000)
      isRestControl = false
      if vRP.isHandcuffed() or vRP.isInComa() or vRP.isInDie() then
        isRestControl = true
      end
      if isRestControl and show then
        closeGui()
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if not isRestControl and IsControlJustReleased(0, Config.AbrirMenu) then
        TriggerEvent("vrp_bag:openGui")
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(1000)
      if cooldown > 0 then
        cooldown = cooldown - 1
      end
    end
  end
)

AddEventHandler(
  "onResourceStop",
  function(resource)
    if resource == GetCurrentResourceName() then
      closeGui()
    end
  end
)
