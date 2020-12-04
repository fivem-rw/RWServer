RegisterServerEvent("fthrow:SyncStartParticles")
AddEventHandler("fthrow:SyncStartParticles", function(fthrowid)
    TriggerClientEvent("fthrow:StartParticles", -1, fthrowid)
end)

RegisterServerEvent("fthrow:SyncStopParticles")
AddEventHandler("fthrow:SyncStopParticles", function(fthrowid)
    TriggerClientEvent("fthrow:StopParticles", -1, fthrowid)
end)