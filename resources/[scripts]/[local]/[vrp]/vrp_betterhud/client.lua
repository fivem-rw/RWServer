local thirst, hunger = 0
local minHealth = 100

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)
            local ped = PlayerPedId()
            local vMaxHealth = GetEntityMaxHealth(ped) - minHealth
            local vHealth = GetEntityHealth(ped) - minHealth
            SendNUIMessage(
                {
                    show = IsPauseMenuActive(),
                    armor = GetPedArmour(ped),
                    life = (100 * vHealth / vMaxHealth),
                    thirst = thirst,
                    hunger = hunger
                }
            )
        end
    end
)

RegisterNetEvent("vrp_betterhud:updateBasics")
AddEventHandler(
    "vrp_betterhud:updateBasics",
    function(rHunger, rThirst)
        hunger, thirst = rHunger, rThirst
    end
)
