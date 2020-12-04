Player = {}

function Player.IsSpawnHostZone(zone)
    local mPlayerId = PlayerId()
    local mPlayerPedPos = GetEntityCoords(PlayerPedId())
    local selectPlayer = nil
    local selectPos = 999999
    for _, playerId in ipairs(GetActivePlayers()) do
        local pos = GetEntityCoords(GetPlayerPed(playerId))
        local setPos = GetDistanceBetweenCoords(zone[1], zone[2], zone[3], pos.x, pos.y, pos.z, true)
        if setPos < selectPos and setPos < zone[4] / 2 then
            selectPlayer = playerId
            selectPos = setPos
        end
    end

    if mPlayerId ~= selectPlayer then
        return false
    end

    return true
end

function Player.IsSpawnHost()
    local mPlayerId = PlayerId()
    local mServerId = GetPlayerServerId(mPlayerId)
    local mPlayerPedPos = GetEntityCoords(PlayerPedId())

    for _, playerId in ipairs(GetActivePlayers()) do
        if playerId ~= mPlayerId then
            if GetPlayerServerId(playerId) > mServerId and Utils.GetDistanceBetweenCoords(mPlayerPedPos, GetEntityCoords(GetPlayerPed(playerId))) <= Config.Spawning.HOST_DECIDE_DIST then
                return false
            end
        end
    end

    return true
end
