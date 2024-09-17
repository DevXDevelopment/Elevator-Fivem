-- ████████████████████████████████████████████████████████████████████████████████████████
-- █░░░░░░░░░░░░░░█░░░░░░██████████░░░░░░█░░░░░░░░░░░░░░░░███░░░░░░██░░░░░░█░░░░░░██░░░░░░█
-- █░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░░░░░░░░░░░░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█
-- █░░▄▀░░░░░░░░░░█░░▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░░░░░░░▄▀░░███░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█
-- █░░▄▀░░█████████░░▄▀░░░░░░▄▀░░░░░░▄▀░░█░░▄▀░░████░░▄▀░░███░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█
-- █░░▄▀░░░░░░░░░░█░░▄▀░░██░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░▄▀░░███░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░█
-- █░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀▄▀░░███░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
-- █░░▄▀░░░░░░░░░░█░░▄▀░░██░░░░░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░░░███░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░█
-- █░░▄▀░░█████████░░▄▀░░██████████░░▄▀░░█░░▄▀░░██░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█
-- █░░▄▀░░░░░░░░░░█░░▄▀░░██████████░░▄▀░░█░░▄▀░░██░░▄▀░░░░░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░█
-- █░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██████████░░▄▀░░█░░▄▀░░██░░▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█
-- █░░░░░░░░░░░░░░█░░░░░░██████████░░░░░░█░░░░░░██░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░█                  
--                            https://discord.gg/vyDJyfMb8p
local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

CreateThread(function()
    while true do
        sleep = 1000
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        
        for k, v in pairs(Config.Asansorler) do
            for i, z in pairs(v.coords) do
                local dist = #(plyCoords - z.coords)
                
                if dist < 3.0 then
                    sleep = 5
                    DrawMarker(2, z.coords.x, z.coords.y, z.coords.z, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 32, 236, 54, 100, 0, 0, 0, 1, 0, 0, 0)
                    if dist < 1.5 then
                        ShowFloatingHelpNotification("~g~[E]~w~ Elevator", z.coords, 2.0)
                        if IsControlJustPressed(0, 38) then
                            OpenMenu(v.coords)
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)


function ShowFloatingHelpNotification(msg, coords,r)
    AddTextEntry('FloatingHelpNotification'..'_'..r, msg)
    SetFloatingHelpTextWorldPosition(1, coords.x,coords.y,coords.z + 0.2)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotification'..'_'..r)
    EndTextCommandDisplayHelp(2, false, false, -1)
end


function OpenMenu(data)
    local menu = {}

    for k, v in pairs(data) do
        menu[#menu+1] = {
            header = v.header,
            txt = "",
            params = {
                event = "emruh:asansoreBin",
                args = v.coords
            }
        }
        exports["qb-menu"]:openMenu(menu)
    end

end

RegisterNetEvent("emruh:asansoreBin", function(coords)
    SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, true)
end)