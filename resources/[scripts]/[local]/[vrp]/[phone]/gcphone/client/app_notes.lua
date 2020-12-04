RegisterNetEvent("gcPhone:notes_receive")
AddEventHandler(
  "gcPhone:notes_receive",
  function(message)
    SendNUIMessage({event = "notes_receive", message = message})
  end
)

RegisterNetEvent("gcPhone:notes_channel")
AddEventHandler(
  "gcPhone:notes_channel",
  function(channel, messages)
    local tmpTable = {}
    for i = 1, #messages do
      table.insert(tmpTable, messages[#messages + 1 - i])
    end
    SendNUIMessage({event = "notes_channel", messages = tmpTable})
  end
)

RegisterNUICallback(
  "notes_addMessage",
  function(data, cb)
    TriggerServerEvent("gcPhone:notes_addMessage", data.channel, data.message)
  end
)

RegisterNUICallback(
  "notes_getChannel",
  function(data, cb)
    TriggerServerEvent("gcPhone:notes_channel", data.channel)
  end
)
