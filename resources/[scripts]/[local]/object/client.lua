AntiOBJ = true

ObjectsBL={
"stt_prop_stunt_jump15",
"stt_prop_stunt_jump30",
"stt_prop_stunt_jump45",
"stt_prop_stunt_track_bumps",
"stt_prop_stunt_track_cutout",
"stt_prop_stunt_track_dwlink",
"stt_prop_stunt_track_dwlink_02",
"stt_prop_stunt_track_dwsh15",
"stt_prop_stunt_track_dwshort",
"stt_prop_stunt_track_dwslope15",
"stt_prop_stunt_track_dwslope30",
"stt_prop_stunt_track_dwslope45",
"stt_prop_stunt_track_dwturn",
"stt_prop_stunt_track_dwuturn",
"stt_prop_stunt_track_exshort",
"stt_prop_stunt_track_fork",
"stt_prop_stunt_track_funlng",
"stt_prop_stunt_track_funnel",
"stt_prop_stunt_track_hill",
"stt_prop_stunt_track_hill2",
"stt_prop_stunt_track_jump",
"stt_prop_stunt_track_link",
"stt_prop_stunt_track_otake",
"stt_prop_stunt_track_slope15",
"stt_prop_stunt_track_slope30",
"stt_prop_stunt_track_slope45",
"stt_prop_stunt_track_st_01",
"stt_prop_stunt_track_st_02",
"stt_prop_stunt_track_start",
"stt_prop_stunt_track_start_02",
"stt_prop_stunt_track_straight",
"stt_prop_stunt_track_straightice",
"stt_prop_stunt_track_turn",
"stt_prop_stunt_track_turnice",
"stt_prop_stunt_track_uturn",
"xs_prop_hamburgher_wl",
"sr_prop_spec_tube_xxs_01a",
"xs_prop_arena_airmissile_01a",
"xs_prop_arena_bag_01",
"xs_prop_arena_bomb_l",
"xs_prop_arena_bomb_m",
"xs_prop_arena_bomb_s",
"xs_prop_arena_cash_pile_l",
"xs_prop_arena_cash_pile_m",
"xs_prop_arena_cash_pile_s",
"xs_prop_arena_champ_closed",
"xs_prop_arena_champ_open",
"xs_prop_arena_confetti_cannon",
"xs_prop_arena_crate_01a",
"xs_prop_arena_finish_line",
"xs_prop_arena_goal",
"xs_prop_arena_podium_01a",
"xs_prop_arena_podium_02a",
"xs_prop_arena_podium_03a",
"xs_prop_arena_telescope_01",
"xs_prop_arena_trophy_double_01a",
"xs_prop_arena_trophy_double_01b",
"xs_prop_arena_trophy_double_01c",
"xs_prop_arena_trophy_single_01a",
"xs_prop_arena_trophy_single_01b",
"xs_prop_arena_trophy_single_01c",
"xs_p_para_bag_arena_s",
"xs_prop_arena_goal_sf",
"xs_prop_arena_bollard_rising_01a",
"xs_prop_arena_bollard_rising_01b",
"xs_prop_arena_bollard_rising_01a_sf",
"xs_prop_arena_bollard_rising_01b_sf",
"xs_prop_arena_bollard_rising_01a_wl",
"xs_prop_arena_bollard_rising_01b_wl",
"xs_prop_arenaped",
"xs_prop_arena_clipboard_01a",
"xs_prop_arena_clipboard_01b",
"xs_prop_arena_clipboard_paper",
"xs_prop_arena_1bay_01a",
"xs_prop_arena_2bay_01a",
"xs_prop_arena_oil_jack_01a",
"xs_prop_arena_oil_jack_02a",
"xs_prop_arena_pit_fire_01a",
"xs_prop_arena_spikes_01a",
"xs_prop_arena_spikes_02a",
"xs_prop_arena_spikes_01a_sf",
"xs_prop_arena_spikes_02a_sf",
"xs_prop_arena_car_wall_01a",
"xs_prop_arena_car_wall_02a",
"xs_prop_arena_car_wall_03a",
"xs_prop_arena_gate_01a",
"xs_prop_arena_wall_01a",
"xs_prop_arena_wall_01b",
"xs_prop_arena_wall_01c",
"xs_prop_arena_wall_02a",
"xs_prop_barrier_10m_01a",
"xs_prop_barrier_15m_01a",
"xs_prop_barrier_5m_01a",
"cargoplane",
"prop_beach_fire",
"xs_prop_arena_oil_jack_01a",
"658306424"
}


function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

function DeleteObjects(object, detach)
    if DoesEntityExist(object) then
	NetworkRequestControlOfEntity(object)
	while not NetworkHasControlOfEntity(object) do
		Citizen.Wait(1)
	end
	if detach then
        DetachEntity(object, 0, false)
	end
	SetEntityCollision(object, false, false)
	SetEntityAlpha(object, 0.0, true)
	SetEntityAsMissionEntity(object, true, true)
	SetEntityAsNoLongerNeeded(object)
    DeleteEntity(object)
	end
end

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(500)
	local ped = PlayerPedId()
	local handle, object = FindFirstObject()
	local finished = false
	repeat
        Wait(1)
        if (AntiOBJ == true)then
		for i=1,#ObjectsBL do
		if GetEntityModel(object) == GetHashKey(ObjectsBL[i]) then
            DeleteObjects(object, false)
		end
        end
    end
        finished, object = FindNextObject(handle)
	until not finished
	EndFindObject(handle)
	end
end)

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

