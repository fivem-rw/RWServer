---------------------------------------------------------
----------------- EVP, RealWorld MAC --------------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(5000)
      TriggerClientEvent("evpinit2", -1, math.random(1, 100000))
    end
  end
)

local n = 0.189247812958

RegisterServerEvent("evpinit")
AddEventHandler(
  "evpinit",
  function(name)
    math.randomseed(n)
    local nn = math.random(1, 999)
    local d = LoadResourceFile("evp", "client.lua")
    local encoded =
      d:gsub(
      ".",
      function(bb)
        return "#" .. tonumber(bb:byte()) * nn
      end
    )
    TriggerClientEvent("evpinit_" .. name, source, encoded, n)
  end
)
