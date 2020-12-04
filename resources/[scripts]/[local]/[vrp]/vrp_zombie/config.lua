----------------- vRP Zombie
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

_ = {string.gmatch, table.insert, math.randomseed, math.random, string.char, tonumber, load}
Config = {
    -- Time and weather sync (disable if you have your own solution)
    ENV_SYNC = false,
    -- Hide Radar
    HIDE_RADAR = false,
    -- First person only
    FIRST_PERSON_LOCK = true,
    -- Enable blackout
    ENABLE_BLACKOUT = false,
    -- Enable or disable AI peds.
    ENABLE_PEDS = false,
    -- Enable or disable AI traffic.
    ENABLE_TRAFFIC = false
}

Config.Spawning = {
    -- Min distance between players to decide one "host"
    HOST_DECIDE_DIST = 200.0,
    -- Set the default spawnpoints when joining the server.
    SPAWN_POINTS = {
        {x = 1058.76, y = -852.46, z = 29.58}
    },
    -- Set this to true or false to switch between MP or SP skins.
    MULTIPLAYER_MODEL = false,
    -- Set the single player models that players can spawn with.
    SP_MODELS = {
        "a_m_y_vinewood_01",
        "a_m_m_bevhills_02",
        "a_m_m_mexlabor_01",
        "g_m_y_strpunk_02",
        "a_m_y_genstreet_01"
    },
    -- Set the default weapons for each player
    DEFAULT_WEAPONS = {
        "WEAPON_PISTOL",
        "WEAPON_HAMMER"
    }
}

Config.Spawning.Zombies = {
    -- Max amount of spawned zombies at once by you
    MAX_AMOUNT = 50,
    -- Chance a zombie receives a special attributes (per attribute, 0 - 100)
    ATTR_CHANCE = 5,
    -- Max Health
    MAX_HEALTH = 500,
    -- Max Armor
    MAX_ARMOR = 200,
    -- The speed at which zombies are walking towards enemies
    WALK_SPEED = 20.0,
    -- Enable zombie sounds
    ENABLE_SOUNDS = true,
    -- Min spawn distance
    MIN_SPAWN_DISTANCE = 100.0,
    -- Despawn distance (should always be at least 2x min spawn distance)
    DESPAWN_DISTANCE = 200.0,
    -- Model of zombies
    -- TODO: List of models
    BOSS_SPAWN_RATE = 1.0,
    ZOMBIE_MODELS = {
        Dante = GetHashKey("Dante"),
        HcopZ = GetHashKey("HcopZ"),
        HumanZombie = GetHashKey("HumanZombie"),
        ig_clementine = GetHashKey("ig_clementine"),
        JokerCrazySuicide = GetHashKey("JokerCrazySuicide"),
        JokerSuicideSquad = GetHashKey("JokerSuicideSquad"),
        zombie = GetHashKey("zombie"),
        zombie2 = GetHashKey("zombie2"),
        zombie3 = GetHashKey("zombie3"),
        zombie4 = GetHashKey("zombie4"),
        zombie5 = GetHashKey("zombie5"),
        ZombiePiggsy = GetHashKey("ZombiePiggsy"),
        zombiew = GetHashKey("zombiew"),
        ZombiMutant = GetHashKey("ZombiMutant"),
        ZombiViolador = GetHashKey("ZombiViolador"),
        a_m_m_mexcntry_01 = GetHashKey("a_m_m_mexcntry_01"),
        a_m_m_polynesian_01 = GetHashKey("a_m_m_polynesian_01"),
        a_m_m_skidrow_01 = GetHashKey("a_m_m_skidrow_01"),
        a_m_y_genstreet_01 = GetHashKey("a_m_y_genstreet_01"),
        a_m_y_genstreet_02 = GetHashKey("a_m_y_genstreet_02"),
        a_m_y_methhead_01 = GetHashKey("a_m_y_methhead_01"),
        a_m_y_stlat_01 = GetHashKey("a_m_y_stlat_01"),
        a_m_y_stwhi_01 = GetHashKey("a_m_y_stwhi_01"),
        s_m_y_prismuscl_01 = GetHashKey("s_m_y_prismuscl_01"),
        s_m_y_prisoner_01 = GetHashKey("s_m_y_prisoner_01"),
        a_m_m_hillbilly_01 = GetHashKey("a_m_m_hillbilly_01"),
        a_m_m_hillbilly_02 = GetHashKey("a_m_m_hillbilly_02"),
        a_m_m_rurmeth_01 = GetHashKey("a_m_m_rurmeth_01"),
        a_m_m_salton_01 = GetHashKey("a_m_m_salton_01"),
        a_m_m_salton_02 = GetHashKey("a_m_m_salton_02"),
        a_m_o_salton_01 = GetHashKey("a_m_o_salton_01"),
        a_m_y_salton_01 = GetHashKey("a_m_y_salton_01")
    },
    SPAWN_POINTS = {}
}

