local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "omni_self_storage")

local CHESTS = {}
local CHESTS_OCCUPIED = {}

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
    local chestName = "item_packer:" .. name .. ":chest"
    local permissions = permissions or {}

    local nid = "area:" .. chestName
    if area ~= nil then
        nid = nid .. ":" .. area
    end

    local chest_put = function(idname, amount)
        local weight = vRP.getItemWeight({idname})
        local cost = amount * fee
        if weight > 0.0 then
            if fee > 0.0 then
                if vRP.tryGetInventoryItem({user_id, "storage_card", 1, false}) then
                    vRPclient.notify(player, {("~y~저장 카드~w~를 사용하여 저장하였습니다."):format(ReadableNumber(cost, 2))})
                else
                    vRP.giveMoney({user_id, -cost})
                    vRPclient.notify(player, {("~y~창고 요금 : ~g~$%s ~w~(~y~x%i~w~)"):format(ReadableNumber(cost, 2), amount)})
                end
            end
        end
    end

    local chest_enter = function(player, area)
        local allowed = false
        local user_id = vRP.getUserId({player})
        if user_id then
            if not vRP.hasPermission({user_id, "omni.storage_override"}) and #permissions > 0 then
                for _, perm in next, permissions do
                    if vRP.hasPermission({user_id, perm}) then
                        allowed = true
                    end
                end
            else
                allowed = true
            end
            if allowed then
                local menudata = {}
                menudata.name = title

                menudata["**포장 시작"] = {
                    function(player)
                        vRP.openChest(
                            {
                                player,
                                chestName,
                                size * 10.0,
                                function()
                                end,
                                chest_put,
                                function()
                                end,
                                title
                            }
                        )
                    end,
                    "포장 기계를 작동 합니다."
                }

                menudata["*포장 완료"] = {
                    function(player)
                    end,
                    "포장 기계에 있는 아이템을 포장합니다."
                }

                menudata["재 포장"] = {
                    function(player)
                        local menu = {
                            name = lang.inventory.chest.title(),
                            css = {top = "75px", header_color = "rgba(0,255,125,0.75)"}
                        }
                        vRP.openMenu({source, menu})
                    end,
                    "이미 포장된 아이템박스를 다시 포장합니다.."
                }

                vRP.openMenu({player, menudata})
            else
                vRPclient.notify(player, {"~r~[실패]~w~해당 포장기계는 이용할 수 없습니다."})
            end
        end
    end

    local chest_leave = function(player, area)
        vRP.closeMenu({player})
    end
    -- vRP.setArea({player, nid, x, y, z, 2, 4.5, chest_enter, chest_leave})
    if not CHESTS[player] then
        CHESTS[player] = {}
    end
    CHESTS[player][name] = {nid, chest_enter, chest_leave}
end

AddEventHandler(
    "item_packer:add",
    function(source, data)
        chest_create(source, data.pos.x, data.pos.y, data.pos.z, data.id, data.size, data.name, data.fee, data.permissions, data.area)
        TriggerClientEvent("item_packer:add", source, data)
    end
)

RegisterServerEvent("item_packer:open")
AddEventHandler(
    "item_packer:open",
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
            chest_create(source, coords.x, coords.y, coords.z, storageId, storageData.size, storageData.name, storageData.fee, storageData.permissions, coords.area)
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
