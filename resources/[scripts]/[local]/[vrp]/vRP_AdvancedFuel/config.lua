petrolCanPrice = 1

lang = "en"
-- lang = "fr"

settings = {}
settings["en"] = {
	openMenu = "Press ~g~E~w~ to open the menu.",
	electricError = "~r~Drive an electric car.",
	fuelError = "~r~You do not drive an electric car.",
	buyFuel = "주유소",
	liters = "리터",
	percent = "퍼센트",
	confirm = "확인",
	fuelStation = "주유소",
	boatFuelStation = "Gas station Boats",
	avionFuelStation = "Gas station aircraft",
	heliFuelStation = "Gas station helicopters",
	getJerryCan = "Press ~g~E~w~ to buy a Canister ("..petrolCanPrice..")",
	refeel = "Press ~g~E~w~ to feed.",
	YouHaveBought = "구매 완료 (소비세 포함) ",
	fuel = " 리터",
	price = "가격"
}

settings["fr"] = {
	openMenu = "Appuyez sur ~g~E~w~ pour ouvrir le menu.",
	electricError = "~r~Vous avez une voiture électrique.",
	fuelError = "~r~Vous n'êtes pas au bon endroit.",
	buyFuel = "acheter de l'essence",
	liters = "litres",
	percent = "pourcent",
	confirm = "Valider",
	fuelStation = "Station essence",
	boatFuelStation = "Station d'essence | Bateau",
	avionFuelStation = "Station d'essence | Avions",
	heliFuelStation = "Station d'essence | Hélicoptères",
	getJerryCan = "Appuyez sur ~g~E~w~ pour acheter un bidon d'essence ("..petrolCanPrice..")",
	refeel = "Appuyez sur ~g~E~w~ pour remplir votre voiture d'essence.",
	YouHaveBought = "Vous avez acheté ",
	fuel = " litres d'essence",
	price = "prix"
}


showBar = true
showText = true


hud_form = 2 -- 1 : Vertical | 2 = Horizontal
hud_x = 0.085
hud_y = 0.8

text_x = 0.168
text_y = 0.808


electricityPrice = 3 -- NOT RANOMED !!
petrolCanPrice = 30000
randomPrice = false --Random the price of each stations
price = 1645 --If random price is on False, set the price here for 1 liter