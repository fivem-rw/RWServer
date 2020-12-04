local modules = {}
function module(rsc, path) -- load a LUA resource file as module
  if path == nil then -- shortcut for vrp, can omit the resource parameter
    path = rsc
    rsc = "vrp"
  end

  local key = rsc .. path

  if modules[key] then -- cached module
    return table.unpack(modules[key])
  else
    local f, err = load(LoadResourceFile(rsc, path .. ".lua"))
    if f then
      local ar = {pcall(f)}
      if ar[1] then
        table.remove(ar, 1)
        modules[key] = ar
        return table.unpack(ar)
      else
        modules[key] = nil
        print("[vRP] error loading module " .. rsc .. "/" .. path .. ":" .. ar[2])
      end
    else
      print("[vRP] error parsing module " .. rsc .. "/" .. path .. ":" .. err)
    end
  end
end

-- generate a task metatable (helper to return delayed values with timeout)
--- dparams: default params in case of timeout or empty cbr()
--- timeout: milliseconds, default 5000
function Task(callback, dparams, timeout)
  if timeout == nil then
    timeout = 5000
  end

  local r = {}
  r.done = false

  local finish = function(params)
    if not r.done then
      if params == nil then
        params = dparams or {}
      end
      r.done = true
      callback(table.unpack(params))
    end
  end

  setmetatable(
    r,
    {
      __call = function(t, params)
        finish(params)
      end
    }
  )
  SetTimeout(
    timeout,
    function()
      finish(dparams)
    end
  )

  return r
end

function parseInt(v)
  --  return cast(int,tonumber(v))
  local n = tonumber(v)
  if n == nil then
    return 0
  else
    return math.floor(n)
  end
end

function parseDouble(v)
  --  return cast(double,tonumber(v))
  local n = tonumber(v)
  if n == nil then
    n = 0
  end
  return n
end

function parseFloat(v)
  return parseDouble(v)
end

-- will remove chars not allowed/disabled by strchars
-- if allow_policy is true, will allow all strchars, if false, will allow everything except the strchars
local sanitize_tmp = {}
function sanitizeString(str, strchars, allow_policy)
  local r = ""

  -- get/prepare index table
  local chars = sanitize_tmp[strchars]
  if chars == nil then
    chars = {}
    local size = string.len(strchars)
    for i = 1, size do
      local char = string.sub(strchars, i, i)
      chars[char] = true
    end

    sanitize_tmp[strchars] = chars
  end

  -- sanitize
  size = string.len(str)
  for i = 1, size do
    local char = string.sub(str, i, i)
    if (allow_policy and chars[char]) or (not allow_policy and not chars[char]) then
      r = r .. char
    end
  end

  return r
end

function splitString(str, sep)
  if sep == nil then
    sep = "%s"
  end

  local t = {}
  local i = 1

  for str in string.gmatch(str, "([^" .. sep .. "]+)") do
    t[i] = str
    i = i + 1
  end

  return t
end

function joinStrings(list, sep)
  if sep == nil then
    sep = ""
  end

  local str = ""
  local count = 0
  local size = #list
  for k, v in pairs(list) do
    count = count + 1
    str = str .. v
    if count < size then
      str = str .. sep
    end
  end

  return str
end

