--[[
    FiveM Scripts
    Copyright C 2018  Sighmir

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    at your option any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

vRP = Proxy.getInterface("vRP")

other = nil
drag = false
playerStillDragged = false

RegisterNetEvent("dr:drag")
AddEventHandler(
    "dr:drag",
    function(pl)
        other = pl
        drag = not drag
    end
)

RegisterNetEvent("dr:undrag")
AddEventHandler(
    "dr:undrag",
    function(pl)
        other = pl
        drag = false
    end
)

Citizen.CreateThread(
    function()
        while true do
            if other ~= nil then
                local ped = GetPlayerPed(GetPlayerFromServerId(other))
                local myped = GetPlayerPed(-1)
                if drag then
                    if not playerStillDragged then
                        AttachEntityToEntity(myped, ped, 4103, 11816, 0.35, 0.35, 0.0, 0.0, 0.0, 0.0, false, false, false, true, 2, true)
                        playerStillDragged = true
                    end
                else
                    if playerStillDragged then
                        DetachEntity(myped, true, false)
                        playerStillDragged = false
                    end
                end
            end
            Citizen.Wait(100)
        end
    end
)
