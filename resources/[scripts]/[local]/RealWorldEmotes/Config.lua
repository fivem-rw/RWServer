Config = {
-- Change the language of the menu here!.
-- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
-- try en, fr, de or sv.
	MenuLanguage = 'ko',	
-- Set this to true to enable some extra prints
	DebugDisplay = false,
-- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
-- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
-- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
-- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 170, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Favorite emote keybinding here.
	FavKeybindEnabled = false,
	FavKeybind = 171, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can change the header image for the f3 menu here
-- Use a 512 x 128 image!
-- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgur.com/kgzvDwQ.png",
-- You can change the menu position here
	MenuPosition = "right", -- (left, right)
-- You can disable the Ragdoll keybinding here.
	RagdollEnabled = true,
	RagdollKeybind = 243, -- Get the button number here https://docs.fivem.net/game-references/controls/
-- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
-- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
-- You can disable the Shared Emotes here.
    SharedEmotesEnabled = true,
    CheckForUpdates = true,
-- If you have the SQL imported enable this to turn on keybinding.
    SqlKeybinding = false,
}

Config.KeybindKeys = {
    ['num4'] = 108,
    ['num5'] = 110,
    ['num6'] = 109,
    ['num7'] = 117,
    ['num8'] = 111,
    ['num9'] = 118
}

Config.Languages = {
  ['ko'] = {
        ['emotes'] = 'Emotes',
        ['danceemotes'] = "🕺 Dance Emotes",
        ['basicaction'] = "> 기본 행동",
        ['basicdance'] = "> 기본 댄스",
        ['propemotes'] = "> 물건 사용",
        ['favoriteemotes'] = "🌟 즐겨찾기",
        ['favoriteinfo'] = "즐겨찾는 행동을 저장합니다.",
        ['rfavorite'] = "즐겨찾기 초기화",
        ['prop2info'] = "❓ Prop Emotes can be located at the end",
        ['set'] = "Set (",
        ['setboundemote'] = ") to be your bound emote?",
        ['newsetemote'] = "~w~ is now your bound emote, press ~g~CapsLock~w~ to use it.",
        ['cancelemote'] = "행동 취소",
        ['cancelemoteinfo'] = "~r~X~w~ 행동을 취소합니다. 단축키: 키보드 [X]",
        ['walkingstyles'] = "> 걷는 스타일",
        ['resetdef'] = "기본 상태",
        ['normalreset'] = "기본 (초기화)",
        ['moods'] = "> 표정",
        ['infoupdate'] = "Information",
        ['infoupdateav'] = "Information (Update available)",
        ['infoupdateavtext'] = "An update is available, get the latest version from ~y~https://github.com/andristum/dpemotes~w~",
        ['suggestions'] = "Suggestions?",
        ['suggestionsinfo'] = "'dullpear_dev' on FiveM forums for any feature/emote suggestions! ✉️",
        ['notvaliddance'] = "is not a valid dance.",
        ['notvalidemote'] = "is not a valid emote.",
        ['nocancel'] = "No emote to cancel.",
        ['maleonly'] = "This emote is male only, sorry!",
        ['emotemenucmd'] = "Do /emotemenu for a menu.",
        ['shareemotes'] = "> 같이 행동",
        ['shareemotesinfo'] = "Invite a nearby person to emote",
        ['sharedanceemotes'] = "> 같이 추기",
        ['notvalidsharedemote'] = "is not a valid shared emote.",
        ['sentrequestto'] = "Sent request to ~y~",
        ['nobodyclose'] = "Nobody ~r~close~w~ enough.",
        ['doyouwanna'] = "~y~Y~w~ to accept, ~r~L~w~ to refuse (~g~",
        ['refuseemote'] = "Emote refused.",
        ['makenearby'] = "makes the nearby player play",
        ['camera'] = "Press ~y~G~w~ to use camera flash.",
        ['makeitrain'] = "Press ~y~G~w~ to make it rain.",
        ['pee'] = "Hold ~y~G~w~ to pee.",
        ['spraychamp'] = "Hold ~y~G~w~ to spray champagne",
        ['bound'] = "Bound ",
        ['to'] = "to",
        ['currentlyboundemotes'] = " Currently bound emotes:",
        ['notvalidkey'] = "is not a valid key.",
        ['keybinds'] = "🔢 Keybinds",
        ['keybindsinfo'] = "Use"
  }
}