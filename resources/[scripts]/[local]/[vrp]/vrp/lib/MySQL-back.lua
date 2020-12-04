MySQL.enable = false

MySQL.ready(
  function()
    MySQL.enable = true
  end
)

MySQL.createCommand = function(name, query)
  if MySQL.commands == nil then
    MySQL.commands = {}
  end
  MySQL.commands[name] = query
end
MySQL.query = function(name, params, callback)
  if not MySQL.enable then
    SetTimeout(
      1000,
      function()
        MySQL.query(name, params, callback)
      end
    )
    return
  end
  if type(callback) ~= "function" then
    callback = function()
    end
  end
  MySQL.Async.fetchAll(MySQL.commands[name] or "", params or {}, callback)
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
  MySQL.Async.execute(MySQL.commands[name] or "", params or {}, callback)
end
