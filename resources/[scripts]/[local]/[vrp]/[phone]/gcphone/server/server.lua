local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("lib/htmlEntities")

gcphoneS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "gcphone")
gcphoneC = Tunnel.getInterface("gcphone", "gcphone")
Tunnel.bindInterface("gcphone", gcphoneS)

math.randomseed(os.time())

function gcphoneS.prompt(title, content)
    local player = source
    local text = ""
    vRP.prompt(
        {
            player,
            title or "",
            content or "",
            function(player, text)
                gcphoneC.promptResult(player, {text})
            end
        }
    )
end

draCB.RegisterServerCallback(
    "gcPhone:hasPhone",
    function(source, cb, data)
        local user_id = vRP.getUserId({source})
        if vRP.getInventoryItemAmount({user_id, "aphone"}) > 0 then
            cb(true)
        else
            cb(false)
        end
    end
)

function getPhoneRandomNumber()
    return "0" .. math.random(600000000, 699999999)
end

--====================================================================================
--  Utils
--====================================================================================
function getSourceFromIdentifier(identifier, cb)
    return vRP.getUserSource({identifier})
end
function getNumberPhone(identifier)
    local result =
        MySQL.Sync.fetchAll(
        "SELECT vrp_user_identities.phone FROM vrp_user_identities WHERE vrp_user_identities.user_id = @identifier",
        {
            ["@identifier"] = identifier
        }
    )
    if result[1] ~= nil then
        return result[1].phone
    end
    return nil
end
function getIdentifierByPhoneNumber(phone_number)
    local result =
        MySQL.Sync.fetchAll(
        "SELECT vrp_user_identities.user_id FROM vrp_user_identities WHERE vrp_user_identities.phone = @phone_number",
        {
            ["@phone_number"] = phone_number
        }
    )
    if result[1] ~= nil then
        return result[1].user_id
    end
    return nil
end

function getPlayerID(source)
    local player = vRP.getUserId({source})
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function getOrGeneratePhoneNumber(sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getNumberPhone(identifier)
    if myPhoneNumber == "0" or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        MySQL.Async.insert(
            "UPDATE vrp_user_identities SET phone = @myPhoneNumber WHERE user_id = @identifier",
            {
                ["@myPhoneNumber"] = myPhoneNumber,
                ["@identifier"] = identifier
            },
            function()
                cb(myPhoneNumber)
            end
        )
    else
        cb(myPhoneNumber)
    end
end
--====================================================================================
--  Contacts
--====================================================================================
function getContacts(identifier)
    local result =
        MySQL.Sync.fetchAll(
        "SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier",
        {
            ["@identifier"] = identifier
        }
    )
    return result
end
function addContact(source, identifier, number, display)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert(
        "INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)",
        {
            ["@identifier"] = identifier,
            ["@number"] = number,
            ["@display"] = display
        },
        function()
            notifyContactChange(sourcePlayer, identifier)
        end
    )
end
function updateContact(source, identifier, id, number, display)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert(
        "UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id",
        {
            ["@number"] = number,
            ["@display"] = display,
            ["@id"] = id
        },
        function()
            notifyContactChange(sourcePlayer, identifier)
        end
    )
end
function deleteContact(source, identifier, id)
    local sourcePlayer = tonumber(source)
    MySQL.Sync.execute(
        "DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id",
        {
            ["@identifier"] = identifier,
            ["@id"] = id
        }
    )
    notifyContactChange(sourcePlayer, identifier)
end
function deleteAllContact(identifier)
    MySQL.Sync.execute(
        "DELETE FROM phone_users_contacts WHERE `identifier` = @identifier",
        {
            ["@identifier"] = identifier
        }
    )
end
function notifyContactChange(source, identifier)
    local sourcePlayer = tonumber(source)
    local identifier = identifier
    if sourcePlayer ~= nil then
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
    end
end

RegisterServerEvent("gcPhone:addContact")
AddEventHandler(
    "gcPhone:addContact",
    function(display, phoneNumber)
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        addContact(sourcePlayer, identifier, phoneNumber, display)
    end
)

RegisterServerEvent("gcPhone:updateContact")
AddEventHandler(
    "gcPhone:updateContact",
    function(id, display, phoneNumber)
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        updateContact(sourcePlayer, identifier, id, phoneNumber, display)
    end
)

RegisterServerEvent("gcPhone:deleteContact")
AddEventHandler(
    "gcPhone:deleteContact",
    function(id)
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        deleteContact(sourcePlayer, identifier, id)
    end
)

--====================================================================================
--  Messages
--====================================================================================
function getMessages(identifier)
    local result =
        MySQL.Sync.fetchAll(
        "SELECT phone_messages.* FROM phone_messages LEFT JOIN vrp_user_identities ON vrp_user_identities.user_id = @identifier WHERE phone_messages.receiver = vrp_user_identities.phone",
        {
            ["@identifier"] = identifier
        }
    )
    return result
    --return MySQLQueryTimeStamp("SELECT phone_messages.* FROM phone_messages LEFT JOIN users ON users.identifier = @identifier WHERE phone_messages.receiver = users.phone_number", {['@identifier'] = identifier})
end

RegisterServerEvent("gcPhone:_internalAddMessage")
AddEventHandler(
    "gcPhone:_internalAddMessage",
    function(transmitter, receiver, message, owner, cb)
        cb(_internalAddMessage(transmitter, receiver, message, owner))
    end
)

function _internalAddMessage(transmitter, receiver, message, owner)
    local Query = "INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`) VALUES(@transmitter, @receiver, @message, @isRead, @owner);"
    local Query2 = "SELECT * from phone_messages WHERE `id` = @id;"
    local Parameters = {
        ["@transmitter"] = transmitter,
        ["@receiver"] = receiver,
        ["@message"] = message,
        ["@isRead"] = owner,
        ["@owner"] = owner
    }
    local id = MySQL.Sync.insert(Query, Parameters)
    return MySQL.Sync.fetchAll(
        Query2,
        {
            ["@id"] = id
        }
    )[1]
end

function addMessage(source, identifier, phone_number, message)
    local sourcePlayer = tonumber(source)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getNumberPhone(identifier)
    if otherIdentifier ~= nil and vRP.getUserSource({otherIdentifier}) ~= nil then
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0)
        TriggerClientEvent("gcPhone:receiveMessage", tonumber(vRP.getUserSource({otherIdentifier})), tomess)
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1)
    TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
