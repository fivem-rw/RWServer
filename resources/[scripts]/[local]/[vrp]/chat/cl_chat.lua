vRP = Proxy.getInterface("vRP")

local isRDR = not TerraingridActivate and true or false

local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false
local isShowUI = true

RegisterNetEvent("chatMessage")
RegisterNetEvent("chat:addTemplate")
RegisterNetEvent("chat:addMessage")
RegisterNetEvent("chat:addSuggestion")
RegisterNetEvent("chat:addSuggestions")
RegisterNetEvent("chat:removeSuggestion")
RegisterNetEvent("chat:clear")

-- internal events
RegisterNetEvent("__cfx_internal:serverPrint")

RegisterNetEvent("_chat:messageEntered")

RegisterNetEvent("chat:changeShowUI")
AddEventHandler(
  "chat:changeShowUI",
  function(isShow)
    isShowUI = isShow
    SendNUIMessage(
      {
        type = "ON_CHANGE_SHOW_UI",
        message = {
          isShow = isShow
        }
      }
    )
  end
)

--deprecated, use chat:addMessage
AddEventHandler(
  "chatMessage",
  function(author, color, text, class)
    local args = {text}

    if author ~= "" then
      table.insert(args, 1, author)
    end

    SendNUIMessage(
      {
        type = "ON_MESSAGE",
        message = {
          color = color,
          multiline = true,
          args = args,
          class = class or ""
        }
      }
    )
  end
)

AddEventHandler(
  "__cfx_internal:serverPrint",
  function(msg)
    print(msg)

    SendNUIMessage(
      {
        type = "ON_MESSAGE",
        message = {
          templateId = "print",
          multiline = true,
          args = {msg}
        }
      }
    )
  end
)

AddEventHandler(
  "chat:addMessage",
  function(message)
    SendNUIMessage(
      {
        type = "ON_MESSAGE",
        message = message
      }
    )
  end
)

AddEventHandler(
  "chat:addSuggestion",
  function(name, help, params)
    SendNUIMessage(
      {
        type = "ON_SUGGESTION_ADD",
        suggestion = {
          name = name,
          help = help,
          params = params or nil
        }
      }
    )
  end
)

AddEventHandler(
  "chat:addSuggestions",
  function(suggestions)
    for _, suggestion in ipairs(suggestions) do
      SendNUIMessage(
        {
          type = "ON_SUGGESTION_ADD",
          suggestion = suggestion
        }
      )
    end
  end
)

AddEventHandler(
  "chat:removeSuggestion",
  function(name)
    SendNUIMessage(
      {
        type = "ON_SUGGESTION_REMOVE",
        name = name
      }
    )
  end
)

AddEventHandler(
  "chat:addTemplate",
  function(id, html)
    SendNUIMessage(
      {
        type = "ON_TEMPLATE_ADD",
        template = {
          id = id,
          html = html
        }
      }
    )
  end
)

AddEventHandler(
  "chat:clear",
  function(name)
    SendNUIMessage(
      {
        type = "ON_CLEAR"
      }
    )
  end
)

RegisterNUICallback(
  "chatResult",
  function(data, cb)
    chatInputActive = false
    SetNuiFocus(false)

    if not data.canceled then
      local id = PlayerId()

      local custom = {}
      custom.isJailed = vRP.isJailed({})
      custom.isComa = vRP.isInComa({})
      custom.isDie = vRP.isInDie({})

      --deprecated
      local r, g, b = 0, 0x99, 255

      if custom.isDie == true then
        TriggerEvent("chatMessage", "알림", {255, 0, 255}, "죽은 상태에서는 메세지를 보낼 수 없습니다.")
      elseif custom.isComa == true and not (data.message:sub(1, 4) == "/ooc" or data.message:sub(1, 7) == "/전체") then
        TriggerEvent("chatMessage", "알림", {255, 0, 255}, "혼수 상태에서는 메세지를 보낼 수 없습니다.")
      else
        if data.message:sub(1, 1) == "/" then
          if custom.isJailed == true then
            TriggerEvent("chatMessage", "알림", {255, 0, 255}, "구금 상태에서는 해당 메세지를 보낼 수 없습니다.")
          else
            ExecuteCommand(data.message:sub(2))
          end
        else
          TriggerServerEvent("_chat:messageEntered", GetPlayerName(id), {r, g, b}, data.message, custom)
        end
      end
    end

    cb("ok")
  end
)

local function refreshCommands()
  if GetRegisteredCommands then
    local registeredCommands = GetRegisteredCommands()

    local suggestions = {}

    for _, command in ipairs(registeredCommands) do
      if IsAceAllowed(("command.%s"):format(command.name)) then
        table.insert(
          suggestions,
          {
            name = "/" .. command.name,
            help = ""
          }
        )
      end
    end

    TriggerEvent("chat:addSuggestions", suggestions)
  end
end

local function refreshThemes()
  local themes = {}

  for resIdx = 0, GetNumResources() - 1 do
    local resource = GetResourceByFindIndex(resIdx)

    if GetResourceState(resource) == "started" then
      local numThemes = GetNumResourceMetadata(resource, "chat_theme")

      if numThemes > 0 then
        local themeName = GetResourceMetadata(resource, "chat_theme")
        local themeData = json.decode(GetResourceMetadata(resource, "chat_theme_extra") or "null")

        if themeName and themeData then
          themeData.baseUrl = "nui://" .. resource .. "/"
          themes[themeName] = themeData
        end
      end
    end
  end

  SendNUIMessage(
    {
      type = "ON_UPDATE_THEMES",
      themes = themes
    }
  )
end

AddEventHandler(
  "onClientResourceStart",
  function(resName)
    Wait(500)

    refreshCommands()
    --refreshThemes()
  end
)

AddEventHandler(
  "onClientResourceStop",
  function(resName)
    Wait(500)

    refreshCommands()
    --refreshThemes()
  end
)

RegisterNUICallback(
  "loaded",
  function(data, cb)
    TriggerServerEvent("chat:init")

    refreshCommands()
    --refreshThemes()

    chatLoaded = true

    cb("ok")
  end
)

Citizen.CreateThread(
  function()
    SetTextChatEnabled(false)
    SetNuiFocus(false)

    while true do
      Wait(0)

      if not chatInputActive then
        if isShowUI and IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
          chatInputActive = true
          chatInputActivating = true

          SendNUIMessage(
            {
              type = "ON_OPEN"
            }
          )
        end
      end

      if chatInputActivating then
        if isShowUI and not IsControlPressed(0, 245) then
          SetNuiFocus(true)

          chatInputActivating = false
        end
      end

      if chatLoaded then
        local shouldBeHidden = false

        if IsScreenFadedOut() or IsPauseMenuActive() then
          shouldBeHidden = true
        end

        if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
          chatHidden = shouldBeHidden

          SendNUIMessage(
            {
              type = "ON_SCREEN_STATE_CHANGE",
              shouldHide = shouldBeHidden
            }
          )
        end
      end
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(3600000)
      TriggerEvent("chat:clear")
    end
  end
)
