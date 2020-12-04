-- MAIN THREAD
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			for k, v in pairs(cfg.hotkeys) do
				if IsControlJustPressed(v.group, k) or IsDisabledControlJustPressed(v.group, k) then
					v.pressed()
				end

				if IsControlJustReleased(v.group, k) or IsDisabledControlJustReleased(v.group, k) then
					v.released()
				end
			end
		end
	end
)

-- THIS IS FOR NO DOC COMA
Citizen.CreateThread(
	function()
		-- coma thread
		while true do
			Citizen.Wait(1000)
			if vRP.isInComa({}) and not vRP.isJailed({}) then
				vRP.closeMenu(source)
				if called == 0 then
					vRP.closeMenu(player)
					HKserver.canSkipComa(
						{},
						function(skipper)
							if skipper then
								vRP.closeMenu(player)
								HKserver.docsOnline(
									{},
									function(docs)
										if docs == 0 then
											vRP.closeMenu(player)
											vRP.notify({"~r~당신을 치료할 구급대원이 없습니다.\n~b~~g~E~b~ 를 눌러 리스폰하세요."})
										else
											vRP.closeMenu(player)
											vRP.notify({"~g~EMS 온라인\n~b~~g~E~b~ 버튼을 눌러 의료서비스를 호출하세요."})
											--vRP.notify({"~b~~r~Z~b~ 키 의료서비스 포기."})
										end
									end
								)
							end
						end
					)
				else
					called = called - 1
				end
			else
				called = 0
			end
		end
	end
)