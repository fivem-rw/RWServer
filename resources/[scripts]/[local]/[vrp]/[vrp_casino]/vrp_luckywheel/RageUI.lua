
RMenu.Add("cmgblackjack", "instructions", RageUI.CreateMenu("", "test", 0, 350, "casinoui_lucky_wheel", "casinoui_lucky_wheel"))
RMenu:Get("cmgblackjack", "instructions"):SetSubtitle("~b~리얼월드 추첨휠")

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
						"~g~[E] ~w~키를 눌러 추첨휠 돌리기",
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