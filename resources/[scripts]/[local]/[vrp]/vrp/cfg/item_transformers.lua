local cfg = {}

-- define static item transformers
-- see https://github.com/ImagicTheCat/vRP to understand the item transformer concept/definition

cfg.item_transformers = {
  -- example of harvest item transformer
  --[[  {
    name = "Fishing", -- menu name
    permissions = {"mission.delivery.fish"}, -- you can add permissions
    r = 0,
    g = 125,
    b = 255, -- color
    max_units = 100000,
    units_per_minute = 100000,
    x = 743.19586181641,
    y = 3895.3967285156,
    z = 30.5,
    radius = 1.5,
    height = 1.5, -- area
    recipes = {
      ["메기 잡기"] = {
        -- action name
        description = "메기를 잡습니다.", -- action description
        in_money = 0, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {
          -- items given per unit
          ["catfish"] = 1,
          ["trash"] = 1
        }
      },
      ["베스 잡기"] = {
        -- action name
        description = "베스를 잡습니다.", -- action description
        in_money = 0, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {
          -- items given per unit
          ["bass"] = 1,
          ["trash"] = 1
        }
      }
    }
  },]]
  --, onstart = function(player,recipe) end, -- optional start callback -- onstep = function(player,recipe) end, -- optional step callback -- onstop = function(player,recipe) end -- optional stop callback
  --
  -- {
  -- name="Santa's Workshop", -- menu name
  -- permissions = {"harvest.presents"}, -- you can add permissions
  -- r=0,g=125,b=255, -- color
  -- max_units=100000,
  -- units_per_minute=2,
  -- x=2213.0520019531,y=5577.5981445313,z=53.795757293701, -- UPDATE THIS
  -- radius=3, height=1.5, -- area
  -- recipes = {
  -- ["Gather Presents"] = { -- action name
  -- description="Gathering Presents", -- action description
  -- in_money=0, -- money taken per unit
  -- out_money=0, -- money earned per unit
  -- reagents={}, -- items taken per unit
  -- products={ -- items given per unit
  -- ["Presents"] = 1
  -- }
  -- }
  -- }
  -- },
  --[[{
    name="Water bottles/tacos tree", -- menu name
    -- permissions = {"harvest.water_bottle_tacos"}, -- you can add permissions
    r=0,g=125,b=255, -- color
    max_units=100000,
    units_per_minute=100000,
    x=-1692.6646728516,y=-1086.3079833984,z=13.152559280396, -- pos
    radius=5, height=1.5, -- area
    recipes = {
      ["Harvest water"] = { -- action name
        description="Harvest some water bottles.", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["water"] = 1
        }
      },
      ["Harvest tacos"] = { -- action name
        description="Harvest some tacos.", -- action description
        in_money=0, -- money taken per unit
        out_money=0, -- money earned per unit
        reagents={}, -- items taken per unit
        products={ -- items given per unit
          ["tacos"] = 1
        }
      }
    } --},
  {
    name = "Body training", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 3,
    x = -1202.96252441406,
    y = -1566.14086914063,
    z = 4.61040639877319,
    radius = 7.5,
    height = 1.5, -- area
    recipes = {
      ["운동하기"] = {
        -- action name
        description = "운동을 하여 근력을 키웁니다.", -- action description
        in_money = 1000, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {}, -- items given per unit
        aptitudes = {
          -- optional
          ["physical.strength"] = 0.1 -- "group.aptitude", give 1 exp per unit
        }
      }
    }
  },
  {
    name = "교도소 운동", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 3,
    x = -1771.9786376953,
    y = 2597.1423339844,
    z = 45.798027038574,
    radius = 7.5,
    height = 1.5, -- area
    recipes = {
      ["운동하기"] = {
        -- action name
        description = "운동을 하여 근력을 키웁니다.", -- action description
        in_money = 0, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {}, -- items given per unit
        aptitudes = {
          -- optional
          ["physical.strength"] = 0.05 -- "group.aptitude", give 1 exp per unit
        }
      }
    }
  },
  {
    name = "교도소 운동", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 3,
	x = 1769.4956054688,
	y = 2592.7272949219,
	z = 45.798030853271,
    radius = 7.5,
    height = 1.5, -- area
    recipes = {
      ["운동하기"] = {
        -- action name
        description = "운동을 하여 근력을 키웁니다.", -- action description
        in_money = 0, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {}, -- items given per unit
        aptitudes = {
          -- optional
          ["physical.strength"] = 0.05 -- "group.aptitude", give 1 exp per unit
        }
      }
    }
  },
  {
    name = "교도소 운동", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 3,
	x = 1765.7209472656,
	y = 2592.5166015625,
	z = 45.798030853271,
    radius = 7.5,
    height = 1.5, -- area
    recipes = {
      ["운동하기"] = {
        -- action name
        description = "운동을 하여 근력을 키웁니다.", -- action description
        in_money = 0, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {}, -- items given per unit
        aptitudes = {
          -- optional
          ["physical.strength"] = 0.05 -- "group.aptitude", give 1 exp per unit
        }
      }
    }
  },
  {
    name = "Body training", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 3,
    x = 246.39833068848,
    y = -733.85308837891,
    z = 38.994884490967,
    radius = 7.5,
    height = 1.5, -- area
    recipes = {
      ["운동하기"] = {
        -- action name
        description = "운동을 하여 근력을 키웁니다.", -- action description
        in_money = 1000, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {}, -- items given per unit
        aptitudes = {
          -- optional
          ["physical.strength"] = 0.1 -- "group.aptitude", give 1 exp per unit
        }
      }
    }
  },
  {
    name = "Jail Training", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 1,
    x = 1642.7900390625,
    y = 2570.4543457031,
    z = 45.564849853516,
    radius = 7.5,
    height = 1.5, -- area
    recipes = {
      ["운동하기"] = {
        -- action name
        description = "운동을 하여 근력을 키웁니다.", -- action description
        in_money = 1000, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {}, -- items given per unit
        aptitudes = {
          -- optional
          ["physical.strength"] = 0.1 -- "group.aptitude", give 1 exp per unit
        }
      }
    }
  },]]
  {
    name = "운전면허증", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 1,
    units_per_minute = 1,
    x = -553.44854736328,
    y = -192.95422241211,
    z = 38.219749450684,
    radius = 1.5,
    height = 0.2, -- area
    recipes = {
      ["운전면허증 발급"] = {
        -- action name
        description = "운전면허증을 발급받습니다.", -- action description`
        in_money = 0, -- money taken per unit
        out_money = 15000, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {
          ["driver"] = 1
        }, -- items given per unit
        aptitudes = {} -- optional
      }
    }
  },
  {
    name = "뉴비 운전면허증", -- menu name
    r = 255,
    g = 125,
    b = 0, -- color
    max_units = 1,
    units_per_minute = 1,
    x = -2236.8513,
    y = 261.6274,
    z = 174.69998,
    radius = 1.5,
    height = 0.2, -- area
    recipes = {
      ["운전면허증 발급"] = {
        -- action name
        description = "운전면허증을 발급받습니다.", -- action description`
        in_money = 0, -- money taken per unit
        out_money = 15000, -- money earned per unit
        reagents = {}, -- items taken per unit
        products = {
          ["driver"] = 1
        }, -- items given per unit
        aptitudes = {} -- optional
      }
    }
  },
  ---- 진통제 시작
  {
    name = "진통제 배분", -- menu name
    permissions = {"ems.jt"}, -- job drug dealer required to use
    r = 0,
    g = 255,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 100000,
    x = 313.00695800781,
    y = -593.86077880859,
    z = 48.224159240723, -- pos (needed for public use lab tools)
    radius = 1.1,
    height = 1.5, -- area
    recipes = {
      ["진통제 배분 중"] = {
        -- action name
        description = "배분중", -- action description
        in_money = 5000, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {
          -- items taken per unit
          ["jtj8"] = 1
        },
        products = {
          -- items given per unit
          ["jtjc"] = 1
        }
      }
    }
  },
  -- 진통제 끝
  {
    name = "대마초 제조", -- menu name,
    r = 0,
    g = 255,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 100000,
    x = 1036.5233154297,
    y = -3204.2526855469,
    z = -38.172836303711,
    radius = 1.1,
    height = 1.5, -- area
    recipes = {
      ["대마초"] = {
        -- action name
        description = "대마초 제조", -- action description
        in_money = 500, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {
          -- items taken per unit
          ["seeds"] = 1
        },
        products = {
          -- items given per unit
          ["weed"] = 3
        },
        aptitudes = {
          -- optional
          ["laboratory.weed"] = 3, -- "group.aptitude", give 1 exp per unit
          ["science.chemicals"] = 6
        }
      }
    }
  },
  {
    name = "LSD 제조", -- menu name,
    r = 0,
    g = 255,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 100000,
    x = 1003.0200195313,
    y = -3195.3415527344,
    z = -38.993137359619,
    radius = 1.1,
    height = 1.5, -- area
    recipes = {
      ["lsd"] = {
        -- action name
        description = "make lsd", -- action description
        in_money = 500, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {
          -- items taken per unit
          ["harness"] = 1
        },
        products = {
          -- items given per unit
          ["lsd"] = 3
        },
        aptitudes = {
          -- optional
          ["laboratory.lsd"] = 3, -- "group.aptitude", give 1 exp per unit
          ["science.chemicals"] = 6
        }
      }
    }
  },
  {
    name = "코카인 제조", -- menu name,
    r = 0,
    g = 255,
    b = 0, -- color
    max_units = 100000,
    units_per_minute = 100000,
    x = 1100.0014648438,
    y = -3194.56640625,
    z = -38.993438720703,
    radius = 1.1,
    height = 1.5, -- area
    recipes = {
      ["코카인"] = {
        -- action name
        description = "make cocaine", -- action description
        in_money = 500, -- money taken per unit
        out_money = 0, -- money earned per unit
        reagents = {
          -- items taken per unit
          ["benzoyl"] = 1
        },
        products = {
          -- items given per unit
          ["cocaine"] = 3
        },
        aptitudes = {
          -- optional
          ["laboratory.cocaine"] = 3, -- "group.aptitude", give 1 exp per unit
          ["science.chemicals"] = 6
        }
      }
    }
  }
}

-- define transformers randomly placed on the map
cfg.hidden_transformers = {}

-- time in minutes before hidden transformers are relocated (min is 5 minutes)
cfg.hidden_transformer_duration = 5 * 24 * 60 -- 5 days

-- configure the information reseller (can sell hidden transformers positions)
cfg.informer = {
  infos = {
    ["weed field"] = 20000,
    ["cocaine dealer"] = 20000,
    ["lsd bar"] = 20000
  },
  positions = {},
  interval = 60, -- interval in minutes for the reseller respawn
  duration = 10, -- duration in minutes of the spawned reseller
  blipid = 133,
  blipcolor = 2
}

return cfg
