local cfg = {}

cfg.lang = "ko"
-- define customization parts
local parts = {
  ["얼굴"] = -1,
  ["피부/잡티"] = 0,
  ["배 털"] = 1,
  ["눈썹 화장"] = 2,
  ["주름"] = 3,
  ["얼굴 화장"] = 4,
  ["볼 터치"] = 5,
  ["컴플렉스"] = 6,
  ["피부/색상"] = 7,
  ["입술 색상"] = 8,
  ["기미"] = 9,
  ["가슴 털"] = 10,
  ["몸 잡티"] = 11,
  ["머리"] = 12
}

-- changes prices (any change to the character parts add amount to the total price)
cfg.drawable_change_price = 20
cfg.texture_change_price = 5
cfg.barbershops_title = "헤어샵"

-- skinshops list {parts,x,y,z}
cfg.barbershops = {
  {parts, -815.59008789063, -182.16806030273, 37.568920135498},
  {parts, 139.21583557129, -1708.9689941406, 29.301620483398},
  {parts, -1281.9802246094, -1119.6861572266, 7.0001249313354},
  {parts, 1934.115234375, 3730.7399902344, 32.854434967041},
  {parts, 1211.0759277344, -475.00064086914, 66.218032836914},
  {parts, -34.97777557373, -150.9037322998, 57.086517333984},
  {parts, -280.37301635742, 6227.017578125, 31.705526351929}
}

return cfg
