local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

local arrNetIds = {}

RegisterServerEvent("fthrow:SyncStartParticles")
AddEventHandler(
    "fthrow:SyncStartParticles",
    function(fthrowid, scale, zoffset, particleName, type)
        TriggerClientEvent("fthrow:StartParticles", -1, fthrowid, scale, zoffset, particleName, type)
    end
)

RegisterServerEvent("fthrow:SyncStopParticles")
AddEventHandler(
    "fthrow:SyncStopParticles",
    function(fthrowid)
        TriggerClientEvent("fthrow:StopParticles", -1, fthrowid)
    end
)

RegisterCommand(
    "rwfx",
    function(source, args, raw)
        local player = source
        if args[2] ~= "0" then 
            player = vRP.getUserSource({tonumber(args[2])})
        end
        local scale = 1
        local zoffset = 0
        local particleName = "exp_sht_flame"
        local type = 1
        if args[3] then 
            scale = tonumber(args[3]) or 0
        end
        if args[4] then 
            zoffset = tonumber(args[4]) or 0
        end
        if args[5] and tonumber(args[5]) ~= 0 then 
            particleName = args[5]
        end
        if args[6] then 
            type = args[6]
        end
        if args[1] == "start" then
            TriggerClientEvent("tefx:start", player, scale + 0.1, zoffset + 0.1, particleName, type)
        else
            TriggerClientEvent("tefx:end", player)
        end
    end
)
