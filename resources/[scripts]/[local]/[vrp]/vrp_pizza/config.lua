-- If your action has no objects, do: name = prop_none and set all numerical values to 0.0".

config = {
	newUsers = {
		DefaultDepartment = "civilian",
		DefaultRank = 0,
		DefaultPermissionLevel = 0
	},
	bindings = {
		interact_position = 51, -- E
		use_police_menu = 166, -- F5
		accept_fine = 246, -- Y
		refuse_fine = 45 -- R
	},
	actions = {
		box_carry = {
			name = "Carry Package",
			currentAction = "box_carry",
			animDictionary = "anim@heists@box_carry@",
			animationName = "idle",
			animObjects = {
				name = "prop_cs_cardbox_01",
				--- Offsets: ---
				xoff = 0.0,
				yoff = 0.0,
				zoff = 0.0,
				-- Rotations: --
				xrot = 0.0,
				yrot = 0.0,
				zrot = 0.0
			}
		},
		pizza_delivery = {
			name = "Deliver Pizza",
			currentAction = "pizza_delivery",
			animDictionary = "anim@heists@box_carry@",
			animationName = "idle",
			animObjects = {
				name = "prop_pizza_box_01",
				--- Offsets: ---
				xoff = 0.0,
				yoff = -0.25,
				zoff = -0.2,
				-- Rotations: --
				xrot = 0.0,
				yrot = 0.0,
				zrot = 0.0
			}
		},
		crate_delivery = {
			name = "Carry Crate",
			currentAction = "crate_delivery",
			animDictionary = "anim@heists@box_carry@",
			animationName = "idle",
			animObjects = {
				name = "prop_crate_07a",
				--- Offsets: ---
				xoff = 0.0,
				yoff = -0.25,
				zoff = -0.2,
				-- Rotations: --
				xrot = 180.0,
				yrot = 180.0,
				zrot = 90.0
			}
		}
	}
}
