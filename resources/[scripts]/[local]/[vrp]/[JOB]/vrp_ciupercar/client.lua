vRPciupercarC = {}
Tunnel.bindInterface("vRP_ciupercar", vRPciupercarC)
Proxy.addInterface("vRP_ciupercar", vRPciupercarC)
vRP = Proxy.getInterface("vRP")
vRPSciupercar = Tunnel.getInterface("vRP_ciupercar", "vRP_ciupercar")

local hasjob = false
local cosSC = false
local ciuperci = 0
local vinde = false
local cosul = true

function DrawText3D(x, y, z, text, scl)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * scl
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

local coordonate = {
    {-573.41424560547, 5546.3491210938, 52.509700775146 - 1},
    {-573.22344970703, 5557.05078125, 51.710678100586 - 1},
    {-564.17840576172, 5563.3603515625, 51.419013977051 - 1},
    {-566.98486328125, 5572.841796875, 50.196380615234 - 1},
    {-562.0205078125, 5578.3081054688, 49.299255371094 - 1},
    {-564.40557861328, 5587.6274414063, 47.825664520264 - 1},
    {-569.58239746094, 5580.31640625, 48.596900939941 - 1},
    {-570.85931396484, 5583.9296875, 47.505107879639 - 1},
    {-575.16558837891, 5576.9716796875, 48.135982513428 - 1},
    {-578.17034912109, 5569.1987304688, 49.369106292725 - 1},
    {-572.97265625, 5569.8022460938, 50.087135314941 - 1},
    {774.31677246094, 4204.9287109375, 8.3551778793335},
    {-487.12420654297, 5642.3081054688, 60.907688140869},
    {-480.12628173828, 5632.076171875, 62.752582550049},
    {-476.57949829102, 5623.28515625, 64.728225708008},
    {-470.79650878906, 5618.9819335938, 64.725242614746},
    {-468.44445800781, 5602.8403320313, 68.27547454834},
    {-472.52420043945, 5588.439453125, 69.946311950684},
    {-475.27792358398, 5583.4741210938, 70.531211853027},
    {-489.46371459961, 5569.4458007813, 71.85799407959},
    {-486.861328125, 5547.3305664063, 74.173217773438},
    {-500.82421875, 5551.298828125, 72.280242919922},
    {-521.66485595703, 5560.0581054688, 67.133811950684},
    {-521.55572509766, 5569.9990234375, 66.560554504395},
    {-533.83312988281, 5566.1201171875, 61.952377319336},
    {-544.42657470703, 5566.185546875, 59.996856689453},
    {-552.2236328125, 5539.6728515625, 60.384056091309},
    {-572.36016845703, 5534.8022460938, 53.558227539063},
    {-578.78057861328, 5526.123046875, 52.341888427734},
    {-598.25024414063, 5593.3452148438, 39.263874053955},
    {-598.74749755859, 5587.7612304688, 39.968696594238},
    {-605.91668701172, 5585.8168945313, 39.170295715332},
    {-599.76666259766, 5565.9619140625, 44.228275299072},
    {-573.388671875, 5584.033203125, 46.781723022461},
    {-573.60650634766, 5593.7197265625, 44.615161895752},
    {-573.78784179688, 5607.0502929688, 41.667179107666},
    {-580.36077880859, 5621.2065429688, 38.689907073975}
}
local tabel = {}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local pos = GetEntityCoords(GetPlayerPed(-1))
            local metrii = math.floor(GetDistanceBetweenCoords(-421.75500488281, 6135.4267578125, 31.877311706543, GetEntityCoords(GetPlayerPed(-1))))
            if metrii < 20 then
                DrawMarker(20, -421.75500488281, 6135.4267578125, 31.877311706543, 0, 0, 0, 0, 0, 0, 0.6001, 0.6001, 0.6001, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                DrawMarker(6, -421.75500488281, 6135.4267578125, 31.877311706543, 0, 0, 0, 0, 0, 0, 0.9501, 0.9501, 0.9501, 255, 210, 0, 255, 0, 0, 0, 1, 0, 0, 0)
                DrawMarker(1, -421.75500488281, 6135.4267578125, 30.891, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 0.04, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                DrawText3D(-421.75500488281, 6135.4267578125, 31.877311706543 + 1.2, "~y~[버섯캐기 미션]", 1.5)
                DrawText3D(-421.75500488281, 6135.4267578125, 31.877311706543 + 1, "~w~버섯캐기 작업을 시작합니다", 1)
                DrawText3D(-421.75500488281, 6135.4267578125, 31.877311706543 + 0.75, "~y~[E]~w~ 작업시작 | ~r~[Y]~w~ 버섯판매", 0.9)
                DrawText3D(-421.75500488281, 6135.4267578125, 31.877311706543 + 0.50, "~r~경고! 미션 취소 안됩니다!", 0.9)
            end
            if hasjob == true then
                for i, v in pairs(coordonate) do
                    local metrii2 = math.floor(GetDistanceBetweenCoords(v[1], v[2], v[3], GetEntityCoords(GetPlayerPed(-1))))
                    if ciuperci == 1 or ciuperci == 2 or ciuperci == 3 or ciuperci == 4 or ciuperci == 5 then
                        DrawText3D(pos.x, pos.y, pos.z + 1.2, "~g~[수확한 버섯]", 0.8)
                        DrawText3D(pos.x, pos.y, pos.z + 1, "~w~" .. ciuperci .. "~w~/~r~6개", 1.2)
                    elseif ciuperci == 6 then
                        DrawText3D(pos.x, pos.y, pos.z + 1.4, "~g~[수확한 버섯]", 0.8)
                        DrawText3D(pos.x, pos.y, pos.z + 1.2, "~r~6~w~/~r~6개", 1.2)
                        DrawText3D(pos.x, pos.y, pos.z + 1, "~g~버섯~w~을 ~g~판매~w~하러 가십시요!", 0.8)
                        vinde = true
                    end
                    if coordonate[i] ~= nil then
                        if metrii2 <= 3 then
                            DrawText3D(v[1], v[2], v[3] + 0.7, "~y~[E]~w~버섯 수확", 1.2)
                            if IsControlJustPressed(1, 51) then
                                table.remove(coordonate, i)
                                vRP.playAnim({false, {task = "WORLD_HUMAN_GARDENER_PLANT"}, false})
                                SetTimeout(
                                    10000,
                                    function()
                                        vRP.stopAnim({false})
                                        vRP.notify({"~g~[안내]~w~버섯을 수확했습니다", "성공"})
                                        ciuperci = ciuperci + 1
                                    end
                                )
                            end
                        end
                    else
                        DrawText3D(v[1], v[2], v[3] + 0.7, "~r~이미 수확 된 버섯 입니다.", 1.2)
                    end
                end
            end
            if metrii <= 3 then
                DrawText3D(pos.x, pos.y, pos.z + 1, "~※경고※\n버섯을 모두 수확하지 않으면\n버섯 미션을 완료할 수 없습니다", 0.5)
                if IsControlJustPressed(1, 51) then
                    if hasjob == false then
                        vRP.notify({"~y~[안내] ~w~지정된 위치로 이동해 버섯을 캐십시요.", "성공"})

                        hasjob = true

                        vRP.notify({"~y~[안내] ~g~버섯 미션~w~을 받았습니다", "성공"})

                        for i, v in pairs(coordonate) do
                            cvprop = CreateObject(RWO, GetHashKey("prop_stoneshroom1"), v[1], v[2], v[3], false)
                        end
                    elseif hasjob == true then
                        vRP.notify({"~r~[실패] ~g~이미 버섯 미션~w~을 받았습니다", "성공"})
                    end
                elseif IsControlJustPressed(1, 246) then
                    if vinde == true then
                        vRPSciupercar.verificaciuperci({ciuperci})
                        ciuperci = 0
                        hasjob = false
                        cosSC = false
                        vinde = false
                        DeleteEntity(cosdeoua)
                        DeleteEntity(cosdeoua)
                        table.insert(coordonate, {790.95959472656, 4286.9658203125, 55.545942687988})
                        table.insert(coordonate, {785.61285400391, 4288.5952148438, 55.76137008667})
                        table.insert(coordonate, {777.37567138672, 4286.013671875, 55.376140594482})
                        table.insert(coordonate, {783.12194824219, 4294.5239257813, 58.114027404785})
                        table.insert(coordonate, {765.93200683594, 4276.0834960938, 55.820201873779 - 1})
                        table.insert(coordonate, {759.37152099609, 4287.658203125, 60.372291564941 - 1})
                        table.insert(coordonate, {-487.12420654297, 5642.3081054688, 60.907688140869})
                        table.insert(coordonate, {-480.12628173828, 5632.076171875, 62.752582550049})
                        table.insert(coordonate, {-476.57949829102, 5623.28515625, 64.728225708008})
                        table.insert(coordonate, {-470.79650878906, 5618.9819335938, 64.725242614746})
                        table.insert(coordonate, {-468.44445800781, 5602.8403320313, 68.27547454834})
                        table.insert(coordonate, {-472.52420043945, 5588.439453125, 69.946311950684})
                        table.insert(coordonate, {-475.27792358398, 5583.4741210938, 70.531211853027})
                        table.insert(coordonate, {-489.46371459961, 5569.4458007813, 71.85799407959})
                        table.insert(coordonate, {-486.861328125, 5547.3305664063, 74.173217773438})
                        table.insert(coordonate, {-500.82421875, 5551.298828125, 72.280242919922})
                        table.insert(coordonate, {-521.66485595703, 5560.0581054688, 67.133811950684})
                        table.insert(coordonate, {-521.55572509766, 5569.9990234375, 66.560554504395})
                        table.insert(coordonate, {-533.83312988281, 5566.1201171875, 61.952377319336})
                        table.insert(coordonate, {-544.42657470703, 5566.185546875, 59.996856689453})
                        table.insert(coordonate, {-552.2236328125, 5539.6728515625, 60.384056091309})
                        table.insert(coordonate, {-572.36016845703, 5534.8022460938, 53.558227539063})
                        table.insert(coordonate, {-578.78057861328, 5526.123046875, 52.341888427734})
                        table.insert(coordonate, {-598.25024414063, 5593.3452148438, 39.263874053955})
                        table.insert(coordonate, {-598.74749755859, 5587.7612304688, 39.968696594238})
                        table.insert(coordonate, {-605.91668701172, 5585.8168945313, 39.170295715332})
                        table.insert(coordonate, {-599.76666259766, 5565.9619140625, 44.228275299072})
                        table.insert(coordonate, {-573.388671875, 5584.033203125, 46.781723022461})
                        table.insert(coordonate, {-573.60650634766, 5593.7197265625, 44.615161895752})
                        table.insert(coordonate, {-573.78784179688, 5607.0502929688, 41.667179107666})
                        table.insert(coordonate, {-580.36077880859, 5621.2065429688, 38.689907073975})
                    else
                        vRP.notify({"~r~[안내] ~w~버섯이 없습니다", "성공"})
                    end
                end
            end
        end
    end
)
