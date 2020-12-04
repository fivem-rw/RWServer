--[[
    FiveM Scripts
	The Official HackerGeo Script 
	Credits - HackerGeo
	Website - www.HackerGeo.com
	GitHub - GITHUB.com/HackerGeo-sp1ne
	Steam - SteamCommunity.com/id/HackerGeo1
	Copyright 2019 ©HackerGeo. All rights served
]]

------------------------------------------------------WARNING-----------------------------------------------------
---------------------Do not reupload/re release any part of this script without my permission---------------------
------------------------------------------------------------------------------------------------------------------


local cfg = {}
local resourceName = ""..GetCurrentResourceName()..""

cfg.anticheat = {
    steam_require = false,
    name = "[리얼월드 안티치트]",
    author = "HackerGeo",
    perm = "anticheat.settings",
    no_perm = "~r~Nu ai acces la setarile ~g~AntiCheat-ului!",
    protect = "~y~활성화 되었습니다. ~g~서버 보호중..",
    database = "Baza de date verificata",
    reason = "reason",
    steam = "Trebuie sa ai STEAM-ul pornit"
}

cfg.jump = {
    reason = "SUPER JUMP",
    desc = "A PRIMIT KICK",
    kick = "AI FOST DETECTAT CU HACK",
}

cfg.cars = {
    reason = "CARS BLACKLISTED",
    desc = "A PRIMIT BAN",
    kick = "AI FOST DETECTAT CU HACK",
}

cfg.version = {
    version = "1.7.7",
    new = "New AntiCheat Version",
    current = "Your AntiCheat Version",
    updated = "is up to date",
    outdated = "is Outdated",
    download = "Download the latest version",
    from = "From the HackerGeo.com",
}


function getConfig()
	return cfg
end
