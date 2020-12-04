-- Menu configuration, array of menus to display
menuConfigs = {
    ["emotes"] = {
        -- Example menu for emotes when player is on foot
        enableMenu = function()
            -- Function to enable/disable menu handling
            local player = GetPlayerPed(-1)
            return true
            --return IsPedOnFoot(player)
        end,
        data = {
            -- Data that is passed to Javascript
            keybind = "l", -- Wheel keybind to use (case sensitive, must match entry in keybindControls table)
            style = {
                -- Wheel style settings
                sizePx = 600, -- Wheel size in pixels
                slices = {
                    -- Slice style settings
                    default = {["fill"] = "#000000", ["stroke"] = "#000000", ["stroke-width"] = 2, ["opacity"] = 0.60},
                    hover = {["fill"] = "#ff8000", ["stroke"] = "#000000", ["stroke-width"] = 2, ["opacity"] = 0.80},
                    selected = {["fill"] = "#ff8000", ["stroke"] = "#000000", ["stroke-width"] = 2, ["opacity"] = 0.80}
                },
                titles = {
                    -- Text style settings
                    default = {
                        ["fill"] = "#ffffff",
                        ["stroke"] = "none",
                        ["font"] = "Helvetica",
                        ["font-size"] = 16,
                        ["font-weight"] = "bold"
                    },
                    hover = {
                        ["fill"] = "#ffffff",
                        ["stroke"] = "none",
                        ["font"] = "Helvetica",
                        ["font-size"] = 16,
                        ["font-weight"] = "bold"
                    },
                    selected = {
                        ["fill"] = "#ffffff",
                        ["stroke"] = "none",
                        ["font"] = "Helvetica",
                        ["font-size"] = 16,
                        ["font-weight"] = "bold"
                    }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                -- Array of wheels to display
                {
                    navAngle = 270, -- Oritentation of wheel
                    minRadiusPercent = 0.4, -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.7, -- Maximum radius of wheel in percentage
                    labels = {"모션취소", "싫어", "빠른박수", "박수", "빨장끼기", "브이", "뻐큐", "눕기"},
                    commands = {
                        "e cancel",
                        "e no",
                        "e cheer",
                        "e slowclap",
                        "e foldarms",
                        "e peace",
                        "e finger",
                        "e dead"
                    }
                },
                {
                    navAngle = 79, -- Oritentation of wheel
                    minRadiusPercent = 0.7, -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 1.0, -- Maximum radius of wheel in percentage
                    labels = {"경례", "쌍뻐큐", "체포굴복", "걱정하기", "아깝다", "좌절", "옆으로눕기", "갱스터1", "갱스터2", "근무서기", "총잡이", "진정해", "시가", "한발", "존슨", "똥고"},
                    commands = {
                        "e salute",
                        "e finger2",
                        "e surrender",
                        "e palm",
                        "e damn",
                        "e fail",
                        "e bum",
                        "e gang1",
                        "e gang2",
                        "e copidle",
                        "e holster",
                        "e copcrowd2",
                        "e cigar",
                        "e leanwall",
                        "e grabcrotch",
                        "e pickbutt"
                    }
                }
            }
        }
    },
    ["vehicles"] = {
        -- Example menu for vehicle controls when player is in a vehicle
        enableMenu = function()
            -- Function to enable/disable menu handling
            local player = GetPlayerPed(-1)
            return false
            --return IsPedInAnyVehicle(player, false)
        end,
        data = {
            -- Data that is passed to Javascript
            keybind = "m", -- Wheel keybind to use (case sensitive, must match entry in keybindControls table)
            style = {
                -- Wheel style settings
                sizePx = 400, -- Wheel size in pixels
                slices = {
                    -- Slice style settings
                    default = {["fill"] = "#000000", ["stroke"] = "#000000", ["stroke-width"] = 3, ["opacity"] = 0.60},
                    hover = {["fill"] = "#ff8000", ["stroke"] = "#000000", ["stroke-width"] = 3, ["opacity"] = 0.80},
                    selected = {["fill"] = "#ff8000", ["stroke"] = "#000000", ["stroke-width"] = 3, ["opacity"] = 0.80}
                },
                titles = {
                    -- Text style settings
                    default = {
                        ["fill"] = "#ffffff",
                        ["stroke"] = "none",
                        ["font"] = "Helvetica",
                        ["font-size"] = 16,
                        ["font-weight"] = "bold"
                    },
                    hover = {
                        ["fill"] = "#ffffff",
                        ["stroke"] = "none",
                        ["font"] = "Helvetica",
                        ["font-size"] = 16,
                        ["font-weight"] = "bold"
                    },
                    selected = {
                        ["fill"] = "#ffffff",
                        ["stroke"] = "none",
                        ["font"] = "Helvetica",
                        ["font-size"] = 16,
                        ["font-weight"] = "bold"
                    }
                },
                icons = {
                    width = 64,
                    height = 64
                }
            },
            wheels = {
                -- Array of wheels to display
                {
                    navAngle = 270, -- Oritentation of wheel
                    minRadiusPercent = 0.4, -- Minimum radius of wheel in percentage
                    maxRadiusPercent = 0.9, -- Maximum radius of wheel in percentage
                    labels = {
                        "imgsrc:engine.png",
                        "imgsrc:key.png",
                        "imgsrc:lock.png",
                        "imgsrc:doors.png",
                        "imgsrc:trunk.png",
                        "imgsrc:hood.png"
                    },
                    commands = {"engine", "getvkey", "lock", "rdoors", "trunk", "hood"}
                }
            }
        }
    }
}
