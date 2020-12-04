
RMenu.Add("cmgblackjack", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_roulette", "casinoui_roulette"))
RMenu:Get("cmgblackjack", "instructions"):SetSubtitle("~b~리얼월드 룰렛")

RageUI.CreateWhile(
	1.0,
	true,
	function()
		if RageUI.Visible(RMenu:Get("cmgblackjack", "instructions")) then
			RageUI.DrawContent(
				{header = true, instructionalButton = true, glare = false},
				function()
					RageUI.FakeButton(
						"test",
						"~g~[E] ~w~키를 눌러 룰렛 시작",
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
						RMenu:Get("cmgblackjack_high", "instructions")
					)
				end,
				function()
					---Panels
				end
			)
		end
	end,
	1
)