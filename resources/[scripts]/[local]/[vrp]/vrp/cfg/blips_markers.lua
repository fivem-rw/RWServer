-- this file is used to define additional static blips and markers to the map
-- some lists: https://wiki.gtanet.work/index.php?title=Blips

local cfg = {}

-- list of blips
-- {x,y,z,idtype,idcolor,text}
cfg.blips = {
  --{-1202.96252441406, -1566.14086914063, 4.61040639877319, 311, 17, "헬스장"}
}

-- list of markers
-- {x,y,z,sx,sy,sz,r,g,b,a,visible_distance}
cfg.markers = {
  {743.19586181641, 3895.3967285156, 30.556676864624, 1.5, 1.5, 0.2, 204, 204, 0, 100, 35}, -- Place where to get the fish from.
  {1008.8854980469, 3908.5732421875, 30.031631, 1.5, 1.5, 0.2, 204, 204, 0, 100, 35}, -- Place to get the boat from (marked on the ground)
  {-553.44854736328, -192.95422241211, 37.219749450684, 1.5, 1.5, 0.2, 204, 204, 0, 100, 35, "운전면허증 발급"}, -- Place to get Drivers License
  {-2236.8513, 261.6274, 173.60785, 1.5, 1.5, 0.2, 204, 204, 0, 100, 35, "운전면허증 발급"} -- Place to get Drivers License
}

return cfg
