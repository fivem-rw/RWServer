---------------------------------------------------------
------------ VRP DeathMatch, RealWorld MAC --------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

isTest = false
gameSpeed = 1
teamName = {
  [1] = "^*^1[레드]",
  [2] = "^*^5[블루]"
}
killPoints = {
  [1] = {10, "킬"},
  [2] = {15, "더블킬"},
  [3] = {30, "트리플킬"},
  [4] = {50, "쿼드라킬"},
  [5] = {70, "펜타킬"},
  [6] = {100, "크레이지킬"},
  [7] = {200, "언벌리버블"}
}
statusName = {
  [1] = "~w~대기중",
  [2] = "~y~시작중",
  [3] = "~g~게임중",
  [4] = "~b~일시정지",
  [5] = "~r~종료"
}
teamResultName = {
  [1] = "레드팀 승",
  [2] = "블루팀 승",
  [3] = "무승부"
}

function getTimeString(time)
  local m = parseInt(time / 60)
  local s = parseInt(time % 60)
  if m < 10 then
    m = "0" .. m
  end
  if s < 10 then
    s = "0" .. s
  end
  return m .. ":" .. s
end

function DrawText3D(x, y, z, text, s)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

  if not s then
    s = 2.5
  end

  local scale = (1 / dist) * s
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov

  if onScreen then
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextDropShadow(0, 0, 0, 0, 150)
    SetTextEdge(1, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end

function DrawTxt2(x, y, width, height, scale, text, r, g, b, a)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(2, 0, 0, 0, 255)
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x - width / 2, y - height / 2 + 0.005)
end

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
