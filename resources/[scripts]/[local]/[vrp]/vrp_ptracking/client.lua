--[[
    bScript™ vrp_ptracking (https://www.bareungak.com/)
    
    Sort : Client-Side
	Version : 1.00

    Author : Bareungak (https://steamcommunity.com/id/Bareungak)
]]
--[[

    LICENSE (EN)

    Licenses are provided in a leased form to the licensed purchaser and under no circumstances can be transferred to another person.

    Seller and developer shall not be liable for any legal indemnity if the licensed purchaser cancels the licence in violation of the terms and conditions.

    In the event of property damage to the developer or seller caused by a significant event in connection with the license, 
    the developer or seller shall claim damages and be designated as a competent court near the developer or seller's location in the event of a lawsuit.

    The terms and conditions take effect after the corresponding script is applied.

]]
--[[

    라이선스 (KO)

    허가된 구매자에게 라이선스를 임대형식으로 제공하며 어떠한 경우에도 타인에게 라이선스를 양도 할 수 없다.

    허가된 구매자가 해당 약관을 위반하여 라이선스가 취소되는 경우 판매자와 개발자는 그 어떤 법적 배상의 책임을 지지 않는다.

    라이선스와 관련하여 중대한 사건으로 인해 개발자 또는 판매자에게 재산상의 손해이 발생한 경우
    개발자 또는 판매자는 해당 구매자에게 손해배상을 청구하고, 소송시 개발자 또는 판매자 소재지 근처의 관할 법원으로 지정한다.

    해당 스크립트를 적용한 이후 부터 해당 약관의 효력이 발생한다.

]]
--[[

    구매자 :
    UID :
    구매 일시 :

    에게 임대 형식으로 라이선스를 적용하며, 약관 위반사항 또는 라이선스와 관련하여 중대한 사건 발생으로 인해 
    개발자 판매자에게 재산상의 손해가 발생한 경우 구매자가 전적으로 책임지며, 라이선스는 취소되 해당 에드온을 사용할 수 없다.

]]
vrp_ptrackingC = {}
Tunnel.bindInterface("vrp_ptracking", vrp_ptrackingC)
Proxy.addInterface("vrp_ptracking", vrp_ptrackingC)
vRP = Proxy.getInterface("vRP")
vrp_ptrackingS = Tunnel.getInterface("vrp_ptracking", "vrp_ptracking")

local RouletteWords = cfg.words
local target_source = nil

cachedScaleform = nil

function ScaleformLabel(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

local lives = cfg.lives
local ClickReturn
local SorF = false
local Hacking = false
local UsingComputer = false

StartComputer = function()
    Citizen.CreateThread(
        function()
            InitializeBruteForce = function(scaleform)
                local scaleform = RequestScaleformMovieInteractive(scaleform)
                while not HasScaleformMovieLoaded(scaleform) do
                    Citizen.Wait(0)
                end

                local CAT = "hack"
                local CurrentSlot = 0
                while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                    Citizen.Wait(0)
                    CurrentSlot = CurrentSlot + 1
                end

                if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
                    ClearAdditionalText(CurrentSlot, true)
                    RequestAdditionalText(CAT, CurrentSlot)
                    while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                        Citizen.Wait(0)
                    end
                end

                PushScaleformMovieFunction(scaleform, "SET_LABELS")
                PushScaleformMovieFunctionParameterString("로컬 디스크 (C:)")
                PushScaleformMovieFunctionParameterString(cfg.networkname)
                PushScaleformMovieFunctionParameterString("외부 장치 (J:)")
                PushScaleformMovieFunctionParameterString(cfg.program1name)
                PushScaleformMovieFunctionParameterString(cfg.program2name)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
                PushScaleformMovieFunctionParameterInt(4)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
                PushScaleformMovieFunctionParameterFloat(1.0)
                PushScaleformMovieFunctionParameterFloat(4.0)
                PushScaleformMovieFunctionParameterString("내 컴퓨터")
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
                PushScaleformMovieFunctionParameterFloat(6.0)
                PushScaleformMovieFunctionParameterFloat(6.0)
                PushScaleformMovieFunctionParameterString("종료")
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_LIVES")
                PushScaleformMovieFunctionParameterInt(lives)
                PushScaleformMovieFunctionParameterInt(5)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_LIVES")
                PushScaleformMovieFunctionParameterInt(lives)
                PushScaleformMovieFunctionParameterInt(5)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(0)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(1)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(2)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(3)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(4)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(5)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(6)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(7)
                PushScaleformMovieFunctionParameterInt(cfg.speed)
                PopScaleformMovieFunctionVoid()

                return scaleform
            end

            cachedScaleform = InitializeBruteForce("HACKING_PC")

            UsingComputer = true

            while UsingComputer do
                Citizen.Wait(0)

                DisableControlAction(0, 1, true) -- Disable pan
                DisableControlAction(0, 2, true) -- Disable tilt
                DisableControlAction(0, 24, true) -- Attack
                DisableControlAction(0, 257, true) -- Attack 2
                DisableControlAction(0, 25, true) -- Aim
                DisableControlAction(0, 263, true) -- Melee Attack 1
                DisableControlAction(0, 31, true) -- S (fault in Keys table!)
                DisableControlAction(0, 30, true) -- D (fault in Keys table!)
                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                DisableControlAction(0, 72, true) -- Disable reversing in vehicle
                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle

                if UsingComputer then
                    DrawScaleformMovieFullscreen(cachedScaleform, 255, 255, 255, 255, 0)
                    PushScaleformMovieFunction(cachedScaleform, "SET_CURSOR")
                    PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
                    PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
                    PopScaleformMovieFunctionVoid()
                    if IsDisabledControlJustPressed(0, 24) and not SorF then
                        PushScaleformMovieFunction(cachedScaleform, "SET_INPUT_EVENT_SELECT")
                        ClickReturn = PopScaleformMovieFunction()
                        PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
                    elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                        PushScaleformMovieFunction(cachedScaleform, "SET_INPUT_EVENT_BACK")
                        PopScaleformMovieFunctionVoid()
                        PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
                    end
                end
            end
        end
    )
end

Citizen.CreateThread(
    function()
        while true do
            local sleepThread = 500

            if HasScaleformMovieLoaded(cachedScaleform) and UsingComputer then
                sleepThread = 5

                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                print("ClickReturn", ClickReturn)
                if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                    ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)

                    print("ProgramID", ProgramID, Hacking)

                    if ProgramID == 83 and not Hacking then
                        lives = 5

                        PushScaleformMovieFunction(cachedScaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(lives)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()

                        PushScaleformMovieFunction(cachedScaleform, "OPEN_APP")
                        PushScaleformMovieFunctionParameterFloat(1.0)
                        PopScaleformMovieFunctionVoid()

                        PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_WORD")
                        PushScaleformMovieFunctionParameterString(RouletteWords[math.random(#RouletteWords)])
                        PopScaleformMovieFunctionVoid()

                        Hacking = true
                    elseif Hacking and ProgramID == 87 then
                        lives = lives - 1
                        PushScaleformMovieFunction(cachedScaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(lives)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()
                        PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                    elseif Hacking and ProgramID == 92 then
                        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                    elseif Hacking and ProgramID == 86 then
                        SorF = true
                        print("okok0")
                        PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                        PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(true)
                        ScaleformLabel("WINBRUTE")
                        PopScaleformMovieFunctionVoid()
                        print("okok1")
                        Wait(5000)
                        PushScaleformMovieFunction(cachedScaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        SetScaleformMovieAsNoLongerNeeded(cachedScaleform)
                        UsingComputer = false
                        Hacking = false
                        SorF = false
                        print("okok2")

                        vrp_ptrackingS.Result({true, target_source})

                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                    elseif ProgramID == 6 then
                        UsingComputer = false
                        SetScaleformMovieAsNoLongerNeeded(cachedScaleform)

                        vrp_ptrackingS.Result({true, target_source})

                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                    end

                    if Hacking then
                        PushScaleformMovieFunction(cachedScaleform, "SHOW_LIVES")
                        PushScaleformMovieFunctionParameterBool(true)
                        PopScaleformMovieFunctionVoid()

                        if lives <= 0 then
                            SorF = true
                            PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                            PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_OUTCOME")
                            PushScaleformMovieFunctionParameterBool(false)
                            ScaleformLabel("LOSEBRUTE")
                            PopScaleformMovieFunctionVoid()
                            Wait(5000)
                            PushScaleformMovieFunction(cachedScaleform, "CLOSE_APP")
                            PopScaleformMovieFunctionVoid()
                            SetScaleformMovieAsNoLongerNeeded(cachedScaleform)
                            Hacking = false
                            SorF = false
                            UsingComputer = false

                            vrp_ptrackingS.Result({true, target_source})

                            DisableControlAction(0, 24, false)
                            DisableControlAction(0, 25, false)
                        end
                    end
                end
            end

            Citizen.Wait(sleepThread)
        end
    end
)

RegisterNetEvent("vrp_ptracking:Open")
AddEventHandler(
    "vrp_ptracking:Open",
    function(target)
        target_source = target
        StartComputer()
    end
)

Citizen.CreateThread(
    function()
        Citizen.Wait(1000)
        --vrp_ptrackingS.op({})
    end
)