end

function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute(
        "UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter",
        {
            ["@receiver"] = mePhoneNumber,
            ["@transmitter"] = num
        }
    )
end

function deleteMessage(msgId)
    MySQL.Sync.execute(
        "DELETE FROM phone_messages WHERE `id` = @id",
        {
            ["@id"] = msgId
        }
    )
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {["@mePhoneNumber"] = mePhoneNumber, ["@phone_number"] = phone_number})
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getNumberPhone(identifier)
    MySQL.Sync.execute(
        "DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber",
        {
            ["@mePhoneNumber"] = mePhoneNumber
        }
    )
end

RegisterServerEvent("gcPhone:sendMessage")
AddEventHandler(
    "gcPhone:sendMessage",
    function(phoneNumber, message)
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        addMessage(sourcePlayer, identifier, phoneNumber, message)
    end
)

RegisterServerEvent("gcPhone:deleteMessage")
AddEventHandler(
    "gcPhone:deleteMessage",
    function(msgId)
        deleteMessage(msgId)
    end
)

RegisterServerEvent("gcPhone:deleteMessageNumber")
AddEventHandler(
    "gcPhone:deleteMessageNumber",
    function(number)
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        deleteAllMessageFromPhoneNumber(sourcePlayer, identifier, number)
        -- TriggerClientEvent("gcphone:allMessage", sourcePlayer, getMessages(identifier))
    end
)

RegisterServerEvent("gcPhone:deleteAllMessage")
AddEventHandler(
    "gcPhone:deleteAllMessage",
    function()
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        deleteAllMessage(identifier)
    end
)

RegisterServerEvent("gcPhone:setReadMessageNumber")
AddEventHandler(
    "gcPhone:setReadMessageNumber",
    function(num)
        local identifier = getPlayerID(source)
        setReadMessageNumber(identifier, num)
    end
)

RegisterServerEvent("gcPhone:deleteALL")
AddEventHandler(
    "gcPhone:deleteALL",
    function()
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        deleteAllMessage(identifier)
        deleteAllContact(identifier)
        appelsDeleteAllHistorique(identifier)
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, {})
        TriggerClientEvent("gcPhone:allMessage", sourcePlayer, {})
        TriggerClientEvent("appelsDeleteAllHistorique", sourcePlayer, {})
    end
)

