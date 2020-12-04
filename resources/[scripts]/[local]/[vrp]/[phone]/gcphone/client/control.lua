RegisterNUICallback(
  "control",
  function(data, cb)
    if data and data.params then
      if data.params.method:find("vrp_barrier") then
        TriggerServerEvent("proxy_vrp_barrier:action", data.params.method)
      elseif data.params.method:find("vrp_ptracking") then
        TriggerServerEvent("proxy_vrp_ptracking:action", data.params.method)
      elseif data.params.method:find("vrp_licrevoked") then
        TriggerServerEvent("proxy_vrp_licrevoked:action", data.params.method)
      elseif data.params.method:find("vrp_arevive") then
        TriggerServerEvent("proxy_vrp_arevive:action", data.params.method)
      else
        TriggerServerEvent("proxy_vrp_basic_menu:action", data.params.method)
        TriggerServerEvent("proxy_vrp:action", data.params.method)
      end
    end
  end
)
