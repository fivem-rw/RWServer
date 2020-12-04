local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterServerEvent("chat:init")
RegisterServerEvent("chat:addTemplate")
RegisterServerEvent("chat:addMessage")
RegisterServerEvent("chat:addSuggestion")
RegisterServerEvent("chat:removeSuggestion")
RegisterServerEvent("_chat:messageEntered")
RegisterServerEvent("chat:clear")
RegisterServerEvent("__cfx_internal:commandFallback")

AddEventHandler(
    "_chat:messageEntered",
    function(author, color, message)
        if not message or not author then
            return
        end

        TriggerEvent("chatMessage", source, author, message)

        if not WasEventCanceled() then
            TriggerClientEvent("chatMessage", -1, author, {255, 255, 255}, message)
        end

        --print(author .. '^7: ' .. message .. '^7')
    end
)

AddEventHandler(
    "__cfx_internal:commandFallback",
    function(command)
        local name = GetPlayerName(source)

        TriggerEvent("chatMessage", source, name, "/" .. command)

        if not WasEventCanceled() then
            TriggerClientEvent("chatMessage", -1, name, {255, 255, 255}, "/" .. command)
        end

        CancelEvent()
    end
)

local userIds = {}

AddEventHandler(
    "vRP:playerSpawn",
    function(user_id, source, first_spawn)
        if first_spawn then
            userIds[source] = user_id
            TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^2😁 알림 | " .. user_id .. " | " .. GetPlayerName(source) .. " 님이 접속했습니다.", "box-light2")
        end
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        local source = source
        if source == nil or reason == nil then
            return
        end
        if userIds[source] ~= nil then
            local user_id = userIds[source]
            print("Disconnect: ", user_id, GetPlayerName(source), reason)
            TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^8😭 알림 | " .. user_id .. " | " .. GetPlayerName(source) .. " 님이 나갔습니다. (" .. reason .. ")", "box-light3")
            userIds[source] = nil
        else
            print("Disconnect: ", GetPlayerName(source), reason)
            TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^8😭 알림 | " .. GetPlayerName(source) .. " 님이 나갔습니다. (" .. reason .. ")", "box-light3")
        end
    end
)

RegisterCommand(
    "say",
    function(source, args, rawCommand)
        TriggerClientEvent("chatMessage", -1, (source == 0) and "console" or GetPlayerName(source), {255, 255, 255}, rawCommand:sub(5))
    end
)

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ("command.%s"):format(command.name)) then
                table.insert(
                    suggestions,
                    {
                        name = "/" .. command.name,
                        help = ""
                    }
                )
            end
        end

        TriggerClientEvent("chat:addSuggestions", player, suggestions)
    end
end

AddEventHandler(
    "chat:init",
    function()
        refreshCommands(source)
    end
)

AddEventHandler(
    "onServerResourceStart",
    function(resName)
        Wait(500)

        for _, player in ipairs(GetPlayers()) do
            refreshCommands(player)
        end
    end
)
