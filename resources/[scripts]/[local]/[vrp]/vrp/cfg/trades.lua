local cfg = {}

-- define trade types like garages and weapons
-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the trade)

cfg.trade_types = {
	["광석"] = {
		_config = {permissions = {"user.paycheck"}},
		["stone"] = 40000,
		["silver1"] = 80000,
		["golden1"] = 280000
	},
	["보석"] = {
		_config = {permissions = {"user.paycheck"}},
		["r_bs"] = 100000,
		["s_bs"] = 400000,
		["e_bs"] = 700000,
		["d_bs"] = 1000000
	},
	["카지노칩 환전"] = {
		_config = {permissions = {"user.paycheck"}},
		["real_chip_n"] = 100000
	},	
	["물고기"] = {
		_config = {permissions = {"user.paycheck"}},
		["bass_body"] = 80000,
		["bass_head"] = 120000,
		["bass_j"] = 90000,
		["catfish_body"] = 100000,
		["catfish_head"] = 120000,
		["catfish_j"] = 100000,
		["pisicademare_body"] = 90000,
		["pisicademare_head"] = 150000,
		["pisicademare_j"] = 160000,
		["pescarus_body"] = 130000,
		["pescarus_wing"] = 100000,
		["pescarus_kori"] = 110000,
		["rechin_body"] = 90000,
		["rechin_head"] = 170000,
		["rechin_j"] = 130000
	},
	["우유"] = {
		_config = {permissions = {"user.paycheck"}},
		["garrafa_leite"] = 120000
	},
	["잡화상점"] = {
		_config = {permissions = {"user.paycheck"}},
		["trash"] = 500,
		["mushroom_i"] = 200000
	}
}

-- list of trades {type,x,y,z}

cfg.trades = {
	{"광석", 154.80171203613, -978.21728515625, 30.091867446899},
	{"보석", 153.73399353027, -969.13153076172, 30.091873168945},
	--{"카지노칩 환전", 959.52203369141, 25.281511306763, 76.991355895996},
	{"물고기", 210.1689453125, -926.68701171875, 30.691394805908},
	{"잡화상점", 233.24261474609, -895.69598388672, 30.691411972046},
	{"우유", 264.24859619141, -824.89532470703, 29.437795639038}
}

return cfg
