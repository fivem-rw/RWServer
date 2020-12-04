local m = {} -- <<< Don't touch this!
-----------[ SETTINGS ]---------------------------------------------------

-- Delay in minutes between messages
m.delay = 2

-- Prefix appears in front of each message. 
-- Suffix appears on the end of each message.
-- Leave a prefix/suffix empty ( '' ) to disable them.
m.prefix = '^9^*[팁] '
m.suffix = ''

-- You can make as many messages as you want.
-- You can use ^0-^9 in your messages to change text color.
m.messages = {
	'^8RP와 관련없는 대화, 질문은 /ooc 할말 로 해주세요!',
	'^6리얼월드 디스코드 주소 https://discord.gg/realw',
	'^5상대에게 귓속말은 /w 고유번호 할말 로 할 수 있습니다!',
	'^4게임 내 음성 채팅 활성화 및 서버 디스코드 가입은 필수입니다! https://discord.gg/realw',
	'^3경찰, 메딕, 총리부 등의 공무원은 디스코드에서 모집 공고를 보고 지원해주세요. https://discord.gg/realw',
	'^2시청에서 운전면허증은 발급 받으셨나요? 무면허로 운전할 시 처벌 받을 수 있습니다!',
	'^1신분증(주민등록증)은 꼭 발급해주세요. 발급은 시청에서 가능합니다!',
	'^8자세한 업데이트 내용 및 규칙은 디스코드에 있습니다! https://discord.gg/realw',
	'^6누군가에게 범죄를 당하셨나요? 신고는 핸드폰으로 해주세요! K → 전화 → 서비스 → 112긴급',
	'^5계속 체력이 줄어드나요? 마트에서 음식과 음료를 구매해서 사용하세요!',
}

-- Player identifiers on this list will not receive any messages.
-- Simply remove all identifiers if you don't want an ignore list.
m.ignorelist = { 
    'ip:127.0.1.5',
    'steam:123456789123456',
    'license:1654687313215747944131321',
}
--------------------------------------------------------------------------


















-----[ CODE, DON'T TOUCH THIS ]-------------------------------------------
local playerIdentifiers
local enableMessages = true
local timeout = m.delay * 1000 * 60 -- from ms, to sec, to min
local playerOnIgnoreList = false
RegisterNetEvent('va:setPlayerIdentifiers')
AddEventHandler('va:setPlayerIdentifiers', function(identifiers)
    playerIdentifiers = identifiers
end)
Citizen.CreateThread(function()
    while playerIdentifiers == {} or playerIdentifiers == nil do
        Citizen.Wait(1000)
        TriggerServerEvent('va:getPlayerIdentifiers')
    end
    for iid in pairs(m.ignorelist) do
        for pid in pairs(playerIdentifiers) do
            if m.ignorelist[iid] == playerIdentifiers[pid] then
                playerOnIgnoreList = true
                break
            end
        end
    end
    if not playerOnIgnoreList then
        while true do
            for i in pairs(m.messages) do
                if enableMessages then
                    chat(i)
                    print('[vAnnouncer] Message #' .. i .. ' sent.')
                end
                Citizen.Wait(timeout)
            end
            
            Citizen.Wait(0)
        end
    else
        print('[vAnnouncer] Player is on ignorelist, no announcements will be received.')
    end
end)
function chat(i)
    TriggerEvent('chatMessage', '', {255,255,255}, m.prefix .. m.messages[i] .. m.suffix)
end
RegisterCommand('automessage', function()
    enableMessages = not enableMessages
    if enableMessages then
        status = '^2enabled^5.'
    else
        status = '^1disabled^5.'
    end
    TriggerEvent('chatMessage', '', {255, 255, 255}, '^5[vAnnouncer] automessages are now ' .. status)
end, false)
--------------------------------------------------------------------------
