AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/oocf" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "🌎 전체 O O C | " .. name, { 200, 200, 200 }, string.sub(msg,5))
	end
  if sm[1] == "/twitf" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "🔷 Twitter | " .. name .."님의 트윗 ", { 85, 172, 238 }, string.sub(msg,6))
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