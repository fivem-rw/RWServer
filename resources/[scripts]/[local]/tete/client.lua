

function CreateNamedRenderTargetForModel(name, model)
local handle = 0
if not IsNamedRendertargetRegistered(name) then
RegisterNamedRendertarget(name, 0)
end
if not IsNamedRendertargetLinked(model) then
LinkNamedRendertarget(model)
end
if IsNamedRendertargetRegistered(name) then
handle = GetNamedRendertargetRenderId(name)
end

return handle
end

Citizen.CreateThread(function ()
local model = GetHashKey("ba_prop_club_screens_01");
local pos = { x = -1604.664, y = -3012.583, z = 80.00 };
local entity = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.05, model, 0, 0, 0)
local handle = CreateNamedRenderTargetForModel("club_projector", model)

RegisterScriptWithAudio(0)
SetTvChannel(-1)

Citizen.InvokeNative(0x9DD5A62390C3B735, 2, "PL_DIX_LED_PALACE", 0)
SetTvChannel(2)
EnableMovieSubtitles(1)

while true do
    SetTvAudioFrontend(0)
    AttachTvAudioToEntity(entity)
    SetTextRenderId(handle)
        Set_2dLayer(4)
        Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
        DrawTvChannel(0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
    SetTextRenderId(GetDefaultScriptRendertargetRenderId())
    Citizen.Wait(0)
end
end)