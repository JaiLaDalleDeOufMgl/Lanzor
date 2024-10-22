local cached_players = {}

RegisterNetEvent("utils:playerDisconnect")
AddEventHandler("utils:playerDisconnect", function(player, info)
    CreateThread(function()
        cached_players[player] = info

        Wait(20000)
        if cached_players[player] ~= nil then
            cached_players[player] = nil
        end
    end)
end)

CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        local pNear = false

        for k,v in pairs(cached_players) do
            if #(v.pos - pCoords) < 15 then
                pNear = true
                DrawText3DSecond(v.pos.x, v.pos.y, v.pos.z+0.12, exports.Tree:serveurConfig().Serveur.color.."Une personne a quitté la ville")
                DrawText3DSecondPos(v.pos.x, v.pos.y, v.pos.z, "~s~Raison: "..v.res.. "\nJoueurs: "..v.date) 
            end
        end


        if pNear then
            Wait(1)
        else
            Wait(1000)
        end
    end
end)

function DrawText3DSecond(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function DrawText3DSecondPos(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.30, 0.30)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end