AddEventHandler(
    "gcPhone:deleteALLvRPIdentity",
    function(src, user_id, num)
        deleteAllMessage(user_id)
        deleteAllContact(user_id)
        appelsDeleteAllHistorique(user_id)
        TriggerClientEvent("gcPhone:contactList", src, {})
        TriggerClientEvent("gcPhone:allMessage", src, {})
        TriggerClientEvent("appelsDeleteAllHistorique", src, {})
        TriggerClientEvent("gcPhone:myPhoneNumber", src, num) -- update phonenumber
    end
)

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall(num)
    local result =
        MySQL.Sync.fetchAll(
        "SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120",
        {
            ["@num"] = num
        }
    )
    return result
end

function sendHistoriqueCall(src, num)
    local histo = getHistoriqueCall(num)
    TriggerClientEvent("gcPhone:historiqueCall", src, histo)
end

function saveAppels(appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        MySQL.Async.insert(
            "INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)",
            {
                ["@owner"] = appelInfo.transmitter_num,
                ["@num"] = appelInfo.receiver_num,
                ["@incoming"] = 1,
                ["@accepts"] = appelInfo.is_accepts
            },
            function()
                notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
            end
        )
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "###-####"
        end
        MySQL.Async.insert(
            "INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)",
            {
                ["@owner"] = appelInfo.receiver_num,
                ["@num"] = num,
                ["@incoming"] = 0,
                ["@accepts"] = appelInfo.is_accepts
            },
            function()
                if appelInfo.receiver_src ~= nil then
                    notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
                end
            end
        )
    end
end

function notifyNewAppelsHisto(src, num)
    sendHistoriqueCall(src, num)
end

RegisterServerEvent("gcPhone:getHistoriqueCall")
AddEventHandler(
    "gcPhone:getHistoriqueCall",
    function()
        local sourcePlayer = tonumber(source)
        local srcIdentifier = getPlayerID(source)
        local srcPhone = getNumberPhone(srcIdentifier)
        sendHistoriqueCall(sourcePlayer, num)
    end
)

RegisterServerEvent("gcPhone:internal_startCall")
AddEventHandler(
    "gcPhone:internal_startCall",
    function(source, phone_number, rtcOffer, extraData)
        if FixePhone[phone_number] ~= nil then
            onCallFixePhone(source, phone_number, rtcOffer, extraData)
            return
        end

        local rtcOffer = rtcOffer
        if phone_number == nil or phone_number == "" then
            print("BAD CALL NUMBER IS NIL")
            return
        end

        local hidden = string.sub(phone_number, 1, 1) == "#"
        if hidden == true then
            phone_number = string.sub(phone_number, 2)
        end

        local indexCall = lastIndexCall
        lastIndexCall = lastIndexCall + 1

        local sourcePlayer = tonumber(source)
        local srcIdentifier = getPlayerID(source)

        local srcPhone = ""
        if extraData ~= nil and extraData.useNumber ~= nil then
            srcPhone = extraData.useNumber
        else
            srcPhone = getNumberPhone(srcIdentifier)
        end
        local destPlayer = getIdentifierByPhoneNumber(phone_number)
        local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
        AppelsEnCours[indexCall] = {
            id = indexCall,
            transmitter_src = sourcePlayer,
            transmitter_num = srcPhone,
            receiver_src = nil,
            receiver_num = phone_number,
            is_valid = destPlayer ~= nil,
            is_accepts = false,
            hidden = hidden,
            rtcOffer = rtcOffer,
            extraData = extraData
        }

        if is_valid == true then
            -- getSourceFromIdentifier(destPlayer, function (srcTo)
            if vRP.getUserSource({destPlayer}) ~= nil then
                srcTo = tonumber(vRP.getUserSource({destPlayer}))

                if srcTo ~= nil then
                    AppelsEnCours[indexCall].receiver_src = srcTo
                    -- TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                    TriggerClientEvent("gcPhone:waitingCall", sourcePlayer, AppelsEnCours[indexCall], true)
                    TriggerClientEvent("gcPhone:waitingCall", srcTo, AppelsEnCours[indexCall], false)
                else
                    -- TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                    TriggerClientEvent("gcPhone:waitingCall", sourcePlayer, AppelsEnCours[indexCall], true)
                end
            end
        else
            TriggerEvent("gcPhone:addCall", AppelsEnCours[indexCall])
            TriggerClientEvent("gcPhone:waitingCall", sourcePlayer, AppelsEnCours[indexCall], true)
        end
    end
)

Citizen.CreateThread(
    function()
        if false then
            Citizen.Wait(2000)
            AppelsEnCours[10] = {
                id = 10,
                transmitter_src = 1,
                transmitter_num = "1",
                receiver_src = 1,
                receiver_num = "1",
                is_valid = true,
                is_accepts = false,
                hidden = false,
                rtcOffer = false,
                extraData = {}
            }
            TriggerClientEvent("gcPhone:waitingCall", 1, AppelsEnCours[10], false)
        end
    end
)

RegisterServerEvent("gcPhone:startCall")
AddEventHandler(
    "gcPhone:startCall",
    function(phone_number, rtcOffer, extraData)
        TriggerEvent("gcPhone:internal_startCall", source, phone_number, rtcOffer, extraData)
    end
)

RegisterServerEvent("gcPhone:candidates")
AddEventHandler(
    "gcPhone:candidates",
    function(callId, candidates)
        if callId ~= nil and AppelsEnCours[callId] ~= nil then
            local source = source
            local to = AppelsEnCours[callId].transmitter_src
            if source == to then
                to = AppelsEnCours[callId].receiver_src
            end
            TriggerClientEvent("gcPhone:candidates", to, candidates)
        end
    end
)

RegisterServerEvent("gcPhone:acceptCall")
AddEventHandler(
    "gcPhone:acceptCall",
    function(infoCall, rtcAnswer)
        local id = infoCall.id
        if id ~= nil and AppelsEnCours[id] ~= nil then
            if PhoneFixeInfo[id] ~= nil then
                onAcceptFixePhone(source, infoCall, rtcAnswer)
                return
            end
            AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
            if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
                AppelsEnCours[id].is_accepts = true
                AppelsEnCours[id].rtcAnswer = rtcAnswer
                TriggerClientEvent("gcPhone:acceptCall", AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
                SetTimeout(
                    1000,
                    function()
                        -- change to +1000, if necessary.
                        TriggerClientEvent("gcPhone:acceptCall", AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
                    end
                )
                saveAppels(AppelsEnCours[id])
            end
        end
    end
)

RegisterServerEvent("gcPhone:rejectCall")
AddEventHandler(
    "gcPhone:rejectCall",
    function(infoCall)
        local id = infoCall.id
        if id ~= nil and AppelsEnCours[id] ~= nil then
            if PhoneFixeInfo[id] ~= nil then
                onRejectFixePhone(source, infoCall)
                return
            end
            if AppelsEnCours[id].transmitter_src ~= nil then
                TriggerClientEvent("gcPhone:rejectCall", AppelsEnCours[id].transmitter_src)
            end
            if AppelsEnCours[id].receiver_src ~= nil then
                TriggerClientEvent("gcPhone:rejectCall", AppelsEnCours[id].receiver_src)
            end

            if AppelsEnCours[id].is_accepts == false then
                saveAppels(AppelsEnCours[id])
            end
            TriggerEvent("gcPhone:removeCall", AppelsEnCours)
            AppelsEnCours[id] = nil
        end
    end
)

RegisterServerEvent("gcPhone:appelsDeleteHistorique")
AddEventHandler(
    "gcPhone:appelsDeleteHistorique",
    function(numero)
        local sourcePlayer = tonumber(source)
        local srcIdentifier = getPlayerID(source)
        local srcPhone = getNumberPhone(srcIdentifier)
        MySQL.Sync.execute(
            "DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num",
            {
                ["@owner"] = srcPhone,
                ["@num"] = numero
            }
        )
    end
)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getNumberPhone(srcIdentifier)
    MySQL.Sync.execute(
        "DELETE FROM phone_calls WHERE `owner` = @owner",
        {
            ["@owner"] = srcPhone
        }
    )
end

RegisterServerEvent("gcPhone:appelsDeleteAllHistorique")
AddEventHandler(
    "gcPhone:appelsDeleteAllHistorique",
    function()
        local sourcePlayer = tonumber(source)
        local srcIdentifier = getPlayerID(source)
        appelsDeleteAllHistorique(srcIdentifier)
    end
)

--====================================================================================
--  OnLoad
--====================================================================================
AddEventHandler(
    "vRP:playerSpawn",
    function(user_id, source, first_spawn)
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        getOrGeneratePhoneNumber(
            sourcePlayer,
            identifier,
            function(myPhoneNumber)
                TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, myPhoneNumber)
                TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
                TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
            end
        )
        local bankM = vRP.getBankMoney({user_id})
        TriggerClientEvent("gcphone:setAccountMoney", source, bankM)
    end
)

-- Just For reload
RegisterServerEvent("gcPhone:allUpdate")
AddEventHandler(
    "gcPhone:allUpdate",
    function()
        local sourcePlayer = tonumber(source)
        local identifier = getPlayerID(source)
        local num = getNumberPhone(identifier)
        TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, num)
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
        TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(identifier))
        TriggerClientEvent("gcPhone:getBourse", sourcePlayer, getBourse())
        sendHistoriqueCall(sourcePlayer, num)
    end
)

AddEventHandler(
    "onMySQLReady",
    function()
        -- MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
    end
)

--====================================================================================
--  App bourse
--====================================================================================
Citizen.CreateThread(
    function()
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        while true do
            Citizen.Wait(math.ceil(StockUpdateTime * hour))
            TriggerEvent("gcPhone:GeneratePrices")
        end
    end
)

function getBourse()
    name = {}
    price = {}
    middle = {}
    difference = {}

    local result = MySQL.Sync.fetchAll("SELECT * FROM phone_stocks", {})

    -- local qnt = #result
    -- for i=1, qnt, 1 do
    --     name[i] = result[i].Label
    --     price[i] = result[i].Current
    --     middle[i] = result[i].Med

    --     difference[i] = price[i] - middle[i]
    -- end

    local stocks = {}

    for k, v in pairs(result) do
        local difference = v.Current - v.Med
        table.insert(stocks, {libelle = v.Label, price = v.Current, difference = difference})
    end
    -- for i=1, qnt, 1 do
    --     local line = {libelle = name[i], price = price[i], difference = difference[i]}
    --     table.insert(stocks, line)
    -- end
    return stocks
end

-- RegisterServerEvent('gcPhone:GeneratePrices')
AddEventHandler(
    "gcPhone:GeneratePrices",
    function()
        MySQL.Async.fetchAll(
            "SELECT * FROM phone_stocks",
            {},
            function(result)
                for i = 1, #result, 1 do
                    local id = result[i].ID

                    local nome = result[i].Name
                    local attuale = result[i].Current
                    local min = result[i].Min
                    local max = result[i].Max
                    local med = result[i].Med

                    local med = ((min + max) / 2)

                    local rnd = math.random(min, max)

                    MySQL.Async.execute(
                        "UPDATE phone_stocks SET Current=@RND , Med=@MED WHERE ID=@ID",
                        {
                            ["@RND"] = rnd,
                            ["@MED"] = med,
                            ["@ID"] = id
                        }
                    )
                end
            end
        )

        local stocks = getBourse()
        TriggerClientEvent("gcPhone:getBourse", -1, stocks)
    end
)

draCB.RegisterServerCallback(
    "gcPhone:getStocks",
    function(source, name, cb)
        local Name = name
        MySQL.Async.fetchAll(
            "SELECT * FROM phone_stocks WHERE Name=@Name",
            {["@Name"] = Name},
            function(result)
                local stock = result[1].Current
                cb(stock)
            end
        )
    end
)

--====================================================================================
--  App ... WIP
--====================================================================================

-- SendNUIMessage('ongcPhoneRTC_receive_offer')
-- SendNUIMessage('ongcPhoneRTC_receive_answer')

-- RegisterNUICallback('gcPhoneRTC_send_offer', function (data)

-- end)

-- RegisterNUICallback('gcPhoneRTC_send_answer', function (data)

-- end)

function onCallFixePhone(source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == "#"
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ""
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getNumberPhone(srcIdentifier)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }

    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent("gcPhone:notifyFixePhoneChange", -1, PhoneFixeInfo)
    TriggerClientEvent("gcPhone:waitingCall", sourcePlayer, AppelsEnCours[indexCall], true)
end

function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id

    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src ~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent("gcPhone:notifyFixePhoneChange", -1, PhoneFixeInfo)
        TriggerClientEvent("gcPhone:acceptCall", AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
        SetTimeout(
            1000,
            function()
                -- change to +1000, if necessary.
                TriggerClientEvent("gcPhone:acceptCall", AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
            end
        )
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent("gcPhone:notifyFixePhoneChange", -1, PhoneFixeInfo)
    TriggerClientEvent("gcPhone:rejectCall", AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil
end

RegisterServerEvent("gcPhone:getBankMoney")
AddEventHandler(
    "gcPhone:getBankMoney",
    function()
        local player = source
        local user_id = vRP.getUserId({player})
        local bankM = vRP.getBankMoney({user_id})
        TriggerClientEvent("gcphone:setAccountMoney", player, bankM)
    end
)

function sendToDiscord_moneybank(color, name, message, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["url"] = "https://i.imgur.com/xGCgBw1.png",
            ["footer"] = {
                ["text"] = footer
            }
        }
    }
    PerformHttpRequest(
        "https://discordapp.com/api/webhooks/682652392852160521/IziK7O1lHkPZKXfwfjVfQrGhxkKTdSkleJVzb92Li7CbkjLQZf_ziaI_UGelXg0iK90-",
        function(err, text, headers)
        end,
        "POST",
        json.encode({embeds = embed}),
        {["Content-Type"] = "application/json"}
    )
end

RegisterServerEvent("gcPhone:moneyTransfer")
AddEventHandler(
    "gcPhone:moneyTransfer",
    function(num, amount)
        local source = source
        local result = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_identities WHERE phone = @Number", {["@Number"] = num})
        local nuser_id = nil
        if result and #result > 0 then
            nuser_id = tonumber(result[1].user_id)
        else
            vRPclient.notify(source, {"존재하지 않는 계좌번호 (" .. num .. ")"})
            return
        end

        local nplayer = vRP.getUserSource({nuser_id})
        if nplayer ~= nil then
            local user_id = vRP.getUserId({source})
            local player = vRP.getUserSource({user_id})

            local name = GetPlayerName(player)
            local target_name = GetPlayerName(nplayer)
            local target_id = nuser_id

            if tonumber(player) == tonumber(nplayer) then
                TriggerClientEvent("pNotify:SendNotification", player, {text = "자신에게는 송금할 수 없습니다.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                CancelEvent()
            else
                local rounded = math.floor(tonumber(amount))
                if rounded <= 0 then
                    TriggerClientEvent("pNotify:SendNotification", source, {text = "금액을 보낼 수 없습니다.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    CancelEvent()
                else
                    vRP.request(
                        {
                            player,
                            "이체 하시겠습니까?<br>금액: <strong>" .. format_num(rounded) .. "</strong>원 / 받는사람: " .. target_name .. "",
                            30,
                            function(player, ok)
                                if ok then
                                    local bankbalance = vRP.getBankMoney({user_id})
                                    local newbalance = bankbalance - rounded
                                    if (rounded <= bankbalance) then
                                        local bankbalance2 = vRP.getBankMoney({nuser_id})
                                        local newbalance2 = bankbalance2 + rounded

                                        local new_balance = bankbalance - rounded
                                        local new_balance2 = bankbalance2 + rounded

                                        vRP.setBankMoney({user_id, new_balance})
                                        vRP.setBankMoney({nuser_id, new_balance2})

                                        TriggerClientEvent("gcphone:setAccountMoney", player, new_balance)
                                        TriggerClientEvent("gcphone:setAccountMoney", nplayer, new_balance2)

                                        local transferAmount = format_num(rounded)

                                        sendToDiscord_moneybank(16711680, "계좌 이체 내역서", "보내는 사람 : " .. name .. "(" .. user_id .. "번)\n\n받는 사람 : " .. target_name .. "(" .. target_id .. "번)\n\n송금한 금액 : " .. transferAmount .. "원", os.date("송금일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록 시스템"))

                                        TriggerClientEvent(
                                            "pNotify:SendNotification",
                                            player,
                                            {
                                                text = "이체 완료<br>금액: <strong>" .. format_num(rounded) .. "</strong>원<br>받는사람: " .. target_name .. "",
                                                type = "success",
                                                timeout = 5000,
                                                layout = "centerLeft"
                                            }
                                        )
                                        TriggerClientEvent(
                                            "pNotify:SendNotification",
                                            nplayer,
                                            {
                                                text = "이체 받음<br>금액: <strong>" .. format_num(rounded) .. "</strong>원<br>보낸사람: " .. name .. "",
                                                type = "success",
                                                timeout = 5000,
                                                layout = "centerLeft"
                                            }
                                        )

                                        CancelEvent()
                                    else
                                        TriggerClientEvent("pNotify:SendNotification", player, {text = "잔액이 부족합니다.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                    end
                                else
                                    TriggerClientEvent("pNotify:SendNotification", player, {text = "이체가 취소되었습니다.", type = "error", queue = "global", timeout = 4000, layout = "centerLeft", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                end
                            end
                        }
                    )
                end
            end
        else
            TriggerClientEvent(
                "pNotify:SendNotification",
                nplayer,
                {
                    text = "해당 유저를 찾을 수 없습니다.",
                    type = "error",
                    timeout = 4000
                }
            )
        end
    end
)
