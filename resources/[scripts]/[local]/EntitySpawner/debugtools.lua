RequestStreamedTextureDict("fiveM_headerss")
RequestStreamedTextureDict("freemodeTextD")
RequestStreamedTextureDict("fiveM_BasicTextures")
RequestStreamedTextureDict("fiveM_animatedTextures")
function things(modelHash)
	stuff = modelHash
end

local debugWindowTextureDict = "shared"
local debugWindowTexture = "bggradient"
local debugWindowXPos = 0.85
local debugWindowYPos = 0.41
local debugWindowSizeX = 0.28
local debugWindowSizeY = 0.71
local debugWindowHeading = 0.0
local debugWindowColorR = 0
local debugWindowColorG = 0
local debugWindowColorB = 0
local debugWindowTranparency = 200
local showInfo = false
local debugWindowConfigMenu = false
local moveWindowSprite = false
function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

rgbSlider_R = 0
rgbSlider_G = 0
rgbSlider_B = 0
rgbSlider_A = 200
rgbButtonSlider_XPos_R = 0.1698
rgbButtonSlider_YPos_R = 0.4540
rgbButtonSlider_XPos_G = 0.1800
rgbButtonSlider_YPos_G = 0.4540
rgbButtonSlider_XPos_B = 0.1900
rgbButtonSlider_YPos_B = 0.4540
sizeX = 0.00880
sizeY = 0.014
saveOldColors = true
loadOldColors = true
function rgbControl()
	local mouseX = GetControlNormal(2, 239)
	local mouseY = GetControlNormal(2, 240)

	local buttonX1 = rgbButtonSlider_XPos_R - sizeX / 2
	local buttonX2 = rgbButtonSlider_XPos_R + sizeX / 2
	local buttonY1 = rgbButtonSlider_YPos_R - sizeY / 2
	local buttonY2 = rgbButtonSlider_YPos_R + sizeY / 2

	local buttonX3 = rgbButtonSlider_XPos_G - sizeX / 2
	local buttonX4 = rgbButtonSlider_XPos_G + sizeX / 2
	local buttonY3 = rgbButtonSlider_YPos_G - sizeY / 2
	local buttonY4 = rgbButtonSlider_YPos_G + sizeY / 2

	local buttonX5 = rgbButtonSlider_XPos_B - sizeX / 2
	local buttonX6 = rgbButtonSlider_XPos_B + sizeX / 2
	local buttonY5 = rgbButtonSlider_YPos_B - sizeY / 2
	local buttonY6 = rgbButtonSlider_YPos_B + sizeY / 2

	--border box
	DrawSprite("shared", "bggradient", 0.1879 + 0.50, 0.3805, 0.059, 0.207, 0.0, 5, 100, 12, 255)
	--color chooser box
	DrawSprite("shared", "bggradient", 0.1881 + 0.50, 0.3808, 0.052, 0.1838, 0.0, 0, 0, 0, 255)
	--color chooser box RGB "R" slider base
	DrawSprite("shared", "bggradient", 0.1700 + 0.50, 0.3896, 0.001999, 0.1420, 0.0, 128, 128, 128, 255)
	--color chooser box RGB "R" slider
	DrawSprite("shared", "bggradient", rgbButtonSlider_XPos_R + 0.50, rgbButtonSlider_YPos_R, 0.00880, 0.014, 0.0, 255, 255, 255, 255)
	--color chooser box RGB "G" slider base
	DrawSprite("shared", "bggradient", 0.1800 + 0.50, 0.3896, 0.001999, 0.1420, 0.0, 128, 128, 128, 255)
	--color chooser box RGB "G" slider
	DrawSprite("shared", "bggradient", rgbButtonSlider_XPos_G + 0.50, rgbButtonSlider_YPos_G, 0.00880, 0.014, 0.0, 255, 255, 255, 255)
	--color chooser box RGB "B" slider base
	DrawSprite("shared", "bggradient", 0.1900 + 0.50, 0.3896, 0.001999, 0.1420, 0.0, 128, 128, 128, 255)
	--color chooser box RGB "B" slider
	DrawSprite("shared", "bggradient", rgbButtonSlider_XPos_B + 0.50, rgbButtonSlider_YPos_B, 0.00880, 0.014, 0.0, 255, 255, 255, 255)
	--color chooser box RGB "A" slider base
	DrawSprite("shared", "bggradient", 0.2050 + 0.50, 0.3896, 0.001999, 0.1420, 0.0, 128, 128, 128, 255)

	if (mouseX > buttonX1 + 0.50 and mouseX < buttonX2 + 0.50) and (mouseY >= buttonY1 and mouseY <= buttonY2) then
		DrawSprite("shared", "bggradient", rgbButtonSlider_XPos_R + 0.50, rgbButtonSlider_YPos_R, 0.00880, 0.014, 0.0, 255, 0, 255, 255)
		if IsControlPressed(2, 237) then
			rgbButtonSlider_YPos_R = mouseY
		end
	end

	if (mouseX > buttonX3 + 0.50 and mouseX < buttonX4 + 0.50) and (mouseY >= buttonY3 and mouseY <= buttonY4) then
		DrawSprite("shared", "bggradient", rgbButtonSlider_XPos_G + 0.50, rgbButtonSlider_YPos_G, 0.00880, 0.014, 0.0, 255, 0, 255, 255)
		if IsControlPressed(2, 237) then
			rgbButtonSlider_YPos_G = mouseY
		end
	end

	if (mouseX > buttonX5 + 0.50 and mouseX < buttonX6 + 0.50) and (mouseY >= buttonY5 and mouseY <= buttonY6) then
		DrawSprite("shared", "bggradient", rgbButtonSlider_XPos_B + 0.50, rgbButtonSlider_YPos_B, 0.00880, 0.014, 0.0, 255, 0, 255, 255)
		if IsControlPressed(2, 237) then
			rgbButtonSlider_YPos_B = mouseY
		end
	end
	debugWindowColorR = rgbSlider_R
	debugWindowColorG = rgbSlider_G
	debugWindowColorB = rgbSlider_B
	drawTxt(tostring(rgbSlider_R), 1, 1, 0.1700 + 0.50, 0.3020 - 0.01, 0.16, 255, 0, 0, 255)
	drawTxt(tostring(rgbSlider_G), 1, 1, 0.1800 + 0.50, 0.3020 - 0.01, 0.16, 0, 255, 0, 255)
	drawTxt(tostring(rgbSlider_B), 1, 1, 0.1900 + 0.50, 0.3020 - 0.01, 0.16, 0, 0, 255, 255)

	if rgbButtonSlider_YPos_R < 0.3254 then
		rgbButtonSlider_YPos_R = 0.3254
		rgbSlider_R = 255
	end
	if rgbButtonSlider_YPos_G < 0.3254 then
		rgbButtonSlider_YPos_G = 0.3254
		rgbSlider_G = 255
	end
	if rgbButtonSlider_YPos_B < 0.3254 then
		rgbButtonSlider_YPos_B = 0.3254
		rgbSlider_B = 255
	end
	if rgbButtonSlider_YPos_R > 0.4540 then
		rgbButtonSlider_YPos_R = 0.4540
		rgbSlider_R = 0
	end
	if rgbButtonSlider_YPos_G > 0.4540 then
		rgbButtonSlider_YPos_G = 0.4540
		rgbSlider_G = 0
	end
	if rgbButtonSlider_YPos_B > 0.4540 then
		rgbButtonSlider_YPos_B = 0.4540
		rgbSlider_B = 0
	end

	--------------------------------------------------------
	------------------rgb slider R -------------------------
	--------------------------------------------------------
	if rgbButtonSlider_YPos_R > 0.3254 and rgbButtonSlider_YPos_R < 0.3259 then
		rgbSlider_R = 254
	elseif rgbButtonSlider_YPos_R > 0.3259 and rgbButtonSlider_YPos_R < 0.3264 then
		rgbSlider_R = 253
	elseif rgbButtonSlider_YPos_R > 0.3264 and rgbButtonSlider_YPos_R < 0.3269 then
		rgbSlider_R = 252
	elseif rgbButtonSlider_YPos_R > 0.3269 and rgbButtonSlider_YPos_R < 0.3274 then
		rgbSlider_R = 251
	elseif rgbButtonSlider_YPos_R > 0.3274 and rgbButtonSlider_YPos_R < 0.3279 then
		rgbSlider_R = 250
	elseif rgbButtonSlider_YPos_R > 0.3279 and rgbButtonSlider_YPos_R < 0.3284 then
		rgbSlider_R = 249
	elseif rgbButtonSlider_YPos_R > 0.3284 and rgbButtonSlider_YPos_R < 0.3289 then
		rgbSlider_R = 248
	elseif rgbButtonSlider_YPos_R > 0.3289 and rgbButtonSlider_YPos_R < 0.3294 then
		rgbSlider_R = 247
	elseif rgbButtonSlider_YPos_R > 0.3294 and rgbButtonSlider_YPos_R < 0.3299 then
		rgbSlider_R = 246
	elseif rgbButtonSlider_YPos_R > 0.3299 and rgbButtonSlider_YPos_R < 0.3304 then
		rgbSlider_R = 245
	elseif rgbButtonSlider_YPos_R > 0.3304 and rgbButtonSlider_YPos_R < 0.3309 then
		rgbSlider_R = 244
	elseif rgbButtonSlider_YPos_R > 0.3309 and rgbButtonSlider_YPos_R < 0.3314 then
		rgbSlider_R = 243
	elseif rgbButtonSlider_YPos_R > 0.3314 and rgbButtonSlider_YPos_R < 0.3319 then
		rgbSlider_R = 242
	elseif rgbButtonSlider_YPos_R > 0.3319 and rgbButtonSlider_YPos_R < 0.3324 then
		rgbSlider_R = 241
	elseif rgbButtonSlider_YPos_R > 0.3324 and rgbButtonSlider_YPos_R < 0.3329 then
		rgbSlider_R = 240
	elseif rgbButtonSlider_YPos_R > 0.3329 and rgbButtonSlider_YPos_R < 0.3334 then
		rgbSlider_R = 239
	elseif rgbButtonSlider_YPos_R > 0.3334 and rgbButtonSlider_YPos_R < 0.3339 then
		rgbSlider_R = 238
	elseif rgbButtonSlider_YPos_R > 0.3339 and rgbButtonSlider_YPos_R < 0.3344 then
		rgbSlider_R = 237
	elseif rgbButtonSlider_YPos_R > 0.3344 and rgbButtonSlider_YPos_R < 0.3349 then
		rgbSlider_R = 236
	elseif rgbButtonSlider_YPos_R > 0.3349 and rgbButtonSlider_YPos_R < 0.3354 then
		rgbSlider_R = 235
	elseif rgbButtonSlider_YPos_R > 0.3354 and rgbButtonSlider_YPos_R < 0.3359 then
		rgbSlider_R = 234
	elseif rgbButtonSlider_YPos_R > 0.3359 and rgbButtonSlider_YPos_R < 0.3364 then
		rgbSlider_R = 233
	elseif rgbButtonSlider_YPos_R > 0.3364 and rgbButtonSlider_YPos_R < 0.3369 then
		rgbSlider_R = 232
	elseif rgbButtonSlider_YPos_R > 0.3369 and rgbButtonSlider_YPos_R < 0.3374 then
		rgbSlider_R = 231
	elseif rgbButtonSlider_YPos_R > 0.3374 and rgbButtonSlider_YPos_R < 0.3379 then
		rgbSlider_R = 230
	elseif rgbButtonSlider_YPos_R > 0.3379 and rgbButtonSlider_YPos_R < 0.3384 then
		rgbSlider_R = 229
	elseif rgbButtonSlider_YPos_R > 0.3384 and rgbButtonSlider_YPos_R < 0.3389 then
		rgbSlider_R = 228
	elseif rgbButtonSlider_YPos_R > 0.3389 and rgbButtonSlider_YPos_R < 0.3394 then
		rgbSlider_R = 227
	elseif rgbButtonSlider_YPos_R > 0.3394 and rgbButtonSlider_YPos_R < 0.3399 then
		rgbSlider_R = 226
	elseif rgbButtonSlider_YPos_R > 0.3399 and rgbButtonSlider_YPos_R < 0.3404 then
		rgbSlider_R = 225
	elseif rgbButtonSlider_YPos_R > 0.3404 and rgbButtonSlider_YPos_R < 0.3409 then
		rgbSlider_R = 224
	elseif rgbButtonSlider_YPos_R > 0.3409 and rgbButtonSlider_YPos_R < 0.3414 then
		rgbSlider_R = 223
	elseif rgbButtonSlider_YPos_R > 0.3414 and rgbButtonSlider_YPos_R < 0.3419 then
		rgbSlider_R = 222
	elseif rgbButtonSlider_YPos_R > 0.3419 and rgbButtonSlider_YPos_R < 0.3424 then
		rgbSlider_R = 221
	elseif rgbButtonSlider_YPos_R > 0.3424 and rgbButtonSlider_YPos_R < 0.3439 then
		rgbSlider_R = 220
	elseif rgbButtonSlider_YPos_R > 0.3429 and rgbButtonSlider_YPos_R < 0.3434 then
		rgbSlider_R = 219
	elseif rgbButtonSlider_YPos_R > 0.3434 and rgbButtonSlider_YPos_R < 0.3439 then
		rgbSlider_R = 218
	elseif rgbButtonSlider_YPos_R > 0.3439 and rgbButtonSlider_YPos_R < 0.3444 then
		rgbSlider_R = 217
	elseif rgbButtonSlider_YPos_R > 0.3444 and rgbButtonSlider_YPos_R < 0.3449 then
		rgbSlider_R = 216
	elseif rgbButtonSlider_YPos_R > 0.3449 and rgbButtonSlider_YPos_R < 0.3454 then
		rgbSlider_R = 215
	elseif rgbButtonSlider_YPos_R > 0.3454 and rgbButtonSlider_YPos_R < 0.3459 then
		rgbSlider_R = 214
	elseif rgbButtonSlider_YPos_R > 0.3459 and rgbButtonSlider_YPos_R < 0.3464 then
		rgbSlider_R = 213
	elseif rgbButtonSlider_YPos_R > 0.3464 and rgbButtonSlider_YPos_R < 0.3469 then
		rgbSlider_R = 212
	elseif rgbButtonSlider_YPos_R > 0.3469 and rgbButtonSlider_YPos_R < 0.3474 then
		rgbSlider_R = 211
	elseif rgbButtonSlider_YPos_R > 0.3474 and rgbButtonSlider_YPos_R < 0.3479 then
		rgbSlider_R = 210
	elseif rgbButtonSlider_YPos_R > 0.3479 and rgbButtonSlider_YPos_R < 0.3484 then
		rgbSlider_R = 209
	elseif rgbButtonSlider_YPos_R > 0.3484 and rgbButtonSlider_YPos_R < 0.3489 then
		rgbSlider_R = 208
	elseif rgbButtonSlider_YPos_R > 0.3489 and rgbButtonSlider_YPos_R < 0.3494 then
		rgbSlider_R = 207
	elseif rgbButtonSlider_YPos_R > 0.3494 and rgbButtonSlider_YPos_R < 0.3499 then
		rgbSlider_R = 206
	elseif rgbButtonSlider_YPos_R > 0.3499 and rgbButtonSlider_YPos_R < 0.3504 then
		rgbSlider_R = 205
	elseif rgbButtonSlider_YPos_R > 0.3504 and rgbButtonSlider_YPos_R < 0.3509 then
		rgbSlider_R = 204
	elseif rgbButtonSlider_YPos_R > 0.3509 and rgbButtonSlider_YPos_R < 0.3514 then
		rgbSlider_R = 203
	elseif rgbButtonSlider_YPos_R > 0.3514 and rgbButtonSlider_YPos_R < 0.3519 then
		rgbSlider_R = 202
	elseif rgbButtonSlider_YPos_R > 0.3519 and rgbButtonSlider_YPos_R < 0.3524 then
		rgbSlider_R = 201
	elseif rgbButtonSlider_YPos_R > 0.3524 and rgbButtonSlider_YPos_R < 0.3529 then
		rgbSlider_R = 200
	elseif rgbButtonSlider_YPos_R > 0.3529 and rgbButtonSlider_YPos_R < 0.3534 then
		rgbSlider_R = 199
	elseif rgbButtonSlider_YPos_R > 0.3534 and rgbButtonSlider_YPos_R < 0.3539 then
		rgbSlider_R = 198
	elseif rgbButtonSlider_YPos_R > 0.3539 and rgbButtonSlider_YPos_R < 0.3544 then
		rgbSlider_R = 197
	elseif rgbButtonSlider_YPos_R > 0.3544 and rgbButtonSlider_YPos_R < 0.3549 then
		rgbSlider_R = 196
	elseif rgbButtonSlider_YPos_R > 0.3549 and rgbButtonSlider_YPos_R < 0.3554 then
		rgbSlider_R = 195
	elseif rgbButtonSlider_YPos_R > 0.3554 and rgbButtonSlider_YPos_R < 0.3559 then
		rgbSlider_R = 194
	elseif rgbButtonSlider_YPos_R > 0.3559 and rgbButtonSlider_YPos_R < 0.3564 then
		rgbSlider_R = 193
	elseif rgbButtonSlider_YPos_R > 0.3564 and rgbButtonSlider_YPos_R < 0.3569 then
		rgbSlider_R = 192
	elseif rgbButtonSlider_YPos_R > 0.3569 and rgbButtonSlider_YPos_R < 0.3574 then
		rgbSlider_R = 191
	elseif rgbButtonSlider_YPos_R > 0.3574 and rgbButtonSlider_YPos_R < 0.3579 then
		rgbSlider_R = 190
	elseif rgbButtonSlider_YPos_R > 0.3579 and rgbButtonSlider_YPos_R < 0.3584 then
		rgbSlider_R = 189
	elseif rgbButtonSlider_YPos_R > 0.3584 and rgbButtonSlider_YPos_R < 0.3589 then
		rgbSlider_R = 188
	elseif rgbButtonSlider_YPos_R > 0.3589 and rgbButtonSlider_YPos_R < 0.3594 then
		rgbSlider_R = 187
	elseif rgbButtonSlider_YPos_R > 0.3594 and rgbButtonSlider_YPos_R < 0.3599 then
		rgbSlider_R = 186
	elseif rgbButtonSlider_YPos_R > 0.3599 and rgbButtonSlider_YPos_R < 0.3604 then
		rgbSlider_R = 185
	elseif rgbButtonSlider_YPos_R > 0.3604 and rgbButtonSlider_YPos_R < 0.3609 then
		rgbSlider_R = 184
	elseif rgbButtonSlider_YPos_R > 0.3609 and rgbButtonSlider_YPos_R < 0.3614 then
		rgbSlider_R = 183
	elseif rgbButtonSlider_YPos_R > 0.3614 and rgbButtonSlider_YPos_R < 0.3319 then
		rgbSlider_R = 182
	elseif rgbButtonSlider_YPos_R > 0.3619 and rgbButtonSlider_YPos_R < 0.3624 then
		rgbSlider_R = 181
	elseif rgbButtonSlider_YPos_R > 0.3624 and rgbButtonSlider_YPos_R < 0.3629 then
		rgbSlider_R = 180
	elseif rgbButtonSlider_YPos_R > 0.3629 and rgbButtonSlider_YPos_R < 0.3634 then
		rgbSlider_R = 179
	elseif rgbButtonSlider_YPos_R > 0.3634 and rgbButtonSlider_YPos_R < 0.3639 then
		rgbSlider_R = 178
	elseif rgbButtonSlider_YPos_R > 0.3639 and rgbButtonSlider_YPos_R < 0.3644 then
		rgbSlider_R = 177
	elseif rgbButtonSlider_YPos_R > 0.3644 and rgbButtonSlider_YPos_R < 0.3649 then
		rgbSlider_R = 176
	elseif rgbButtonSlider_YPos_R > 0.3649 and rgbButtonSlider_YPos_R < 0.3654 then
		rgbSlider_R = 175
	elseif rgbButtonSlider_YPos_R > 0.3654 and rgbButtonSlider_YPos_R < 0.3659 then
		rgbSlider_R = 174
	elseif rgbButtonSlider_YPos_R > 0.3659 and rgbButtonSlider_YPos_R < 0.3664 then
		rgbSlider_R = 173
	elseif rgbButtonSlider_YPos_R > 0.3664 and rgbButtonSlider_YPos_R < 0.3369 then
		rgbSlider_R = 172
	elseif rgbButtonSlider_YPos_R > 0.3669 and rgbButtonSlider_YPos_R < 0.3674 then
		rgbSlider_R = 171
	elseif rgbButtonSlider_YPos_R > 0.3674 and rgbButtonSlider_YPos_R < 0.3679 then
		rgbSlider_R = 170
	elseif rgbButtonSlider_YPos_R > 0.3679 and rgbButtonSlider_YPos_R < 0.3684 then
		rgbSlider_R = 169
	elseif rgbButtonSlider_YPos_R > 0.3684 and rgbButtonSlider_YPos_R < 0.3689 then
		rgbSlider_R = 168
	elseif rgbButtonSlider_YPos_R > 0.3689 and rgbButtonSlider_YPos_R < 0.3694 then
		rgbSlider_R = 167
	elseif rgbButtonSlider_YPos_R > 0.3694 and rgbButtonSlider_YPos_R < 0.3699 then
		rgbSlider_R = 166
	elseif rgbButtonSlider_YPos_R > 0.3699 and rgbButtonSlider_YPos_R < 0.3704 then
		rgbSlider_R = 165
	elseif rgbButtonSlider_YPos_R > 0.3704 and rgbButtonSlider_YPos_R < 0.3709 then
		rgbSlider_R = 164
	elseif rgbButtonSlider_YPos_R > 0.3709 and rgbButtonSlider_YPos_R < 0.3714 then
		rgbSlider_R = 163
	elseif rgbButtonSlider_YPos_R > 0.3714 and rgbButtonSlider_YPos_R < 0.3719 then
		rgbSlider_R = 162
	elseif rgbButtonSlider_YPos_R > 0.3719 and rgbButtonSlider_YPos_R < 0.3724 then
		rgbSlider_R = 161
	elseif rgbButtonSlider_YPos_R > 0.3734 and rgbButtonSlider_YPos_R < 0.3739 then
		rgbSlider_R = 160
	elseif rgbButtonSlider_YPos_R > 0.3739 and rgbButtonSlider_YPos_R < 0.3744 then
		rgbSlider_R = 159
	elseif rgbButtonSlider_YPos_R > 0.3744 and rgbButtonSlider_YPos_R < 0.3749 then
		rgbSlider_R = 158
	elseif rgbButtonSlider_YPos_R > 0.3749 and rgbButtonSlider_YPos_R < 0.3754 then
		rgbSlider_R = 157
	elseif rgbButtonSlider_YPos_R > 0.3754 and rgbButtonSlider_YPos_R < 0.3759 then
		rgbSlider_R = 156
	elseif rgbButtonSlider_YPos_R > 0.3759 and rgbButtonSlider_YPos_R < 0.3764 then
		rgbSlider_R = 155
	elseif rgbButtonSlider_YPos_R > 0.3764 and rgbButtonSlider_YPos_R < 0.3769 then
		rgbSlider_R = 154
	elseif rgbButtonSlider_YPos_R > 0.3769 and rgbButtonSlider_YPos_R < 0.3774 then
		rgbSlider_R = 153
	elseif rgbButtonSlider_YPos_R > 0.3774 and rgbButtonSlider_YPos_R < 0.3779 then
		rgbSlider_R = 152
	elseif rgbButtonSlider_YPos_R > 0.3779 and rgbButtonSlider_YPos_R < 0.3784 then
		rgbSlider_R = 151
	elseif rgbButtonSlider_YPos_R > 0.3784 and rgbButtonSlider_YPos_R < 0.3789 then
		rgbSlider_R = 150
	elseif rgbButtonSlider_YPos_R > 0.3789 and rgbButtonSlider_YPos_R < 0.3794 then
		rgbSlider_R = 149
	elseif rgbButtonSlider_YPos_R > 0.3794 and rgbButtonSlider_YPos_R < 0.3799 then
		rgbSlider_R = 148
	elseif rgbButtonSlider_YPos_R > 0.3799 and rgbButtonSlider_YPos_R < 0.3804 then
		rgbSlider_R = 147
	elseif rgbButtonSlider_YPos_R > 0.3804 and rgbButtonSlider_YPos_R < 0.3809 then
		rgbSlider_R = 146
	elseif rgbButtonSlider_YPos_R > 0.3809 and rgbButtonSlider_YPos_R < 0.3814 then
		rgbSlider_R = 145
	elseif rgbButtonSlider_YPos_R > 0.3814 and rgbButtonSlider_YPos_R < 0.3819 then
		rgbSlider_R = 144
	elseif rgbButtonSlider_YPos_R > 0.3819 and rgbButtonSlider_YPos_R < 0.3824 then
		rgbSlider_R = 143
	elseif rgbButtonSlider_YPos_R > 0.3824 and rgbButtonSlider_YPos_R < 0.3829 then
		rgbSlider_R = 142
	elseif rgbButtonSlider_YPos_R > 0.3829 and rgbButtonSlider_YPos_R < 0.3834 then
		rgbSlider_R = 141
	elseif rgbButtonSlider_YPos_R > 0.3834 and rgbButtonSlider_YPos_R < 0.3839 then
		rgbSlider_R = 140
	elseif rgbButtonSlider_YPos_R > 0.3839 and rgbButtonSlider_YPos_R < 0.3844 then
		rgbSlider_R = 139
	elseif rgbButtonSlider_YPos_R > 0.3844 and rgbButtonSlider_YPos_R < 0.3849 then
		rgbSlider_R = 138
	elseif rgbButtonSlider_YPos_R > 0.3849 and rgbButtonSlider_YPos_R < 0.3854 then
		rgbSlider_R = 137
	elseif rgbButtonSlider_YPos_R > 0.3854 and rgbButtonSlider_YPos_R < 0.3859 then
		rgbSlider_R = 136
	elseif rgbButtonSlider_YPos_R > 0.3859 and rgbButtonSlider_YPos_R < 0.3864 then
		rgbSlider_R = 135
	elseif rgbButtonSlider_YPos_R > 0.3864 and rgbButtonSlider_YPos_R < 0.3869 then
		rgbSlider_R = 134
	elseif rgbButtonSlider_YPos_R > 0.3869 and rgbButtonSlider_YPos_R < 0.3874 then
		rgbSlider_R = 133
	elseif rgbButtonSlider_YPos_R > 0.3874 and rgbButtonSlider_YPos_R < 0.3879 then
		rgbSlider_R = 132
	elseif rgbButtonSlider_YPos_R > 0.3879 and rgbButtonSlider_YPos_R < 0.3884 then
		rgbSlider_R = 131
	elseif rgbButtonSlider_YPos_R > 0.3884 and rgbButtonSlider_YPos_R < 0.3889 then
		rgbSlider_R = 130
	elseif rgbButtonSlider_YPos_R > 0.3889 and rgbButtonSlider_YPos_R < 0.3894 then
		rgbSlider_R = 129
	elseif rgbButtonSlider_YPos_R > 0.3894 and rgbButtonSlider_YPos_R < 0.3899 then
		rgbSlider_R = 128
	elseif rgbButtonSlider_YPos_R > 0.3899 and rgbButtonSlider_YPos_R < 0.3904 then
		rgbSlider_R = 127
	elseif rgbButtonSlider_YPos_R > 0.3904 and rgbButtonSlider_YPos_R < 0.3909 then
		rgbSlider_R = 126
	elseif rgbButtonSlider_YPos_R > 0.3909 and rgbButtonSlider_YPos_R < 0.3914 then
		rgbSlider_R = 125
	elseif rgbButtonSlider_YPos_R > 0.3914 and rgbButtonSlider_YPos_R < 0.3919 then
		rgbSlider_R = 124
	elseif rgbButtonSlider_YPos_R > 0.3919 and rgbButtonSlider_YPos_R < 0.3924 then
		rgbSlider_R = 123
	elseif rgbButtonSlider_YPos_R > 0.3924 and rgbButtonSlider_YPos_R < 0.3929 then
		rgbSlider_R = 122
	elseif rgbButtonSlider_YPos_R > 0.3929 and rgbButtonSlider_YPos_R < 0.3934 then
		rgbSlider_R = 121
	elseif rgbButtonSlider_YPos_R > 0.3934 and rgbButtonSlider_YPos_R < 0.3939 then
		rgbSlider_R = 120
	elseif rgbButtonSlider_YPos_R > 0.3939 and rgbButtonSlider_YPos_R < 0.3944 then
		rgbSlider_R = 119
	elseif rgbButtonSlider_YPos_R > 0.3944 and rgbButtonSlider_YPos_R < 0.3949 then
		rgbSlider_R = 118
	elseif rgbButtonSlider_YPos_R > 0.3949 and rgbButtonSlider_YPos_R < 0.3954 then
		rgbSlider_R = 117
	elseif rgbButtonSlider_YPos_R > 0.3954 and rgbButtonSlider_YPos_R < 0.3969 then
		rgbSlider_R = 116
	elseif rgbButtonSlider_YPos_R > 0.3969 and rgbButtonSlider_YPos_R < 0.3974 then
		rgbSlider_R = 115
	elseif rgbButtonSlider_YPos_R > 0.3974 and rgbButtonSlider_YPos_R < 0.3979 then
		rgbSlider_R = 114
	elseif rgbButtonSlider_YPos_R > 0.3979 and rgbButtonSlider_YPos_R < 0.3984 then
		rgbSlider_R = 113
	elseif rgbButtonSlider_YPos_R > 0.3984 and rgbButtonSlider_YPos_R < 0.3989 then
		rgbSlider_R = 112
	elseif rgbButtonSlider_YPos_R > 0.3989 and rgbButtonSlider_YPos_R < 0.3994 then
		rgbSlider_R = 111
	elseif rgbButtonSlider_YPos_R > 0.3994 and rgbButtonSlider_YPos_R < 0.3999 then
		rgbSlider_R = 110
	elseif rgbButtonSlider_YPos_R > 0.3999 and rgbButtonSlider_YPos_R < 0.4004 then
		rgbSlider_R = 109
	elseif rgbButtonSlider_YPos_R > 0.4004 and rgbButtonSlider_YPos_R < 0.4009 then
		rgbSlider_R = 108
	elseif rgbButtonSlider_YPos_R > 0.4009 and rgbButtonSlider_YPos_R < 0.4014 then
		rgbSlider_R = 107
	elseif rgbButtonSlider_YPos_R > 0.4014 and rgbButtonSlider_YPos_R < 0.4019 then
		rgbSlider_R = 106
	elseif rgbButtonSlider_YPos_R > 0.4019 and rgbButtonSlider_YPos_R < 0.4024 then
		rgbSlider_R = 105
	elseif rgbButtonSlider_YPos_R > 0.4024 and rgbButtonSlider_YPos_R < 0.4029 then
		rgbSlider_R = 104
	elseif rgbButtonSlider_YPos_R > 0.4029 and rgbButtonSlider_YPos_R < 0.4034 then
		rgbSlider_R = 103
	elseif rgbButtonSlider_YPos_R > 0.4034 and rgbButtonSlider_YPos_R < 0.4039 then
		rgbSlider_R = 102
	elseif rgbButtonSlider_YPos_R > 0.4039 and rgbButtonSlider_YPos_R < 0.4044 then
		rgbSlider_R = 101
	elseif rgbButtonSlider_YPos_R > 0.4044 and rgbButtonSlider_YPos_R < 0.4049 then
		rgbSlider_R = 100
	elseif rgbButtonSlider_YPos_R > 0.4049 and rgbButtonSlider_YPos_R < 0.4054 then
		rgbSlider_R = 99
	elseif rgbButtonSlider_YPos_R > 0.4054 and rgbButtonSlider_YPos_R < 0.4059 then
		rgbSlider_R = 98
	elseif rgbButtonSlider_YPos_R > 0.4059 and rgbButtonSlider_YPos_R < 0.4064 then
		rgbSlider_R = 97
	elseif rgbButtonSlider_YPos_R > 0.4064 and rgbButtonSlider_YPos_R < 0.4069 then
		rgbSlider_R = 96
	elseif rgbButtonSlider_YPos_R > 0.4069 and rgbButtonSlider_YPos_R < 0.4074 then
		rgbSlider_R = 95
	elseif rgbButtonSlider_YPos_R > 0.4074 and rgbButtonSlider_YPos_R < 0.4079 then
		rgbSlider_R = 94
	elseif rgbButtonSlider_YPos_R > 0.4079 and rgbButtonSlider_YPos_R < 0.4084 then
		rgbSlider_R = 93
	elseif rgbButtonSlider_YPos_R > 0.4084 and rgbButtonSlider_YPos_R < 0.4089 then
		rgbSlider_R = 92
	elseif rgbButtonSlider_YPos_R > 0.4089 and rgbButtonSlider_YPos_R < 0.4094 then
		rgbSlider_R = 91
	elseif rgbButtonSlider_YPos_R > 0.4094 and rgbButtonSlider_YPos_R < 0.4099 then
		rgbSlider_R = 90
	elseif rgbButtonSlider_YPos_R > 0.4099 and rgbButtonSlider_YPos_R < 0.4104 then
		rgbSlider_R = 89
	elseif rgbButtonSlider_YPos_R > 0.4104 and rgbButtonSlider_YPos_R < 0.4109 then
		rgbSlider_R = 88
	elseif rgbButtonSlider_YPos_R > 0.4109 and rgbButtonSlider_YPos_R < 0.4114 then
		rgbSlider_R = 87
	elseif rgbButtonSlider_YPos_R > 0.4114 and rgbButtonSlider_YPos_R < 0.4119 then
		rgbSlider_R = 86
	elseif rgbButtonSlider_YPos_R > 0.4119 and rgbButtonSlider_YPos_R < 0.4124 then
		rgbSlider_R = 85
	elseif rgbButtonSlider_YPos_R > 0.4124 and rgbButtonSlider_YPos_R < 0.4129 then
		rgbSlider_R = 84
	elseif rgbButtonSlider_YPos_R > 0.4129 and rgbButtonSlider_YPos_R < 0.4134 then
		rgbSlider_R = 83
	elseif rgbButtonSlider_YPos_R > 0.4134 and rgbButtonSlider_YPos_R < 0.4139 then
		rgbSlider_R = 82
	elseif rgbButtonSlider_YPos_R > 0.4139 and rgbButtonSlider_YPos_R < 0.4144 then
		rgbSlider_R = 81
	elseif rgbButtonSlider_YPos_R > 0.4144 and rgbButtonSlider_YPos_R < 0.4149 then
		rgbSlider_R = 80
	elseif rgbButtonSlider_YPos_R > 0.4149 and rgbButtonSlider_YPos_R < 0.4154 then
		rgbSlider_R = 79
	elseif rgbButtonSlider_YPos_R > 0.4154 and rgbButtonSlider_YPos_R < 0.4159 then
		rgbSlider_R = 78
	elseif rgbButtonSlider_YPos_R > 0.4159 and rgbButtonSlider_YPos_R < 0.4164 then
		rgbSlider_R = 77
	elseif rgbButtonSlider_YPos_R > 0.4164 and rgbButtonSlider_YPos_R < 0.4169 then
		rgbSlider_R = 76
	elseif rgbButtonSlider_YPos_R > 0.4169 and rgbButtonSlider_YPos_R < 0.4174 then
		rgbSlider_R = 75
	elseif rgbButtonSlider_YPos_R > 0.4174 and rgbButtonSlider_YPos_R < 0.4179 then
		rgbSlider_R = 74
	elseif rgbButtonSlider_YPos_R > 0.4179 and rgbButtonSlider_YPos_R < 0.4184 then
		rgbSlider_R = 73
	elseif rgbButtonSlider_YPos_R > 0.4184 and rgbButtonSlider_YPos_R < 0.4189 then
		rgbSlider_R = 72
	elseif rgbButtonSlider_YPos_R > 0.4179 and rgbButtonSlider_YPos_R < 0.4194 then
		rgbSlider_R = 71
	elseif rgbButtonSlider_YPos_R > 0.4194 and rgbButtonSlider_YPos_R < 0.4199 then
		rgbSlider_R = 70
	elseif rgbButtonSlider_YPos_R > 0.4199 and rgbButtonSlider_YPos_R < 0.4204 then
		rgbSlider_R = 69
	elseif rgbButtonSlider_YPos_R > 0.4204 and rgbButtonSlider_YPos_R < 0.4209 then
		rgbSlider_R = 68
	elseif rgbButtonSlider_YPos_R > 0.4209 and rgbButtonSlider_YPos_R < 0.4214 then
		rgbSlider_R = 67
	elseif rgbButtonSlider_YPos_R > 0.4214 and rgbButtonSlider_YPos_R < 0.4219 then
		rgbSlider_R = 66
	elseif rgbButtonSlider_YPos_R > 0.4219 and rgbButtonSlider_YPos_R < 0.4224 then
		rgbSlider_R = 65
	elseif rgbButtonSlider_YPos_R > 0.4224 and rgbButtonSlider_YPos_R < 0.4229 then
		rgbSlider_R = 64
	elseif rgbButtonSlider_YPos_R > 0.4229 and rgbButtonSlider_YPos_R < 0.4234 then
		rgbSlider_R = 63
	elseif rgbButtonSlider_YPos_R > 0.4234 and rgbButtonSlider_YPos_R < 0.4239 then
		rgbSlider_R = 62
	elseif rgbButtonSlider_YPos_R > 0.4239 and rgbButtonSlider_YPos_R < 0.4244 then
		rgbSlider_R = 61
	elseif rgbButtonSlider_YPos_R > 0.4244 and rgbButtonSlider_YPos_R < 0.4249 then
		rgbSlider_R = 60
	elseif rgbButtonSlider_YPos_R > 0.4249 and rgbButtonSlider_YPos_R < 0.4254 then
		rgbSlider_R = 59
	elseif rgbButtonSlider_YPos_R > 0.4254 and rgbButtonSlider_YPos_R < 0.4259 then
		rgbSlider_R = 58
	elseif rgbButtonSlider_YPos_R > 0.4259 and rgbButtonSlider_YPos_R < 0.4264 then
		rgbSlider_R = 57
	elseif rgbButtonSlider_YPos_R > 0.4264 and rgbButtonSlider_YPos_R < 0.4269 then
		rgbSlider_R = 56
	elseif rgbButtonSlider_YPos_R > 0.4269 and rgbButtonSlider_YPos_R < 0.4274 then
		rgbSlider_R = 55
	elseif rgbButtonSlider_YPos_R > 0.4274 and rgbButtonSlider_YPos_R < 0.4279 then
		rgbSlider_R = 54
	elseif rgbButtonSlider_YPos_R > 0.4279 and rgbButtonSlider_YPos_R < 0.4284 then
		rgbSlider_R = 53
	elseif rgbButtonSlider_YPos_R > 0.4284 and rgbButtonSlider_YPos_R < 0.4289 then
		rgbSlider_R = 52
	elseif rgbButtonSlider_YPos_R > 0.4289 and rgbButtonSlider_YPos_R < 0.4294 then
		rgbSlider_R = 51
	elseif rgbButtonSlider_YPos_R > 0.4294 and rgbButtonSlider_YPos_R < 0.4299 then
		rgbSlider_R = 50
	elseif rgbButtonSlider_YPos_R > 0.4299 and rgbButtonSlider_YPos_R < 0.4304 then
		rgbSlider_R = 49
	elseif rgbButtonSlider_YPos_R > 0.4304 and rgbButtonSlider_YPos_R < 0.4309 then
		rgbSlider_R = 48
	elseif rgbButtonSlider_YPos_R > 0.4309 and rgbButtonSlider_YPos_R < 0.4314 then
		rgbSlider_R = 47
	elseif rgbButtonSlider_YPos_R > 0.4314 and rgbButtonSlider_YPos_R < 0.4319 then
		rgbSlider_R = 46
	elseif rgbButtonSlider_YPos_R > 0.4319 and rgbButtonSlider_YPos_R < 0.4324 then
		rgbSlider_R = 45
	elseif rgbButtonSlider_YPos_R > 0.4324 and rgbButtonSlider_YPos_R < 0.4329 then
		rgbSlider_R = 44
	elseif rgbButtonSlider_YPos_R > 0.4329 and rgbButtonSlider_YPos_R < 0.4334 then
		rgbSlider_R = 43
	elseif rgbButtonSlider_YPos_R > 0.4334 and rgbButtonSlider_YPos_R < 0.4339 then
		rgbSlider_R = 42
	elseif rgbButtonSlider_YPos_R > 0.4339 and rgbButtonSlider_YPos_R < 0.4344 then
		rgbSlider_R = 41
	elseif rgbButtonSlider_YPos_R > 0.4344 and rgbButtonSlider_YPos_R < 0.4349 then
		rgbSlider_R = 40
	elseif rgbButtonSlider_YPos_R > 0.4349 and rgbButtonSlider_YPos_R < 0.4354 then
		rgbSlider_R = 39
	elseif rgbButtonSlider_YPos_R > 0.4354 and rgbButtonSlider_YPos_R < 0.4359 then
		rgbSlider_R = 38
	elseif rgbButtonSlider_YPos_R > 0.4359 and rgbButtonSlider_YPos_R < 0.4364 then
		rgbSlider_R = 37
	elseif rgbButtonSlider_YPos_R > 0.4364 and rgbButtonSlider_YPos_R < 0.4369 then
		rgbSlider_R = 36
	elseif rgbButtonSlider_YPos_R > 0.4369 and rgbButtonSlider_YPos_R < 0.4374 then
		rgbSlider_R = 35
	elseif rgbButtonSlider_YPos_R > 0.4374 and rgbButtonSlider_YPos_R < 0.4379 then
		rgbSlider_R = 34
	elseif rgbButtonSlider_YPos_R > 0.4379 and rgbButtonSlider_YPos_R < 0.4374 then
		rgbSlider_R = 33
	elseif rgbButtonSlider_YPos_R > 0.4384 and rgbButtonSlider_YPos_R < 0.4389 then
		rgbSlider_R = 32
	elseif rgbButtonSlider_YPos_R > 0.4389 and rgbButtonSlider_YPos_R < 0.4394 then
		rgbSlider_R = 31
	elseif rgbButtonSlider_YPos_R > 0.4394 and rgbButtonSlider_YPos_R < 0.4399 then
		rgbSlider_R = 30
	elseif rgbButtonSlider_YPos_R > 0.4399 and rgbButtonSlider_YPos_R < 0.4404 then
		rgbSlider_R = 29
	elseif rgbButtonSlider_YPos_R > 0.4404 and rgbButtonSlider_YPos_R < 0.4409 then
		rgbSlider_R = 28
	elseif rgbButtonSlider_YPos_R > 0.4409 and rgbButtonSlider_YPos_R < 0.4414 then
		rgbSlider_R = 27
	elseif rgbButtonSlider_YPos_R > 0.4414 and rgbButtonSlider_YPos_R < 0.4419 then
		rgbSlider_R = 26
	elseif rgbButtonSlider_YPos_R > 0.4419 and rgbButtonSlider_YPos_R < 0.4424 then
		rgbSlider_R = 25
	elseif rgbButtonSlider_YPos_R > 0.4424 and rgbButtonSlider_YPos_R < 0.4429 then
		rgbSlider_R = 24
	elseif rgbButtonSlider_YPos_R > 0.4429 and rgbButtonSlider_YPos_R < 0.4434 then
		rgbSlider_R = 23
	elseif rgbButtonSlider_YPos_R > 0.4434 and rgbButtonSlider_YPos_R < 0.4439 then
		rgbSlider_R = 22
	elseif rgbButtonSlider_YPos_R > 0.4439 and rgbButtonSlider_YPos_R < 0.4444 then
		rgbSlider_R = 21
	elseif rgbButtonSlider_YPos_R > 0.4444 and rgbButtonSlider_YPos_R < 0.4449 then
		rgbSlider_R = 20
	elseif rgbButtonSlider_YPos_R > 0.4449 and rgbButtonSlider_YPos_R < 0.4454 then
		rgbSlider_R = 19
	elseif rgbButtonSlider_YPos_R > 0.4454 and rgbButtonSlider_YPos_R < 0.4459 then
		rgbSlider_R = 18
	elseif rgbButtonSlider_YPos_R > 0.4459 and rgbButtonSlider_YPos_R < 0.4464 then
		rgbSlider_R = 17
	elseif rgbButtonSlider_YPos_R > 0.4464 and rgbButtonSlider_YPos_R < 0.4469 then
		rgbSlider_R = 16
	elseif rgbButtonSlider_YPos_R > 0.4469 and rgbButtonSlider_YPos_R < 0.4474 then
		rgbSlider_R = 15
	elseif rgbButtonSlider_YPos_R > 0.4474 and rgbButtonSlider_YPos_R < 0.4479 then
		rgbSlider_R = 14
	elseif rgbButtonSlider_YPos_R > 0.4479 and rgbButtonSlider_YPos_R < 0.4484 then
		rgbSlider_R = 13
	elseif rgbButtonSlider_YPos_R > 0.4484 and rgbButtonSlider_YPos_R < 0.4489 then
		rgbSlider_R = 12
	elseif rgbButtonSlider_YPos_R > 0.4489 and rgbButtonSlider_YPos_R < 0.4484 then
		rgbSlider_R = 11
	elseif rgbButtonSlider_YPos_R > 0.4484 and rgbButtonSlider_YPos_R < 0.4489 then
		rgbSlider_R = 10
	elseif rgbButtonSlider_YPos_R > 0.4489 and rgbButtonSlider_YPos_R < 0.4494 then
		rgbSlider_R = 9
	elseif rgbButtonSlider_YPos_R > 0.4494 and rgbButtonSlider_YPos_R < 0.4499 then
		rgbSlider_R = 8
	elseif rgbButtonSlider_YPos_R > 0.4499 and rgbButtonSlider_YPos_R < 0.4504 then
		rgbSlider_R = 7
	elseif rgbButtonSlider_YPos_R > 0.4504 and rgbButtonSlider_YPos_R < 0.4509 then
		rgbSlider_R = 6
	elseif rgbButtonSlider_YPos_R > 0.4509 and rgbButtonSlider_YPos_R < 0.4514 then
		rgbSlider_R = 5
	elseif rgbButtonSlider_YPos_R > 0.4514 and rgbButtonSlider_YPos_R < 0.4519 then
		rgbSlider_R = 4
	elseif rgbButtonSlider_YPos_R > 0.4519 and rgbButtonSlider_YPos_R < 0.4524 then
		rgbSlider_R = 3
	elseif rgbButtonSlider_YPos_R > 0.4524 and rgbButtonSlider_YPos_R < 0.4529 then
		rgbSlider_R = 2
	elseif rgbButtonSlider_YPos_R > 0.4529 and rgbButtonSlider_YPos_R < 0.4534 then
		rgbSlider_R = 1
	elseif rgbButtonSlider_YPos_R > 0.4534 and rgbButtonSlider_YPos_R < 0.4539 then
		rgbSlider_R = 0
	end

	--------------------------------------------------------
	------------------rgb slider G -------------------------
	--------------------------------------------------------

	if rgbButtonSlider_YPos_G > 0.3254 and rgbButtonSlider_YPos_G < 0.3259 then
		rgbSlider_G = 254
	elseif rgbButtonSlider_YPos_G > 0.3259 and rgbButtonSlider_YPos_G < 0.3264 then
		rgbSlider_G = 253
	elseif rgbButtonSlider_YPos_G > 0.3264 and rgbButtonSlider_YPos_G < 0.3269 then
		rgbSlider_G = 252
	elseif rgbButtonSlider_YPos_G > 0.3269 and rgbButtonSlider_YPos_G < 0.3274 then
		rgbSlider_G = 251
	elseif rgbButtonSlider_YPos_G > 0.3274 and rgbButtonSlider_YPos_G < 0.3279 then
		rgbSlider_G = 250
	elseif rgbButtonSlider_YPos_G > 0.3279 and rgbButtonSlider_YPos_G < 0.3284 then
		rgbSlider_G = 249
	elseif rgbButtonSlider_YPos_G > 0.3284 and rgbButtonSlider_YPos_G < 0.3289 then
		rgbSlider_G = 248
	elseif rgbButtonSlider_YPos_G > 0.3289 and rgbButtonSlider_YPos_G < 0.3294 then
		rgbSlider_G = 247
	elseif rgbButtonSlider_YPos_G > 0.3294 and rgbButtonSlider_YPos_G < 0.3299 then
		rgbSlider_G = 246
	elseif rgbButtonSlider_YPos_G > 0.3299 and rgbButtonSlider_YPos_G < 0.3304 then
		rgbSlider_G = 245
	elseif rgbButtonSlider_YPos_G > 0.3304 and rgbButtonSlider_YPos_G < 0.3309 then
		rgbSlider_G = 244
	elseif rgbButtonSlider_YPos_G > 0.3309 and rgbButtonSlider_YPos_G < 0.3314 then
		rgbSlider_G = 243
	elseif rgbButtonSlider_YPos_G > 0.3314 and rgbButtonSlider_YPos_G < 0.3319 then
		rgbSlider_G = 242
	elseif rgbButtonSlider_YPos_G > 0.3319 and rgbButtonSlider_YPos_G < 0.3324 then
		rgbSlider_G = 241
	elseif rgbButtonSlider_YPos_G > 0.3324 and rgbButtonSlider_YPos_G < 0.3329 then
		rgbSlider_G = 240
	elseif rgbButtonSlider_YPos_G > 0.3329 and rgbButtonSlider_YPos_G < 0.3334 then
		rgbSlider_G = 239
	elseif rgbButtonSlider_YPos_G > 0.3334 and rgbButtonSlider_YPos_G < 0.3339 then
		rgbSlider_G = 238
	elseif rgbButtonSlider_YPos_G > 0.3339 and rgbButtonSlider_YPos_G < 0.3344 then
		rgbSlider_G = 237
	elseif rgbButtonSlider_YPos_G > 0.3344 and rgbButtonSlider_YPos_G < 0.3349 then
		rgbSlider_G = 236
	elseif rgbButtonSlider_YPos_G > 0.3349 and rgbButtonSlider_YPos_G < 0.3354 then
		rgbSlider_G = 235
	elseif rgbButtonSlider_YPos_G > 0.3354 and rgbButtonSlider_YPos_G < 0.3359 then
		rgbSlider_G = 234
	elseif rgbButtonSlider_YPos_G > 0.3359 and rgbButtonSlider_YPos_G < 0.3364 then
		rgbSlider_G = 233
	elseif rgbButtonSlider_YPos_G > 0.3364 and rgbButtonSlider_YPos_G < 0.3369 then
		rgbSlider_G = 232
	elseif rgbButtonSlider_YPos_G > 0.3369 and rgbButtonSlider_YPos_G < 0.3374 then
		rgbSlider_G = 231
	elseif rgbButtonSlider_YPos_G > 0.3374 and rgbButtonSlider_YPos_G < 0.3379 then
		rgbSlider_G = 230
	elseif rgbButtonSlider_YPos_G > 0.3379 and rgbButtonSlider_YPos_G < 0.3384 then
		rgbSlider_G = 229
	elseif rgbButtonSlider_YPos_G > 0.3384 and rgbButtonSlider_YPos_G < 0.3389 then
		rgbSlider_G = 228
	elseif rgbButtonSlider_YPos_G > 0.3389 and rgbButtonSlider_YPos_G < 0.3394 then
		rgbSlider_G = 227
	elseif rgbButtonSlider_YPos_G > 0.3394 and rgbButtonSlider_YPos_G < 0.3399 then
		rgbSlider_G = 226
	elseif rgbButtonSlider_YPos_G > 0.3399 and rgbButtonSlider_YPos_G < 0.3404 then
		rgbSlider_G = 225
	elseif rgbButtonSlider_YPos_G > 0.3404 and rgbButtonSlider_YPos_G < 0.3409 then
		rgbSlider_G = 224
	elseif rgbButtonSlider_YPos_G > 0.3409 and rgbButtonSlider_YPos_G < 0.3414 then
		rgbSlider_G = 223
	elseif rgbButtonSlider_YPos_G > 0.3414 and rgbButtonSlider_YPos_G < 0.3419 then
		rgbSlider_G = 222
	elseif rgbButtonSlider_YPos_G > 0.3419 and rgbButtonSlider_YPos_G < 0.3424 then
		rgbSlider_G = 221
	elseif rgbButtonSlider_YPos_G > 0.3424 and rgbButtonSlider_YPos_G < 0.3439 then
		rgbSlider_G = 220
	elseif rgbButtonSlider_YPos_G > 0.3429 and rgbButtonSlider_YPos_G < 0.3434 then
		rgbSlider_G = 219
	elseif rgbButtonSlider_YPos_G > 0.3434 and rgbButtonSlider_YPos_G < 0.3439 then
		rgbSlider_G = 218
	elseif rgbButtonSlider_YPos_G > 0.3439 and rgbButtonSlider_YPos_G < 0.3444 then
		rgbSlider_G = 217
	elseif rgbButtonSlider_YPos_G > 0.3444 and rgbButtonSlider_YPos_G < 0.3449 then
		rgbSlider_G = 216
	elseif rgbButtonSlider_YPos_G > 0.3449 and rgbButtonSlider_YPos_G < 0.3454 then
		rgbSlider_G = 215
	elseif rgbButtonSlider_YPos_G > 0.3454 and rgbButtonSlider_YPos_G < 0.3459 then
		rgbSlider_G = 214
	elseif rgbButtonSlider_YPos_G > 0.3459 and rgbButtonSlider_YPos_G < 0.3464 then
		rgbSlider_G = 213
	elseif rgbButtonSlider_YPos_G > 0.3464 and rgbButtonSlider_YPos_G < 0.3469 then
		rgbSlider_G = 212
	elseif rgbButtonSlider_YPos_G > 0.3469 and rgbButtonSlider_YPos_G < 0.3474 then
		rgbSlider_G = 211
	elseif rgbButtonSlider_YPos_G > 0.3474 and rgbButtonSlider_YPos_G < 0.3479 then
		rgbSlider_G = 210
	elseif rgbButtonSlider_YPos_G > 0.3479 and rgbButtonSlider_YPos_G < 0.3484 then
		rgbSlider_G = 209
	elseif rgbButtonSlider_YPos_G > 0.3484 and rgbButtonSlider_YPos_G < 0.3489 then
		rgbSlider_G = 208
	elseif rgbButtonSlider_YPos_G > 0.3489 and rgbButtonSlider_YPos_G < 0.3494 then
		rgbSlider_G = 207
	elseif rgbButtonSlider_YPos_G > 0.3494 and rgbButtonSlider_YPos_G < 0.3499 then
		rgbSlider_G = 206
	elseif rgbButtonSlider_YPos_G > 0.3499 and rgbButtonSlider_YPos_G < 0.3504 then
		rgbSlider_G = 205
	elseif rgbButtonSlider_YPos_G > 0.3504 and rgbButtonSlider_YPos_G < 0.3509 then
		rgbSlider_G = 204
	elseif rgbButtonSlider_YPos_G > 0.3509 and rgbButtonSlider_YPos_G < 0.3514 then
		rgbSlider_G = 203
	elseif rgbButtonSlider_YPos_G > 0.3514 and rgbButtonSlider_YPos_G < 0.3519 then
		rgbSlider_G = 202
	elseif rgbButtonSlider_YPos_G > 0.3519 and rgbButtonSlider_YPos_G < 0.3524 then
		rgbSlider_G = 201
	elseif rgbButtonSlider_YPos_G > 0.3524 and rgbButtonSlider_YPos_G < 0.3529 then
		rgbSlider_G = 200
	elseif rgbButtonSlider_YPos_G > 0.3529 and rgbButtonSlider_YPos_G < 0.3534 then
		rgbSlider_G = 199
	elseif rgbButtonSlider_YPos_G > 0.3534 and rgbButtonSlider_YPos_G < 0.3539 then
		rgbSlider_G = 198
	elseif rgbButtonSlider_YPos_G > 0.3539 and rgbButtonSlider_YPos_G < 0.3544 then
		rgbSlider_G = 197
	elseif rgbButtonSlider_YPos_G > 0.3544 and rgbButtonSlider_YPos_G < 0.3549 then
		rgbSlider_G = 196
	elseif rgbButtonSlider_YPos_G > 0.3549 and rgbButtonSlider_YPos_G < 0.3554 then
		rgbSlider_G = 195
	elseif rgbButtonSlider_YPos_G > 0.3554 and rgbButtonSlider_YPos_G < 0.3559 then
		rgbSlider_G = 194
	elseif rgbButtonSlider_YPos_G > 0.3559 and rgbButtonSlider_YPos_G < 0.3564 then
		rgbSlider_G = 193
	elseif rgbButtonSlider_YPos_G > 0.3564 and rgbButtonSlider_YPos_G < 0.3569 then
		rgbSlider_G = 192
	elseif rgbButtonSlider_YPos_G > 0.3569 and rgbButtonSlider_YPos_G < 0.3574 then
		rgbSlider_G = 191
	elseif rgbButtonSlider_YPos_G > 0.3574 and rgbButtonSlider_YPos_G < 0.3579 then
		rgbSlider_G = 190
	elseif rgbButtonSlider_YPos_G > 0.3579 and rgbButtonSlider_YPos_G < 0.3584 then
		rgbSlider_G = 189
	elseif rgbButtonSlider_YPos_G > 0.3584 and rgbButtonSlider_YPos_G < 0.3589 then
		rgbSlider_G = 188
	elseif rgbButtonSlider_YPos_G > 0.3589 and rgbButtonSlider_YPos_G < 0.3594 then
		rgbSlider_G = 187
	elseif rgbButtonSlider_YPos_G > 0.3594 and rgbButtonSlider_YPos_G < 0.3599 then
		rgbSlider_G = 186
	elseif rgbButtonSlider_YPos_G > 0.3599 and rgbButtonSlider_YPos_G < 0.3604 then
		rgbSlider_G = 185
	elseif rgbButtonSlider_YPos_G > 0.3604 and rgbButtonSlider_YPos_G < 0.3609 then
		rgbSlider_G = 184
	elseif rgbButtonSlider_YPos_G > 0.3609 and rgbButtonSlider_YPos_G < 0.3614 then
		rgbSlider_G = 183
	elseif rgbButtonSlider_YPos_G > 0.3614 and rgbButtonSlider_YPos_G < 0.3319 then
		rgbSlider_G = 182
	elseif rgbButtonSlider_YPos_G > 0.3619 and rgbButtonSlider_YPos_G < 0.3624 then
		rgbSlider_G = 181
	elseif rgbButtonSlider_YPos_G > 0.3624 and rgbButtonSlider_YPos_G < 0.3629 then
		rgbSlider_G = 180
	elseif rgbButtonSlider_YPos_G > 0.3629 and rgbButtonSlider_YPos_G < 0.3634 then
		rgbSlider_G = 179
	elseif rgbButtonSlider_YPos_G > 0.3634 and rgbButtonSlider_YPos_G < 0.3639 then
		rgbSlider_G = 178
	elseif rgbButtonSlider_YPos_G > 0.3639 and rgbButtonSlider_YPos_G < 0.3644 then
		rgbSlider_G = 177
	elseif rgbButtonSlider_YPos_G > 0.3644 and rgbButtonSlider_YPos_G < 0.3649 then
		rgbSlider_G = 176
	elseif rgbButtonSlider_YPos_G > 0.3649 and rgbButtonSlider_YPos_G < 0.3654 then
		rgbSlider_G = 175
	elseif rgbButtonSlider_YPos_G > 0.3654 and rgbButtonSlider_YPos_G < 0.3659 then
		rgbSlider_G = 174
	elseif rgbButtonSlider_YPos_G > 0.3659 and rgbButtonSlider_YPos_G < 0.3664 then
		rgbSlider_G = 173
	elseif rgbButtonSlider_YPos_G > 0.3664 and rgbButtonSlider_YPos_G < 0.3369 then
		rgbSlider_G = 172
	elseif rgbButtonSlider_YPos_G > 0.3669 and rgbButtonSlider_YPos_G < 0.3674 then
		rgbSlider_G = 171
	elseif rgbButtonSlider_YPos_G > 0.3674 and rgbButtonSlider_YPos_G < 0.3679 then
		rgbSlider_G = 170
	elseif rgbButtonSlider_YPos_G > 0.3679 and rgbButtonSlider_YPos_G < 0.3684 then
		rgbSlider_G = 169
	elseif rgbButtonSlider_YPos_G > 0.3684 and rgbButtonSlider_YPos_G < 0.3689 then
		rgbSlider_G = 168
	elseif rgbButtonSlider_YPos_G > 0.3689 and rgbButtonSlider_YPos_G < 0.3694 then
		rgbSlider_G = 167
	elseif rgbButtonSlider_YPos_G > 0.3694 and rgbButtonSlider_YPos_G < 0.3699 then
		rgbSlider_G = 166
	elseif rgbButtonSlider_YPos_G > 0.3699 and rgbButtonSlider_YPos_G < 0.3704 then
		rgbSlider_G = 165
	elseif rgbButtonSlider_YPos_G > 0.3704 and rgbButtonSlider_YPos_G < 0.3709 then
		rgbSlider_G = 164
	elseif rgbButtonSlider_YPos_G > 0.3709 and rgbButtonSlider_YPos_G < 0.3714 then
		rgbSlider_G = 163
	elseif rgbButtonSlider_YPos_G > 0.3714 and rgbButtonSlider_YPos_G < 0.3719 then
		rgbSlider_G = 162
	elseif rgbButtonSlider_YPos_G > 0.3719 and rgbButtonSlider_YPos_G < 0.3724 then
		rgbSlider_G = 161
	elseif rgbButtonSlider_YPos_G > 0.3734 and rgbButtonSlider_YPos_G < 0.3739 then
		rgbSlider_G = 160
	elseif rgbButtonSlider_YPos_G > 0.3739 and rgbButtonSlider_YPos_G < 0.3744 then
		rgbSlider_G = 159
	elseif rgbButtonSlider_YPos_G > 0.3744 and rgbButtonSlider_YPos_G < 0.3749 then
		rgbSlider_G = 158
	elseif rgbButtonSlider_YPos_G > 0.3749 and rgbButtonSlider_YPos_G < 0.3754 then
		rgbSlider_G = 157
	elseif rgbButtonSlider_YPos_G > 0.3754 and rgbButtonSlider_YPos_G < 0.3759 then
		rgbSlider_G = 156
	elseif rgbButtonSlider_YPos_G > 0.3759 and rgbButtonSlider_YPos_G < 0.3764 then
		rgbSlider_G = 155
	elseif rgbButtonSlider_YPos_G > 0.3764 and rgbButtonSlider_YPos_G < 0.3769 then
		rgbSlider_G = 154
	elseif rgbButtonSlider_YPos_G > 0.3769 and rgbButtonSlider_YPos_G < 0.3774 then
		rgbSlider_G = 153
	elseif rgbButtonSlider_YPos_G > 0.3774 and rgbButtonSlider_YPos_G < 0.3779 then
		rgbSlider_G = 152
	elseif rgbButtonSlider_YPos_G > 0.3779 and rgbButtonSlider_YPos_G < 0.3784 then
		rgbSlider_G = 151
	elseif rgbButtonSlider_YPos_G > 0.3784 and rgbButtonSlider_YPos_G < 0.3789 then
		rgbSlider_G = 150
	elseif rgbButtonSlider_YPos_G > 0.3789 and rgbButtonSlider_YPos_G < 0.3794 then
		rgbSlider_G = 149
	elseif rgbButtonSlider_YPos_G > 0.3794 and rgbButtonSlider_YPos_G < 0.3799 then
		rgbSlider_G = 148
	elseif rgbButtonSlider_YPos_G > 0.3799 and rgbButtonSlider_YPos_G < 0.3804 then
		rgbSlider_G = 147
	elseif rgbButtonSlider_YPos_G > 0.3804 and rgbButtonSlider_YPos_G < 0.3809 then
		rgbSlider_G = 146
	elseif rgbButtonSlider_YPos_G > 0.3809 and rgbButtonSlider_YPos_G < 0.3814 then
		rgbSlider_G = 145
	elseif rgbButtonSlider_YPos_G > 0.3814 and rgbButtonSlider_YPos_G < 0.3819 then
		rgbSlider_G = 144
	elseif rgbButtonSlider_YPos_G > 0.3819 and rgbButtonSlider_YPos_G < 0.3824 then
		rgbSlider_G = 143
	elseif rgbButtonSlider_YPos_G > 0.3824 and rgbButtonSlider_YPos_G < 0.3829 then
		rgbSlider_G = 142
	elseif rgbButtonSlider_YPos_G > 0.3829 and rgbButtonSlider_YPos_G < 0.3834 then
		rgbSlider_G = 141
	elseif rgbButtonSlider_YPos_G > 0.3834 and rgbButtonSlider_YPos_G < 0.3839 then
		rgbSlider_G = 140
	elseif rgbButtonSlider_YPos_G > 0.3839 and rgbButtonSlider_YPos_G < 0.3844 then
		rgbSlider_G = 139
	elseif rgbButtonSlider_YPos_G > 0.3844 and rgbButtonSlider_YPos_G < 0.3849 then
		rgbSlider_G = 138
	elseif rgbButtonSlider_YPos_G > 0.3849 and rgbButtonSlider_YPos_G < 0.3854 then
		rgbSlider_G = 137
	elseif rgbButtonSlider_YPos_G > 0.3854 and rgbButtonSlider_YPos_G < 0.3859 then
		rgbSlider_G = 136
	elseif rgbButtonSlider_YPos_G > 0.3859 and rgbButtonSlider_YPos_G < 0.3864 then
		rgbSlider_G = 135
	elseif rgbButtonSlider_YPos_G > 0.3864 and rgbButtonSlider_YPos_G < 0.3869 then
		rgbSlider_G = 134
	elseif rgbButtonSlider_YPos_G > 0.3869 and rgbButtonSlider_YPos_G < 0.3874 then
		rgbSlider_G = 133
	elseif rgbButtonSlider_YPos_G > 0.3874 and rgbButtonSlider_YPos_G < 0.3879 then
		rgbSlider_G = 132
	elseif rgbButtonSlider_YPos_G > 0.3879 and rgbButtonSlider_YPos_G < 0.3884 then
		rgbSlider_G = 131
	elseif rgbButtonSlider_YPos_G > 0.3884 and rgbButtonSlider_YPos_G < 0.3889 then
		rgbSlider_G = 130
	elseif rgbButtonSlider_YPos_G > 0.3889 and rgbButtonSlider_YPos_G < 0.3894 then
		rgbSlider_G = 129
	elseif rgbButtonSlider_YPos_G > 0.3894 and rgbButtonSlider_YPos_G < 0.3899 then
		rgbSlider_G = 128
	elseif rgbButtonSlider_YPos_G > 0.3899 and rgbButtonSlider_YPos_G < 0.3904 then
		rgbSlider_G = 127
	elseif rgbButtonSlider_YPos_G > 0.3904 and rgbButtonSlider_YPos_G < 0.3909 then
		rgbSlider_G = 126
	elseif rgbButtonSlider_YPos_G > 0.3909 and rgbButtonSlider_YPos_G < 0.3914 then
		rgbSlider_G = 125
	elseif rgbButtonSlider_YPos_G > 0.3914 and rgbButtonSlider_YPos_G < 0.3919 then
		rgbSlider_G = 124
	elseif rgbButtonSlider_YPos_G > 0.3919 and rgbButtonSlider_YPos_G < 0.3924 then
		rgbSlider_G = 123
	elseif rgbButtonSlider_YPos_G > 0.3924 and rgbButtonSlider_YPos_G < 0.3929 then
		rgbSlider_G = 122
	elseif rgbButtonSlider_YPos_G > 0.3929 and rgbButtonSlider_YPos_G < 0.3934 then
		rgbSlider_G = 121
	elseif rgbButtonSlider_YPos_G > 0.3934 and rgbButtonSlider_YPos_G < 0.3939 then
		rgbSlider_G = 120
	elseif rgbButtonSlider_YPos_G > 0.3939 and rgbButtonSlider_YPos_G < 0.3944 then
		rgbSlider_G = 119
	elseif rgbButtonSlider_YPos_G > 0.3944 and rgbButtonSlider_YPos_G < 0.3949 then
		rgbSlider_G = 118
	elseif rgbButtonSlider_YPos_G > 0.3949 and rgbButtonSlider_YPos_G < 0.3954 then
		rgbSlider_G = 117
	elseif rgbButtonSlider_YPos_G > 0.3954 and rgbButtonSlider_YPos_G < 0.3969 then
		rgbSlider_G = 116
	elseif rgbButtonSlider_YPos_G > 0.3969 and rgbButtonSlider_YPos_G < 0.3974 then
		rgbSlider_G = 115
	elseif rgbButtonSlider_YPos_G > 0.3974 and rgbButtonSlider_YPos_G < 0.3979 then
		rgbSlider_G = 114
	elseif rgbButtonSlider_YPos_G > 0.3979 and rgbButtonSlider_YPos_G < 0.3984 then
		rgbSlider_G = 113
	elseif rgbButtonSlider_YPos_G > 0.3984 and rgbButtonSlider_YPos_G < 0.3989 then
		rgbSlider_G = 112
	elseif rgbButtonSlider_YPos_G > 0.3989 and rgbButtonSlider_YPos_G < 0.3994 then
		rgbSlider_G = 111
	elseif rgbButtonSlider_YPos_G > 0.3994 and rgbButtonSlider_YPos_G < 0.3999 then
		rgbSlider_G = 110
	elseif rgbButtonSlider_YPos_G > 0.3999 and rgbButtonSlider_YPos_G < 0.4004 then
		rgbSlider_G = 109
	elseif rgbButtonSlider_YPos_G > 0.4004 and rgbButtonSlider_YPos_G < 0.4009 then
		rgbSlider_G = 108
	elseif rgbButtonSlider_YPos_G > 0.4009 and rgbButtonSlider_YPos_G < 0.4014 then
		rgbSlider_G = 107
	elseif rgbButtonSlider_YPos_G > 0.4014 and rgbButtonSlider_YPos_G < 0.4019 then
		rgbSlider_G = 106
	elseif rgbButtonSlider_YPos_G > 0.4019 and rgbButtonSlider_YPos_G < 0.4024 then
		rgbSlider_G = 105
	elseif rgbButtonSlider_YPos_G > 0.4024 and rgbButtonSlider_YPos_G < 0.4029 then
		rgbSlider_G = 104
	elseif rgbButtonSlider_YPos_G > 0.4029 and rgbButtonSlider_YPos_G < 0.4034 then
		rgbSlider_G = 103
	elseif rgbButtonSlider_YPos_G > 0.4034 and rgbButtonSlider_YPos_G < 0.4039 then
		rgbSlider_G = 102
	elseif rgbButtonSlider_YPos_G > 0.4039 and rgbButtonSlider_YPos_G < 0.4044 then
		rgbSlider_G = 101
	elseif rgbButtonSlider_YPos_G > 0.4044 and rgbButtonSlider_YPos_G < 0.4049 then
		rgbSlider_G = 100
	elseif rgbButtonSlider_YPos_G > 0.4049 and rgbButtonSlider_YPos_G < 0.4054 then
		rgbSlider_G = 99
	elseif rgbButtonSlider_YPos_G > 0.4054 and rgbButtonSlider_YPos_G < 0.4059 then
		rgbSlider_G = 98
	elseif rgbButtonSlider_YPos_G > 0.4059 and rgbButtonSlider_YPos_G < 0.4064 then
		rgbSlider_G = 97
	elseif rgbButtonSlider_YPos_G > 0.4064 and rgbButtonSlider_YPos_G < 0.4069 then
		rgbSlider_G = 96
	elseif rgbButtonSlider_YPos_G > 0.4069 and rgbButtonSlider_YPos_G < 0.4074 then
		rgbSlider_G = 95
	elseif rgbButtonSlider_YPos_G > 0.4074 and rgbButtonSlider_YPos_G < 0.4079 then
		rgbSlider_G = 94
	elseif rgbButtonSlider_YPos_G > 0.4079 and rgbButtonSlider_YPos_G < 0.4084 then
		rgbSlider_G = 93
	elseif rgbButtonSlider_YPos_G > 0.4084 and rgbButtonSlider_YPos_G < 0.4089 then
		rgbSlider_G = 92
	elseif rgbButtonSlider_YPos_G > 0.4089 and rgbButtonSlider_YPos_G < 0.4094 then
		rgbSlider_G = 91
	elseif rgbButtonSlider_YPos_G > 0.4094 and rgbButtonSlider_YPos_G < 0.4099 then
		rgbSlider_G = 90
	elseif rgbButtonSlider_YPos_G > 0.4099 and rgbButtonSlider_YPos_G < 0.4104 then
		rgbSlider_G = 89
	elseif rgbButtonSlider_YPos_G > 0.4104 and rgbButtonSlider_YPos_G < 0.4109 then
		rgbSlider_G = 88
	elseif rgbButtonSlider_YPos_G > 0.4109 and rgbButtonSlider_YPos_G < 0.4114 then
		rgbSlider_G = 87
	elseif rgbButtonSlider_YPos_G > 0.4114 and rgbButtonSlider_YPos_G < 0.4119 then
		rgbSlider_G = 86
	elseif rgbButtonSlider_YPos_G > 0.4119 and rgbButtonSlider_YPos_G < 0.4124 then
		rgbSlider_G = 85
	elseif rgbButtonSlider_YPos_G > 0.4124 and rgbButtonSlider_YPos_G < 0.4129 then
		rgbSlider_G = 84
	elseif rgbButtonSlider_YPos_G > 0.4129 and rgbButtonSlider_YPos_G < 0.4134 then
		rgbSlider_G = 83
	elseif rgbButtonSlider_YPos_G > 0.4134 and rgbButtonSlider_YPos_G < 0.4139 then
		rgbSlider_G = 82
	elseif rgbButtonSlider_YPos_G > 0.4139 and rgbButtonSlider_YPos_G < 0.4144 then
		rgbSlider_G = 81
	elseif rgbButtonSlider_YPos_G > 0.4144 and rgbButtonSlider_YPos_G < 0.4149 then
		rgbSlider_G = 80
	elseif rgbButtonSlider_YPos_G > 0.4149 and rgbButtonSlider_YPos_G < 0.4154 then
		rgbSlider_G = 79
	elseif rgbButtonSlider_YPos_G > 0.4154 and rgbButtonSlider_YPos_G < 0.4159 then
		rgbSlider_G = 78
	elseif rgbButtonSlider_YPos_G > 0.4159 and rgbButtonSlider_YPos_G < 0.4164 then
		rgbSlider_G = 77
	elseif rgbButtonSlider_YPos_G > 0.4164 and rgbButtonSlider_YPos_G < 0.4169 then
		rgbSlider_G = 76
	elseif rgbButtonSlider_YPos_G > 0.4169 and rgbButtonSlider_YPos_G < 0.4174 then
		rgbSlider_G = 75
	elseif rgbButtonSlider_YPos_G > 0.4174 and rgbButtonSlider_YPos_G < 0.4179 then
		rgbSlider_G = 74
	elseif rgbButtonSlider_YPos_G > 0.4179 and rgbButtonSlider_YPos_G < 0.4184 then
		rgbSlider_G = 73
	elseif rgbButtonSlider_YPos_G > 0.4184 and rgbButtonSlider_YPos_G < 0.4189 then
		rgbSlider_G = 72
	elseif rgbButtonSlider_YPos_G > 0.4179 and rgbButtonSlider_YPos_G < 0.4194 then
		rgbSlider_G = 71
	elseif rgbButtonSlider_YPos_G > 0.4194 and rgbButtonSlider_YPos_G < 0.4199 then
		rgbSlider_G = 70
	elseif rgbButtonSlider_YPos_G > 0.4199 and rgbButtonSlider_YPos_G < 0.4204 then
		rgbSlider_G = 69
	elseif rgbButtonSlider_YPos_G > 0.4204 and rgbButtonSlider_YPos_G < 0.4209 then
		rgbSlider_G = 68
	elseif rgbButtonSlider_YPos_G > 0.4209 and rgbButtonSlider_YPos_G < 0.4214 then
		rgbSlider_G = 67
	elseif rgbButtonSlider_YPos_G > 0.4214 and rgbButtonSlider_YPos_G < 0.4219 then
		rgbSlider_G = 66
	elseif rgbButtonSlider_YPos_G > 0.4219 and rgbButtonSlider_YPos_G < 0.4224 then
		rgbSlider_G = 65
	elseif rgbButtonSlider_YPos_G > 0.4224 and rgbButtonSlider_YPos_G < 0.4229 then
		rgbSlider_G = 64
	elseif rgbButtonSlider_YPos_G > 0.4229 and rgbButtonSlider_YPos_G < 0.4234 then
		rgbSlider_G = 63
	elseif rgbButtonSlider_YPos_G > 0.4234 and rgbButtonSlider_YPos_G < 0.4239 then
		rgbSlider_G = 62
	elseif rgbButtonSlider_YPos_G > 0.4239 and rgbButtonSlider_YPos_G < 0.4244 then
		rgbSlider_G = 61
	elseif rgbButtonSlider_YPos_G > 0.4244 and rgbButtonSlider_YPos_G < 0.4249 then
		rgbSlider_G = 60
	elseif rgbButtonSlider_YPos_G > 0.4249 and rgbButtonSlider_YPos_G < 0.4254 then
		rgbSlider_G = 59
	elseif rgbButtonSlider_YPos_G > 0.4254 and rgbButtonSlider_YPos_G < 0.4259 then
		rgbSlider_G = 58
	elseif rgbButtonSlider_YPos_G > 0.4259 and rgbButtonSlider_YPos_G < 0.4264 then
		rgbSlider_G = 57
	elseif rgbButtonSlider_YPos_G > 0.4264 and rgbButtonSlider_YPos_G < 0.4269 then
		rgbSlider_G = 56
	elseif rgbButtonSlider_YPos_G > 0.4269 and rgbButtonSlider_YPos_G < 0.4274 then
		rgbSlider_G = 55
	elseif rgbButtonSlider_YPos_G > 0.4274 and rgbButtonSlider_YPos_G < 0.4279 then
		rgbSlider_G = 54
	elseif rgbButtonSlider_YPos_G > 0.4279 and rgbButtonSlider_YPos_G < 0.4284 then
		rgbSlider_G = 53
	elseif rgbButtonSlider_YPos_G > 0.4284 and rgbButtonSlider_YPos_G < 0.4289 then
		rgbSlider_G = 52
	elseif rgbButtonSlider_YPos_G > 0.4289 and rgbButtonSlider_YPos_G < 0.4294 then
		rgbSlider_G = 51
	elseif rgbButtonSlider_YPos_G > 0.4294 and rgbButtonSlider_YPos_G < 0.4299 then
		rgbSlider_G = 50
	elseif rgbButtonSlider_YPos_G > 0.4299 and rgbButtonSlider_YPos_G < 0.4304 then
		rgbSlider_G = 49
	elseif rgbButtonSlider_YPos_G > 0.4304 and rgbButtonSlider_YPos_G < 0.4309 then
		rgbSlider_G = 48
	elseif rgbButtonSlider_YPos_G > 0.4309 and rgbButtonSlider_YPos_G < 0.4314 then
		rgbSlider_G = 47
	elseif rgbButtonSlider_YPos_G > 0.4314 and rgbButtonSlider_YPos_G < 0.4319 then
		rgbSlider_G = 46
	elseif rgbButtonSlider_YPos_G > 0.4319 and rgbButtonSlider_YPos_G < 0.4324 then
		rgbSlider_G = 45
	elseif rgbButtonSlider_YPos_G > 0.4324 and rgbButtonSlider_YPos_G < 0.4329 then
		rgbSlider_G = 44
	elseif rgbButtonSlider_YPos_G > 0.4329 and rgbButtonSlider_YPos_G < 0.4334 then
		rgbSlider_G = 43
	elseif rgbButtonSlider_YPos_G > 0.4334 and rgbButtonSlider_YPos_G < 0.4339 then
		rgbSlider_G = 42
	elseif rgbButtonSlider_YPos_G > 0.4339 and rgbButtonSlider_YPos_G < 0.4344 then
		rgbSlider_G = 41
	elseif rgbButtonSlider_YPos_G > 0.4344 and rgbButtonSlider_YPos_G < 0.4349 then
		rgbSlider_G = 40
	elseif rgbButtonSlider_YPos_G > 0.4349 and rgbButtonSlider_YPos_G < 0.4354 then
		rgbSlider_G = 39
	elseif rgbButtonSlider_YPos_G > 0.4354 and rgbButtonSlider_YPos_G < 0.4359 then
		rgbSlider_G = 38
	elseif rgbButtonSlider_YPos_G > 0.4359 and rgbButtonSlider_YPos_G < 0.4364 then
		rgbSlider_G = 37
	elseif rgbButtonSlider_YPos_G > 0.4364 and rgbButtonSlider_YPos_G < 0.4369 then
		rgbSlider_G = 36
	elseif rgbButtonSlider_YPos_G > 0.4369 and rgbButtonSlider_YPos_G < 0.4374 then
		rgbSlider_G = 35
	elseif rgbButtonSlider_YPos_G > 0.4374 and rgbButtonSlider_YPos_G < 0.4379 then
		rgbSlider_G = 34
	elseif rgbButtonSlider_YPos_G > 0.4379 and rgbButtonSlider_YPos_G < 0.4374 then
		rgbSlider_G = 33
	elseif rgbButtonSlider_YPos_G > 0.4384 and rgbButtonSlider_YPos_G < 0.4389 then
		rgbSlider_G = 32
	elseif rgbButtonSlider_YPos_G > 0.4389 and rgbButtonSlider_YPos_G < 0.4394 then
		rgbSlider_G = 31
	elseif rgbButtonSlider_YPos_G > 0.4394 and rgbButtonSlider_YPos_G < 0.4399 then
		rgbSlider_G = 30
	elseif rgbButtonSlider_YPos_G > 0.4399 and rgbButtonSlider_YPos_G < 0.4404 then
		rgbSlider_G = 29
	elseif rgbButtonSlider_YPos_G > 0.4404 and rgbButtonSlider_YPos_G < 0.4409 then
		rgbSlider_G = 28
	elseif rgbButtonSlider_YPos_G > 0.4409 and rgbButtonSlider_YPos_G < 0.4414 then
		rgbSlider_G = 27
	elseif rgbButtonSlider_YPos_G > 0.4414 and rgbButtonSlider_YPos_G < 0.4419 then
		rgbSlider_G = 26
	elseif rgbButtonSlider_YPos_G > 0.4419 and rgbButtonSlider_YPos_G < 0.4424 then
		rgbSlider_G = 25
	elseif rgbButtonSlider_YPos_G > 0.4424 and rgbButtonSlider_YPos_G < 0.4429 then
		rgbSlider_G = 24
	elseif rgbButtonSlider_YPos_G > 0.4429 and rgbButtonSlider_YPos_G < 0.4434 then
		rgbSlider_G = 23
	elseif rgbButtonSlider_YPos_G > 0.4434 and rgbButtonSlider_YPos_G < 0.4439 then
		rgbSlider_G = 22
	elseif rgbButtonSlider_YPos_G > 0.4439 and rgbButtonSlider_YPos_G < 0.4444 then
		rgbSlider_G = 21
	elseif rgbButtonSlider_YPos_G > 0.4444 and rgbButtonSlider_YPos_G < 0.4449 then
		rgbSlider_G = 20
	elseif rgbButtonSlider_YPos_G > 0.4449 and rgbButtonSlider_YPos_G < 0.4454 then
		rgbSlider_G = 19
	elseif rgbButtonSlider_YPos_G > 0.4454 and rgbButtonSlider_YPos_G < 0.4459 then
		rgbSlider_G = 18
	elseif rgbButtonSlider_YPos_G > 0.4459 and rgbButtonSlider_YPos_G < 0.4464 then
		rgbSlider_G = 17
	elseif rgbButtonSlider_YPos_G > 0.4464 and rgbButtonSlider_YPos_G < 0.4469 then
		rgbSlider_G = 16
	elseif rgbButtonSlider_YPos_G > 0.4469 and rgbButtonSlider_YPos_G < 0.4474 then
		rgbSlider_G = 15
	elseif rgbButtonSlider_YPos_G > 0.4474 and rgbButtonSlider_YPos_G < 0.4479 then
		rgbSlider_G = 14
	elseif rgbButtonSlider_YPos_G > 0.4479 and rgbButtonSlider_YPos_G < 0.4484 then
		rgbSlider_G = 13
	elseif rgbButtonSlider_YPos_G > 0.4484 and rgbButtonSlider_YPos_G < 0.4489 then
		rgbSlider_G = 12
	elseif rgbButtonSlider_YPos_G > 0.4489 and rgbButtonSlider_YPos_G < 0.4484 then
		rgbSlider_G = 11
	elseif rgbButtonSlider_YPos_G > 0.4484 and rgbButtonSlider_YPos_G < 0.4489 then
		rgbSlider_G = 10
	elseif rgbButtonSlider_YPos_G > 0.4489 and rgbButtonSlider_YPos_G < 0.4494 then
		rgbSlider_G = 9
	elseif rgbButtonSlider_YPos_G > 0.4494 and rgbButtonSlider_YPos_G < 0.4499 then
		rgbSlider_G = 8
	elseif rgbButtonSlider_YPos_G > 0.4499 and rgbButtonSlider_YPos_G < 0.4504 then
		rgbSlider_G = 7
	elseif rgbButtonSlider_YPos_G > 0.4504 and rgbButtonSlider_YPos_G < 0.4509 then
		rgbSlider_G = 6
	elseif rgbButtonSlider_YPos_G > 0.4509 and rgbButtonSlider_YPos_G < 0.4514 then
		rgbSlider_G = 5
	elseif rgbButtonSlider_YPos_G > 0.4514 and rgbButtonSlider_YPos_G < 0.4519 then
		rgbSlider_G = 4
	elseif rgbButtonSlider_YPos_G > 0.4519 and rgbButtonSlider_YPos_G < 0.4524 then
		rgbSlider_G = 3
	elseif rgbButtonSlider_YPos_G > 0.4524 and rgbButtonSlider_YPos_G < 0.4529 then
		rgbSlider_G = 2
	elseif rgbButtonSlider_YPos_G > 0.4529 and rgbButtonSlider_YPos_G < 0.4534 then
		rgbSlider_G = 1
	elseif rgbButtonSlider_YPos_G > 0.4534 and rgbButtonSlider_YPos_G < 0.4539 then
		rgbSlider_G = 0
	end

	--------------------------------------------------------
	------------------rgb slider B -------------------------
	--------------------------------------------------------

	if rgbButtonSlider_YPos_B > 0.3254 and rgbButtonSlider_YPos_B < 0.3259 then
		rgbSlider_B = 254
	elseif rgbButtonSlider_YPos_B > 0.3259 and rgbButtonSlider_YPos_B < 0.3264 then
		rgbSlider_B = 253
	elseif rgbButtonSlider_YPos_B > 0.3264 and rgbButtonSlider_YPos_B < 0.3269 then
		rgbSlider_B = 252
	elseif rgbButtonSlider_YPos_B > 0.3269 and rgbButtonSlider_YPos_B < 0.3274 then
		rgbSlider_B = 251
	elseif rgbButtonSlider_YPos_B > 0.3274 and rgbButtonSlider_YPos_B < 0.3279 then
		rgbSlider_B = 250
	elseif rgbButtonSlider_YPos_B > 0.3279 and rgbButtonSlider_YPos_B < 0.3284 then
		rgbSlider_B = 249
	elseif rgbButtonSlider_YPos_B > 0.3284 and rgbButtonSlider_YPos_B < 0.3289 then
		rgbSlider_B = 248
	elseif rgbButtonSlider_YPos_B > 0.3289 and rgbButtonSlider_YPos_B < 0.3294 then
		rgbSlider_B = 247
	elseif rgbButtonSlider_YPos_B > 0.3294 and rgbButtonSlider_YPos_B < 0.3299 then
		rgbSlider_B = 246
	elseif rgbButtonSlider_YPos_B > 0.3299 and rgbButtonSlider_YPos_B < 0.3304 then
		rgbSlider_B = 245
	elseif rgbButtonSlider_YPos_B > 0.3304 and rgbButtonSlider_YPos_B < 0.3309 then
		rgbSlider_B = 244
	elseif rgbButtonSlider_YPos_B > 0.3309 and rgbButtonSlider_YPos_B < 0.3314 then
		rgbSlider_B = 243
	elseif rgbButtonSlider_YPos_B > 0.3314 and rgbButtonSlider_YPos_B < 0.3319 then
		rgbSlider_B = 242
	elseif rgbButtonSlider_YPos_B > 0.3319 and rgbButtonSlider_YPos_B < 0.3324 then
		rgbSlider_B = 241
	elseif rgbButtonSlider_YPos_B > 0.3324 and rgbButtonSlider_YPos_B < 0.3329 then
		rgbSlider_B = 240
	elseif rgbButtonSlider_YPos_B > 0.3329 and rgbButtonSlider_YPos_B < 0.3334 then
		rgbSlider_B = 239
	elseif rgbButtonSlider_YPos_B > 0.3334 and rgbButtonSlider_YPos_B < 0.3339 then
		rgbSlider_B = 238
	elseif rgbButtonSlider_YPos_B > 0.3339 and rgbButtonSlider_YPos_B < 0.3344 then
		rgbSlider_B = 237
	elseif rgbButtonSlider_YPos_B > 0.3344 and rgbButtonSlider_YPos_B < 0.3349 then
		rgbSlider_B = 236
	elseif rgbButtonSlider_YPos_B > 0.3349 and rgbButtonSlider_YPos_B < 0.3354 then
		rgbSlider_B = 235
	elseif rgbButtonSlider_YPos_B > 0.3354 and rgbButtonSlider_YPos_B < 0.3359 then
		rgbSlider_B = 234
	elseif rgbButtonSlider_YPos_B > 0.3359 and rgbButtonSlider_YPos_B < 0.3364 then
		rgbSlider_B = 233
	elseif rgbButtonSlider_YPos_B > 0.3364 and rgbButtonSlider_YPos_B < 0.3369 then
		rgbSlider_B = 232
	elseif rgbButtonSlider_YPos_B > 0.3369 and rgbButtonSlider_YPos_B < 0.3374 then
		rgbSlider_B = 231
	elseif rgbButtonSlider_YPos_B > 0.3374 and rgbButtonSlider_YPos_B < 0.3379 then
		rgbSlider_B = 230
	elseif rgbButtonSlider_YPos_B > 0.3379 and rgbButtonSlider_YPos_B < 0.3384 then
		rgbSlider_B = 229
	elseif rgbButtonSlider_YPos_B > 0.3384 and rgbButtonSlider_YPos_B < 0.3389 then
		rgbSlider_B = 228
	elseif rgbButtonSlider_YPos_B > 0.3389 and rgbButtonSlider_YPos_B < 0.3394 then
		rgbSlider_B = 227
	elseif rgbButtonSlider_YPos_B > 0.3394 and rgbButtonSlider_YPos_B < 0.3399 then
		rgbSlider_B = 226
	elseif rgbButtonSlider_YPos_B > 0.3399 and rgbButtonSlider_YPos_B < 0.3404 then
		rgbSlider_B = 225
	elseif rgbButtonSlider_YPos_B > 0.3404 and rgbButtonSlider_YPos_B < 0.3409 then
		rgbSlider_B = 224
	elseif rgbButtonSlider_YPos_B > 0.3409 and rgbButtonSlider_YPos_B < 0.3414 then
		rgbSlider_B = 223
	elseif rgbButtonSlider_YPos_B > 0.3414 and rgbButtonSlider_YPos_B < 0.3419 then
		rgbSlider_B = 222
	elseif rgbButtonSlider_YPos_B > 0.3419 and rgbButtonSlider_YPos_B < 0.3424 then
		rgbSlider_B = 221
	elseif rgbButtonSlider_YPos_B > 0.3424 and rgbButtonSlider_YPos_B < 0.3439 then
		rgbSlider_B = 220
	elseif rgbButtonSlider_YPos_B > 0.3429 and rgbButtonSlider_YPos_B < 0.3434 then
		rgbSlider_B = 219
	elseif rgbButtonSlider_YPos_B > 0.3434 and rgbButtonSlider_YPos_B < 0.3439 then
		rgbSlider_B = 218
	elseif rgbButtonSlider_YPos_B > 0.3439 and rgbButtonSlider_YPos_B < 0.3444 then
		rgbSlider_B = 217
	elseif rgbButtonSlider_YPos_B > 0.3444 and rgbButtonSlider_YPos_B < 0.3449 then
		rgbSlider_B = 216
	elseif rgbButtonSlider_YPos_B > 0.3449 and rgbButtonSlider_YPos_B < 0.3454 then
		rgbSlider_B = 215
	elseif rgbButtonSlider_YPos_B > 0.3454 and rgbButtonSlider_YPos_B < 0.3459 then
		rgbSlider_B = 214
	elseif rgbButtonSlider_YPos_B > 0.3459 and rgbButtonSlider_YPos_B < 0.3464 then
		rgbSlider_B = 213
	elseif rgbButtonSlider_YPos_B > 0.3464 and rgbButtonSlider_YPos_B < 0.3469 then
		rgbSlider_B = 212
	elseif rgbButtonSlider_YPos_B > 0.3469 and rgbButtonSlider_YPos_B < 0.3474 then
		rgbSlider_B = 211
	elseif rgbButtonSlider_YPos_B > 0.3474 and rgbButtonSlider_YPos_B < 0.3479 then
		rgbSlider_B = 210
	elseif rgbButtonSlider_YPos_B > 0.3479 and rgbButtonSlider_YPos_B < 0.3484 then
		rgbSlider_B = 209
	elseif rgbButtonSlider_YPos_B > 0.3484 and rgbButtonSlider_YPos_B < 0.3489 then
		rgbSlider_B = 208
	elseif rgbButtonSlider_YPos_B > 0.3489 and rgbButtonSlider_YPos_B < 0.3494 then
		rgbSlider_B = 207
	elseif rgbButtonSlider_YPos_B > 0.3494 and rgbButtonSlider_YPos_B < 0.3499 then
		rgbSlider_B = 206
	elseif rgbButtonSlider_YPos_B > 0.3499 and rgbButtonSlider_YPos_B < 0.3504 then
		rgbSlider_B = 205
	elseif rgbButtonSlider_YPos_B > 0.3504 and rgbButtonSlider_YPos_B < 0.3509 then
		rgbSlider_B = 204
	elseif rgbButtonSlider_YPos_B > 0.3509 and rgbButtonSlider_YPos_B < 0.3514 then
		rgbSlider_B = 203
	elseif rgbButtonSlider_YPos_B > 0.3514 and rgbButtonSlider_YPos_B < 0.3519 then
		rgbSlider_B = 202
	elseif rgbButtonSlider_YPos_B > 0.3519 and rgbButtonSlider_YPos_B < 0.3524 then
		rgbSlider_B = 201
	elseif rgbButtonSlider_YPos_B > 0.3524 and rgbButtonSlider_YPos_B < 0.3529 then
		rgbSlider_B = 200
	elseif rgbButtonSlider_YPos_B > 0.3529 and rgbButtonSlider_YPos_B < 0.3534 then
		rgbSlider_B = 199
	elseif rgbButtonSlider_YPos_B > 0.3534 and rgbButtonSlider_YPos_B < 0.3539 then
		rgbSlider_B = 198
	elseif rgbButtonSlider_YPos_B > 0.3539 and rgbButtonSlider_YPos_B < 0.3544 then
		rgbSlider_B = 197
	elseif rgbButtonSlider_YPos_B > 0.3544 and rgbButtonSlider_YPos_B < 0.3549 then
		rgbSlider_B = 196
	elseif rgbButtonSlider_YPos_B > 0.3549 and rgbButtonSlider_YPos_B < 0.3554 then
		rgbSlider_B = 195
	elseif rgbButtonSlider_YPos_B > 0.3554 and rgbButtonSlider_YPos_B < 0.3559 then
		rgbSlider_B = 194
	elseif rgbButtonSlider_YPos_B > 0.3559 and rgbButtonSlider_YPos_B < 0.3564 then
		rgbSlider_B = 193
	elseif rgbButtonSlider_YPos_B > 0.3564 and rgbButtonSlider_YPos_B < 0.3569 then
		rgbSlider_B = 192
	elseif rgbButtonSlider_YPos_B > 0.3569 and rgbButtonSlider_YPos_B < 0.3574 then
		rgbSlider_B = 191
	elseif rgbButtonSlider_YPos_B > 0.3574 and rgbButtonSlider_YPos_B < 0.3579 then
		rgbSlider_B = 190
	elseif rgbButtonSlider_YPos_B > 0.3579 and rgbButtonSlider_YPos_B < 0.3584 then
		rgbSlider_B = 189
	elseif rgbButtonSlider_YPos_B > 0.3584 and rgbButtonSlider_YPos_B < 0.3589 then
		rgbSlider_B = 188
	elseif rgbButtonSlider_YPos_B > 0.3589 and rgbButtonSlider_YPos_B < 0.3594 then
		rgbSlider_B = 187
	elseif rgbButtonSlider_YPos_B > 0.3594 and rgbButtonSlider_YPos_B < 0.3599 then
		rgbSlider_B = 186
	elseif rgbButtonSlider_YPos_B > 0.3599 and rgbButtonSlider_YPos_B < 0.3604 then
		rgbSlider_B = 185
	elseif rgbButtonSlider_YPos_B > 0.3604 and rgbButtonSlider_YPos_B < 0.3609 then
		rgbSlider_B = 184
	elseif rgbButtonSlider_YPos_B > 0.3609 and rgbButtonSlider_YPos_B < 0.3614 then
		rgbSlider_B = 183
	elseif rgbButtonSlider_YPos_B > 0.3614 and rgbButtonSlider_YPos_B < 0.3319 then
		rgbSlider_B = 182
	elseif rgbButtonSlider_YPos_B > 0.3619 and rgbButtonSlider_YPos_B < 0.3624 then
		rgbSlider_B = 181
	elseif rgbButtonSlider_YPos_B > 0.3624 and rgbButtonSlider_YPos_B < 0.3629 then
		rgbSlider_B = 180
	elseif rgbButtonSlider_YPos_B > 0.3629 and rgbButtonSlider_YPos_B < 0.3634 then
		rgbSlider_B = 179
	elseif rgbButtonSlider_YPos_B > 0.3634 and rgbButtonSlider_YPos_B < 0.3639 then
		rgbSlider_B = 178
	elseif rgbButtonSlider_YPos_B > 0.3639 and rgbButtonSlider_YPos_B < 0.3644 then
		rgbSlider_B = 177
	elseif rgbButtonSlider_YPos_B > 0.3644 and rgbButtonSlider_YPos_B < 0.3649 then
		rgbSlider_B = 176
	elseif rgbButtonSlider_YPos_B > 0.3649 and rgbButtonSlider_YPos_B < 0.3654 then
		rgbSlider_B = 175
	elseif rgbButtonSlider_YPos_B > 0.3654 and rgbButtonSlider_YPos_B < 0.3659 then
		rgbSlider_B = 174
	elseif rgbButtonSlider_YPos_B > 0.3659 and rgbButtonSlider_YPos_B < 0.3664 then
		rgbSlider_B = 173
	elseif rgbButtonSlider_YPos_B > 0.3664 and rgbButtonSlider_YPos_B < 0.3369 then
		rgbSlider_B = 172
	elseif rgbButtonSlider_YPos_B > 0.3669 and rgbButtonSlider_YPos_B < 0.3674 then
		rgbSlider_B = 171
	elseif rgbButtonSlider_YPos_B > 0.3674 and rgbButtonSlider_YPos_B < 0.3679 then
		rgbSlider_B = 170
	elseif rgbButtonSlider_YPos_B > 0.3679 and rgbButtonSlider_YPos_B < 0.3684 then
		rgbSlider_B = 169
	elseif rgbButtonSlider_YPos_B > 0.3684 and rgbButtonSlider_YPos_B < 0.3689 then
		rgbSlider_B = 168
	elseif rgbButtonSlider_YPos_B > 0.3689 and rgbButtonSlider_YPos_B < 0.3694 then
		rgbSlider_B = 167
	elseif rgbButtonSlider_YPos_B > 0.3694 and rgbButtonSlider_YPos_B < 0.3699 then
		rgbSlider_B = 166
	elseif rgbButtonSlider_YPos_B > 0.3699 and rgbButtonSlider_YPos_B < 0.3704 then
		rgbSlider_B = 165
	elseif rgbButtonSlider_YPos_B > 0.3704 and rgbButtonSlider_YPos_B < 0.3709 then
		rgbSlider_B = 164
	elseif rgbButtonSlider_YPos_B > 0.3709 and rgbButtonSlider_YPos_B < 0.3714 then
		rgbSlider_B = 163
	elseif rgbButtonSlider_YPos_B > 0.3714 and rgbButtonSlider_YPos_B < 0.3719 then
		rgbSlider_B = 162
	elseif rgbButtonSlider_YPos_B > 0.3719 and rgbButtonSlider_YPos_B < 0.3724 then
		rgbSlider_B = 161
	elseif rgbButtonSlider_YPos_B > 0.3734 and rgbButtonSlider_YPos_B < 0.3739 then
		rgbSlider_B = 160
	elseif rgbButtonSlider_YPos_B > 0.3739 and rgbButtonSlider_YPos_B < 0.3744 then
		rgbSlider_B = 159
	elseif rgbButtonSlider_YPos_B > 0.3744 and rgbButtonSlider_YPos_B < 0.3749 then
		rgbSlider_B = 158
	elseif rgbButtonSlider_YPos_B > 0.3749 and rgbButtonSlider_YPos_B < 0.3754 then
		rgbSlider_B = 157
	elseif rgbButtonSlider_YPos_B > 0.3754 and rgbButtonSlider_YPos_B < 0.3759 then
		rgbSlider_B = 156
	elseif rgbButtonSlider_YPos_B > 0.3759 and rgbButtonSlider_YPos_B < 0.3764 then
		rgbSlider_B = 155
	elseif rgbButtonSlider_YPos_B > 0.3764 and rgbButtonSlider_YPos_B < 0.3769 then
		rgbSlider_B = 154
	elseif rgbButtonSlider_YPos_B > 0.3769 and rgbButtonSlider_YPos_B < 0.3774 then
		rgbSlider_B = 153
	elseif rgbButtonSlider_YPos_B > 0.3774 and rgbButtonSlider_YPos_B < 0.3779 then
		rgbSlider_B = 152
	elseif rgbButtonSlider_YPos_B > 0.3779 and rgbButtonSlider_YPos_B < 0.3784 then
		rgbSlider_B = 151
	elseif rgbButtonSlider_YPos_B > 0.3784 and rgbButtonSlider_YPos_B < 0.3789 then
		rgbSlider_B = 150
	elseif rgbButtonSlider_YPos_B > 0.3789 and rgbButtonSlider_YPos_B < 0.3794 then
		rgbSlider_B = 149
	elseif rgbButtonSlider_YPos_B > 0.3794 and rgbButtonSlider_YPos_B < 0.3799 then
		rgbSlider_B = 148
	elseif rgbButtonSlider_YPos_B > 0.3799 and rgbButtonSlider_YPos_B < 0.3804 then
		rgbSlider_B = 147
	elseif rgbButtonSlider_YPos_B > 0.3804 and rgbButtonSlider_YPos_B < 0.3809 then
		rgbSlider_B = 146
	elseif rgbButtonSlider_YPos_B > 0.3809 and rgbButtonSlider_YPos_B < 0.3814 then
		rgbSlider_B = 145
	elseif rgbButtonSlider_YPos_B > 0.3814 and rgbButtonSlider_YPos_B < 0.3819 then
		rgbSlider_B = 144
	elseif rgbButtonSlider_YPos_B > 0.3819 and rgbButtonSlider_YPos_B < 0.3824 then
		rgbSlider_B = 143
	elseif rgbButtonSlider_YPos_B > 0.3824 and rgbButtonSlider_YPos_B < 0.3829 then
		rgbSlider_B = 142
	elseif rgbButtonSlider_YPos_B > 0.3829 and rgbButtonSlider_YPos_B < 0.3834 then
		rgbSlider_B = 141
	elseif rgbButtonSlider_YPos_B > 0.3834 and rgbButtonSlider_YPos_B < 0.3839 then
		rgbSlider_B = 140
	elseif rgbButtonSlider_YPos_B > 0.3839 and rgbButtonSlider_YPos_B < 0.3844 then
		rgbSlider_B = 139
	elseif rgbButtonSlider_YPos_B > 0.3844 and rgbButtonSlider_YPos_B < 0.3849 then
		rgbSlider_B = 138
	elseif rgbButtonSlider_YPos_B > 0.3849 and rgbButtonSlider_YPos_B < 0.3854 then
		rgbSlider_B = 137
	elseif rgbButtonSlider_YPos_B > 0.3854 and rgbButtonSlider_YPos_B < 0.3859 then
		rgbSlider_B = 136
	elseif rgbButtonSlider_YPos_B > 0.3859 and rgbButtonSlider_YPos_B < 0.3864 then
		rgbSlider_B = 135
	elseif rgbButtonSlider_YPos_B > 0.3864 and rgbButtonSlider_YPos_B < 0.3869 then
		rgbSlider_B = 134
	elseif rgbButtonSlider_YPos_B > 0.3869 and rgbButtonSlider_YPos_B < 0.3874 then
		rgbSlider_B = 133
	elseif rgbButtonSlider_YPos_B > 0.3874 and rgbButtonSlider_YPos_B < 0.3879 then
		rgbSlider_B = 132
	elseif rgbButtonSlider_YPos_B > 0.3879 and rgbButtonSlider_YPos_B < 0.3884 then
		rgbSlider_B = 131
	elseif rgbButtonSlider_YPos_B > 0.3884 and rgbButtonSlider_YPos_B < 0.3889 then
		rgbSlider_B = 130
	elseif rgbButtonSlider_YPos_B > 0.3889 and rgbButtonSlider_YPos_B < 0.3894 then
		rgbSlider_B = 129
	elseif rgbButtonSlider_YPos_B > 0.3894 and rgbButtonSlider_YPos_B < 0.3899 then
		rgbSlider_B = 128
	elseif rgbButtonSlider_YPos_B > 0.3899 and rgbButtonSlider_YPos_B < 0.3904 then
		rgbSlider_B = 127
	elseif rgbButtonSlider_YPos_B > 0.3904 and rgbButtonSlider_YPos_B < 0.3909 then
		rgbSlider_B = 126
	elseif rgbButtonSlider_YPos_B > 0.3909 and rgbButtonSlider_YPos_B < 0.3914 then
		rgbSlider_B = 125
	elseif rgbButtonSlider_YPos_B > 0.3914 and rgbButtonSlider_YPos_B < 0.3919 then
		rgbSlider_B = 124
	elseif rgbButtonSlider_YPos_B > 0.3919 and rgbButtonSlider_YPos_B < 0.3924 then
		rgbSlider_B = 123
	elseif rgbButtonSlider_YPos_B > 0.3924 and rgbButtonSlider_YPos_B < 0.3929 then
		rgbSlider_B = 122
	elseif rgbButtonSlider_YPos_B > 0.3929 and rgbButtonSlider_YPos_B < 0.3934 then
		rgbSlider_B = 121
	elseif rgbButtonSlider_YPos_B > 0.3934 and rgbButtonSlider_YPos_B < 0.3939 then
		rgbSlider_B = 120
	elseif rgbButtonSlider_YPos_B > 0.3939 and rgbButtonSlider_YPos_B < 0.3944 then
		rgbSlider_B = 119
	elseif rgbButtonSlider_YPos_B > 0.3944 and rgbButtonSlider_YPos_B < 0.3949 then
		rgbSlider_B = 118
	elseif rgbButtonSlider_YPos_B > 0.3949 and rgbButtonSlider_YPos_B < 0.3954 then
		rgbSlider_B = 117
	elseif rgbButtonSlider_YPos_B > 0.3954 and rgbButtonSlider_YPos_B < 0.3969 then
		rgbSlider_B = 116
	elseif rgbButtonSlider_YPos_B > 0.3969 and rgbButtonSlider_YPos_B < 0.3974 then
		rgbSlider_B = 115
	elseif rgbButtonSlider_YPos_B > 0.3974 and rgbButtonSlider_YPos_B < 0.3979 then
		rgbSlider_B = 114
	elseif rgbButtonSlider_YPos_B > 0.3979 and rgbButtonSlider_YPos_B < 0.3984 then
		rgbSlider_B = 113
	elseif rgbButtonSlider_YPos_B > 0.3984 and rgbButtonSlider_YPos_B < 0.3989 then
		rgbSlider_B = 112
	elseif rgbButtonSlider_YPos_B > 0.3989 and rgbButtonSlider_YPos_B < 0.3994 then
		rgbSlider_B = 111
	elseif rgbButtonSlider_YPos_B > 0.3994 and rgbButtonSlider_YPos_B < 0.3999 then
		rgbSlider_B = 110
	elseif rgbButtonSlider_YPos_B > 0.3999 and rgbButtonSlider_YPos_B < 0.4004 then
		rgbSlider_B = 109
	elseif rgbButtonSlider_YPos_B > 0.4004 and rgbButtonSlider_YPos_B < 0.4009 then
		rgbSlider_B = 108
	elseif rgbButtonSlider_YPos_B > 0.4009 and rgbButtonSlider_YPos_B < 0.4014 then
		rgbSlider_B = 107
	elseif rgbButtonSlider_YPos_B > 0.4014 and rgbButtonSlider_YPos_B < 0.4019 then
		rgbSlider_B = 106
	elseif rgbButtonSlider_YPos_B > 0.4019 and rgbButtonSlider_YPos_B < 0.4024 then
		rgbSlider_B = 105
	elseif rgbButtonSlider_YPos_B > 0.4024 and rgbButtonSlider_YPos_B < 0.4029 then
		rgbSlider_B = 104
	elseif rgbButtonSlider_YPos_B > 0.4029 and rgbButtonSlider_YPos_B < 0.4034 then
		rgbSlider_B = 103
	elseif rgbButtonSlider_YPos_B > 0.4034 and rgbButtonSlider_YPos_B < 0.4039 then
		rgbSlider_B = 102
	elseif rgbButtonSlider_YPos_B > 0.4039 and rgbButtonSlider_YPos_B < 0.4044 then
		rgbSlider_B = 101
	elseif rgbButtonSlider_YPos_B > 0.4044 and rgbButtonSlider_YPos_B < 0.4049 then
		rgbSlider_B = 100
	elseif rgbButtonSlider_YPos_B > 0.4049 and rgbButtonSlider_YPos_B < 0.4054 then
		rgbSlider_B = 99
	elseif rgbButtonSlider_YPos_B > 0.4054 and rgbButtonSlider_YPos_B < 0.4059 then
		rgbSlider_B = 98
	elseif rgbButtonSlider_YPos_B > 0.4059 and rgbButtonSlider_YPos_B < 0.4064 then
		rgbSlider_B = 97
	elseif rgbButtonSlider_YPos_B > 0.4064 and rgbButtonSlider_YPos_B < 0.4069 then
		rgbSlider_B = 96
	elseif rgbButtonSlider_YPos_B > 0.4069 and rgbButtonSlider_YPos_B < 0.4074 then
		rgbSlider_B = 95
	elseif rgbButtonSlider_YPos_B > 0.4074 and rgbButtonSlider_YPos_B < 0.4079 then
		rgbSlider_B = 94
	elseif rgbButtonSlider_YPos_B > 0.4079 and rgbButtonSlider_YPos_B < 0.4084 then
		rgbSlider_B = 93
	elseif rgbButtonSlider_YPos_B > 0.4084 and rgbButtonSlider_YPos_B < 0.4089 then
		rgbSlider_B = 92
	elseif rgbButtonSlider_YPos_B > 0.4089 and rgbButtonSlider_YPos_B < 0.4094 then
		rgbSlider_B = 91
	elseif rgbButtonSlider_YPos_B > 0.4094 and rgbButtonSlider_YPos_B < 0.4099 then
		rgbSlider_B = 90
	elseif rgbButtonSlider_YPos_B > 0.4099 and rgbButtonSlider_YPos_B < 0.4104 then
		rgbSlider_B = 89
	elseif rgbButtonSlider_YPos_B > 0.4104 and rgbButtonSlider_YPos_B < 0.4109 then
		rgbSlider_B = 88
	elseif rgbButtonSlider_YPos_B > 0.4109 and rgbButtonSlider_YPos_B < 0.4114 then
		rgbSlider_B = 87
	elseif rgbButtonSlider_YPos_B > 0.4114 and rgbButtonSlider_YPos_B < 0.4119 then
		rgbSlider_B = 86
	elseif rgbButtonSlider_YPos_B > 0.4119 and rgbButtonSlider_YPos_B < 0.4124 then
		rgbSlider_B = 85
	elseif rgbButtonSlider_YPos_B > 0.4124 and rgbButtonSlider_YPos_B < 0.4129 then
		rgbSlider_B = 84
	elseif rgbButtonSlider_YPos_B > 0.4129 and rgbButtonSlider_YPos_B < 0.4134 then
		rgbSlider_B = 83
	elseif rgbButtonSlider_YPos_B > 0.4134 and rgbButtonSlider_YPos_B < 0.4139 then
		rgbSlider_B = 82
	elseif rgbButtonSlider_YPos_B > 0.4139 and rgbButtonSlider_YPos_B < 0.4144 then
		rgbSlider_B = 81
	elseif rgbButtonSlider_YPos_B > 0.4144 and rgbButtonSlider_YPos_B < 0.4149 then
		rgbSlider_B = 80
	elseif rgbButtonSlider_YPos_B > 0.4149 and rgbButtonSlider_YPos_B < 0.4154 then
		rgbSlider_B = 79
	elseif rgbButtonSlider_YPos_B > 0.4154 and rgbButtonSlider_YPos_B < 0.4159 then
		rgbSlider_B = 78
	elseif rgbButtonSlider_YPos_B > 0.4159 and rgbButtonSlider_YPos_B < 0.4164 then
		rgbSlider_B = 77
	elseif rgbButtonSlider_YPos_B > 0.4164 and rgbButtonSlider_YPos_B < 0.4169 then
		rgbSlider_B = 76
	elseif rgbButtonSlider_YPos_B > 0.4169 and rgbButtonSlider_YPos_B < 0.4174 then
		rgbSlider_B = 75
	elseif rgbButtonSlider_YPos_B > 0.4174 and rgbButtonSlider_YPos_B < 0.4179 then
		rgbSlider_B = 74
	elseif rgbButtonSlider_YPos_B > 0.4179 and rgbButtonSlider_YPos_B < 0.4184 then
		rgbSlider_B = 73
	elseif rgbButtonSlider_YPos_B > 0.4184 and rgbButtonSlider_YPos_B < 0.4189 then
		rgbSlider_B = 72
	elseif rgbButtonSlider_YPos_B > 0.4179 and rgbButtonSlider_YPos_B < 0.4194 then
		rgbSlider_B = 71
	elseif rgbButtonSlider_YPos_B > 0.4194 and rgbButtonSlider_YPos_B < 0.4199 then
		rgbSlider_B = 70
	elseif rgbButtonSlider_YPos_B > 0.4199 and rgbButtonSlider_YPos_B < 0.4204 then
		rgbSlider_B = 69
	elseif rgbButtonSlider_YPos_B > 0.4204 and rgbButtonSlider_YPos_B < 0.4209 then
		rgbSlider_B = 68
	elseif rgbButtonSlider_YPos_B > 0.4209 and rgbButtonSlider_YPos_B < 0.4214 then
		rgbSlider_B = 67
	elseif rgbButtonSlider_YPos_B > 0.4214 and rgbButtonSlider_YPos_B < 0.4219 then
		rgbSlider_B = 66
	elseif rgbButtonSlider_YPos_B > 0.4219 and rgbButtonSlider_YPos_B < 0.4224 then
		rgbSlider_B = 65
	elseif rgbButtonSlider_YPos_B > 0.4224 and rgbButtonSlider_YPos_B < 0.4229 then
		rgbSlider_B = 64
	elseif rgbButtonSlider_YPos_B > 0.4229 and rgbButtonSlider_YPos_B < 0.4234 then
		rgbSlider_B = 63
	elseif rgbButtonSlider_YPos_B > 0.4234 and rgbButtonSlider_YPos_B < 0.4239 then
		rgbSlider_B = 62
	elseif rgbButtonSlider_YPos_B > 0.4239 and rgbButtonSlider_YPos_B < 0.4244 then
		rgbSlider_B = 61
	elseif rgbButtonSlider_YPos_B > 0.4244 and rgbButtonSlider_YPos_B < 0.4249 then
		rgbSlider_B = 60
	elseif rgbButtonSlider_YPos_B > 0.4249 and rgbButtonSlider_YPos_B < 0.4254 then
		rgbSlider_B = 59
	elseif rgbButtonSlider_YPos_B > 0.4254 and rgbButtonSlider_YPos_B < 0.4259 then
		rgbSlider_B = 58
	elseif rgbButtonSlider_YPos_B > 0.4259 and rgbButtonSlider_YPos_B < 0.4264 then
		rgbSlider_B = 57
	elseif rgbButtonSlider_YPos_B > 0.4264 and rgbButtonSlider_YPos_B < 0.4269 then
		rgbSlider_B = 56
	elseif rgbButtonSlider_YPos_B > 0.4269 and rgbButtonSlider_YPos_B < 0.4274 then
		rgbSlider_B = 55
	elseif rgbButtonSlider_YPos_B > 0.4274 and rgbButtonSlider_YPos_B < 0.4279 then
		rgbSlider_B = 54
	elseif rgbButtonSlider_YPos_B > 0.4279 and rgbButtonSlider_YPos_B < 0.4284 then
		rgbSlider_B = 53
	elseif rgbButtonSlider_YPos_B > 0.4284 and rgbButtonSlider_YPos_B < 0.4289 then
		rgbSlider_B = 52
	elseif rgbButtonSlider_YPos_B > 0.4289 and rgbButtonSlider_YPos_B < 0.4294 then
		rgbSlider_B = 51
	elseif rgbButtonSlider_YPos_B > 0.4294 and rgbButtonSlider_YPos_B < 0.4299 then
		rgbSlider_B = 50
	elseif rgbButtonSlider_YPos_B > 0.4299 and rgbButtonSlider_YPos_B < 0.4304 then
		rgbSlider_B = 49
	elseif rgbButtonSlider_YPos_B > 0.4304 and rgbButtonSlider_YPos_B < 0.4309 then
		rgbSlider_B = 48
	elseif rgbButtonSlider_YPos_B > 0.4309 and rgbButtonSlider_YPos_B < 0.4314 then
		rgbSlider_B = 47
	elseif rgbButtonSlider_YPos_B > 0.4314 and rgbButtonSlider_YPos_B < 0.4319 then
		rgbSlider_B = 46
	elseif rgbButtonSlider_YPos_B > 0.4319 and rgbButtonSlider_YPos_B < 0.4324 then
		rgbSlider_B = 45
	elseif rgbButtonSlider_YPos_B > 0.4324 and rgbButtonSlider_YPos_B < 0.4329 then
		rgbSlider_B = 44
	elseif rgbButtonSlider_YPos_B > 0.4329 and rgbButtonSlider_YPos_B < 0.4334 then
		rgbSlider_B = 43
	elseif rgbButtonSlider_YPos_B > 0.4334 and rgbButtonSlider_YPos_B < 0.4339 then
		rgbSlider_B = 42
	elseif rgbButtonSlider_YPos_B > 0.4339 and rgbButtonSlider_YPos_B < 0.4344 then
		rgbSlider_B = 41
	elseif rgbButtonSlider_YPos_B > 0.4344 and rgbButtonSlider_YPos_B < 0.4349 then
		rgbSlider_B = 40
	elseif rgbButtonSlider_YPos_B > 0.4349 and rgbButtonSlider_YPos_B < 0.4354 then
		rgbSlider_B = 39
	elseif rgbButtonSlider_YPos_B > 0.4354 and rgbButtonSlider_YPos_B < 0.4359 then
		rgbSlider_B = 38
	elseif rgbButtonSlider_YPos_B > 0.4359 and rgbButtonSlider_YPos_B < 0.4364 then
		rgbSlider_B = 37
	elseif rgbButtonSlider_YPos_B > 0.4364 and rgbButtonSlider_YPos_B < 0.4369 then
		rgbSlider_B = 36
	elseif rgbButtonSlider_YPos_B > 0.4369 and rgbButtonSlider_YPos_B < 0.4374 then
		rgbSlider_B = 35
	elseif rgbButtonSlider_YPos_B > 0.4374 and rgbButtonSlider_YPos_B < 0.4379 then
		rgbSlider_B = 34
	elseif rgbButtonSlider_YPos_B > 0.4379 and rgbButtonSlider_YPos_B < 0.4374 then
		rgbSlider_B = 33
	elseif rgbButtonSlider_YPos_B > 0.4384 and rgbButtonSlider_YPos_B < 0.4389 then
		rgbSlider_B = 32
	elseif rgbButtonSlider_YPos_B > 0.4389 and rgbButtonSlider_YPos_B < 0.4394 then
		rgbSlider_B = 31
	elseif rgbButtonSlider_YPos_B > 0.4394 and rgbButtonSlider_YPos_B < 0.4399 then
		rgbSlider_B = 30
	elseif rgbButtonSlider_YPos_B > 0.4399 and rgbButtonSlider_YPos_B < 0.4404 then
		rgbSlider_B = 29
	elseif rgbButtonSlider_YPos_B > 0.4404 and rgbButtonSlider_YPos_B < 0.4409 then
		rgbSlider_B = 28
	elseif rgbButtonSlider_YPos_B > 0.4409 and rgbButtonSlider_YPos_B < 0.4414 then
		rgbSlider_B = 27
	elseif rgbButtonSlider_YPos_B > 0.4414 and rgbButtonSlider_YPos_B < 0.4419 then
		rgbSlider_B = 26
	elseif rgbButtonSlider_YPos_B > 0.4419 and rgbButtonSlider_YPos_B < 0.4424 then
		rgbSlider_B = 25
	elseif rgbButtonSlider_YPos_B > 0.4424 and rgbButtonSlider_YPos_B < 0.4429 then
		rgbSlider_B = 24
	elseif rgbButtonSlider_YPos_B > 0.4429 and rgbButtonSlider_YPos_B < 0.4434 then
		rgbSlider_B = 23
	elseif rgbButtonSlider_YPos_B > 0.4434 and rgbButtonSlider_YPos_B < 0.4439 then
		rgbSlider_B = 22
	elseif rgbButtonSlider_YPos_B > 0.4439 and rgbButtonSlider_YPos_B < 0.4444 then
		rgbSlider_B = 21
	elseif rgbButtonSlider_YPos_B > 0.4444 and rgbButtonSlider_YPos_B < 0.4449 then
		rgbSlider_B = 20
	elseif rgbButtonSlider_YPos_B > 0.4449 and rgbButtonSlider_YPos_B < 0.4454 then
		rgbSlider_B = 19
	elseif rgbButtonSlider_YPos_B > 0.4454 and rgbButtonSlider_YPos_B < 0.4459 then
		rgbSlider_B = 18
	elseif rgbButtonSlider_YPos_B > 0.4459 and rgbButtonSlider_YPos_B < 0.4464 then
		rgbSlider_B = 17
	elseif rgbButtonSlider_YPos_B > 0.4464 and rgbButtonSlider_YPos_B < 0.4469 then
		rgbSlider_B = 16
	elseif rgbButtonSlider_YPos_B > 0.4469 and rgbButtonSlider_YPos_B < 0.4474 then
		rgbSlider_B = 15
	elseif rgbButtonSlider_YPos_B > 0.4474 and rgbButtonSlider_YPos_B < 0.4479 then
		rgbSlider_B = 14
	elseif rgbButtonSlider_YPos_B > 0.4479 and rgbButtonSlider_YPos_B < 0.4484 then
		rgbSlider_B = 13
	elseif rgbButtonSlider_YPos_B > 0.4484 and rgbButtonSlider_YPos_B < 0.4489 then
		rgbSlider_B = 12
	elseif rgbButtonSlider_YPos_B > 0.4489 and rgbButtonSlider_YPos_B < 0.4484 then
		rgbSlider_B = 11
	elseif rgbButtonSlider_YPos_B > 0.4484 and rgbButtonSlider_YPos_B < 0.4489 then
		rgbSlider_B = 10
	elseif rgbButtonSlider_YPos_B > 0.4489 and rgbButtonSlider_YPos_B < 0.4494 then
		rgbSlider_B = 9
	elseif rgbButtonSlider_YPos_B > 0.4494 and rgbButtonSlider_YPos_B < 0.4499 then
		rgbSlider_B = 8
	elseif rgbButtonSlider_YPos_B > 0.4499 and rgbButtonSlider_YPos_B < 0.4504 then
		rgbSlider_B = 7
	elseif rgbButtonSlider_YPos_B > 0.4504 and rgbButtonSlider_YPos_B < 0.4509 then
		rgbSlider_B = 6
	elseif rgbButtonSlider_YPos_B > 0.4509 and rgbButtonSlider_YPos_B < 0.4514 then
		rgbSlider_B = 5
	elseif rgbButtonSlider_YPos_B > 0.4514 and rgbButtonSlider_YPos_B < 0.4519 then
		rgbSlider_B = 4
	elseif rgbButtonSlider_YPos_B > 0.4519 and rgbButtonSlider_YPos_B < 0.4524 then
		rgbSlider_B = 3
	elseif rgbButtonSlider_YPos_B > 0.4524 and rgbButtonSlider_YPos_B < 0.4529 then
		rgbSlider_B = 2
	elseif rgbButtonSlider_YPos_B > 0.4529 and rgbButtonSlider_YPos_B < 0.4534 then
		rgbSlider_B = 1
	elseif rgbButtonSlider_YPos_B > 0.4534 and rgbButtonSlider_YPos_G < 0.4539 then
		rgbSlider_B = 0
	end

	--------------------------------------------------------
	------------------rgb sliders end ----------------------
	--------------------------------------------------------
	if IsControlJustPressed(0, 176) then
	end
