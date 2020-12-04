cfg = {}

cfg.KeyMarker = {1, 47}
cfg.KeyMarkerName = "~INPUT_DETONATE~"

cfg.blips = true -- enable blips

cfg.cooldown = 600 -- TEMPO DO COOLDOWN EM SEGUNDOS

cfg.cops = 2 -- MINIMO DE PM'S ON
cfg.permission = "policia.em_servico" -- permission given to cops

cfg.atms = { -- list of atms
	["fleeca"] = {
		position = { ['x'] = 147.64654541016, ['y'] = -1035.8035888672, ['z'] = 29.343029022217 },
		reward = 30000000 + math.random(500000,3000000),
		nameofatm = "리얼월드 광장 근처 플리카 은행 ATM",
		lastrobbed = 600,
		seconds = 300,
		pontosXp = 50,
	},
	["fleeca2"] = {
		position = { ['x'] = 111.21974945068, ['y'] = -775.30010986328, ['z'] = -1331.438467025757 },
		reward = 5000000 + math.random(0,10000),
		nameofatm = "ATM 프라 사",
		lastrobbed = 600,
		seconds = 300,
		pontosXp = 40,
	},
}