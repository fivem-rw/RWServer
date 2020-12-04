---------------------------------------------------------
-------------- RealWorld MAC - VRP UserList -------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Keys = {
	["ESC"] = 322,
	["F1"] = 288,
	["F2"] = 289,
	["F3"] = 170,
	["F5"] = 166,
	["F6"] = 167,
	["F7"] = 168,
	["F8"] = 169,
	["F9"] = 56,
	["F10"] = 57,
	["~"] = 243,
	["1"] = 157,
	["2"] = 158,
	["3"] = 160,
	["4"] = 164,
	["5"] = 165,
	["6"] = 159,
	["7"] = 161,
	["8"] = 162,
	["9"] = 163,
	["-"] = 84,
	["="] = 83,
	["BACKSPACE"] = 177,
	["TAB"] = 37,
	["Q"] = 44,
	["W"] = 32,
	["E"] = 38,
	["R"] = 45,
	["T"] = 245,
	["Y"] = 246,
	["U"] = 303,
	["P"] = 199,
	["["] = 39,
	["]"] = 40,
	["ENTER"] = 18,
	["CAPS"] = 137,
	["A"] = 34,
	["S"] = 8,
	["D"] = 9,
	["F"] = 23,
	["G"] = 47,
	["H"] = 74,
	["K"] = 311,
	["L"] = 182,
	["LEFTSHIFT"] = 21,
	["Z"] = 20,
	["X"] = 73,
	["C"] = 26,
	["V"] = 0,
	["B"] = 29,
	["N"] = 249,
	["M"] = 244,
	[","] = 82,
	["."] = 81,
	["LEFTCTRL"] = 36,
	["LEFTALT"] = 19,
	["SPACE"] = 22,
	["RIGHTCTRL"] = 70,
	["HOME"] = 213,
	["PAGEUP"] = 10,
	["PAGEDOWN"] = 11,
	["DELETE"] = 178,
	["LEFT"] = 174,
	["RIGHT"] = 175,
	["TOP"] = 27,
	["DOWN"] = 173,
	["NENTER"] = 201,
	["N4"] = 108,
	["N5"] = 60,
	["N6"] = 107,
	["N+"] = 96,
	["N-"] = 97,
	["N7"] = 117,
	["N8"] = 61,
	["N9"] = 118
}

function getKeyCode(key)
	return Keys[key]
end

-- Remove Emo

local function lookupify(t)
	local r = {}
	for _, v in pairs(t) do
		r[v] = true
	end
	return r
end

local blockedRanges = {
	{0x0001F601, 0x0001F64F},
	{0x00002702, 0x000027B0},
	{0x0001F680, 0x0001F6C0},
	--{0x000024C2, 0x0001F251},
	{0x0001F300, 0x0001F5FF},
	{0x00002194, 0x00002199},
	{0x000023E9, 0x000023F3},
	{0x000025FB, 0x000026FD},
	{0x0001F300, 0x0001F5FF},
	{0x0001F600, 0x0001F636},
	{0x0001F681, 0x0001F6C5},
	{0x0001F30D, 0x0001F567}
}

local blockedSingles =
	lookupify {
	0x000000A9,
	0x000000AE,
	0x0000203C,
	0x00002049,
	0x000020E3,
	0x00002122,
	0x00002139,
	0x000021A9,
	0x000021AA,
	0x0000231A,
	0x0000231B,
	0x000025AA,
	0x000025AB,
	0x000025B6,
	0x000025C0,
	0x00002934,
	0x00002935,
	0x00002B05,
	0x00002B06,
	0x00002B07,
	0x00002B1B,
	0x00002B1C,
	0x00002B50,
	0x00002B55,
	0x00003030,
	0x0000303D,
	0x00003297,
	0x00003299,
	0x0001F004,
	0x0001F0CF,
	0x0001F985
}

function removeEmoji(str)
	local codepoints = {}
	for _, codepoint in utf8.codes(str) do
		local insert = true
		if blockedSingles[codepoint] then
			insert = false
		else
			for _, range in ipairs(blockedRanges) do
				if range[1] <= codepoint and codepoint <= range[2] then
					insert = false
					break
				end
			end
		end
		if insert then
			table.insert(codepoints, codepoint)
		end
	end
	return utf8.char(table.unpack(codepoints))
end
