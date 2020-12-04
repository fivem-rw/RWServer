local eventPrefix = GetCurrentResourceName() .. ":"
local merge_task = {}
function merge_to_left_o(orig, new)
  merge_task[orig] = new

  local left = orig
  while left ~= nil do
    local right = merge_task[left]
    for new_key, new_val in pairs(right) do
      local old_val = left[new_key]
      if old_val == nil then
        left[new_key] = new_val
      else
        local old_type = type(old_val)
        local new_type = type(new_val)
        if (old_type == "table" and new_type == "table") then
          merge_task[old_val] = new_val
        else
          left[new_key] = new_val
        end
      end
    end
    merge_task[left] = nil
    left = next(merge_task)
  end
end

if IsDuplicityVersion() then
  local isShowEventLogT = false
  local isShowEventLogH = false
  local registerServerEvent, registerNetEvent, addEventHandler = RegisterServerEvent, RegisterNetEvent, AddEventHandler
  local triggerClientEvent = TriggerClientEvent
  local events = {}

  function TriggerClientEvent(...)
    if isShowEventLogT then
      print("TriggerClientEvent", ...)
    end
    return triggerClientEvent(...)
  end

  function RegisterServerEvent(event)
    events[event] = math.random(0xBAFF1ED)
    return registerServerEvent(event)
  end

  function AddEventHandler(event, func)
    if events[event] then
      return addEventHandler(
        event,
        function(code, ...)
          if isShowEventLogH then
            print("bEvent", ...)
          end

          --print(code, ...)
          if code ~= events[event] then
            --print("code error", event, code, events[event])
            return CancelEvent()
          end

          return func(...)
        end
      )
    end

    if isShowEventLogH then
      print("aEvent", event)
    end

    return addEventHandler(event, func)
  end

  registerServerEvent(eventPrefix .. "getEvents")
  addEventHandler(
    eventPrefix .. "getEvents",
    function()
      TriggerClientEvent(eventPrefix .. "recieveEvents", source, events)

      local root = "vrp:"
      if eventPrefix ~= root then
        TriggerClientEvent(root .. "recieveEvents", source, events)
      end
    end
  )

  Citizen.CreateThread(
    function()
      while true do
        if GetConvar("isShowEventLogT", "false") == "true" then
          isShowEventLogT = true
        else
          isShowEventLogT = false
        end
        if GetConvar("isShowEventLogH", "false") == "true" then
          isShowEventLogH = true
        else
          isShowEventLogH = false
        end
        Citizen.Wait(5000)
      end
    end
  )
else
  local triggerServerEvent = TriggerServerEvent
  local events = {}
  RegisterNetEvent(eventPrefix .. "recieveEvents")
  AddEventHandler(
    eventPrefix .. "recieveEvents",
    function(_events)
      merge_to_left_o(events, _events)
    end
  )

  function TriggerServerEvent(event, ...)
    while not events do
      Citizen.Wait(25)
    end
    return triggerServerEvent(event, events[event], ...)
  end
  triggerServerEvent(eventPrefix .. "getEvents")

  Citizen.CreateThread(
    function()
      while true do
        collectgarbage()
        collectgarbage()
        Citizen.Wait(60000)
      end
    end
  )
end
