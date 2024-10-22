local PositionAscEMS = {
    {x = -1869.81, y = -308.82, z = 41.25},
    {x = -1835.56, y = -339.36, z = 58.15},
}

CreateThread(function()
    while true do
        local Sleep = 1000
        local pCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(PositionAscEMS) do
            local distance = #(vector3(pCoords.x, pCoords.y, pCoords.z) - vector3(PositionAscEMS[k].x, PositionAscEMS[k].y, PositionAscEMS[k].z))
			if distance <= 15 then
				Sleep = 0
				DrawMarker(2, PositionAscEMS[k].x, PositionAscEMS[k].y, PositionAscEMS[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3,250,0,255, 255, 0, 0, 0, 1, nil, nil, 0)
			
				if distance <= 1.5 then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour prendre l'ascenseur")
					if IsControlJustPressed(0, 51) then
						openAsc()
					end
				end
			end
        end

        Wait(Sleep)
    end
end)

openAsc = function()
    local mainMenuNord = RageUI.CreateMenu("", "Choisissez un étage")

    RageUI.Visible(mainMenuNord, not RageUI.Visible(mainMenuNord))

    while mainMenuNord do
        RageUI.IsVisible(mainMenuNord, function()
            RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."[2]~s~ Helipad", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    DoScreenFadeOut(1000)
                    Citizen.Wait(5000)
                    DoScreenFadeIn(5000)
                    SetEntityCoords(PlayerPedId(),-1835.56, -339.36, 58.15)

                end
            })
            RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."[1]~s~ Rez de chaussée", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    DoScreenFadeOut(1000)
                    Citizen.Wait(5000)
                    DoScreenFadeIn(5000)
                    SetEntityCoords(PlayerPedId(),-1869.81, -308.82, 41.25)


                end
            })
        end)
        if not RageUI.Visible(mainMenuNord) then
            mainMenuNord = RMenu:DeleteType(mainMenuNord, true)
        end
        Citizen.Wait(0)
    end
end