function comma_value(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
    if (k == 0) then
      break
    end
  end
  return formatted
end

---============================================================
-- rounds a number to the nearest decimal places
--
function round(val, decimal)
  if (decimal) then
    return math.floor((val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
  else
    return math.floor(val + 0.5)
  end
end

--===================================================================
-- given a numeric value formats output with comma to separate thousands
-- and rounded to given decimal places
--
--
function format_num(amount, decimal, prefix, neg_prefix)
  local str_amount, formatted, famount, remain

  amount = parseDouble(amount)

  decimal = decimal or 0
  neg_prefix = neg_prefix or "-" -- default negative sign

  famount = math.abs(round(amount, decimal))
  famount = math.floor(famount)

  remain = round(math.abs(amount) - famount, decimal)

  -- comma to separate the thousands
  formatted = comma_value(famount)

  -- attach the decimal portion
  if (decimal > 0) then
    remain = string.sub(tostring(remain), 3)
    formatted = formatted .. "." .. remain .. string.rep("0", decimal - string.len(remain))
  end

  formatted = (prefix or "") .. formatted

  -- if value is negative then format accordingly
  if (amount < 0) then
    if (neg_prefix == "()") then
      formatted = "(" .. formatted .. ")"
    else
      formatted = neg_prefix .. formatted
    end
  end

  return formatted
end

local Keys = {
  ["ESC"] = 322,
  ["F1"] = 288,
  ["F2"] = 289,
  ["F3"] = 170,
  ["F5"] = 166,
  ["F6"] = 167,
  ["F7"] = 168,
  ["F8"] = 169,
  ["F9"] = 56,
  ["F10"] = 57,
  ["~"] = 243,
  ["1"] = 157,
  ["2"] = 158,
  ["3"] = 160,
  ["4"] = 164,
  ["5"] = 165,
  ["6"] = 159,
  ["7"] = 161,
  ["8"] = 162,
  ["9"] = 163,
  ["-"] = 84,
  ["="] = 83,
  ["BACKSPACE"] = 177,
  ["TAB"] = 37,
  ["Q"] = 44,
  ["W"] = 32,
  ["E"] = 38,
  ["R"] = 45,
  ["T"] = 245,
  ["Y"] = 246,
  ["U"] = 303,
  ["P"] = 199,
  ["["] = 39,
  ["]"] = 40,
  ["ENTER"] = 18,
  ["CAPS"] = 137,
  ["A"] = 34,
  ["S"] = 8,
  ["D"] = 9,
  ["F"] = 23,
  ["G"] = 47,
  ["H"] = 74,
  ["K"] = 311,
  ["L"] = 182,
  ["LEFTSHIFT"] = 21,
  ["Z"] = 20,
  ["X"] = 73,
  ["C"] = 26,
  ["V"] = 0,
  ["B"] = 29,
  ["N"] = 249,
  ["M"] = 244,
  [","] = 82,
  ["."] = 81,
  ["LEFTCTRL"] = 36,
  ["LEFTALT"] = 19,
  ["SPACE"] = 22,
  ["RIGHTCTRL"] = 70,
  ["HOME"] = 213,
  ["PAGEUP"] = 10,
  ["PAGEDOWN"] = 11,
  ["DELETE"] = 178,
  ["LEFT"] = 174,
  ["RIGHT"] = 175,
  ["TOP"] = 27,
  ["DOWN"] = 173,
  ["NENTER"] = 201,
  ["N4"] = 108,
  ["N5"] = 60,
  ["N6"] = 107,
  ["N+"] = 96,
  ["N-"] = 97,
  ["N7"] = 117,
  ["N8"] = 61,
  ["N9"] = 118
}

function getKeyCode(key)
  return Keys[key]
end

-- Remove Emo

local function lookupify(t)
  local r = {}
  for _, v in pairs(t) do
    r[v] = true
  end
  return r
end

local blockedRanges = {
  {0x0001F601, 0x0001F64F},
  {0x00002702, 0x000027B0},
  {0x0001F680, 0x0001F6C0},
  --{0x000024C2, 0x0001F251},
  {0x0001F300, 0x0001F5FF},
  {0x00002194, 0x00002199},
  {0x000023E9, 0x000023F3},
  {0x000025FB, 0x000026FD},
  {0x0001F300, 0x0001F5FF},
  {0x0001F600, 0x0001F636},
  {0x0001F681, 0x0001F6C5},
  {0x0001F30D, 0x0001F567}
}

local blockedSingles =
  lookupify {
  0x000000A9,
  0x000000AE,
  0x0000203C,
  0x00002049,
  0x000020E3,
  0x00002122,
  0x00002139,
  0x000021A9,
  0x000021AA,
  0x0000231A,
  0x0000231B,
  0x000025AA,
  0x000025AB,
  0x000025B6,
  0x000025C0,
  0x00002934,
  0x00002935,
  0x00002B05,
  0x00002B06,
  0x00002B07,
  0x00002B1B,
  0x00002B1C,
  0x00002B50,
  0x00002B55,
  0x00003030,
  0x0000303D,
  0x00003297,
  0x00003299,
  0x0001F004,
  0x0001F0CF,
  0x0001F985
}

function removeEmoji(str)
  local codepoints = {}
  for _, codepoint in utf8.codes(str) do
    local insert = true
    if blockedSingles[codepoint] then
      insert = false
    else
      for _, range in ipairs(blockedRanges) do
        if range[1] <= codepoint and codepoint <= range[2] then
          insert = false
          break
        end
      end
    end
    if insert then
      table.insert(codepoints, codepoint)
    end
  end
  return utf8.char(table.unpack(codepoints))
end
