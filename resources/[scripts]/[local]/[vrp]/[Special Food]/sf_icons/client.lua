icons = {
    {"bank", "bank", "bank"},
    {"staff", "staff", "staff"},
    {"voice", "voice", "voice"},
    {"logo", "logo", "logo"},
    {"car", "car", "car"},
    {"RentCarZone", "RentCarZone", "RentCarZone"},
    {"carwash", "carwash", "carwash"},
    {"discord", "discord", "discord"},
    {"hungry", "hungry", "hungry"},
    {"Thirsty", "Thirsty", "Thirsty"},
    {"error", "error", "error"},
    {"payday", "payday", "payday"},
    {"battlepass", "battlepass", "battlepass"},
    {"discordIcon", "discordIcon", "discordIcon"},
    {"hideHud", "hideHud", "hideHud"},
    {"shardm", "shardm", "shardm"},
    {"559", "559", "559"},
    {"ip", "ip", "ip"},
    {"tvshowroom", "tvshowroom", "tvshowroom"},
    {"weapon-bullets", "weapon-bullets", "weapon-bullets"},
    {"circle", "circle", "circle"},
    {"bannerbp", "bannerbp", "bannerbp"},
    {"gold", "gold", "gold"},
    {"left-arrow", "left-arrow", "left-arrow"},
    {"basicchest", "basicchest", "basicchest"},
    {"legendarchest", "legendarchest", "legendarchest"},
    {"epichest", "epichest", "epichest"},
    {"right-arrow", "right-arrow", "right-arrow"},
    {"armor", "armor", "armor"},
    {"diving", "diving", "diving"},
    {"hp", "hp", "hp"},
    {"hungry", "hungry", "hungry"},
    {"Jump", "Jump", "Jump"},
    {"speed", "speed", "speed"},
    {"Thirsty", "Thirsty", "Thirsty"},
    {"moneyicn", "moneyicn", "moneyicn"}
}

function loadAllIcons()
    for i, v in pairs(icons) do
        local txd = CreateRuntimeTxd(v[1])
        CreateRuntimeTextureFromImage(txd, v[2], "icons/" .. v[3] .. ".png")
    end
end

Citizen.CreateThread(
    function()
        loadAllIcons()
    end
)

function DrawImage3D(name1, name2, x, y, z, width, height, rot, r, g, b, alpha)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)

    if onScreen then
        local width = (1 / dist) * width
        local height = (1 / dist) * height
        local fov = (1 / GetGameplayCamFov()) * 100
        local width = width * fov
        local height = height * fov

        local CoordFrom = GetEntityCoords(PlayerPedId(), true)
        local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z, x, y, z, -1, PlayerPedId(), 0)
        local _, _, _, _, object = GetShapeTestResult(RayHandle)
        if (object == 0) or (object == nil) then
            DrawSprite(name1, name2, _x, _y, width, height, rot, r, g, b, alpha)
        end
    end
end

function drawtxt(text, font, centre, x, y, scale, r, g, b, a)
    y = y - 0.010
    scale = scale / 2
    y = y + 0.002
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextFont(7)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- local show = false
-- local alpha = 250
-- local y = 0.45
-- function playalpha2()
--     show = true
--     Citizen.CreateThread(function()
--         while show do
--             Wait(0)
--             alpha = alpha - 100
--             if alpha >= 50 then
--                 -- alpha = 250
--                 break
--             end
--         end
--     end)
--     Citizen.CreateThread(function()
--         while show do
--             Citizen.Wait(1)
--             y = y - 0.015
--             if y <= 0.15 then
--                 -- y = 0.45
--                 break
--             end
--         end
--     end)
-- end

-- function notifmoney(money,pulamea)
--     local ok = true
--     local nr = math.random(1,20)
--     local x = 0.480 + (nr*0.01)
--     Citizen.CreateThread(function()
--         local n = 0
--         playalpha2()
--         show = true
--         while ok do
--             Wait(0)
--             DrawSprite("moneyicn", "moneyicn", x, y, 0.018, 0.030, 0.0, 255, 255, 255, alpha)
--             -- drawpl("~g~"..money,4,0,x+0.012, y-0.010,0.23,10,235,10,alpha)
--             if pulamea == "plus" then
--                 drawtxt("+$"..money,1,3,x+0.033, y-0.006,0.8,25,225,25,alpha)
--             elseif pulamea == "minus" then
--                 drawtxt("-$"..money,1,3,x+0.033, y-0.006,0.8,255,25,25,alpha)
--             end
--             n = n +1
--             if n == 20 then
--                 -- ok = false
--                 -- show = false
--                 y = 0.45
--                 alpha = 250
--                 break
--             end
--         end
--     end)
-- end

-- -- if statement == "minus" then
-- --     drawpl("~r~"..money,4,0,y+0.012, tst-0.010,0.23,255,255,255,alpha)
-- -- else
-- --     drawpl("~g~"..money,4,0,y+0.012, tst-0.010,0.23,255,255,255,alpha)
-- -- end

-- Citizen.CreateThread(function()
--     while true do
--         Wait(1)
--         if IsControlJustPressed(1,51) then
--             notifmoney("10000", "minus")
--             print("1")
--         end
--     end
-- end)
