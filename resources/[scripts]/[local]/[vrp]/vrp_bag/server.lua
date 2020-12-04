----------------- vRP Bag
----------------- FiveM RealWorld MAC (Modify)
----------------- https://discord.gg/realw

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_bag")

local cfgItems = module("vrp", "cfg/items")
local items = cfgItems.items
local cfgItemsDrugs = module("vrp_drugs", "cfg/drugs")
local itemsDrugs = cfgItemsDrugs.drugs

local markers_ids = Tools.newIDGenerator()
local itemss = {}

local customActionExecute = {}

vRP.defInventoryCustomAction()

function getImageName(id)
    for k, v in pairs(Config.duplicateImageName) do
        if string.find(id, k) ~= nil then
            return v
        end
    end
    return id
end

function init(user_id)
    local player = vRP.getUserSource({user_id})
    local data = vRP.getUserDataTable({user_id})
    if data and data.inventory then
        local inventory = {}
        for data_k, data_v in pairs(data.inventory) do
            local items_v = items[data_k]
            if not items_v then
                items_v = itemsDrugs[data_k]
            end
            local dataType = ""
            local dataContent = ""
            if not items_v then
                if string.find(data_k, "wbody|") then
                    items_v = items["wbody"]
                elseif string.find(data_k, "wammo|") then
                    items_v = items["wammo"]
                elseif string.find(data_k, "wdcard|") then
                    items_v = items["wdcard"]
                elseif string.find(data_k, "skinbox|") then
                    items_v = items["skinbox"]
                    dataType = data_v.type
                    if data_v.content then
                        dataContent = data_v.content[1]
                    end
                elseif string.find(data_k, "smaskbox|") then
                    items_v = items["smaskbox"]
                    dataType = data_v.type
                    if data_v.content then
                        dataContent = data_v.content[1]
                    end
                elseif string.find(data_k, "carbox|") then
                    items_v = items["carbox"]
                    dataType = data_v.type
                    if data_v.content then
                        dataContent = data_v.content[1]
                    end
                elseif string.find(data_k, "skinbox_random|") then
                    items_v = items["skinbox_random"]
                    dataType = data_v.type
                elseif string.find(data_k, "smaskbox_random|") then
                    items_v = items["smaskbox_random"]
                    dataType = data_v.type
                elseif string.find(data_k, "carbox_random|") then
                    items_v = items["carbox_random"]
                    dataType = data_v.type
                end
            end
            if items_v then
                local customAction = {}
                if customActionExecute[data_k] == nil then
                    customActionExecute[data_k] = {}
                end
                if items_v[3] ~= nil and type(items_v[3]) == "function" then
                    local actionList = items_v[3]({data_k})
                    for k, v in pairs(actionList) do
                        customActionExecute[data_k][k] = v[1]
                        table.insert(customAction, k)
                    end
                end

                local name, description, weight = vRP.getItemDefinition({data_k})
                if name then
                    table.insert(
                        inventory,
                        {
                            name = name,
                            description = description,
                            weight = weight,
                            amount = data_v.amount,
                            dataContent = dataContent,
                            idname = data_k,
                            icon = "nui://vrp_bag/html/assets/icons/" .. getImageName(data_k) .. ".png",
                            customAction = customAction
                        }
                    )
                end
            end
        end
        local weight = vRP.getInventoryWeight({user_id})
        local pesoMaximo = vRP.getInventoryMaxWeight({user_id})
        TriggerClientEvent("vrp_bag:atualizarInventario", player, inventory, parseInt(weight), parseInt(pesoMaximo))
    end
end

RegisterServerEvent("vrp_bag:openGui")
AddEventHandler(
    "vrp_bag:openGui",
    function()
        local player = source
        local user_id = vRP.getUserId({player})
        if user_id then
            init(user_id)
            TriggerClientEvent("vrp_bag:openGui", player)
        end
    end
)

RegisterServerEvent("vrp_bag:customAction")
AddEventHandler(
    "vrp_bag:customAction",
    function(args)
        local data = args
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})

        if user_id and data.idname then
            for k, v in pairs(items) do
                if data.idname == k or string.find(data.idname, k) then
                    if data.action == "*장전" or data.action == "*청첩장 확인" then
                        TriggerClientEvent("vrp_bag:closeGui", player)
                        vRP.executeInventoryCustomAction({player, data.idname, data.action})
                    else
                        vRP.executeInventoryCustomAction({player, data.idname, data.action})
                        init(user_id)
                        TriggerClientEvent("vrp_bag:refreshGui", player)
                    end
                    break
                end
            end
        end
    end
)

RegisterServerEvent("vrp_bag:useItem")
AddEventHandler(
    "vrp_bag:useItem",
    function(args)
        local data = args
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})

        if data.idname then
            for k, v in pairs(items) do
                if data.idname == k then
                    useItem(user_id, player, k, v[1], v[2], data.amount)
                    init(user_id)
                    TriggerClientEvent("vrp_bag:refreshGui", player)
                    break
                end
            end
        end
    end
)

