local cfg = {}

cfg.market_types = {
  ["안티 상점"] = {
    _config = {blipid = 52, blipcolor = 1},
    ["anti_market_item1"] = {
      items = {{"wbody|WEAPON_GRENADELAUNCHER", 1}},
      requiredItems = {{"zombie_ear", 2500}, {"zombie_head", 2500}, {"zombie_arm", 2500}}
    },
    ["anti_market_item2"] = {
      items = {{"wammo|WEAPON_COMBATMG", 10}},
      requiredItems = {{"zombie_ear", 1}}
    },
    ["anti_market_item3"] = {
      items = {{"wammo|WEAPON_PISTOL50", 10}},
      requiredItems = {{"zombie_ear", 1}}
    },
    ["anti_market_item4"] = {
      items = {{"wammo|WEAPON_GRENADELAUNCHER", 1}},
      requiredItems = {{"zombie_arm", 1}}
    },
    ["anti_market_item5"] = {
      items = {{"wammo|WEAPON_ASSAULTSHOTGUN", 10}},
      requiredItems = {{"zombie_arm", 1}}
    },
    ["anti_market_item6"] = {
      items = {{"wammo|WEAPON_PUMPSHOTGUN", 10}},
      requiredItems = {{"zombie_head", 1}}
    },
    ["anti_market_item7"] = {
      items = {{"titlebox_zombie1", 1}},
      requiredItems = {{"zombie_ear", 1500}}
    },
    ["anti_market_item8"] = {
      items = {{"titlebox_zombie2", 1}},
      requiredItems = {{"zombie_arm", 1500}}
    },
    ["anti_market_item9"] = {
      items = {{"titlebox_zombie3", 1}},
      requiredItems = {{"zombie_head", 1500}}
    }
  },
  ["미션 상점"] = {
    _config = {blipid = 52, blipcolor = 5},
    ["gold_mission_item1"] = {
      items = {{"titlebox_gold1", 1}},
      requiredItems = {{"gold_mission_sp1", 50}}
    },
    ["gold_mission_item2"] = {
      items = {{"titlebox_gold2", 1}},
      requiredItems = {{"gold_mission_sp2", 80}}
    },
    ["gold_mission_item3"] = {
      items = {{"special_goldticket", 1}},
      requiredItems = {{"special_goldmticket", 5}}
    }
  },
  ["페스티벌"] = {
    _config = {blipid = 483, blipcolor = 5},
    ["event_trade_01"] = {
      items = {{"event_trade_01_t", 1}},
      requiredItems = {{"event_01", 1}, {"event_02", 1}, {"event_03", 1}, {"event_04", 1}, {"event_05", 1}}
    },
    ["event_trade_02"] = {
      items = {{"event_trade_02_t", 1}},
      requiredItems = {{"event_06", 1}, {"event_07", 1}, {"event_08", 1}}
    },
    ["event_trade_03"] = {
      items = {{"event_trade_03_t", 1}},
      requiredItems = {{"event_09", 1}, {"event_10", 1}, {"event_11", 1}}
    },
    ["event_trade_04"] = {
      items = {{"event_trade_04_t", 1}},
      requiredItems = {{"event_16", 1}, {"event_17", 1}, {"event_18", 1}, {"event_19", 1}, {"event_20", 1}}
    },
    ["event_trade_05"] = {
      items = {{"event_trade_05_t", 1}},
      requiredItems = {{"event_12", 1}, {"event_13", 1}, {"event_14", 1}, {"event_15", 1}}
    },
    ["event_trade_06"] = {
      items = {{"event_trade_06_t", 1}},
      requiredItems = {{"event_21", 1}, {"event_22", 1}, {"event_23", 1}, {"event_24", 1}}
    }
  }
}

cfg.markets = {
  {"안티 상점", 1386.9251708984, 3616.8862304688, 38.921012878418},
  {"안티 상점", 1878.2982177734, 3920.40234375, 33.146198272705},
  {"안티 상점", 3423.5002441406, 3679.6538085938, 40.36739730835},
  --{"페스티벌", 227.52578735352, -874.96405029297, 30.491374969482},
  {"미션 상점", -20.544052124023, 6566.744140625, 31.875467300415}
}

return cfg
