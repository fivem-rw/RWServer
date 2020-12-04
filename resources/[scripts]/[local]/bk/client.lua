------------------------------------
--- Police Backup, Made by FAXES ---
------------------------------------

--- CONFIG ---
local leoPeds = {
    "s_m_y_cop_01",
	"s_m_y_cop_02",
	"krpolice",
	"s_m_y_hwaycop_01",
	"s_m_y_hwaycop_02",
	"s_m_y_hwaycop_03",
	"s_f_y_hwaycop_01",
	"s_m_m_snowcop_01",
	"s_m_m_security_01",
	"s_m_y_sheriff_01",
	"s_m_y_sheriff_02",
	"s_m_y_sheriff_03",
	"s_m_y_sheriff_04",
	"s_m_y_sheriff_05",
	"s_m_y_sheriff_06",
	"s_m_y_sheriff_07",
	"s_m_y_sheriff_08",
	"s_f_y_sheriff_01",
	"s_m_y_swat_01",
	"s_m_y_swat_02",
	"s_m_y_swat_03",
	"s_m_y_swat_04",
	"s_m_y_swat_05",
	"s_m_m_fibsec_01",
	"s_m_m_ciasec_01",
}

--------------------------------------------------------------------------------------------------------
function checkPed(ped, PedList)
	for i = 1, #PedList do
		if GetHashKey(PedList[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function playCode99Sound()
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
    Wait(900)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
end

RegisterNetEvent('Fax:ShowInfo')
AddEventHandler('Fax:ShowInfo', function(notetext)
	ShowInfo(notetext)
end)

RegisterNetEvent('Fax:BackupReq')
AddEventHandler('Fax:BackupReq', function(bk, s)
    local src = s
    local bkLvl = bk
    local bkLvlTxt = "N/A"
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(src)))
    local street1 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local streetName = (GetStreetNameFromHashKey(street1))

    if checkPed(GetPlayerPed(PlayerId()), leoPeds) then
        if bkLvl == "1" then
            bkLvlTxt = "~b~코드 1"
        elseif bkLvl == "2" then
            bkLvlTxt = "~y~코드 2"
        elseif bkLvl == "3" then
            bkLvlTxt = "~r~코드 3"
            PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
        elseif bkLvl == "99" then
            bkLvlTxt = "~r~~h~코드 99"
        end

        ShowInfo("지원 요청이 들어왔습니다!" .. bkLvlTxt .. "~s~. ~o~위치 : ~s~" .. streetName .. ".")
        SetNewWaypoint(coords.x, coords.y)

        if bkLvl == "99" then
            playCode99Sound()
        end
    end
end)