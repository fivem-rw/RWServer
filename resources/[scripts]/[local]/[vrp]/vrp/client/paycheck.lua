vRP = Proxy.getInterface("vRP")
paycheckS = Tunnel.getInterface("paycheck", "paycheck")

Citizen.CreateThread(
	function()
		while true do
			local user_id = vRP.getUserId(source)
			Citizen.Wait(30*60*1000)
			--Citizen.Wait(10*1000)
			paycheckS.salary()
		end
	end
)
--[[
Citizen.CreateThread(
	function()
		while true do
			local user_id = vRP.getUserId(source)
			Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
			paycheckS.bonus()
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			local user_id = vRP.getUserId(source)
			Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
			paycheckS.chuseok()
		end
	end
)
Citizen.CreateThread(
	function()
		while true do
			local user_id = vRP.getUserId(source)
			Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
			paycheckS.realestate()
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			local user_id = vRP.getUserId(source)
			Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
			paycheckS.loan()
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			local user_id = vRP.getUserId(source)
			Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
			paycheckS.army()
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			local user_id = vRP.getUserId(source)
			Citizen.Wait(1200000) -- Every X ms you'll get paid (300000 = 5 min)
			paycheckS.companysalary()
		end
	end
)

RegisterNetEvent("autohottime")
AddEventHandler(
	"autohottime",
	function()
		local user_id = vRP.getUserId(source)
		Citizen.Wait(3000)
		paycheckS.autohottime()
	end
)

RegisterNetEvent("autohottime2")
AddEventHandler(
	"autohottime2",
	function()
		local user_id = vRP.getUserId(source)
		Citizen.Wait(3000)
		paycheckS.autohottime2()
	end
)
]]--