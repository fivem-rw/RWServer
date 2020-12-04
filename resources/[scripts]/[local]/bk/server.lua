------------------------------------
--- Police Backup, Made by FAXES ---
------------------------------------

RegisterCommand("code", function(source, args, rawCommand)
    local s = source
    local bkLvl = args[1]

    if not bkLvl then
        TriggerClientEvent("Fax:ShowInfo", source, "~y~코드 지정 요망. ~n~~s~1, 2, 3")
    elseif bkLvl == "1" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl == "2" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl == "3" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl == "99" then
        TriggerClientEvent("Fax:BackupReq", -1, bkLvl, s)
    elseif bkLvl ~= "1" or bkLvl ~= "2" or bkLvl ~= "3" or bkLvl ~= "99" then
        TriggerClientEvent("Fax:ShowInfo", source, "~y~올바르지 않은 코드")
    end
end)