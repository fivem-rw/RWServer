--DrawText3D(x,y,z-0.2, "~b~"..settings[lang].price.." : "..StationsPrice[item.s].."/litru")

local cfg = {}

-- city hall position
cfg.identity = {
  {-552.02882080078, -192.12287902832, 38.219749450684},
  {-2243.7065429688, 260.17776489258, 174.60943603516}
}

-- cityhall blip {blipid,blipcolor}
cfg.blip = {498, 4}

-- cost of a new identity
cfg.new_identity_cost = 15000

-- phone format (max: 20 chars, use D for a random digit)
cfg.phone_format = "010DDDDDDDD"
-- cfg.phone_format = "06DDDDDDDD" -- another example for cellphone in France

-- config the random name generation (first join identity)
-- (I know, it's a lot of names for a little feature)
-- (cf: http://names.mongabay.com/most_common_surnames.htm)
cfg.random_first_names = {
  "신분증"
}

cfg.random_last_names = {
  "미발급"
}

return cfg
