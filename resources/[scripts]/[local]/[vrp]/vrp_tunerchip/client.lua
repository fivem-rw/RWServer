vRPtunerchipC = {}
Tunnel.bindInterface("vRP_tunerchip", vRPtunerchipC)
Proxy.addInterface("vRP_tunerchip", vRPtunerchipC)
vRP = Proxy.getInterface("vRP")
vRPtunerchipS = Tunnel.getInterface("vRP_tunerchip", "vRP_tunerchip")

local MenuAberto = false

local CarrosBloqueados = {
    "police",
    "police2",
    "police3"
}
--Checagem de Carro
function ChecagemCarrosC(x, dados)
    for k, v in pairs(x) do
        if v == dados then
            return true
        end
    end
    return false
end
--Notificações
function TextoSuperior(s)
    SetTextComponentFormat("STRING")
    AddTextComponentString(s)
    EndTextCommandDisplayHelp(0, 0, 0, -1)
end
--Altera os dados do veículo
function AlterarVeiculoC(veh, data)
    if not DoesEntityExist(veh) or not data then
        return nil
    end
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost * 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", data.fuelmix * 1.0)
    SetVehicleEnginePowerMultiplier(veh, data.gearchange * 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.braking * 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", data.drivebiass * 1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", data.brakeforce * 1.0)
end
--Retorna os dados do veículo
function RetornarValoresVeiculoC(veh)
    if not DoesEntityExist(veh) then
        return nil
    end
    local dadosVariaveis = {
        boost = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce"),
        fuelmix = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia"),
        braking = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront"),
        drivebiass = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront"),
        brakeforce = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce")
    }
    return dadosVariaveis
end

function AcaonoMenuC(status, send)
    MenuAberto = status
    SetNuiFocus(status, status)
    local DadosVeh = RetornarValoresVeiculoC(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    if send then
        SendNUIMessage(({type = "AcaonoMenu", state = status, data = DadosVeh}))
    end
end

RegisterNUICallback(
    "AcaonoMenu",
    function(data, cb)
        AcaonoMenuC(data.state, false)
    end
)

RegisterNUICallback(
    "SalvarVeh",
    function(data, cb)
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        if not IsPedInAnyVehicle(ped) or GetPedInVehicleSeat(veh, -1) ~= ped then
            return
        end
        AlterarVeiculoC(veh, data)
        TextoSuperior("~g~튜닝이 성공적으로 되었습니다!")
    end
)

function vRPtunerchipC.AbrirChipTuner()
    if not MenuAberto then
        local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(ped, false)
        if not ChecagemCarrosC(CarrosBloqueados, GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()) then
            AcaonoMenuC(true, true)
            while GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1) == ped and IsPedInAnyVehicle(ped, false) do
                Citizen.Wait(100)
            end
            AcaonoMenuC(false, true)
        else
            TextoSuperior("~r~해당차량은 튜닝이 허용되지 않습니다.")
        end
    else
        return
    end
end
