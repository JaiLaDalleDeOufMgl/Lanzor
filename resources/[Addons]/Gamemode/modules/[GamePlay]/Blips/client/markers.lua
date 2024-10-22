ZonesListeLTD = {
    ["fib_garage_helipad"] = {
        Position = vector3(2505.964, -347.1071, 118.0243),
        Public = false,
        Job = "fib",
        Job2 = nil,
        Action = function()
            OpenMenuHelipadFIB() 
        end
    },
    ["catalogue_plane"] = {
        Position = vector3(-963.9695, -2966.919, 13.94),
        Public = true,
        Action = function()
            TriggerEvent("openMenuCatalogue:plane")
        end
    },
}

function AddMarker(id, data)
    if not ZonesListeLTD[id] then 
        ZonesListeLTD[id] = data
    end
end

function RemoveMarker(id)
    ZonesListeLTD[id] = nil
end


CreateThread(function()
    for _,marker in pairs(ZonesListeLTD) do
        if marker.Blip then
            local blip = AddBlipForCoord(marker.Position)

            SetBlipSprite(blip, marker.Blip.Sprite)
            SetBlipScale(blip, marker.Blip.Scale)
            SetBlipColour(blip, marker.Blip.Color)
            SetBlipDisplay(blip, marker.Blip.Display)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(marker.Blip.Name)
            EndTextCommandSetBlipName(blip)
        end
	end

    while not ESX do 
        Wait(1) 
    end

    while true do
        local Interval = 1500

        for k,v in pairs(ZonesListeLTD) do
            if v.Public or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == v.Job or ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == v.Job2 then
                local Coords = GetEntityCoords(PlayerPedId(), false)
                local dist = #(Coords - v.Position)

                if dist < 15 then
                    Interval = 0
                    DrawMarker(2, v.Position.x, v.Position.y, v.Position.z, 0, 0, 0, 0, nil, nil, 0.55, 0.55, 0.55, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, exports.Tree:serveurConfig().Serveur.colorMarkers.a, 0, 1, 0, 0, nil, nil, 0)
                
                    if dist < 3 then
                        ESX.ShowHelpNotification("Appuyez sur E pour intéragir avec le menu")
                        if IsControlJustPressed(1,51) then
                            v.Action(v.Position)
                        end
                    end
                end
            end
        end
        
        Wait(Interval)
	end
end)




function AddZones(zoneName, data)
    if not ZonesListeLTD[zoneName] then
        ZonesListeLTD[zoneName] = data
        -- print("Creation d'une zone (ZoneName:"..zoneName..")")
        return true
    else 
        -- print("Tentative de cree une zone qui exise deja (ZoneName:"..zoneName..")")
        return false
    end
end

local function RemoveZone(zoneName)
    if ZonesListeLTD[zoneName] then
        ZonesListeLTD[zoneName] = nil
        -- print("Suppression d'une zone (ZoneName:"..zoneName..")")
    else 
        -- print("Tentative de supprimer une zone qui exise pas (ZoneName:"..zoneName..")")
    end
end