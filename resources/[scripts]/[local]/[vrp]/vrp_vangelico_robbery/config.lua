cfg = {}

cfg.blips = true -- enable blips

cfg.seconds = 1800 -- seconds to rob

cfg.cooldown = 3600 -- time between robbaries

cfg.cops = 4 -- minimum cops online
cfg.permission = "cop" -- permission given to cops


cfg.jewels = {
	["보석류"] = {
		position = { ['x'] = -629.99, ['y'] = -236.542, ['z'] = 38.05 },       
		reward = math.random(100000000,150000000),
		nameofstore = "보석상",
		lastrobbed = 0,			
		pontosXp = 50,			
	}
}