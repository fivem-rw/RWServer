local title = ""
local message = ""
local is_visible
local server_env

function Initialize(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(title)
	PushScaleformMovieFunctionParameterString(message)
	PopScaleformMovieFunctionVoid()
	return scaleform
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if is_visible then
				scaleform = Initialize("mp_big_message_freemode")
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
			end
		end
	end
)

RegisterNetEvent("HG:Welcome")
AddEventHandler(
	"HG:Welcome",
	function(user_id, faction, name, money, bmoney, env)
		server_env = env
		if server_env == "pro" then
			title = "~y~리얼월드에 오신것을 환영합니다!"
			message = "~w~고유번호: ~y~" .. user_id .. "   ~w~이름: ~y~" .. name .. "   ~w~직업: ~y~" .. faction .. "   ~w~보유금액: ~y~" .. format_num(parseDouble(money) + parseDouble(bmoney))
		else
			title = "~y~현재 접속한 서버는 리얼월드 테스트서버 입니다."
			message = "~w~FiveM 서버목록에서 ~y~리얼월드 본서버~w~로 접속 바랍니다."
		end
		is_visible = true
		Citizen.Wait(20000)
		is_visible = false
	end
)
