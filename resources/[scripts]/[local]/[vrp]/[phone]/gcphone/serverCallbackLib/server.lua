draCB={}
draCB.ServerCallbacks={}


RegisterServerEvent('draCB:triggerServerCallback')
AddEventHandler('draCB:triggerServerCallback',function(a,b,...)
    local c=source

    draCB.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('draCB:serverCallback',c,b,...)end,...)
end)
        
        
    
draCB.RegisterServerCallback = function(a,t)
    draCB.ServerCallbacks[a]=t 
end
                    
draCB.TriggerServerCallback = function(a,b,source,t,...)
    if draCB.ServerCallbacks[a]~=nil then 
        draCB.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] does not exist')
    end 
end