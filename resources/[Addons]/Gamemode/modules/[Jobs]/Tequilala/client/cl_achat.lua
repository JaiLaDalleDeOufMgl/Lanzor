--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('', 'Frigo Tequilala') 
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function OpenMenuAccueilTequilala() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()

        RageUI.Separator("↓ Boisson ↓")

        RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Vin", nil, {RightLabel = "20$"}, not codesCooldown5 , {
			onSelected = function()
			TriggerServerEvent('Tequilala:BuyVine')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
       end 
    })

        RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Mojito", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyMojito')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Ice Tea", nil, {RightLabel = "8$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyIceTea')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Eau", nil, {RightLabel = "7$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyEau')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Whisky-coca", nil, {RightLabel = "12$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyWhiskycoca')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Coca", nil, {RightLabel = "6$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyCoca')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Limonade", nil, {RightLabel = "7$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyLimonade')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Fanta", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyFanta')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Separator("↓ Nouriture ↓")

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Chips", nil, {RightLabel = "2$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyChips')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Cacahuète", nil, {RightLabel = "1$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyCacahuete')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Olive", nil, {RightLabel = "1$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Tequilala:BuyOlive')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

		end)			
		Wait(0)
	   end
	end)
 end
end

local position = {
    {x = -562.00, y = 286.76, z = 82.17}
}

Citizen.CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tequilala' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    DrawMarker(36, -562.00, 286.76, 82.17, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, exports.Tree:serveurConfig().Serveur.colorMarkers.a, true, true, p19, true)  

                
                    if dist <= 1.0 then
                        --Visual.Subtitle("Appuyer sur "..exports.Tree:serveurConfig().Serveur.color.."[E]~s~ pour intéragir avec le Frigo", 1)
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le frigo.")
                        if IsControlJustPressed(1,51) then
                            OpenMenuAccueilTequilala()
                        end
                    end
                end
            end
        end

        Wait(wait)
    end
end)

