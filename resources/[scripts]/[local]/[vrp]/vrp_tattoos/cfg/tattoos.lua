--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]


local cfg = {}

-- list of weapons for sale
-- for the native name, see the 타투s folder, the native names of the 타투s is in the files with the native name of the it's shop
-- create groups like for the garage config
-- [native_타투_name] = {display_name,price,description}

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)
-- https://wiki.gtanet.work/index.php?title=Blips
-- https://wiki.fivem.net/wiki/Controls

cfg.tattoos = {
	["mpbeach_overlays"] = { -- native store name
		_config = {blipid=75,blipcolor=48,title="Beach 타투s"}, -- you can add permissions like on other vRP features
		["CLEAR"] = {"> 타투 전체 지우기",5000,""},
		["MP_Bea_M_Head_000"] = {"Head 타투 1",5000,""},
		["MP_Bea_M_Head_001"] = {"Head 타투 2",5000,""},
		["MP_Bea_M_Head_002"] = {"Head 타투 3",5000,""},
		["MP_Bea_F_Neck_000"] = {"Neck 타투 1",5000,""},
		["MP_Bea_M_Neck_000"] = {"Neck 타투 2",5000,""},
		["MP_Bea_M_Neck_001"] = {"Neck 타투 3",5000,""},
		["MP_Bea_F_Back_000"] = {"Back 타투 1",5000,""},
		["MP_Bea_F_Back_001"] = {"Back 타투 2",5000,""},
		["MP_Bea_F_Back_002"] = {"Back 타투 3",5000,""},
		["MP_Bea_M_Back_000"] = {"Back 타투 4",5000,""},
		["MP_Bea_F_Chest_000"] = {"Torso 타투 1",5000,""},
		["MP_Bea_F_Chest_001"] = {"Torso 타투 2",5000,""},
		["MP_Bea_F_Chest_002"] = {"Torso 타투 3",5000,""},
		["MP_Bea_M_Chest_000"] = {"Torso 타투 4",5000,""},
		["MP_Bea_M_Chest_001"] = {"Torso 타투 5",5000,""},
		["MP_Bea_F_Stom_000"] = {"Torso 타투 6",5000,""},
		["MP_Bea_F_Stom_001"] = {"Torso 타투 7",5000,""},
		["MP_Bea_F_Stom_002"] = {"Torso 타투 8",5000,""},
		["MP_Bea_M_Stom_000"] = {"Torso 타투 9",5000,""}, 
		["MP_Bea_M_Stom_001"] = {"Torso 타투 10",5000,""},
		["MP_Bea_F_RSide_000"] = {"Torso 타투 11",5000,""},
		["MP_Bea_F_Should_000"] = {"Torso 타투 12",5000,""},
		["MP_Bea_F_Should_001"] = {"Torso 타투 13",5000,""},
		["MP_Bea_F_RArm_001"] = {"Right Arm 타투 1",5000,""},
		["MP_Bea_M_RArm_001"] = {"Right Arm 타투 2",5000,""},
		["MP_Bea_M_RArm_000"] = {"Right Arm 타투 3",5000,""},
		["MP_Bea_F_LArm_000"] = {"Left Arm 타투 1",5000,""},
		["MP_Bea_F_LArm_001"] = {"Left Arm 타투 2",5000,""},
		["MP_Bea_M_LArm_000"] = {"Left Arm 타투 3",5000,""}, 
		["MP_Bea_M_Lleg_000"] = {"Left Leg 타투",5000,""},
		["MP_Bea_F_RLeg_000"] = {"Right Leg 타투",5000,""}
	},
	["mpbusiness_overlays"] = {
		_config = {blipid=75,blipcolor=48,title="Business 타투s"},
		["CLEAR"] = {"> 타투 전체 지우기",5000,""},
		["MP_Buis_M_Neck_000"] = {"Neck 타투 1",5000,""},
		["MP_Buis_M_Neck_001"] = {"Neck 타투 2",5000,""},
		["MP_Buis_M_Neck_002"] = {"Neck 타투 3",5000,""},
		["MP_Buis_M_Neck_003"] = {"Neck 타투 4",5000,""},
		["MP_Buis_M_LeftArm_000"] = {"Left Arm 타투 1",5000,""},
		["MP_Buis_M_LeftArm_001"] = {"Left Arm 타투 2",5000,""},
		["MP_Buis_M_RightArm_000"] = {"Right Arm 타투 1",5000,""},
		["MP_Buis_M_RightArm_001"] = {"Right Arm 타투 2",5000,""},
		["MP_Buis_M_Stomach_000"] = {"Stomach 타투 1",5000,""},
		["MP_Buis_M_Chest_000"] = {"Chest 타투 1",5000,""},
		["MP_Buis_M_Chest_001"] = {"Chest 타투 2",5000,""},
		["MP_Buis_M_Back_000"] = {"Back 타투 1",5000,""},
		["MP_Buis_F_Chest_000"] = {"Chest 타투 3",5000,""},
		["MP_Buis_F_Chest_001"] = {"Chest 타투 4",5000,""},
		["MP_Buis_F_Chest_002"] = {"Chest 타투 5",5000,""},
		["MP_Buis_F_Stom_000"] = {"Stomach 타투 2",5000,""},
		["MP_Buis_F_Stom_001"] = {"Stomach 타투 3",5000,""},
		["MP_Buis_F_Stom_002"] = {"Stomach 타투 4",5000,""},
		["MP_Buis_F_Back_000"] = {"Back 타투 2",5000,""},
		["MP_Buis_F_Back_001"] = {"Back 타투 3",5000,""},
		["MP_Buis_F_Neck_000"] = {"Neck 타투 5",5000,""},
		["MP_Buis_F_Neck_001"] = {"Neck 타투 6",5000,""},
		["MP_Buis_F_RArm_000"] = {"Right Arm 타투 3",5000,""},
		["MP_Buis_F_LArm_000"] = {"Left Arm 타투 3",5000,""},
		["MP_Buis_F_LLeg_000"] = {"Left Leg 타투",5000,""},
		["MP_Buis_F_RLeg_000"] = {"Right Leg 타투",5000,""}

	},

	["mphipster_overlays"] = {
		_config = {blipid=75,blipcolor=48,title="Hipster 타투s"},
		["CLEAR"] = {"> 타투 전체 지우기",5000,""},
		["FM_Hip_M_Tat_000"] = {"Hipster 타투 1",5000,""},
		["FM_Hip_M_Tat_001"] = {"Hipster 타투 2",5000,""},
		["FM_Hip_M_Tat_002"] = {"Hipster 타투 3",5000,""},
		["FM_Hip_M_Tat_003"] = {"Hipster 타투 4",5000,""},
		["FM_Hip_M_Tat_004"] = {"Hipster 타투 5",5000,""},
		["FM_Hip_M_Tat_005"] = {"Hipster 타투 6",5000,""},
		["FM_Hip_M_Tat_006"] = {"Hipster 타투 7",5000,""},
		["FM_Hip_M_Tat_007"] = {"Hipster 타투 8",5000,""},
		["FM_Hip_M_Tat_008"] = {"Hipster 타투 9",5000,""},
		["FM_Hip_M_Tat_009"] = {"Hipster 타투 10",5000,""},
		["FM_Hip_M_Tat_010"] = {"Hipster 타투 11",5000,""},
		["FM_Hip_M_Tat_011"] = {"Hipster 타투 12",5000,""},
		["FM_Hip_M_Tat_012"] = {"Hipster 타투 13",5000,""},
		["FM_Hip_M_Tat_013"] = {"Hipster 타투 14",5000,""},
		["FM_Hip_M_Tat_014"] = {"Hipster 타투 15",5000,""},
		["FM_Hip_M_Tat_015"] = {"Hipster 타투 16",5000,""},
		["FM_Hip_M_Tat_016"] = {"Hipster 타투 17",5000,""},
		["FM_Hip_M_Tat_017"] = {"Hipster 타투 18",5000,""},
		["FM_Hip_M_Tat_018"] = {"Hipster 타투 19",5000,""},
		["FM_Hip_M_Tat_019"] = {"Hipster 타투 20",5000,""},
		["FM_Hip_M_Tat_020"] = {"Hipster 타투 21",5000,""},
		["FM_Hip_M_Tat_021"] = {"Hipster 타투 22",5000,""},
		["FM_Hip_M_Tat_022"] = {"Hipster 타투 23",5000,""},
		["FM_Hip_M_Tat_023"] = {"Hipster 타투 24",5000,""},
		["FM_Hip_M_Tat_024"] = {"Hipster 타투 25",5000,""},
		["FM_Hip_M_Tat_025"] = {"Hipster 타투 26",5000,""},
		["FM_Hip_M_Tat_026"] = {"Hipster 타투 27",5000,""},
		["FM_Hip_M_Tat_027"] = {"Hipster 타투 28",5000,""},
		["FM_Hip_M_Tat_028"] = {"Hipster 타투 29",5000,""},
		["FM_Hip_M_Tat_029"] = {"Hipster 타투 30",5000,""},
		["FM_Hip_M_Tat_030"] = {"Hipster 타투 31",5000,""},
		["FM_Hip_M_Tat_031"] = {"Hipster 타투 32",5000,""},
		["FM_Hip_M_Tat_032"] = {"Hipster 타투 33",5000,""},
		["FM_Hip_M_Tat_033"] = {"Hipster 타투 34",5000,""},
		["FM_Hip_M_Tat_034"] = {"Hipster 타투 35",5000,""},
		["FM_Hip_M_Tat_035"] = {"Hipster 타투 36",5000,""},
		["FM_Hip_M_Tat_036"] = {"Hipster 타투 37",5000,""},
		["FM_Hip_M_Tat_037"] = {"Hipster 타투 38",5000,""},
		["FM_Hip_M_Tat_038"] = {"Hipster 타투 39",5000,""},
		["FM_Hip_M_Tat_039"] = {"Hipster 타투 40",5000,""},
		["FM_Hip_M_Tat_040"] = {"Hipster 타투 41",5000,""},
		["FM_Hip_M_Tat_041"] = {"Hipster 타투 42",5000,""},
		["FM_Hip_M_Tat_042"] = {"Hipster 타투 43",5000,""},
		["FM_Hip_M_Tat_043"] = {"Hipster 타투 44",5000,""}, 
		["FM_Hip_M_Tat_044"] = {"Hipster 타투 45",5000,""},
		["FM_Hip_M_Tat_045"] = {"Hipster 타투 46",5000,""},
		["FM_Hip_M_Tat_046"] = {"Hipster 타투 47",5000,""},
		["FM_Hip_M_Tat_047"] = {"Hipster 타투 48",5000,""},
		["FM_Hip_M_Tat_048"] = {"Hipster 타투 49",5000,""}
	},
}

-- list of 타투shops positions
cfg.shops = {
  {"mpbeach_overlays", 1322.645,-1651.976,52.275},
  {"mpbeach_overlays", -1153.676,-1425.68,4.954},
  {"mpbusiness_overlays", 322.139,180.467,103.587},
  {"mpbusiness_overlays", -3170.071,1075.059,20.829},
  {"mphipster_overlays", 1864.633,3747.738,33.032},
  {"mphipster_overlays", -293.713,6200.04,31.487}
}

return cfg
