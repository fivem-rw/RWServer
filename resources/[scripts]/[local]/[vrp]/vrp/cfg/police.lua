local cfg = {}

-- PCs positions
cfg.pcs = {
  {1853.21, 3689.51, 34.2671},
  {442.030609130859, -978.72705078125, 30.6896057128906},
  {-448.97076416016, 6012.4208984375, 31.71639251709}
}

-- vehicle tracking configuration
cfg.trackveh = {
  min_time = 300, -- min time in seconds
  max_time = 600, -- max time in seconds
  service = "police", -- service to alert when the tracking is successful
  "SWAT",
  "sheriff",
  "highway",
  "trafficguard",
  "Chief",
  "Commander",
  "Lieutenant",
  "Detective",
  "Sergeant",
  "Deputy",
  "Bounty",
  "Dispatch"
}

-- wanted display
cfg.wanted = {
  blipid = 458,
  blipcolor = 38,
  service = "police",
  "SWAT",
  "sheriff",
  "highway",
  "trafficguard",
  "Chief",
  "Dispatch",
  "Commander",
  "Lieutenant",
  "Detective",
  "Deputy",
  "Bounty",
  "Sergeant"
}

-- illegal items (seize)
cfg.seizable_items = {
  "dirty_money",
  "cocaine",
  "lsd",
  "benzoyl",
  "seeds",
  "harness",
  "credit",
  "weed",
  "M4A1",
  "AK47",
  "fake_id"
}

-- jails {x,y,z,radius}
cfg.jails = {
  {459.485870361328, -1001.61560058594, 24.914867401123, 2.1},
  {459.305603027344, -997.873718261719, 24.914867401123, 2.1},
  {459.999938964844, -994.331298828125, 24.9148578643799, 1.6}
}

cfg.jails_ex = {
  ["outside"] = {1839.0756835938, 2580.87890625, 45.897689819336},
  ["inside"] = {1840.1783447266, 2593.6799316406, 45.892105102539}
}

-- fines
-- map of name -> money
cfg.fines = {
  ["차량절도죄"] = 2000000,
  ["절도죄"] = 2000000,
  ["모욕죄"] = 500000,
  ["명예훼손죄"] = 1000000,
  ["업무방해죄"] = 2000000,
  ["폭행죄"] = 1000000,
  ["상해죄"] = 1500000,
  ["성폭력죄"] = 700000,
  ["죄물손괴죄"] = 2000000,
  ["사칭죄"] = 4000000,
  ["공무집행방해죄"] = 3000000,
  ["특수공무방해치사상죄"] = 10000000,
  ["공무원뇌물공여"] = 10000000,
  ["사기죄"] = 1000000,
  ["인질강도죄"] = 3000000,
  ["음모죄"] = 1500000,
  ["총포도검위반"] = 2000000,
  ["마약류소지죄"] = 1500000,
  ["업무상과실"] = 700000,
  ["도주죄"] = 2000000,
  ["중대범죄결합살인"] = 15000000,
  ["극단적인명경시살인"] = 25000000,
  ["공무원차량절도"] = 10000000,
  ["무면허운전"] = 500000,
  ["속도위반"] = 400000,
  ["신호지시위반"] = 300000,
  ["차선위반"] = 400000,
  ["진로위반"] = 400000,
  ["폭주로간주"] = 8000000,
  ["불법틴팅"] = 500000,
  ["보복운전"] = 2100000,
  ["무허가이륙"] = 20000000,
  ["좌회전금지위반"] = 500000,
  ["보석금(1분당)"] = 100000
}

return cfg
