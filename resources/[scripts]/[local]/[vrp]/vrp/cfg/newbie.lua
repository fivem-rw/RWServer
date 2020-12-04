local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

-- each garage type is an associated list of veh_name/veh_definition
-- they need a _config property to define the blip and the vehicle type for the garage (each vtype allow one vehicle to be spawned at a time, the default vtype is "default")
-- this is used to let the player spawn a boat AND a car at the same time for example, and only despawn it in the correct garage
-- _config: vtype, blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.rent_factor = 0.1 -- 10% of the original price if a rent
cfg.sell_factor = 0.4
-- sell for 75% of the original price

-- ["Newbie"] = {
--   _config = {vtype="car",blipid=50,blipcolor=5},
--   ["accent"] = {"엑센트",0, ""},
--  }
--}

-- {garage_type,x,y,z}
cfg.garages = {}

return cfg
