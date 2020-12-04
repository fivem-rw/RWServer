AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	--[[if sm[1] == "/me" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "🕺 " .. name .."의 행동 ", { 255, 255, 255 }, string.sub(msg,5))
	end
  if sm[1] == "/st" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "🙍 " .. name .."의 상태 ", { 255, 255, 255 }, string.sub(msg,5))
	end
  if sm[1] == "/th" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "💡 " .. name .."의 생각 ", { 255, 255, 255 }, string.sub(msg,5))
	end]]--
  if sm[1] == "/adf" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "⭐" .. name .."님의 광고 ", { 255, 50, 50 }, string.sub(msg,5))
	end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end