end
flagAnimationrun = 0
function runFlagAnimation()
	if flagAnimationrun == 0 then
		DrawSprite("fiveM_animatedTextures", "flag0", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 1 then
		DrawSprite("fiveM_animatedTextures", "flag1", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 2 then
		DrawSprite("fiveM_animatedTextures", "flag2", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 3 then
		DrawSprite("fiveM_animatedTextures", "flag3", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 4 then
		DrawSprite("fiveM_animatedTextures", "flag4", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 5 then
		DrawSprite("fiveM_animatedTextures", "flag5", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 6 then
		DrawSprite("fiveM_animatedTextures", "flag6", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 7 then
		DrawSprite("fiveM_animatedTextures", "flag7", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 8 then
		DrawSprite("fiveM_animatedTextures", "flag8", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 9 then
		DrawSprite("fiveM_animatedTextures", "flag9", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 10 then
		DrawSprite("fiveM_animatedTextures", "flag10", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 11 then
		DrawSprite("fiveM_animatedTextures", "flag11", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 12 then
		DrawSprite("fiveM_animatedTextures", "flag12", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 2
	elseif flagAnimationrun == 13 then
		DrawSprite("fiveM_animatedTextures", "flag13", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 14 then
		DrawSprite("fiveM_animatedTextures", "flag14", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 15 then
		DrawSprite("fiveM_animatedTextures", "flag15", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 16 then
		DrawSprite("fiveM_animatedTextures", "flag16", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 17 then
		DrawSprite("fiveM_animatedTextures", "flag17", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun == 18 then
		DrawSprite("fiveM_animatedTextures", "flag18", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	elseif flagAnimationrun >= 19 then
		DrawSprite("fiveM_animatedTextures", "flag19", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		flagAnimationrun = flagAnimationrun + 1
	end
	if flagAnimationrun >= 20 then
		flagAnimationrun = 0
	end
end

lightningAnimationrun = 0

function runLightningAnimation()
	if lightningAnimationrun == 0 then
		DrawSprite("fiveM_animatedTextures", "frame_0_", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		lightningAnimationrun = lightningAnimationrun + 1
	elseif lightningAnimationrun == 1 then
		DrawSprite("fiveM_animatedTextures", "frame_1_", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		lightningAnimationrun = lightningAnimationrun + 1
	elseif lightningAnimationrun == 2 then
		DrawSprite("fiveM_animatedTextures", "frame_2_", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		lightningAnimationrun = lightningAnimationrun + 1
	elseif lightningAnimationrun == 3 then
		DrawSprite("fiveM_animatedTextures", "frame_3_", debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, 0.0, 255, 255, 255, 150)
		lightningAnimationrun = lightningAnimationrun + 1
	end
	if lightningAnimationrun > 3 then
		lightningAnimationrun = 0
	end
end
---------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------put entity name or hash here---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

--things(1098542403)
----------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------this sets delete gun toggle to off --------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
deleteGunToggle = false
----------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------this gets info about spawned entity and player----------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(
	function()
		while true do
			if IsControlJustPressed(0, 211) and IsControlPressed(0, 210) then
				showInfo = not showInfo
			end

				print(showInfo)
			Citizen.Wait(0)
			playerPed = GetPlayerPed(PlayerId())
			playerCoords = GetEntityCoords(GetPlayerPed(PlayerId()), true)
			playerCoordsX = playerCoords.x
			playerCoordsY = playerCoords.y
			playerCoordsZ = playerCoords.z
			playerHeading = GetEntityHeading(GetPlayerPed(PlayerId()))
			PlayerRoomKey = GetRoomKeyFromEntity(GetPlayerPed(PlayerId()))
			playerInteriorID = GetInteriorFromEntity(GetPlayerPed(PlayerId()))
			entityRoomKey = GetRoomKeyFromEntity(a)
			entityInteriorID = GetInteriorFromEntity(a)
			entityCoords = GetEntityCoords(closestEntity, true)
			interiorGroupID = GetInteriorGroupId(entityInteriorID)

			ForceRoomForEntity(a, playerInteriorID, PlayerRoomKey)
			EntityInterior = GetInteriorFromEntity(a)
			EntityRoomKey = GetRoomKeyFromEntity(a)
			if showInfo then
				if ((IsControlPressed(0, 62) and IsControlJustPressed(1, 168)) and not IsControlPressed(0, 21)) then
					debugWindowConfigMenu = not debugWindowConfigMenu
				end
				--SetNetworkIdExistsOnAllMachines(dude10, true)
				--NetworkRegisterEntityAsNetworked(dude10)
				--NetworkSetEntityVisibleToNetwork(dude10, true)
				requestControl = NetworkRequestControlOfNetworkId(NetworkGetNetworkIdFromEntity(dude10))

				local entityCoords = GetEntityCoords(dude10)
				local entityRot = GetEntityRotation(dude10, 2)
				local playerRot = GetEntityRotation(GetPlayerPed(), 2)
				local playerCoords = GetEntityCoords(GetPlayerPed())
				local isEntityNetworked = NetworkHasControlOfEntity(dude10)
				if requestControl == 1 then
					networkHasControl = "yes"
				elseif requestControl == false then
					networkHasControl = "no"
				end
				if isEntityNetworked == 1 then
					isNetworked = "yes"
				elseif isEntityNetworked == false then
					isNetworked = "no"
				end
				if doesEntityExist == 1 then
					networkIDExist = "yes"
				elseif doesEntityExist == false then
					networkIDExist = "no"
				end
				if IsEntityAPed(dude10) then
					if IsPedAPlayer(dude10) then
						dude11 = NetworkGetNetworkIdFromEntity(dude10)
						handle = NetworkHandleFromPlayer(dude11, 13)
					end
				end
				entityNetworkID = NetworkGetNetworkIdFromEntity(dude10)
				doesEntityExist = NetworkDoesNetworkIdExist(NetworkGetNetworkIdFromEntity(dude10))
				SetEntityAsMissionEntity(dude10, 1, 0)
				if debugWindowBackground == nil or debugWindowBackground == "plain" then
					DrawSprite(debugWindowTextureDict, debugWindowTexture, debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, debugWindowHeading, debugWindowColorR, debugWindowColorG, debugWindowColorB, debugWindowTranparency)
				elseif debugWindowBackground == "lightning" then
					runLightningAnimation()
				elseif debugWindowBackground == "flag" then
					runFlagAnimation()
				--DrawSprite(debugWindowTextureDict,debugWindowTexture, debugWindowXPos, debugWindowYPos, debugWindowSizeX, debugWindowSizeY, debugWindowHeading, 255, 255, 255, 200)
				end
				DrawSprite("fiveM_headerss", "header-295-2", debugWindowXPos, debugWindowYPos - 0.325, 0.131, 0.043, 0.0, 255, 255, 255, 255)
				drawTxt("dave's ", 6, 1, debugWindowXPos - 0.030, debugWindowYPos - 0.343, 0.5, 0, 255, 0, 255)
				drawTxt("DEBUG INFO ", 6, 1, debugWindowXPos + 0.023, debugWindowYPos - 0.343, 0.5, 255, 0, 0, 255)
				drawTxt("entity ID: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.310, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(dude10), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.310, 0.3, 0, 255, 255, 255)
				drawTxt("entity model hash: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.280, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(GetEntityModel(dude10)), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.280, 0.3, 0, 255, 255, 255)
				drawTxt("entity interior: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.250, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(GetInteriorFromEntity(dude10)), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.250, 0.3, 0, 255, 255, 255)
				drawTxt("networkID: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.220, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(NetworkGetNetworkIdFromEntity(dude10)), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.220, 0.3, 0, 255, 255, 255)
				drawTxt("is entity networked: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.190, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(isNetworked), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.190, 0.3, 0, 255, 255, 255)
				drawTxt("does network have control", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.160, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(networkHasControl), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.160, 0.3, 0, 255, 255, 255)
				drawTxt("does networkID exist", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.130, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(networkIDExist), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.130, 0.3, 0, 255, 255, 255)
				drawTxt("entity X coords: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.100, 0.3, 0, 255, 0, 255)
				drawTxt(tostring(entityCoords.x), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.100, 0.3, 0, 255, 0, 255)
				drawTxt("entity Y coords: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.070, 0.3, 0, 255, 0, 255)
				drawTxt(tostring(entityCoords.y), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.070, 0.3, 0, 255, 0, 255)
				drawTxt("entity Z coords: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.040, 0.3, 0, 255, 0, 255)
				drawTxt(tostring(entityCoords.z), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.040, 0.3, 0, 255, 0, 255)
				drawTxt("entity X rotation: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos - 0.010, 0.3, 0, 255, 0, 255)
				drawTxt(tostring(entityRot.x), 6, 1, debugWindowXPos + 0.05, debugWindowYPos - 0.010, 0.3, 0, 255, 0, 255)
				drawTxt("entity Y rotation: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.020, 0.3, 0, 255, 0, 255)
				drawTxt(tostring(entityRot.y), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.020, 0.3, 0, 255, 0, 255)
				drawTxt("entity Z rotation: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.050, 0.3, 0, 255, 0, 255)
				drawTxt(tostring(entityRot.z), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.050, 0.3, 0, 255, 0, 255)
				drawTxt("Player X rotation: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.08, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(playerRot.x), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.080, 0.3, 0, 0, 255, 255)
				drawTxt("Player Y rotation: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.110, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(playerRot.y), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.110, 0.3, 0, 0, 255, 255)
				drawTxt("Player Z rotation: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.140, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(playerRot.z), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.140, 0.3, 0, 0, 255, 255)
				drawTxt("Player X position: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.170, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(playerCoords.x), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.170, 0.3, 0, 255, 0, 255)
				drawTxt("Player Y position: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.20, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(playerCoords.y), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.20, 0.3, 0, 255, 0, 255)
				drawTxt("Player Z position: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.23, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(playerCoords.z), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.23, 0.3, 0, 255, 0, 255)
				drawTxt("Player Heading: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.26, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(playerHeading), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.26, 0.3, 0, 255, 0, 255)
				drawTxt("Player UUID: ", 6, 1, debugWindowXPos - 0.05, debugWindowYPos + 0.29, 0.3, 255, 255, 255, 255)
				drawTxt(tostring(handle), 6, 1, debugWindowXPos + 0.05, debugWindowYPos + 0.29, 0.3, 0, 255, 0, 255)
				drawTxt('please note the rotation "order" is always 2 ', 6, 1, debugWindowXPos, debugWindowYPos + 0.32, 0.3, 255, 0, 0, 150)
			end
			if debugWindowConfigMenu == true then
				--------------------------------------------------------------------------------------------------------------
				mouseX = GetControlNormal(2, 239)
				mouseY = GetControlNormal(2, 240)
				--------------------------------------------------------------------------------------------------------------
				--------------------------------------config button "move window"---------------------------------------------
				--------------------------------------------------------------------------------------------------------------
				moveWindowButtotLeftEdge = (debugWindowXPos + debugWindowSizeX / 3) - (debugWindowSizeX - debugWindowSizeX + 0.08) / 2
				moveWindowButtotRightEdge = (debugWindowXPos + debugWindowSizeX / 3) + (debugWindowSizeX - debugWindowSizeX + 0.08) / 2
				moveWindowButtotTopEdge = (debugWindowYPos + debugWindowSizeY / 2 + 0.05) - (debugWindowSizeY - 0.58) / 2
				moveWindowButtotBottonEdge = (debugWindowYPos + debugWindowSizeY / 2 + 0.05) + (debugWindowSizeY - 0.58) / 2
				--------------------------------------------------------------------------------------------------------------
				--------------------------------------config button "change color"---------------------------------------------
				--------------------------------------------------------------------------------------------------------------
				changeWindowColorButtotLeftEdge = (debugWindowXPos) - (debugWindowSizeX - debugWindowSizeX + 0.08) / 2
				changeWindowColorButtotRightEdge = (debugWindowXPos) + (debugWindowSizeX - debugWindowSizeX + 0.08) / 2
				changeWindowColorButtonTopEdge = (debugWindowYPos + debugWindowSizeY / 2 + 0.05) - (debugWindowSizeY - 0.58) / 2
				changeWindowColorButtonBottomEdge = (debugWindowYPos + debugWindowSizeY / 2 + 0.05) + (debugWindowSizeY - 0.58) / 2
				--------------------------------------------------------------------------------------------------------------
				-----------------------------------config button "change background"------------------------------------------
				--------------------------------------------------------------------------------------------------------------
				changeWindowBackgroundButtotLeftEdge = (debugWindowXPos - debugWindowSizeX / 3) - (debugWindowSizeX - debugWindowSizeX + 0.08) / 2
				changeWindowBackgroundButtotRightEdge = (debugWindowXPos - debugWindowSizeX / 3) + (debugWindowSizeX - debugWindowSizeX + 0.08) / 2
				changeWindowBackgroundButtonTopEdge = (debugWindowYPos + debugWindowSizeY / 2 + 0.05) - (debugWindowSizeY - 0.58) / 2
				changeWindowBackgroundButtonBottomEdge = (debugWindowYPos + debugWindowSizeY / 2 + 0.05) + (debugWindowSizeY - 0.58) / 2
				--------------------------------------------------------------------------------------------------------------
				------------------------------------------background button 1-------------------------------------------------
				--------------------------------------------------------------------------------------------------------------
				if debugWindowXPos > 0.5 then
					changeBackgroundButton_1_ButtotLeftEdge = ((((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) - 0.16 / 2 / 2) - ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_1_ButtotRightEdge = ((((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) - 0.16 / 2 / 2) + ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_1_ButtonTopEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - ((debugWindowSizeY - 0.58) - 0.003) / 2
					changeBackgroundButton_1_ButtonBottomEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) + ((debugWindowSizeY - 0.58) - 0.003) / 2

					changeBackgroundButton_2_ButtotLeftEdge = ((((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) + 0.16 / 2 / 2) - ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_2_ButtotRightEdge = ((((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) + 0.16 / 2 / 2) + ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_2_ButtonTopEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - ((debugWindowSizeY - 0.58) - 0.003) / 2
					changeBackgroundButton_2_ButtonBottomEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) + ((debugWindowSizeY - 0.58) - 0.003) / 2
				else
					changeBackgroundButton_1_ButtotLeftEdge = ((((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) - 0.16 / 2 / 2) - ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_1_ButtotRightEdge = ((((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) - 0.16 / 2 / 2) + ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_1_ButtonTopEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - ((debugWindowSizeY - 0.58) - 0.003) / 2
					changeBackgroundButton_1_ButtonBottomEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) + ((debugWindowSizeY - 0.58) - 0.003) / 2

					changeBackgroundButton_2_ButtotLeftEdge = ((((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) + 0.16 / 2 / 2) - ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_2_ButtotRightEdge = ((((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) + 0.16 / 2 / 2) + ((debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003) / 2
					changeBackgroundButton_2_ButtonTopEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - ((debugWindowSizeY - 0.58) - 0.003) / 2
					changeBackgroundButton_2_ButtonBottomEdge = ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) + ((debugWindowSizeY - 0.58) - 0.003) / 2
				end
				SetCurrentPedWeapon(PlayerPedId(-1), GetHashKey("weapon_unarmed"))
				--debug config window
				DrawSprite("fiveM_headerss", "header-295-2", debugWindowXPos, (debugWindowYPos + debugWindowSizeY / 2 + 0.05), debugWindowSizeX, debugWindowSizeY - 0.55, 0.0, 255, 255, 255, 255)
				--change background button
				DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos - debugWindowSizeX / 3), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.58, 0.0, 0, 0, 0, 200)
				--change color button
				DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.58, 0.0, 0, 0, 0, 200)
				--move window button
				DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos + debugWindowSizeX / 3), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), (debugWindowSizeY - 0.58), 0.0, 0, 0, 0, 200)
				drawTxt("move \n window", 6, 1, (debugWindowXPos + debugWindowSizeX / 3), (debugWindowYPos + debugWindowSizeY / 2) - 0.001, 0.3, 255, 255, 255, 255)
				drawTxt("change \n window \n color", 6, 1, (debugWindowXPos), (debugWindowYPos + debugWindowSizeY / 2), 0.3, 255, 255, 255, 255)
				drawTxt("change \n window \n background", 6, 1, (debugWindowXPos - debugWindowSizeX / 3), (debugWindowYPos + debugWindowSizeY / 2), 0.3, 255, 255, 255, 255)
				ShowCursorThisFrame()
				--move window button
				if (mouseX > moveWindowButtotLeftEdge and mouseX < moveWindowButtotRightEdge) and (mouseY >= moveWindowButtotTopEdge and mouseY <= moveWindowButtotBottonEdge) then
					DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos + debugWindowSizeX / 3), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.58, 0.0, 0, 0, 255, 255)
					moveWindow = true
					if IsControlJustPressed(2, 237) and moveWindow == true then
						moveWindowSprite = true
					end
				else
					moveWindow = false
				end
				--change color button
				if (mouseX > changeWindowColorButtotLeftEdge and mouseX < changeWindowColorButtotRightEdge) and (mouseY >= changeWindowColorButtonTopEdge and mouseY <= changeWindowColorButtonBottomEdge) then
					DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.58, 0.0, 0, 0, 255, 255)
					windowColor = true
					if IsControlJustPressed(2, 237) and windowColor == true then
						changeColor = not changeColor
					end
				else
					windowColor = not windowColor
				end

				if changeColor == true then
					rgbControl()
					DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.58, 0.0, 0, 0, 255, 255)
				end
				--change background button
				if (mouseX > changeWindowBackgroundButtotLeftEdge and mouseX < changeWindowBackgroundButtotRightEdge) and (mouseY >= changeWindowBackgroundButtonTopEdge and mouseY <= changeWindowBackgroundButtonBottomEdge) then
					DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos - debugWindowSizeX / 3), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.58, 0.0, 0, 0, 255, 255)
					windowBackground = true
					if IsControlJustPressed(2, 237) and windowBackground == true then
						changeBackground = not changeBackground
					end
				else
					windowBackground = false
				end

				if changeBackground == true then
					--button hightlight
					DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos - debugWindowSizeX / 3), (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.58, 0.0, 0, 0, 255, 255)
					if debugWindowXPos > 0.5 then
						--tiny texture 1
						DrawSprite(debugWindowTextureDict, debugWindowTexture, ((debugWindowXPos) - (debugWindowSizeX) / 2) - (debugWindowSizeX - debugWindowSizeX + 0.08) / 2, (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.68, 0.0, 0, 0, 0, 200)
						--tiny texture 2
						DrawSprite(debugWindowTextureDict, debugWindowTexture, ((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.070, (debugWindowYPos + debugWindowSizeY / 2) + 0.005, debugWindowSizeY - 0.68, debugWindowSizeY - 0.63, 0.0, 0, 0, 0, 200)
						--big texture
						DrawSprite(debugWindowTextureDict, debugWindowTexture, ((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08, debugWindowYPos, 0.16, (debugWindowSizeY - 0.06), 0.0, 0, 0, 0, 200)
						DrawSprite("fiveM_BasicTextures", "LegendaryMotoBoundingBox", ((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08, debugWindowYPos, 0.16, debugWindowSizeY - 0.06, 0.0, 255, 255, 255, 255)
						--background button 1
						DrawSprite(
							"fiveM_animatedTextures",
							"flag0",
							(((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) - 0.16 / 2 / 2,
							((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
							(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
							(debugWindowSizeY - 0.58) - 0.003,
							0.0,
							255,
							255,
							255,
							225
						)
						drawTxt("animated \n background", 6, 1, (((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) - 0.16 / 2 / 2, ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - 0.04, 0.3, 255, 255, 255, 255)
						if (mouseX > changeBackgroundButton_1_ButtotLeftEdge and mouseX < changeBackgroundButton_1_ButtotRightEdge) and (mouseY >= changeBackgroundButton_1_ButtonTopEdge and mouseY <= changeBackgroundButton_1_ButtonBottomEdge) then
							DrawSprite(
								debugWindowTextureDict,
								debugWindowTexture,
								(((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) - 0.16 / 2 / 2,
								((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
								(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
								(debugWindowSizeY - 0.58) - 0.003,
								0.0,
								0,
								0,
								255,
								120
							)
							if saveOldColors == false then
								saveOldColors = true
								old_rgbSlider_R = rgbSlider_R
								old_rgbSlider_G = rgbSlider_G
								old_rgbSlider_B = rgbSlider_B
							end
							if loadOldColors == false then
								loadOldColors = true
								rgbSlider_R = old_rgbSlider_R
								rgbSlider_G = old_rgbSlider_G
								rgbSlider_B = old_rgbSlider_B
							end
							rgbSlider_R = 0
							rgbSlider_G = 0
							rgbSlider_B = 0
							runFlagAnimation()
							windowBackground = true
							if IsControlJustPressed(2, 237) and windowBackground == true then
								changeBackground = not changeBackground
								saveOldColors = false
								debugWindowBackground = "flag"
							end
						else
							windowBackground = false
							loadOldColors = false
						end
						--background button 2
						DrawSprite(
							"fiveM_animatedTextures",
							"frame_0_",
							(((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) + 0.16 / 2 / 2,
							((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
							(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
							(debugWindowSizeY - 0.58) - 0.003,
							0.0,
							255,
							255,
							255,
							225
						)
						drawTxt("animated \n background", 6, 1, (((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) + 0.16 / 2 / 2, ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - 0.04, 0.3, 255, 255, 255, 255)
						if (mouseX > changeBackgroundButton_2_ButtotLeftEdge and mouseX < changeBackgroundButton_2_ButtotRightEdge) and (mouseY >= changeBackgroundButton_2_ButtonTopEdge and mouseY <= changeBackgroundButton_2_ButtonBottomEdge) then
							DrawSprite(
								debugWindowTextureDict,
								debugWindowTexture,
								(((debugWindowXPos) - (debugWindowSizeX) / 2) - 0.08) + 0.16 / 2 / 2,
								((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
								(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
								(debugWindowSizeY - 0.58) - 0.003,
								0.0,
								0,
								0,
								255,
								120
							)
							windowBackground = true
							if IsControlJustPressed(2, 237) and windowBackground == true then
								changeBackground = not changeBackground
								saveOldColors = false
								debugWindowBackground = "lightning"
							end
							if saveOldColors == false then
								saveOldColors = true
								old_rgbSlider_R = rgbSlider_R
								old_rgbSlider_G = rgbSlider_G
								old_rgbSlider_B = rgbSlider_B
							end
							if loadOldColors == false then
								loadOldColors = true
								rgbSlider_R = old_rgbSlider_R
								rgbSlider_G = old_rgbSlider_G
								rgbSlider_B = old_rgbSlider_B
							end
							rgbSlider_R = 0
							rgbSlider_G = 0
							rgbSlider_B = 0
							runLightningAnimation()
							windowBackground = true
						else
							windowBackground = false
							loadOldColors = false
						end
					else
						--tiny texture 1
						DrawSprite(debugWindowTextureDict, debugWindowTexture, ((debugWindowXPos) + (debugWindowSizeX) / 2) + (debugWindowSizeX - debugWindowSizeX + 0.08) / 2, (debugWindowYPos + debugWindowSizeY / 2 + 0.05), (debugWindowSizeX - debugWindowSizeX + 0.08), debugWindowSizeY - 0.68, 0.0, 0, 0, 0, 200)
						--tiny texture 2
						DrawSprite(debugWindowTextureDict, debugWindowTexture, ((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.070, (debugWindowYPos + debugWindowSizeY / 2) + 0.005, debugWindowSizeY - 0.68, debugWindowSizeY - 0.63, 0.0, 0, 0, 0, 200)
						--big texture
						DrawSprite(debugWindowTextureDict, debugWindowTexture, ((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08, debugWindowYPos, 0.16, (debugWindowSizeY - 0.06), 0.0, 0, 0, 0, 200)
						DrawSprite("fiveM_BasicTextures", "LegendaryMotoBoundingBox", ((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08, debugWindowYPos, 0.16, debugWindowSizeY - 0.06, 0.0, 255, 255, 255, 255)
						--background button 1
						DrawSprite(
							"fiveM_animatedTextures",
							"flag0",
							(((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) - 0.16 / 2 / 2,
							((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
							(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
							(debugWindowSizeY - 0.58) - 0.003,
							0.0,
							255,
							255,
							255,
							225
						)
						drawTxt("animated \n background", 6, 1, (((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) - 0.16 / 2 / 2, ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - 0.04, 0.3, 255, 255, 255, 255)
						if (mouseX > changeBackgroundButton_1_ButtotLeftEdge and mouseX < changeBackgroundButton_1_ButtotRightEdge) and (mouseY >= changeBackgroundButton_1_ButtonTopEdge and mouseY <= changeBackgroundButton_1_ButtonBottomEdge) then
							DrawSprite(
								debugWindowTextureDict,
								debugWindowTexture,
								(((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) - 0.16 / 2 / 2,
								((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
								(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
								(debugWindowSizeY - 0.58) - 0.003,
								0.0,
								0,
								0,
								255,
								120
							)
							windowBackground = true
							if IsControlJustPressed(2, 237) and windowBackground == true then
								changeBackground = not changeBackground
								debugWindowBackground = "flag"
								saveOldColors = false
							end
							if saveOldColors == false then
								saveOldColors = true
								old_rgbSlider_R = rgbSlider_R
								old_rgbSlider_G = rgbSlider_G
								old_rgbSlider_B = rgbSlider_B
							end
							if loadOldColors == false then
								loadOldColors = true
								rgbSlider_R = old_rgbSlider_R
								rgbSlider_G = old_rgbSlider_G
								rgbSlider_B = old_rgbSlider_B
							end
							rgbSlider_R = 0
							rgbSlider_G = 0
							rgbSlider_B = 0
							runFlagAnimation()
							windowBackground = true
						else
							windowBackground = false
						end

						--background button 2
						DrawSprite(
							"fiveM_animatedTextures",
							"frame_0_",
							(((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) + 0.16 / 2 / 2,
							((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
							(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
							(debugWindowSizeY - 0.58) - 0.003,
							0.0,
							255,
							255,
							255,
							225
						)
						drawTxt("animated \n background", 6, 1, (((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) + 0.16 / 2 / 2, ((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)) - 0.04, 0.3, 255, 255, 255, 255)
						if (mouseX > changeBackgroundButton_2_ButtotLeftEdge and mouseX < changeBackgroundButton_2_ButtotRightEdge) and (mouseY >= changeBackgroundButton_2_ButtonTopEdge and mouseY <= changeBackgroundButton_2_ButtonBottomEdge) then
							DrawSprite(
								debugWindowTextureDict,
								debugWindowTexture,
								(((debugWindowXPos) + (debugWindowSizeX) / 2) + 0.08) + 0.16 / 2 / 2,
								((debugWindowYPos) - ((debugWindowSizeY - 0.06) / 2) + ((debugWindowSizeY - 0.58) / 2)),
								(debugWindowSizeX - debugWindowSizeX + 0.08) - 0.003,
								(debugWindowSizeY - 0.58) - 0.003,
								0.0,
								0,
								0,
								255,
								120
							)
							windowBackground = true
							if IsControlJustPressed(2, 237) and windowBackground == true then
								changeBackground = not changeBackground
								debugWindowBackground = "lightning"
								saveOldColors = false
							end
							if saveOldColors == false then
								saveOldColors = true
								old_rgbSlider_R = rgbSlider_R
								old_rgbSlider_G = rgbSlider_G
								old_rgbSlider_B = rgbSlider_B
							end
							if loadOldColors == false then
								loadOldColors = true
								rgbSlider_R = old_rgbSlider_R
								rgbSlider_G = old_rgbSlider_G
								rgbSlider_B = old_rgbSlider_B
							end
							rgbSlider_R = 0
							rgbSlider_G = 0
							rgbSlider_B = 0
							runLightningAnimation()
							windowBackground = true
						else
							windowBackground = false
						end
					end
				end

				if moveWindowSprite == true then
					DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos), (debugWindowYPos), 0.05, 0.05, 0.0, 255, 255, 255, 150)
					if (mouseX > (debugWindowXPos - 0.05) and mouseX < (debugWindowXPos + 0.05)) and (mouseY >= (debugWindowYPos - 0.05) and mouseY <= (debugWindowYPos + 0.05)) then
						DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos), (debugWindowYPos), 0.05, 0.05, 0.0, 0, 0, 255, 150)
						if IsControlPressed(2, 237) then
							DrawSprite(debugWindowTextureDict, debugWindowTexture, (debugWindowXPos), (debugWindowYPos), 0.05, 0.05, 0.0, 0, 255, 0, 255)
							debugWindowXPos = mouseX
							debugWindowYPos = mouseY
						end

						if IsControlJustReleased(2, 237) then
							moveWindowSprite = false
						end
					end
				end

				if debugWindowBackground == "lightning" then
					lightning = true
				end
			end
			-----------------------------------------------------------------------------------------------------------------------------------------------------
			---------------------------------this checks if the spawned entity exists and moves it as player pushes buttons---------------------------------------
			-----------------------------------------------------------------------------------------------------------------------------------------------------
			if not DoesEntityExist(a) or DoesEntityExist(GetClosestObjectOfType(playerCoordsX, playerCoordsY, playerCoordsZ, 50.0, stuff, 0, 1, 0)) then
				a = GetClosestObjectOfType(playerCoordsX, playerCoordsY, playerCoordsZ, 50.0, stuff, 1, 1, 1)
			end
			if DoesEntityExist(a) then
				b = ObjToNet(a)
				--this gets the entity coords
				entityCoords = GetEntityCoords(a)
				entityCoords1 = GetEntityCoords(b)
				--this splits up the coords
				entityX = entityCoords.x
				entityY = entityCoords.y
				entityZ = entityCoords.z
				entityX1 = entityCoords1.x
				entityY1 = entityCoords1.y
				entityZ1 = entityCoords1.z
				--this gets the entity rotation
				entityRot = GetEntityRotation(a)
				entityRot1 = GetEntityRotation(b)
				--this splits up the rotation
				entityRotX = entityRot.x
				entityRotY = entityRot.y
				entityRotZ = entityRot.z
				entityRotX1 = entityRot1.x
				entityRotY1 = entityRot1.y
				entityRotZ1 = entityRot1.z
			end
			--if left shift is pressed then movement speed is slower
			if IsControlPressed(0, 21) then
				moveSpeed = 0.01
				moveSpeed1 = 0.2
			else
				moveSpeed = 0.1
				moveSpeed1 = 1.3
			end

			--this sets "a" to nil if no entity was spawned and no entity of type found near player
			if not DoesEntityExist(a) then
				a = nil
			end
			--home key
			-- if control "home" key is pressed then it spawns the entity of your choosing
			if IsControlJustPressed(0, 213) then
				Citizen.Wait(500)
				spawnStuff(stuff)
			end
			--left key
			-- if control "left" key is pressed then it adds 0.01 to the x coord
			if DoesEntityExist(a) and IsControlPressed(0, 174) then
				if frozen == false then
					entityX = entityCoords.x + moveSpeed
					--sets the entity's position with result
					SetEntityCoords(a, entityX, entityY, entityZ)
					entityX1 = entityCoords1.x + moveSpeed
					--sets the entity's position with result
					SetEntityCoords(b, entityX1, entityY1, entityZ1)
				end
			end
			--right key
			-- if control "right" key is pressed then it subtract's 0.01 from the x coord
			if DoesEntityExist(a) and IsControlPressed(0, 175) then
				if frozen == false then
					--entityCoords = GetEntityCoords(a)
					entityX = entityCoords.x - moveSpeed
					--sets the entity's position with result
					SetEntityCoords(a, entityX, entityY, entityZ)
					--entityCoords = GetEntityCoords(a)
					entityX1 = entityCoords1.x - moveSpeed
					--sets the entity's position with result
					SetEntityCoords(b, entityX1, entityY1, entityZ1)
				end
			end
			--pageup
			-- if control "pageUp" key is pressed then it adds 0.01 to the z coord
			if DoesEntityExist(a) and IsControlPressed(0, 10) then
				if frozen == false then
					entityZ = entityCoords.z + moveSpeed
					--sets the entity's position with result
					SetEntityCoords(a, entityX, entityY, entityZ)
					entityZ1 = entityCoords1.z + moveSpeed
					--sets the entity's position with result
					SetEntityCoords(b, entityX1, entityY1, entityZ1)
				end
			end
			--pagedown
			-- if control "pageDown" key is pressed then it subtract's 0.01 from the z coord
			if DoesEntityExist(a) and IsControlPressed(0, 11) then
				if frozen == false then
					entityZ = entityCoords.z - moveSpeed
					--sets the entity's position with result
					SetEntityCoords(a, entityX, entityY, entityZ)
					entityZ1 = entityCoords1.z - moveSpeed
					--sets the entity's position with result
					SetEntityCoords(b, entityX1, entityY1, entityZ1)
				end
			end
			--up key
			-- if control "up" key is pressed then it subtract's 0.01 from the y coord
			if DoesEntityExist(a) and IsControlPressed(0, 27) then
				if frozen == false then
					entityY = entityCoords.y - moveSpeed
					--sets the entity's position with result
					SetEntityCoords(a, entityX, entityY, entityZ)
					entityY1 = entityCoords1.y - moveSpeed
					--sets the entity's position with result
					SetEntityCoords(b, entityX1, entityY1, entityZ1)
				end
			end
			--down key
			-- if control "down" key is pressed then it adds 0.01 to the y coord
			if DoesEntityExist(a) and IsControlPressed(0, 173) then
				if frozen == false then
					entityY = entityCoords.y + moveSpeed
					SetEntityCoords(a, entityX, entityY, entityZ)
					entityY1 = entityCoords1.y + moveSpeed
					SetEntityCoords(b, entityX1, entityY1, entityZ1)
				end
			end

			--leftshift AND "E"
			-- if left shift AND "E" key are pressed then it deletes the entity
			--and any other entity close to the player with the same hashkey
			if IsControlPressed(0, 21) and IsControlPressed(0, 38) then
				if DoesEntityExist(a) or DoesEntityExist(closestEntity) then
					deleteStuff()
				end
			end
			--numberpad "+" key
			-- if numberpad "+" key is pressed then it adds 0.1 to the entity's heading(spins the thing)
			if DoesEntityExist(a) and IsControlPressed(0, 96) then
				if frozen == false then
					entityRotZ = entityRotZ + moveSpeed1
					--sets the entity's heading with result
					SetEntityRotation(a, entityRotX, entityRotY, entityRotZ)
					entityRotZ1 = entityRotZ1 + moveSpeed1
					--sets the entity's heading with result
					SetEntityRotation(b, entityRotX1, entityRotY1, entityRotZ1)
				end
			end
			--numberpad "-" key
			-- if numberpad "-" key is pressed then it subtract's 0.1 from the entity's heading(spins the thing)
			if DoesEntityExist(a) and IsControlPressed(0, 97) then
				if frozen == false then
					entityRotZ = entityRotZ - moveSpeed1
					--sets the entity's heading with result
					SetEntityRotation(a, entityRotX, entityRotY, entityRotZ)
					entityRotZ1 = entityRotZ1 - moveSpeed1
					--sets the entity's heading with result
					SetEntityRotation(b, entityRotX1, entityRotY1, entityRotZ1)
				end
			end
			--the "[" key
			if DoesEntityExist(a) and IsControlPressed(0, 39) then
				if frozen == false then
					--entityRot = GetEntityRotation(a)
					entityRotY = entityRotY + moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(a, entityRotX, entityRotY, entityRotZ)
					--entityRot = GetEntityRotation(a)
					entityRotY1 = entityRotY1 + moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(b, entityRotX1, entityRotY1, entityRotZ1)
				end
			end
			-- the "]" key
			if (DoesEntityExist(a) and IsControlPressed(0, 40)) then
				if frozen == false then
					--entityRot = GetEntityRotation(a)
					entityRotY = entityRotY - moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(a, entityRotX, entityRotY, entityRotZ)
					--entityRot = GetEntityRotation(a)
					entityRotY1 = entityRotY1 - moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(b, entityRotX1, entityRotY1, entityRotZ1)
				end
			end
			-- the "-" key
			if (DoesEntityExist(a) and IsControlPressed(0, 84)) then
				if frozen == false then
					--entityRot = GetEntityRotation(a)
					entityRotX = entityRotX - moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(a, entityRotX, entityRotY, entityRotZ)
					--entityRot = GetEntityRotation(a)
					entityRotX1 = entityRotX1 - moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(b, entityRotX1, entityRotY1, entityRotZ1)
				end
			end
			-- the "=" key
			if (DoesEntityExist(a) and IsControlPressed(0, 83)) then
				if frozen == false then
					--entityRot = GetEntityRotation(a)
					entityRotX = entityRotX + moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(a, entityRotX, entityRotY, entityRotZ)
					--entityRot = GetEntityRotation(a)
					entityRotX1 = entityRotX1 + moveSpeed1
					--sets the entity's rotation with result
					SetEntityRotation(b, entityRotX1, entityRotY1, entityRotZ1)
				end
			end
		end
	end
)

function deleteStuff()
	--this delete's the entity that was spawned or
	--any close by entity with the the same hash key
	if DoesEntityExist(closestEntity) and not DoesEntityExist(a) then
		closestEntity = NetworkGetNetworkIdFromEntity(closestEntity)
		SetEntityAsMissionEntity(closestEntity, true, true)
		DeleteObject(closestEntity)
	end
	if DoesEntityExist(a) then
		--a = NetworkGetNetworkIdFromEntity(a)
		SetEntityAsMissionEntity(a, true, true)
		DeleteObject(a)
	end
	if DoesEntityExist(spawnedVeh) then
		SetEntityAsMissionEntity(spawnedVeh, true, true)
		DeleteVehicle(spawnedVeh)
		DeleteEntity(spawnedVeh)
	end
	if DoesEntityExist(spawnPed) or DoesEntityExist(closestPed) then
		SetEntityAsMissionEntity(spawnPed, true, true)
		SetEntityAsMissionEntity(closestPed, true, true)
		DeletePed(spawnPed)
	end
end
-- this sets the entity's transparency
function invisibleStuff()
	SetEntityAsMissionEntity(a, true, true)
	SetEntityAlpha(a, 255)
end
function unfreezeStuff()
	FreezeEntityPosition(a, false)
	frozen = false
end
function freezeStuff()
	FreezeEntityPosition(a, true)
	frozen = true
end
function setCollisionStuff(bool)
	if bool == false then
		SetEntityCollision(a, true, true)
	end
	if bool == true then
		SetEntityCollision(a, false, false)
	end
end
stuffBool = false
----------------------------
--this is the ACTUAL spawner
function spawnStuff(stuff)
	Citizen.CreateThread(
		function()
			--this requests the model of what is to be spawned
			if DoesEntityExist(dude10) then
				dude10Model = GetEntityModel(dude10)
				if showInfo == true then
					stuff = dude10Model
				end
			end
			if not HasModelLoaded(stuff) then
				Citizen.Wait(0)
				RequestModel(stuff)
			--if model is a veh then spawn a veh
			end
			if IsEntityAVehicle(dude10) then
				spawnedVeh = CreateVehicle(stuff, playerCoordsX, playerCoordsY, playerCoordsZ, playerHeading, 1, 1, 0)
			end
			if IsEntityAPed(dude10) then
				dude10CofigFlag = GetPedConfigFlag(dude10)
				dude10DrawVar_0 = GetPedDrawableVariation(dude10, 0)
				dude10TexVar_0 = GetPedTextureVariation(dude10, 0)
				dude10PaletteVar_0 = GetPedPaletteVariation(dude10, 0)
				dude10DrawVar_1 = GetPedDrawableVariation(dude10, 1)
				dude10TexVar_1 = GetPedTextureVariation(dude10, 1)
				dude10PaletteVar_1 = GetPedPaletteVariation(dude10, 1)
				dude10DrawVar_2 = GetPedDrawableVariation(dude10, 2)
				dude10TexVar_2 = GetPedTextureVariation(dude10, 2)
				dude10PaletteVar_2 = GetPedPaletteVariation(dude10, 2)
				dude10DrawVar_3 = GetPedDrawableVariation(dude10, 3)
				dude10TexVar_3 = GetPedTextureVariation(dude10, 3)
				dude10PaletteVar_3 = GetPedPaletteVariation(dude10, 3)
				dude10DrawVar_4 = GetPedDrawableVariation(dude10, 4)
				dude10TexVar_4 = GetPedTextureVariation(dude10, 4)
				dude10PaletteVar_4 = GetPedPaletteVariation(dude10, 4)
				dude10DrawVar_5 = GetPedDrawableVariation(dude10, 5)
				dude10TexVar_5 = GetPedTextureVariation(dude10, 5)
				dude10PaletteVar_5 = GetPedPaletteVariation(dude10, 5)
				dude10DrawVar_6 = GetPedDrawableVariation(dude10, 6)
				dude10TexVar_6 = GetPedTextureVariation(dude10, 6)
				dude10PaletteVar_6 = GetPedPaletteVariation(dude10, 6)
				dude10DrawVar_7 = GetPedDrawableVariation(dude10, 7)
				dude10TexVar_7 = GetPedTextureVariation(dude10, 7)
				dude10PaletteVar_7 = GetPedPaletteVariation(dude10, 7)
				dude10DrawVar_8 = GetPedDrawableVariation(dude10, 8)
				dude10TexVar_8 = GetPedTextureVariation(dude10, 8)
				dude10PaletteVar_8 = GetPedPaletteVariation(dude10, 8)
				dude10DrawVar_9 = GetPedDrawableVariation(dude10, 9)
				dude10TexVar_9 = GetPedTextureVariation(dude10, 9)
				dude10PaletteVar_9 = GetPedPaletteVariation(dude10, 9)
				dude10DrawVar_10 = GetPedDrawableVariation(dude10, 10)
				dude10TexVar_10 = GetPedTextureVariation(dude10, 10)
				dude10PaletteVar_10 = GetPedPaletteVariation(dude10, 10)
				dude10DrawVar_11 = GetPedDrawableVariation(dude10, 11)
				dude10TexVar_11 = GetPedTextureVariation(dude10, 11)
				dude10PaletteVar_11 = GetPedPaletteVariation(dude10, 11)
				dude10PedType = GetPedType(dude10)
				spawnedPed = CreatePed(dude10PedType, stuff, playerCoordsX + 1, playerCoordsY + 1, playerCoordsZ, playerHeading, 0, 1)
				SetPedComponentVariation(spawnedPed, 0, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 1, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 2, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 3, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 4, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 5, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 6, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 7, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 8, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 9, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 10, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
				SetPedComponentVariation(spawnedPed, 11, dude10DrawVar_0, dude10TexVar_0, dude10PaletteVar_0)
			end
			--spawn the object
			if IsEntityAnObject(dude10) then
				a = ObjToNet(CreateObjectNoOffset(stuff, playerCoordsX + 1, playerCoordsY + 1, playerCoordsZ, 1, 1, 0))
				setCollisionStuff(true)
				freezeStuff()
				SetEntityHeading(a, playerHeading)
			end
		end
	)
end

------------------------------------------------------------------------------------------------------------------
----------------this is the "delete gun active" text that gets displayed if the delete gun is on------------------
------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if deleteGunToggle ~= false then
				local position = "DELETE GUN ACTIVE"
				local offset = {x = 0.290, y = 0.850}
				local rgb = {r = 255, g = 0, b = 0}
				local alpha = 255
				local scale = 1.0
				local font = 0
				SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
				SetTextFont(font)
				SetTextScale(scale, scale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString(position)
				DrawText(offset.x, offset.y)
			end
		end
	end
)

------------------------------------------------------------------------------------------------------------------
-------------------------------this is the delete gun activation controller----------------------------------------
------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Wait(2000)
			if gary ~= false and deleteGunToggle ~= false then
				deleteGunToggle = false
			end
		end
	end
)
----------------------------------------------------------------------------------------------------------------------
------------------------------------this is the "meat" of the delete gun----------------------------------------------
-------------------if the delete gun is active the it deletes what ever the player is looking at----------------------
----------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		pedDeleted = "a ped got DELETED: "
		vehDeleted = "a veh got DELETED: "
		objDeleted = "an obj get DELETED: "
		while true do
			Wait(1000)
			gary = IsControlJustPressed(0, 178) and IsControlPressed(0, 210)
			if gary ~= false and deleteGunToggle ~= true then
				deleteGunToggle = true
				Wait(0)
			end
			Wait(0)
			dude5 = PlayerId()
			dude6 = IsPlayerFreeAiming(dude5)
			if dude6 ~= false then
				dude10 = Citizen.InvokeNative(0x2975C866E6713290, dude5, Citizen.PointerValueInt(), Citizen.ResultAsString(dude10))
				Citizen.Trace("**********************")
				Citizen.Trace("what player is aiming at")
				Citizen.Trace("**********************")
				Citizen.Trace("entity ID = " .. tostring(dude10))
				Citizen.Trace("entity model hash = " .. tostring(GetEntityModel(dude10)))
				Citizen.Trace("entity coords = " .. tostring(GetEntityCoords(dude10)))
				Citizen.Trace("entity rotation = " .. tostring(GetEntityRotation(dude10)))
				Citizen.Trace("entity interior = " .. tostring(GetInteriorFromEntity(dude10)))
				Citizen.Trace("entity roomKey = " .. tostring(GetRoomKeyFromEntity(dude10)))
				Citizen.Trace("object_to_net = " .. tostring(entityNetworkID))
			end
			if dude6 ~= false and deleteGunToggle == true then
				Wait(0)
				--BOOL GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(Player player, Entity *entity) // 2975C866E6713290 8866D9D0
				dude10 = Citizen.InvokeNative(0x2975C866E6713290, dude5, Citizen.PointerValueInt(), Citizen.ResultAsString(dude10))
				dude12 = GetEntityModel(dude10)
				dude16 = GetEntityCoords(dude10)
				Citizen.Trace("entity " .. tostring(dude10))
				Citizen.Trace("entity model " .. tostring(dude12))
				Citizen.Trace("entity coords " .. tostring(dude16))
				isMission = IsEntityAMissionEntity(dude10)
				isPed = IsEntityAPed(dude10)
				isAnObj = IsEntityAnObject(dude10)
				isVeh = IsEntityAVehicle(dude10)
				object_to_net = ObjToNet(dude10)
				net_to_object = NetToObj(dude10)
				if isMission ~= 0 then
					SetEntityAsMissionEntity(dude10, true, true)
					if isPed ~= false then
						--BOOL GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(Player player, Entity *entity) // 2975C866E6713290 8866D9D0
						dude10 = Citizen.InvokeNative(0x2975C866E6713290, dude5, Citizen.PointerValueInt(), Citizen.ResultAsString(dude10))
						isMission = IsEntityAMissionEntity(dude10)
						SetEntityAsMissionEntity(dude10, true, true)
						delPedCoords = GetEntityCoords(dude10)
						delPedModel = GetEntityModel(dude10)
						DeleteEntity(dude10)
						TriggerServerEvent("deleteGunActivity", pedDeleted, tostring(delPedCoords), delPedModel)
						SetModelAsNoLongerNeeded(dude12)
					end
					if isVeh ~= false then
						--BOOL GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(Player player, Entity *entity) // 2975C866E6713290 8866D9D0
						dude10 = Citizen.InvokeNative(0x2975C866E6713290, dude5, Citizen.PointerValueInt(), Citizen.ResultAsString(dude10))
						isMission = IsEntityAMissionEntity(dude10)
						SetEntityAsMissionEntity(dude10, true, true)
						delVehCoords = GetEntityCoords(dude10)
						delVehModel = GetEntityModel(dude10)
						DeleteVehicle(dude10)
						DeleteEntity(dude10)
						SetModelAsNoLongerNeeded(dude12)
					end
					if isAnObj ~= false then
						--BOOL GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(Player player, Entity *entity) // 2975C866E6713290 8866D9D0
						dude10 = Citizen.InvokeNative(0x2975C866E6713290, dude5, Citizen.PointerValueInt(), Citizen.ResultAsString(dude10))
						isEntityNetworked = NetworkHasControlOfEntity(dude10)
						entityNetworkID = NetworkGetNetworkIdFromEntity(dude10)
						doesEntityExist = NetworkDoesNetworkIdExist(NetworkGetNetworkIdFromEntity(dude10))
						NetworkRequestControlOfNetworkId(entityNetworkID)
						SetEntityAsMissionEntity(dude10, 1, 0)
						SetEntityAsMissionEntity(entityNetworkID, 1, 0)

						isMission = IsEntityAMissionEntity(dude10)
						SetEntityAsMissionEntity(object_to_net, true, true)
						SetEntityAsMissionEntity(net_to_object, true, true)
						SetEntityAsMissionEntity(entityNetworkID, true, true)
						object_to_net = ObjToNet(dude10)
						net_to_object = NetToObj(entityNetworkID)
						playerName = GetPlayerName(object_to_net, dude5, true)
						objIndex = GetObjectIndexFromEntityIndex(dude10)
						objCoords = GetEntityCoords(dude10)
						objModel = GetEntityModel(dude10)
						DeleteEntity(object_to_net)
						DeleteObject(net_to_object)
						DeleteObject(dude10)
						DeleteObject(entityNetworkID)
						DeleteEntity(entityNetworkID)
						SetModelAsNoLongerNeeded(GetEntityModel(entityNetworkID))
					end
				end
			end
		end
	end
)

SetSwimMultiplierForPlayer(dude5, 1.49)
SetRunSprintMultiplierForPlayer(dude5, 1.49)
RequestScaleformMovie("instructional_buttons")

--------------------------------------------------------------------------------------------------
----------------------this gets a player if they are not the current player-----------------------
--------------------------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		temp1 = -1
		handle = NetworkHandleFromPlayer(PlayerId(), 13)
		currentPlayerName = GetPlayerName(PlayerId())
		playerPedID = GetPlayerPed(PlayerId())
		playerID = PlayerId()
		playerID = tostring(playerID)
		temp3 = {currentPlayerName, handle, playerPedID}
		while temp1 <= 3 do
			Citizen.Wait(10)
			temp2 = IntToPlayerindex(temp1)
			if GetPlayerPed(temp2) ~= temp0 then
			end
			if DoesEntityExist(GetPlayerPed(temp2)) then
				playerModel = GetEntityModel(GetPlayerPed(temp2))
				if not HasModelLoaded(playerModel) then
					RequestModel(playerModel)
				end
				name = GetPlayerName(temp2)
			else
				name = GetPlayerName(temp2)
			end
			temp1 = temp1 + 1

			if temp1 >= 3 then
				temp1 = -1
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(3000)
			--Citizen.Trace("get hash key of cinscreen: "..tostring(GetHashKey("cinscreen")))
			--Citizen.Trace("is interior ready: "..tostring(IsInteriorReady(258561)))
			--Citizen.Trace("playerId: "..tostring(PlayerId()))
			--Citizen.Trace("get name of this thread: "..tostring(GetIdOfThisThread()))
			--Citizen.Trace("Player position: "..tostring(GetEntityCoords(GetPlayerPed(PlayerId()))))
			--Citizen.Trace("player rotation: "..tostring(GetEntityRotation(GetPlayerPed(PlayerId()))))
			--Citizen.Trace("player ped id: "..tostring(NetworkGetPlayerIndexFromPed(PlayerPedId())))
			--Citizen.Trace("get player ped: "..tostring(temp0))
			--Citizen.Trace("int to player index: "..tostring(temp2))
			--Citizen.Trace("temp1: "..tostring(temp1))
			--Citizen.Trace("spawned entity ID: "..tostring(a))
			--Citizen.Trace("interior ready: "..tostring(IsInteriorReady(258561)))
			--Citizen.Trace("get closest object of type: "..tostring(GetClosestObjectOfType(GetEntityCoords(GetPlayerPed(PlayerId()), true), 20.1, stuff, 0, 0, 0)))
			--Citizen.Trace("get network id of player: "..tostring(NetworkGetNetworkIdFromEntity(GetPlayerPed())))
			--Citizen.Trace("current interior ID: "..tostring(GetInteriorFromEntity(GetPlayerPed(-1))))
			--Citizen.Trace("current roomkey: "..tostring(GetRoomKeyFromEntity(GetPlayerPed(-1))))
			--Citizen.Trace("spawned entity coords: "..tostring(GetEntityCoords(a)))
			--Citizen.Trace("spawned entity heading: "..tostring(GetEntityHeading(a)))
			--Citizen.Trace("spawned entity rotation: "..tostring(GetEntityRotation(a)))
			--Citizen.Trace("spawned entityID : "..tostring(a))
			--Citizen.Trace("get render cam : "..tostring(renderCam))
			--Citizen.Trace("spawned vehID : "..tostring(spawnedVeh))
			--Citizen.Trace("has veh model loaded : "..tostring(HasModelLoaded(veh)))
			--Citizen.Trace("spawned pedID : "..tostring(spawnPed))
			--Citizen.Trace("does cam exist : "..tostring(DoesCamExist(26379945)))
			--Citizen.Trace("closest entity of type: "..tostring(closestEntity))
			--Citizen.Trace("entity roomKey: "..tostring(entityRoomKey))
			--Citizen.Trace("entity interiorID: "..tostring(entityInteriorID))
			--Citizen.Trace("bunker interiorID: "..tostring(bunkerInterior))
			--Citizen.Trace("net to ped playerped: "..tostring(PlayerId()))
			--Citizen.Trace("playerped: "..tostring(GetPlayerPed(PlayerId())))
			--Citizen.Trace("interior groupID: "..tostring(interiorGroupID))
			--Citizen.Trace("spawned entity visible: "..tostring(IsEntityVisible(a)))
			--Citizen.Trace("spawned veh visible: "..tostring(IsEntityVisible(spawnedVeh)))
			--Citizen.Trace("spawned ped visible: "..tostring(IsEntityVisible(spawnPed)))
			--Citizen.Trace("spawned ped variations: "..tostring(pedVariationCount))
			--Citizen.Trace("spawned ped current variation: "..tostring(pedVariation))
			--Citizen.Trace("spawned ped current  drawable variation: "..tostring(pedDrawableVariation))
			--Citizen.Trace("spawned ped number of drawable variation: "..tostring(numberOfDrawableVariations))
			--Citizen.Trace("closest pedCount: "..tostring(closestPedCount))
			--Citizen.Trace("closest ped: "..tostring(closestPed))
			--Citizen.Trace("closest veh: "..tostring(closestVeh))
			--Citizen.Trace("nearby ped count: "..tostring(pedCount))
			--Citizen.Trace("nearby peds: "..tostring(pedz))
			--Citizen.Trace("get closest veh(buggyB): "..tostring(GetClosestVehicle(887.824, -3236.251, -98.8946, 1.0, -769147461, 70)))
			--Citizen.Trace("get closest veh(buggyA): "..tostring(GetClosestVehicle(890.708, -3236.804, -98.8961, 50.0, -769147461, 70)))
		end
	end
)
