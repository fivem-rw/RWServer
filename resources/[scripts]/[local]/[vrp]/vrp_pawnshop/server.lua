---------------------------------------------------------
-------------- VRP Pawnshop, RealWorld MAC --------------
-------------- https://discord.gg/realw -----------------
---------------------------------------------------------

local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "omni_self_storage")

math.randomseed(os.time())
local rand = math.random(1, 100000)
MySQL.createCommand("vRP/pawnshop_sellAllItems" .. rand, "SELECT * FROM vrp_srv_data WHERE dkey = @dkey")
MySQL.createCommand("vRP/pawnshop_clearAllItems" .. rand, "delete FROM vrp_srv_data WHERE dkey = @dkey")

local CHESTS = {}
local CHESTS_OCCUPIED = {}

function notify(player, msg, type, timer)
    TriggerClientEvent(
        "pNotify:SendNotification",
        player,
        {
            text = msg,
            type = type or "success",
            timeout = timer or 3000,
            layout = "centerleft",
            queue = "global"
        }
    )
end

function getItemValue(idname)
    for k, v in pairs(itemValue2) do
        local f = string.find(idname, k)
        if f ~= nil then
            return v
        end
    end
    local value = itemValue[idname]
    if value ~= nil then
        return value
    end
    return nil
end

local function build_itemlist_menu(name, items, cb)
    local menu = {name = name, css = {top = "75px", header_color = "rgba(0,255,125,0.75)"}}

    local kitems = {}

    -- choice callback
    local choose = function(player, choice)
        local idname = kitems[choice]
        if idname then
            cb(idname)
        end
    end

    -- add each item to the menu
    for k, v in pairs(items) do
        local name, description, weight = vRP.getItemDefinition({k})
        if name ~= nil then
            kitems[name] = k -- reference item by display name
            menu[name] = {choose, lang.inventory.iteminfo({v.amount, description, string.format("%.2f", weight)})}
        end
    end

    return menu
end

local function chest_create(player, x, y, z, name, size, title, fee, permissions, area)
    local user_id = vRP.getUserId({player})
    if user_id == nil then
        return
    end
    local chestName = "pawnshop:" .. name .. ":" .. user_id
    local permissions = permissions or {}

    local nid = "area:" .. chestName
    if area ~= nil then
        nid = nid .. ":" .. area
    end

    local check_chest_in = function(idname, amount)
        local value = getItemValue(idname)
        if value == nil then
            return false
        end
        local getAmount = value[3] * amount
        local cost = parseInt(getAmount / 100 * fee)
        if getAmount <= 0 then
            return false
        end
        return true
    end

    local check_chest_out = function(idname, amount)
        local money = vRP.getMoney({user_id})
        local value = getItemValue(idname)
        if value == nil then
            return false
        end
        local getAmount = value[3] * amount
        local cost = parseInt(getAmount / 100 * fee)
        if getAmount <= 0 then
            return false
        end
        if money < getAmount + cost then
            local lowMoney = (getAmount + cost) - money
            notify(player, "상환금액 부족<br>상환할 금액: " .. format_num(getAmount) .. "원<br>수수료: " .. format_num(cost) .. "원<br><span style='color:yellow'>부족한 금액: " .. format_num(lowMoney) .. "원</span>", "error")
            return false
        end
        return true
    end

    local chest_in = function(idname, amount)
        if idname == nil then
            notify(player, "물건을 맡길 수 없습니다.", "error")
            return
        end
        local weight = vRP.getItemWeight({idname})
        local value = getItemValue(idname)
        if value == nil then
            return false
        end
        local getAmount = value[2] * amount
        local cost = parseInt(getAmount / 100 * fee)
        if getAmount > 0 then
            vRP.giveMoney({user_id, getAmount})
            vRP.tryPayment({user_id, cost})
            notify(player, "물건을 맡겼습니다.<br><span style='color:yellow'>빌린금액: " .. format_num(getAmount) .. "원</span><br>수수료: " .. format_num(cost) .. "원", "success", 5000)
        end
    end

    local chest_out = function(idname, amount)
        if idname == nil then
            notify(player, "물건을 찾을 수 없습니다.", "error")
            return
        end
        local weight = vRP.getItemWeight({idname})
        local value = getItemValue(idname)
        if value == nil then
            return false
        end
        local getAmount = value[3] * amount
        local cost = parseInt(getAmount / 100 * fee)
        if getAmount > 0 and vRP.tryPayment({user_id, getAmount + cost}) then
            notify(player, "물건을 찾았습니다.<br><span style='color:red'>상환금액: " .. format_num(getAmount) .. "원</span><br>수수료: " .. format_num(cost) .. "원", "success", 5000)
        else
            notify(player, "물건을 찾을 수 없습니다.", "error")
        end
    end

    local chest_enter = function(player, area)
        local menudata = {}
        menudata.name = title
        menudata["**물건 맡기기/찾기"] = {
            function(player)
                vRP.openChest(
                    {
                        player,
                        chestName,
                        size * 10.0,
                        function()
                        end,
                        chest_in,
                        chest_out,
                        check_chest_in,
                        check_chest_out
                    }
                )
            end,
            "전당포에 물건을 맡기거나 찾습니다."
        }

        menudata["*맡긴물건 처분"] = {
            function(player)
                sellAllItems(player, chestName, fee)
            end,
            "전당포에 맡긴물건을 처분합니다."
        }

        vRP.openMenu({player, menudata})
    end

    local chest_leave = function(player, area)
        vRP.closeMenu({player})
    end
    if not CHESTS[player] then
        CHESTS[player] = {}
    end
    CHESTS[player][name] = {nid, chest_enter, chest_leave}
