-- client-side vRP configuration

local cfg = {}

cfg.iplload = true

cfg.voice_proximity = 20.0 -- default voice proximity (outside)
cfg.voice_proximity_vehicle = 5.0
cfg.voice_proximity_inside = 9.0

cfg.gui = {
  anchor_minimap_width = 260,
  anchor_minimap_left = 60,
  anchor_minimap_bottom = 213
}

-- gui controls (see https://wiki.fivem.net/wiki/Controls)
-- recommended to keep the default values and ask players to change their keys
cfg.controls = {
  phone = {
    -- PHONE CONTROLS
    up = {3, 172},
    down = {3, 173},
    left = {3, 174},
    right = {3, 175},
    select = {3, 176},
    cancel = {3, 177},
    open = {3, 311} -- K to open the menu
  },
  request = {
    yes = {1, 96}, -- Numbpad+
    no = {1, 97} -- Numbpad-
  }
}

-- disable menu if handcuffed
cfg.handcuff_disable_menu = true

-- when health is under the threshold, player is in coma
-- set to 0 to disable coma

cfg.warning_threshold = 130

cfg.coma_disable_menu = true
cfg.coma_threshold = 120
cfg.coma_duration = 10
cfg.coma_effect = "DeathFailMPIn"

cfg.die_threshold = 105
cfg.die_duration = 0.5
cfg.die_effect = "DeathFailOut"

-- if true, vehicles can be controlled by others, but this might corrupts the vehicles id and prevent players from interacting with their vehicles
cfg.vehicle_migration = true

return cfg
