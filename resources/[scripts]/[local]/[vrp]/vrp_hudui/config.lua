local Config = {}

Config.Locale = "ko"

Config.serverLogo = ""

Config.font = {
	name = "Nanum Gothic",
	url = "https://fonts.googleapis.com/css?family=Nanum+Gothic:400,700,800&display=swap&subset=korean"
}

Config.date = {
	format = "default",
	AmPm = false
}

Config.voice = {
	levels = {
		current = 1,
		type = {
			{name = "default", value = 20.0},
			{name = "shout", value = 50.0},
			{name = "lock", value = 0.01},
			{name = "whisper", value = 5.0}
		}
	},
	keys = {
		distance = "HOME"
	}
}

Config.vehicle = {
	speedUnit = "KMH",
	maxSpeed = 400,
	keys = {
		seatbelt = "INSERT",
		cruiser = "CAPS",
		signalLeft = "LEFT",
		signalRight = "RIGHT",
		signalBoth = "N5"
	}
}

Config.ui = {
	showServerLogo = false,
	showJob = false,
	showWalletMoney = true,
	showCreditMoney = true,
	showBankMoney = true,
	showBlackMoney = false,
	showDate = false,
	showLocation = false,
	showVoice = true,
	showHealth = true,
	showArmor = true,
	showStamina = true,
	showHunger = true,
	showThirst = true,
	showMinimap = true,
	showWeapons = true
}

Config.vRP = {
	items = {
		blackMoney = "dirty_money"
	}
}

return Config
