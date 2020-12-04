function notesGetMessageChannel(channel, cb)
  MySQL.Async.fetchAll(
    "SELECT * FROM phone_app_notes WHERE channel = @channel ORDER BY time DESC LIMIT 20",
    {
      ["@channel"] = channel
    },
    cb
  )
end

function notesAddMessage(channel, message, user_id, name)
  local Query = "INSERT INTO phone_app_notes (`channel`, `message`, `user_id`, `name`) VALUES(@channel, @message, @user_id, @name);"
  local Query2 = "SELECT * from phone_app_notes WHERE `id` = @id;"
  local Parameters = {
    ["@channel"] = channel,
    ["@message"] = message,
    ["@user_id"] = user_id,
    ["@name"] = name
  }
  MySQL.Async.insert(
    Query,
    Parameters,
    function(id)
      MySQL.Async.fetchAll(
        Query2,
        {["@id"] = id},
        function(reponse)
          TriggerClientEvent("gcPhone:notes_receive", -1, reponse[1])
        end
      )
    end
  )
end

RegisterServerEvent("gcPhone:notes_channel")
AddEventHandler(
  "gcPhone:notes_channel",
  function(channel)
    local sourcePlayer = tonumber(source)
    notesGetMessageChannel(
      channel,
      function(messages)
        TriggerClientEvent("gcPhone:notes_channel", sourcePlayer, channel, messages)
      end
    )
  end
)

RegisterServerEvent("gcPhone:notes_addMessage")
AddEventHandler(
  "gcPhone:notes_addMessage",
  function(channel, message)
    local player = source
    local user_id = vRP.getUserId({player})
    if not user_id then
      return
    end
    local name = GetPlayerName(player)
    notesAddMessage(channel, message, user_id, name)
  end
)