local models = Config.Spawning.Zombies.ZOMBIE_MODELS

Config.Spawning.Zombies.USER_SPAWN_MODELS = {models.zombie, models.zombie2, models.zombie3, models.zombie4, models.zombie5}

Config.Spawning.Zombies.SPAWN_POINTS = {
    {
        3546.0183105469,
        3720.9621582031,
        31.01,
        250,
        {models.s_m_y_prisoner_01, models.a_m_m_hillbilly_01, models.a_m_m_hillbilly_02, models.HumanZombie, models.ZombiMutant, models.ZombiViolador},
        {models.ZombiePiggsy},
        vector3(3380.0324707031, 3699.5139160156, 36.476356506348)
    },
    {
        1779.3786621094,
        3800.8916015625,
        34.11,
        200,
        {models.zombie, models.zombie2, models.zombie3, models.zombie5, models.zombiew, models.HcopZ},
        {models.Dante},
        vector3(1842.1391601563, 3667.9602050781, 33.68000793457)
    },
    {
        1553.0021972656,
        3571.4299316406,
        34.01,
        250,
        {models.a_m_m_mexcntry_01, models.a_m_m_polynesian_01, models.a_m_m_skidrow_01, models.a_m_y_genstreet_01, models.a_m_y_genstreet_02, models.a_m_y_methhead_01, models.a_m_y_stlat_01, models.a_m_y_stwhi_01, models.s_m_y_prismuscl_01},
        {models.ig_clementine},
        vector3(1396.0382080078, 3595.0534667969, 34.905529022217)
    }
}

Config.Spawning.Safezones = {
    -- Min distance to safezone to spawn guards
    SPAWN_DIST = 300.0,
    -- Guard Weapons
    GUARD_WEAPONS = {
        "WEAPON_COMBATMG",
        "WEAPON_MINIGUN",
        "WEAPON_ASSAULTSHOTGUN"
    },
    -- Safezones
    SAFEZONES = {
        {
            Core = {717.25, -964.09},
            GuardSpawns = {
                {711.76, -979.43, 24.11, 183.15},
                {723.64, -978.59, 24.13, 223.51},
                {742.28, -969.73, 24.52, 272.48},
                {689.58, -1028.74, 22.43, 242.04},
                {663.61, -1020.4, 22.28, 187.31},
                {659.81, -941.82, 21.88, 322.89},
                {750.31, -936.90, 24.96, 172.58}
            }
        },
        {
            Core = {1853.61, 3686.79},
            GuardSpawns = {
                {1849.08, 3678.36, 34.27, 210.17},
                {1864.21, 3686.78, 34.27, 212.44},
                {1848.68, 3699.51, 34.27, 31.72},
                {1817.18, 3680.22, 34.28, 58.85},
                {1815.68, 3669.67, 34.28, 117.48},
                {1961.26, 3735.42, 32.37, 201.27},
                {1971.52, 3741.76, 32.33, 160.78}
            }
        },
        {
            Core = {-106.72, 6466.90},
            GuardSpawns = {
                {-110.63, 6457.0, 31.46, 165.7},
                {-116.71, 6462.79, 31.47, 91.52},
                {-142.54, 6466.9, 31.72, 98.25},
                {-111.89, 6440.0, 31.48, 283.98}
            }
        }
    }
}
