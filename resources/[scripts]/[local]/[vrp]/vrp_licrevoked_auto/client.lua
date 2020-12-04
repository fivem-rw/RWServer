vrp_licrevoked_autoC = {}
Tunnel.bindInterface("vrp_licrevoked_auto", vrp_licrevoked_autoC)
Proxy.addInterface("vrp_licrevoked_auto", vrp_licrevoked_autoC)
vRP = Proxy.getInterface("vRP")
vrp_licrevoked_autoS = Tunnel.getInterface("vrp_licrevoked_auto", "vrp_licrevoked_auto")

Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(60000)
      vrp_licrevoked_autoS.checkAuthRestLicense()
    end
  end
)