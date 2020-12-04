local isShowSQLLog = false

if MySQL == nil then
  MySQL = {}
end

MySQL.enable = true

MySQL.createCommand = function(name, query)
  if MySQL.commands == nil then
    MySQL.commands = {}
  end
  MySQL.commands[name] = query
end
MySQL.execute = function(name, params, callback)
  if not MySQL.enable then
    SetTimeout(
      1000,
      function()
        MySQL.execute(name, params, callback)
      end
    )
    return
  end
  if type(callback) ~= "function" then
    callback = function()
    end
  end
  if isShowSQLLog then
    print("ghmattimysql", name)
  end
  exports["ghmattimysql"]:execute(MySQL.commands[name] or "", params or {}, callback)
end
MySQL.query = function(name, params, callback)
  MySQL.execute(name, params, callback)
end

MySQL.Sync = {
  insert = function(sql, params)
    local r = exports["ghmattimysql"]:executeSync(sql or "", params or {})
    return r.insertId
  end,
  execute = function(sql, params)
    return exports["ghmattimysql"]:executeSync(sql or "", params or {})
  end,
  fetchAll = function(sql, params)
    return exports["ghmattimysql"]:executeSync(sql or "", params or {})
  end
}

MySQL.Async = {
  insert = function(sql, params, callback)
    exports["ghmattimysql"]:execute(
      sql or "",
      params or {},
      function(r)
        callback(r.insertId)
      end
    )
  end,
  execute = function(sql, params, callback)
    exports["ghmattimysql"]:execute(sql or "", params or {}, callback)
  end,
  fetchAll = function(sql, params, callback)
    exports["ghmattimysql"]:execute(sql or "", params or {}, callback)
  end
}

Citizen.CreateThread(
  function()
    while true do
      if GetConvar("isShowSQLLog", "false") == "true" then
        isShowSQLLog = true
      else
        isShowSQLLog = false
      end
      Citizen.Wait(5000)
    end
  end
)

Citizen.CreateThread(
  function()
    while true do
      --collectgarbage()
      --collectgarbage()
      Citizen.Wait(60000)
    end
  end
)
