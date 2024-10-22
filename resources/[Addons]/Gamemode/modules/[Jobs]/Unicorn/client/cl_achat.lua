--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('', 'Frigo Unicorn') 
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function OpenMenuAccueilUnicorn() 
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
			TriggerServerEvent('Unicorn:BuyVine')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
       end 
    })

        RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Mojito", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyMojito')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Ice Tea", nil, {RightLabel = "8$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyIceTea')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Eau", nil, {RightLabel = "7$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyEau')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Whisky-coca", nil, {RightLabel = "12$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyWhiskycoca')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Coca", nil, {RightLabel = "6$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyCoca')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Limonade", nil, {RightLabel = "7$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyLimonade')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Fanta", nil, {RightLabel = "10$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyFanta')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Separator("↓ Nouriture ↓")

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Chips", nil, {RightLabel = "2$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyChips')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Cacahuète", nil, {RightLabel = "1$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyCacahuete')	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
    })

    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Acheter~s~ x1 Olive", nil, {RightLabel = "1$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('Unicorn:BuyOlive')	
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
    {x = 131.92, y = -1322.12, z = 19.40}
}

Citizen.CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    DrawMarker(36, 131.92, -1322.12, 19.40, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, exports.Tree:serveurConfig().Serveur.colorMarkers.a, true, true, p19, true)  

            
                    if dist <= 1.0 then
                        --Visual.Subtitle("Appuyer sur "..exports.Tree:serveurConfig().Serveur.color.."[E]~s~ pour intéragir avec le Frigo", 1)
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le frigo.")
                        if IsControlJustPressed(1,51) then
                            OpenMenuAccueilUnicorn()
                        end
                    end
                end
            end
        end

        Wait(wait)
    end
end)

