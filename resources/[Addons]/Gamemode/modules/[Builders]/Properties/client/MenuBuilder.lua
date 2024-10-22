
RegisterCommand("openProperties", function()
    if ESX.PlayerData.job.name == "realestateagent" then 
        OpenMenuProperties()
    end
end)

local List = {
    Actions = {
        "Déposer",
        "Prendre"
    },
    ActionIndex = 1
}

function DestroyCamProperties()
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', false)
	SetCamActive(cam,  false)	
	FreezeEntityPosition(PlayerPedId(), false)
	RenderScriptCams(false,  false,  0,  false,  false)
    SetFocusEntity(PlayerPedId())
end

function OpenMenuProperties()
    local menu = RageUI.CreateMenu('', "Paramètre disponibles")

    local DATA = {
        NAME = "", 
        LABEL = "",
        PRICE = 0,
        INTERIORSELECTED = nil,
        POIDS = 0,
        POSITION = {
            ENTER = nil,
            EXIT = nil, 
            COFFRE = nil
        }
    }
    local MENU = {
        MAKEVISUAL = false,
        LIST = {
            LIST = {
                { Name = "Entrepot (grand) "..exports.Tree:serveurConfig().Serveur.color.."[VIP]~s~", Value = "Entrepot1"},
                { Name = "Entrepot (moyen)", Value = "Entrepot2"},
                { Name = "Entrepot (petit)", Value = "Entrepot3"},
    
                { Name = "Appartement Moderne", Value = "Appartement1" },
                { Name = "Appartement Modeste", Value = "Appartement2" },
                { Name = "Appartement Luxueux #1", Value = "Appartement3" },
                { Name = "Appartement Luxueux #2", Value = "Appartement4" },
                { Name = "Appartement Luxueux #3", Value = "Appartement5" },
                -- { Name = "Appartement Luxueux #4", Value = "Appartement6" },
    
                { Name = "Villa "..exports.Tree:serveurConfig().Serveur.color.."[VIP]~s~ #1", Value = "Villa1" },
                { Name = "Villa "..exports.Tree:serveurConfig().Serveur.color.."[VIP]~s~ #2", Value = "Villa2" },
    
                { Name = "Bureau "..exports.Tree:serveurConfig().Serveur.color.."[VIP]~s~ #1", Value = "Bureau1" },
                { Name = "Bureau #2", Value = "Bureau2" },
            },
            INDEX = 1
        }
    }
    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)

        RageUI.IsVisible(menu, function()
            RageUI.List("Intérieur", MENU.LIST.LIST, MENU.LIST.INDEX, "Prix : ~s~"..DATA.PRICE..exports.Tree:serveurConfig().Serveur.color.."$\n~s~Poids : ~s~"..DATA.POIDS..exports.Tree:serveurConfig().Serveur.color.."Kg", {}, true, {
                onListChange = function(Index, Item)
                    MENU.LIST.INDEX = Index;
                    if MENU.MAKEVISUAL then
                        CreatCamPorperties(Item.Value)
                    end
                    DATA.INTERIORSELECTED = Item.Value
                    DATA.PRICE = Propeties.List[Item.Value].PRIX
                    DATA.POIDS = Propeties.List[Item.Value].POIDS
                    DATA.POSITION.ENTER = Propeties.List[Item.Value].INSIDE
                    DATA.POSITION.COFFRE = Propeties.List[Item.Value].ROOM_MENU
                end
            })
            local RightLabelExit 
            if DATA.POSITION.EXIT == nil then 
                RightLabelExit = exports.Tree:serveurConfig().Serveur.color.."Non définis"
            else 
                RightLabelExit = exports.Tree:serveurConfig().Serveur.color.."Définis"
            end
            
            RageUI.Button('Position de l\'entrée', nil, {RightLabel = RightLabelExit}, true, {
                onSelected = function() 
                    if not MENU.MAKEVISUAL then
                        local pPed = PlayerPedId()
                        local pCoords = GetEntityCoords(pPed)
                        DATA.POSITION.EXIT = pCoords
                    else 
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Création de Propriete~s~\nVous devez désactiver la visualisation.")
                    end
                end
            })
            if not exports.Gamemode:IsInSafeZone() then
                RageUI.Button('Valider', exports.Tree:serveurConfig().Serveur.color.."Veuillez bien remplir chacun des paramètres présents.", {RightLabel = "→"},  DATA.POIDS ~= nil and DATA.POSITION.EXIT ~= nil, {
                    onSelected = function() 
                        TriggerServerEvent("Properties:CreatedProperties", DATA)
                        RageUI.CloseAll()
                        DestroyCamProperties()
                    end
                })
            else
                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Impossible en safe zone !")
            end
        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
            DestroyCamProperties()
        end
    end
end
