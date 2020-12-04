RMenu.Add("casinoui_slots_angel", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_angel", "casinoui_slots_angel"))
RMenu:Get("casinoui_slots_angel", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_deity", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_deity", "casinoui_slots_deity"))
RMenu:Get("casinoui_slots_deity", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_diamond", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_diamond", "casinoui_slots_diamond"))
RMenu:Get("casinoui_slots_diamond", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_evacuator", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_evacuator", "casinoui_slots_evacuator"))
RMenu:Get("casinoui_slots_evacuator", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_evacuator", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_evacuator", "casinoui_slots_evacuator"))
RMenu:Get("casinoui_slots_evacuator", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_fame", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_fame", "casinoui_slots_fame"))
RMenu:Get("casinoui_slots_fame", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_impotent", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_impotent", "casinoui_slots_impotent"))
RMenu:Get("casinoui_slots_impotent", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_knife", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_knife", "casinoui_slots_knife"))
RMenu:Get("casinoui_slots_knife", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")
RMenu.Add("casinoui_slots_ranger", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_slots_ranger", "casinoui_slots_ranger"))
RMenu:Get("casinoui_slots_ranger", "instructions"):SetSubtitle("~b~리얼월드 슬롯머신")

RageUI.CreateWhile(
	1.0,
	true,
	function()
		for _, v in pairs(Config.Sloty) do
			if RageUI.Visible(RMenu:Get(v[6], "instructions")) then
				RageUI.DrawContent(
					{header = true, instructionalButton = true, glare = false},
					function()
						RageUI.FakeButton(
							"test",
							"~g~[E] ~w~키를 눌러 슬롯머신 시작",
							{RightLabel = "→→→"},
							true,
							function(Hovered, Active, Selected)
								if (Hovered) then
								end
								if (Active) then
								end
								if (Selected) then
								end
							end,
							RMenu:Get(v[6], "instructions")
						)
					end,
					function()
						---Panels
					end
				)
			end
		end
	end,
	1
)
