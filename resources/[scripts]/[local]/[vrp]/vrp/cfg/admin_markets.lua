local cfg = {}
local cfgItems = module("cfg/items")

cfg.market_types = {
  ["관리자 창고"] = {
    _config = {blipid = 52, blipcolor = 2, permissions = {"admin.market"}},
    ["water"] = 0,
    ["titlebox_random"] = 0
  }
}

cfg.markets = {
  {"관리자 창고", 1217.8044433594, -1088.931640625, 31.638889312744}
}

for k,v in pairs(cfgItems.items) do 
  cfg.market_types["관리자 창고"][k] = 0
end

return cfg
