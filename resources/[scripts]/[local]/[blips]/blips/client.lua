function BuildBlips(params)
    local blip = AddBlipForCoord(params.coords.x, params.coords.y, params.coords.z)
    SetBlipSprite(blip, params.bSprite)
    SetBlipColour(blip, params.bColour)
    SetBlipDisplay(blip, params.bDisplay or 4)
    SetBlipScale(blip, params.bScale or 0.9)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(params.title)
    EndTextCommandSetBlipName(blip)
    exports.blip_info:SetBlipInfoTitle(blip, params.title, false)
    exports.blip_info:SetBlipInfoImage(blip, params.txd or "world_blips", params.id)
    exports.blip_info:AddBlipInfoText(blip, params.desc)
    return blip
end

Citizen.CreateThread(
    function()
        Citizen.Wait(1000)
        local isLoadTxd = false
        local count = 100
        RequestStreamedTextureDict("world_blips", 1)
        while not isLoadTxd do
            if HasStreamedTextureDictLoaded("world_blips") then
                isLoadTxd = true
            end
            count = count - 1
            if count < 0 then
                break
            end
            Citizen.Wait(0)
        end
        if isLoadTxd then
            for _, v in pairs(Config.blips) do
                BuildBlips(
                    {
                        coords = v.coords,
                        id = v.id,
                        title = v.title,
                        desc = v.desc,
                        bSprite = v.bSprite,
                        bColour = v.bColour
                    }
                )
                Citizen.Wait(0)
            end
        end
    end
)
