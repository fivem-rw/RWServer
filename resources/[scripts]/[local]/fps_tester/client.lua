function DrawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

local fps = 0

Citizen.CreateThread(
    function()
        while true do
            fps = math.floor(1.0 / GetFrameTime())
            Citizen.Wait(500)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            DrawTxt(0.0,-0.005, 0.00, 0.00, 0.25, fps, 0, 255, 0, 200)
            Citizen.Wait(1)
        end
    end
)
