local blip_sprite = cfg.blip_sprite
local blip_location = cfg.base_location
local blip = nil
local area_blip = nil
local area_size = cfg.area_size

CreateThread(function()
    AddTextEntry("PROSP_BLIP", cfg.blip_name)
    blip = AddBlipForCoord(blip_location)
    SetBlipSprite(blip, blip_sprite)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("PROSP_BLIP")
    EndTextCommandSetBlipName(blip)
    area_blip = AddBlipForRadius(blip_location, area_size)
    SetBlipSprite(area_blip, 10)
end)
