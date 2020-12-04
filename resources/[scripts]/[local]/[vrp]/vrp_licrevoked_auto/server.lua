local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vrp_licrevoked_autoS = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_licrevoked_auto")
vrp_licrevoked_autoC = Tunnel.getInterface("vrp_licrevoked_auto", "vrp_licrevoked_auto")
Tunnel.bindInterface("vrp_licrevoked_auto", vrp_licrevoked_autoS)

function bScript_Discord_License(color, name, message, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "" .. name .. "",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer
            }
        }
    }
    PerformHttpRequest(
        "https://discordapp.com/api/webhooks/688893999695790092/kntHoeKlf5heFp4dAfyrvKGYL9SbxAAaNt82SXIXUz4LDotEWIm4k_MgrR2Kz3t80EuW",
        function(err, text, headers)
        end,
        "POST",
        json.encode({embeds = embed}),
        {["Content-Type"] = "application/json"}
    )
end

function vrp_licrevoked_autoS.checkAuthRestLicense()
    local player = source
    local user_id = vRP.getUserId({player})
    local target_name = GetPlayerName(player)
    if not user_id then
        return
    end
    local bankMoney = vRP.getBankMoney({user_id})
    if bankMoney < 0 then
        if vRP.getLicenseStatus({user_id}) == 0 then
            vRP.setLicenseStatus({user_id, 1})
            vRPclient.notify(player, {"~y~마이너스 계좌가 확인되어 당신의 면허가 정지되었습니다."})
            bScript_Discord_License(4097941, "❎ 면허정지 로그", "처리자 : 자동정지(계좌잔고부족)\n\n 정지 대상 : " .. target_name .. " - " .. user_id .. "번\n\n처리 일시 : " .. os.date("%Y년 %m월 %d일, %H시 %M분 %S초"))
        end
    end
end
