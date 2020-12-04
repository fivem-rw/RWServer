local cfg = {}

cfg.inventory_weight_per_strength = 500 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 100

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
  ["poter"] = 1500,
  ["bongo"] = 1500,
  ["monster"] = 250,
  ["rrstart"] = 200,
  ["nissantitan17"] = 200,
  ["h6"] = 200,
  ["g500"] = 200,
  ["g63amg6x6"] = 500
}

return cfg