end

function sellAllItems(player, chestName, fee)
    local player = player
    local user_id = vRP.getUserId({player})
    if user_id == nil then
        return
    end
    vRP.prompt(
        {
            player,
            "전당포에 맡긴 모든 물건을 처분합니다. 처분후에는 복원이 불가능합니다. 처분하려면 '확인' 이라고 입력해주세요.",
            "",
            function(player, value)
                if value == "확인" then
                    MySQL.query(
                        "vRP/pawnshop_sellAllItems" .. rand,
                        {dkey = "chest:" .. chestName},
                        function(rows, affected)
                            local totalSellAmount = 0
                            local cost = 0
                            if #rows > 0 and rows[1] then
                                local arrItems = json.decode(rows[1].dvalue)
                                for idname, v in pairs(arrItems) do
                                    local amount = v.amount
                                    if amount > 0 then
                                        local value = getItemValue(idname)
                                        if value ~= nil then
                                            totalSellAmount = totalSellAmount + ((value[1] - value[2]) * amount)
                                        end
                                    end
                                end
                            end
                            if totalSellAmount > 0 then
                                cost = parseInt(totalSellAmount / 100 * fee)
                                MySQL.execute(
                                    "vRP/pawnshop_clearAllItems" .. rand,
                                    {dkey = "chest:" .. chestName},
                                    function()
                                        vRP.giveMoney({user_id, totalSellAmount})
                                        vRP.giveMoney({user_id, -cost})
                                        notify(player, "물건을 모두 처분했습니다.<br><span style='color:yellow'>받은금액: " .. format_num(totalSellAmount) .. "원</span><br>수수료: " .. format_num(cost) .. "원", "success", 5000)
                                    end
                                )
                            else
                                notify(player, "처분할 물건이 없습니다.", "warning")
                            end
                        end
                    )
                else
                    notify(player, "처분이 취소되었습니다.", "warning")
                end
            end
        }
    )
end

AddEventHandler(
    "pawnshop:add",
    function(source, data)
        chest_create(source, data.pos.x, data.pos.y, data.pos.z, data.id, data.size, data.name, data.fee, data.permissions, data.area)
        TriggerClientEvent("pawnshop:add", source, data)
    end
)

RegisterServerEvent("pawnshop:open")
AddEventHandler(
    "pawnshop:open",
    function(name)
        if CHESTS[source] then
            if CHESTS[source][name] then
                CHESTS[source][name][2](source)
            end
        end
    end
)

function make_chests(source)
    for storageId, storageData in next, locations do
        for _, coords in next, storageData.storage_locations do
            chest_create(source, coords[1], coords[2], coords[3], storageId, storageData.size, storageData.name, storageData.fee, storageData.permissions, coords.area)
        end
    end
end

Citizen.CreateThread(
    function()
        local users = vRP.getUsers({})
        for user_id, player in next, users do
            make_chests(player)
        end
    end
)

AddEventHandler(
    "vRP:playerSpawn",
    function(user_id, source, first_spawn)
        if first_spawn then
            make_chests(source)
        end
    end
)

Citizen.CreateThread(
	function()
		Citizen.Wait(1000)
		TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, "^*^1[알림] ^3전당포가 시작되었습니다!!")
	end
)