RegisterServerEvent("vrp_bag:dropItem")
AddEventHandler(
    "vrp_bag:dropItem",
    function(data)
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        local amount = parseInt(data.amount)
        local peso = true
        if idname == "mochila" then
            peso = vRP.setMochila({user_id, 0})
        end
        if peso then
            if vRP.tryGetInventoryItem({user_id, data.idname, amount, true}) then
                vRPclient.playAnim(player, {true, {{"pickup_object", "pickup_low", 1}}, false})
                init(user_id)
                TriggerClientEvent("vrp_bag:refreshGui", player)
            else
                TriggerClientEvent("vrp_bag:UINotification", player, "warning", Config.Textos.AvisoGui, Config.Textos.Erro)
            end
        else
            vRPclient.notify(player, {"~r~배낭을 먼저 비우십시오."})
        end
    end
)

function split(str, sep)
    local array = {}
    local reg = string.format("([^%s]+)", sep)
    for mem in string.gmatch(str, reg) do
        table.insert(array, mem)
    end
    return array
end

function useItem(user_id, player, idname, type, variation, amount)
    if type == "drink" or type == "food" or type == "heal" or type == "mochila" or type == "weapon" or type == "ammo" or type == "drogaefeito" or type == "bebidaefeito" then
        if type == "drink" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                TriggerClientEvent("vrp_bag:objectForAnimation", player, "prop_ld_flow_bottle")
                play_drink(player)
                for i = 1, tonumber(amount) do
                    vRP.varyThirst({user_id, variation})
                end
            end
        end
        if type == "food" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                TriggerClientEvent("vrp_bag:objectForAnimation", player, "prop_cs_burger_01")
                play_eat(player)
                for i = 1, tonumber(amount) do
                    vRP.varyHunger({user_id, variation})
                end
            end
        end
        if type == "heal" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                for i = 1, tonumber(amount) do
                    vRPclient.varyHealth(player, {25})
                end
            end
        end
        if type == "weapon" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                if tonumber(amount) == 1 then
                    local fullidname = split(idname, "|")
                    vRPclient.giveWeapons(
                        player,
                        {
                            {
                                [fullidname[2]] = {ammo = 0}
                            },
                            false
                        }
                    )
                else
                    vRPclient.notify(player, {"무기는 하나만 장착 할 수 있습니다."})
                end
            end
        end
        if type == "ammo" then
            local fullidname = split(idname, "|")
            local exists = false
            vRPclient.getWeapons(
                player,
                {},
                function(weapons)
                    for k, v in pairs(weapons) do
                        if k == fullidname[2] then
                            exists = true
                        end
                    end
                    if exists == true then
                        if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                            vRPclient.giveWeapons(
                                player,
                                {
                                    {
                                        [fullidname[2]] = {ammo = tonumber(amount)}
                                    },
                                    false
                                }
                            )
                        end
                    else
                        TriggerClientEvent("vrp_inventory:UINotification", player, "warning", Config.Language.WarningTitle, Config.Language.WeaponNotEquipped)
                    end
                end
            )
        end
        if type == "mochila" then
            local src = source
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                vRPclient.notify(player, {"성공적으로 사용 된 배낭."})
                vRP.varyExp({user_id, "physical", "strength", 650})
            else
                vRPclient.notify(player, {"배낭에 배낭이 없습니다."})
            end
        end
        if type == "drogaefeito" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                vRPclient.playAnim(player, {true, {{"mp_player_int_uppersmoke", "mp_player_int_smoke"}}, true})
                SetTimeout(
                    10000,
                    function()
                        vRPclient.stopAnim(player, {false})
                        vRPclient.playScreenEffect(player, {"RaceTurbo", 180})
                        vRPclient.playScreenEffect(player, {"DrugsTrevorClownsFight", 180})
                        vRPclient.notify(player, {"사용 된 약물."})
                    end
                )
            end
        end
        if type == "bebidaefeito" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                TriggerClientEvent("vrp_bag:objectForAnimation", player, "prop_amb_beer_bottle")
                play_drink(player)
                SetTimeout(
                    10000,
                    function()
                        vRPclient.playScreenEffect(player, {"RaceTurbo", 180})
                        vRPclient.playScreenEffect(player, {"DrugsTrevorClownsFight", 180})
                        vRPclient.notify(player, {"섭취 한 음료."})
                    end
                )
            end
        end
    end
    if type == "none" then
        TriggerClientEvent("vrp_bag:UINotification", player, "warning", Config.Textos.AvisoGui, Config.Textos.NaoUtilizavel)
    end
end

function sendToDiscord_item(color, name, message, footer)
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
        "https://discordapp.com/api/webhooks/689108977921163304/JX3rZgOdIs8qQYsfzOA7KEsgK4_J8M8ZqHZRBM-5yxTWHkZAxI1Pvg2kJoZmLsr9sQCi",
        function(err, text, headers)
        end,
        "POST",
        json.encode({embeds = embed}),
        {["Content-Type"] = "application/json"}
    )
