-- MENU FUNCTION --

local open = false 
local tequilalaDeTesMort = RageUI.CreateMenu('', 'Garage Tequilala')
tequilalaDeTesMort.Display.Header = true 
tequilalaDeTesMort.Closed = function()
  open = false
end

function OpenTesMorttequilala()
     if open then 
         open = false
         RageUI.Visible(tequilalaDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(tequilalaDeTesMort, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(tequilalaDeTesMort,function() 

              RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                  if dist4 < 4 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                end
              end, })

-- test
               RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Gestion Véhicule ~s~ ↓")

                RageUI.Button("Véhicule de Fonction", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()

                        ESX.Game.SpawnVehicle('stretch', vector3(-554.98, 304.11, 83.26), 275.59, function (vehicle)
                            local newPlate = exports['Gamemode']:GeneratePlate()
                            SetVehicleNumberPlateText(vehicle, newPlate)
                            exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                            TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        end)
                        RageUI.CloseAll()
                    end
                })

           end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = -565.74, y = 298.21, z = 83.02}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tequilala' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(36, -565.74,298.21,83.02, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 1.3, 1.3, 1.3,250,0,255, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
               ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                if IsControlJustPressed(1,51) then
                  OpenTesMorttequilala()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)