end

RegisterServerEvent("vrp_bag:giveItem")
AddEventHandler(
    "vrp_bag:giveItem",
    function(data)
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        local pname = GetPlayerName(source)
        if user_id ~= nil then
            vRPclient.getNearestPlayer(
                player,
                {5},
                function(nplayer)
                    if nplayer ~= nil then
                        local nuser_id = vRP.getUserId({nplayer})
                        local target_pname = GetPlayerName(nplayer)
                        if nuser_id ~= nil then
                            local amount = parseInt(data.amount)
                            local new_weight = vRP.getInventoryWeight({nuser_id}) + vRP.getItemWeight({data.idname}) * amount
                            if new_weight <= vRP.getInventoryMaxWeight({nuser_id}) then
                                local result = vRP.tryGetInventoryItem({user_id, data.idname, amount, true})
                                if result then
                                    if type(result) == "table" and result.type and result.content then
                                        vRP.giveInventoryItem({nuser_id, data.idname, amount, result, true, false, true})
                                    else
                                        vRP.giveInventoryItem({nuser_id, data.idname, amount, true, false, true})
                                    end
                                    local itemName = vRP.getItemName({data.idname})
                                    sendToDiscord_item(65280, "아이템 전달 보고서", "보내는 사람 : " .. pname .. "(" .. user_id .. "번)\n\n받는 사람 : " .. target_pname .. "(" .. nuser_id .. "번)\n\n보낸 아이템 : " .. itemName .. "\n\n보낸 갯수 : " .. format_num(amount) .. "개", os.date("전달일시 : %Y년 %m월 %d일 %H시 %M분 %S초 | 리얼월드 자동기록"))
                                    vRPclient.playAnim(player, {true, {{"mp_common", "givetake1_a", 1}}, false})
                                    vRPclient.playAnim(nplayer, {true, {{"mp_common", "givetake2_a", 1}}, false})
                                    init(user_id)
                                    TriggerClientEvent("vrp_bag:refreshGui", player)
                                else
                                    vRPclient.notify(player, {Config.Textos.Erro})
                                end
                            else
                                vRPclient.notify(player, {Config.Textos.SemEspaco})
                            end
                        else
                            vRPclient.notify(player, {Config.Textos.NinguemPerto})
                        end
                    else
                        vRPclient.notify(player, {Config.Textos.NinguemPerto})
                    end
                end
            )
        end
    end
)

function play_eat(player)
    local seq = {
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_enter", 1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger", 1},
        {"mp_player_inteat@burger", "mp_player_int_eat_burger_fp", 1},
        {"mp_player_inteat@burger", "mp_player_int_eat_exit_burger", 1}
    }

    vRPclient.playAnim(player, {true, seq, false})
end

function play_drink(player)
    local seq = {
        {"mp_player_intdrink", "intro_bottle", 1},
        {"mp_player_intdrink", "loop_bottle", 1},
        {"mp_player_intdrink", "outro_bottle", 1}
    }

    vRPclient.playAnim(player, {true, seq, false})
end

----------------------------------------------------------------------------------------------------------

AddEventHandler(
    "vrp_bag:create",
    function(itemb, count, px, py, pz)
        local id = markers_ids:gen()
        if id then
            itemss[id] = {
                itemb = itemb,
                count = count,
                x = px,
                y = py,
                z = pz,
                name = vRP.getItemName({itemb}),
                tempo = 1800
            }
        end
    end
)

RegisterServerEvent("vrp_bag:drop")
AddEventHandler(
    "vrp_bag:drop",
    function(itemb, count)
        local user_id = vRP.getUserId({source})
        if user_id then
            vRP.giveInventoryItem({user_id, itemb, count, false})
        end
    end
)

RegisterServerEvent("vrp_bag:take")
AddEventHandler(
    "vrp_bag:take",
    function(id)
        local user_id = vRP.getUserId({source})
        if user_id then
            if itemss[id] ~= nil then
                local new_weight = vRP.getInventoryWeight({user_id}) + vRP.getItemWeight({itemss[id].itemb}) * itemss[id].count
                if new_weight <= vRP.getInventoryMaxWeight({user_id}) then
                    if itemss[id] == nil then
                        return
                    end
                    vRP.giveInventoryItem({user_id, itemss[id].itemb, itemss[id].count, false})
                    vRPclient._playAnim(source, {true, {{"pickup_object", "pickup_low"}}, false})
                    itemss[id] = nil
                    markers_ids:free(id)
                    TriggerClientEvent("vrp_bag:remove", -1, id)
                else
                    vRPclient.notify(source, {"~r~배낭."})
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            for k, v in pairs(itemss) do
                if itemss[k].tempo > 0 then
                    itemss[k].tempo = itemss[k].tempo - 1
                    if itemss[k].tempo <= 0 then
                        itemss[k] = nil
                        markers_ids:free(k)
                        TriggerClientEvent("vrp_bag:remove", -1, k)
                    end
                end
            end
        end
    end
)
