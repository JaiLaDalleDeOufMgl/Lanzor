menuOpened, menuCat, menus = false, "drugsbuilder", {}

local builder = {
    -- Valeur de base
    name = nil,
    rawItem = nil,
    treatedItem = nil,

    -- Valeur numériques
    harvestCount = nil,
    treatmentCount = nil,
    treatmentReward = nil,
    sellCount = nil,
    sellRewardPerCount = nil,
    sale = nil,

    -- Potisions
    harvest = nil,
    treatement = nil,
    vendor = nil,
}

local function input(TextEntry, ExampleText, MaxStringLenght, isValueInt)
    
	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(1000) 
		blockinput = false 
        if isValueInt then 
            local isNumber = tonumber(result)
            if isNumber then return result else return nil end
        end

		return result
	else
		Citizen.Wait(1000)
		blockinput = false 
		return nil
	end
end

local function canCreateDrug()
    return name ~= nil and name ~= "" and harvestCount ~= nil and harvestCount >= 1 and treatmentCount ~= nil and treatmentCount >= 1 and treatmentReward ~= nil and treatmentReward >= 1 and sellCount ~= nil and sellCount >= 1 and sellRewardPerCount ~= nil and sellRewardPerCount >= 1 and sale ~= nil and harvest ~= nil and treatement ~= nil and vendor ~= nil
end

local function subCat(string)
    return menuCat.."_"..string
end

local function addMenu(name)
    RMenu.Add(menuCat, subCat(name), RageUIv1.CreateMenu("",exports.Tree:serveurConfig().Serveur.color.."Gestion des drogues"))
    RMenu:Get(menuCat, subCat(name)).Closed = function()end
    table.insert(menus, name)
end

local function addSubMenu(name, depend)
    RMenu.Add(menuCat, subCat(name), RageUIv1.CreateSubMenu(RMenu:Get(menuCat, subCat(depend)), "", exports.Tree:serveurConfig().Serveur.color.."Gestion des drogues"))
    RMenu:Get(menuCat, subCat(name)).Closed = function()end
    table.insert(menus, name)
end

local function valueNotDefault(value)
    if not value or value == "" then return "" else return "~s~: ~g~"..tostring(value) end
end

local function okIfDef(value)
    if not value or value == "" then return "" else return "~s~: ~g~Défini" end
end

local function delMenus()
    for k,v in pairs(menus) do 
        RMenu:Delete(menuCat, v)
    end
end

function openMenu35(drugs) 
    local colorVar = "~s~"
    local actualColor = 1
    local colors = {exports.Tree:serveurConfig().Serveur.color.."", exports.Tree:serveurConfig().Serveur.color.."","~o~",exports.Tree:serveurConfig().Serveur.color.."","~c~","~g~",exports.Tree:serveurConfig().Serveur.color..""}

    menuOpened = true
    addMenu("main")
    addSubMenu("builder", "main")
    RageUIv1.Visible(RMenu:Get(menuCat, subCat("main")), true)

    Citizen.CreateThread(function()
        while menuOpened do
            Wait(800)
            if colorVar == "~s~" then colorVar = exports.Tree:serveurConfig().Serveur.color.."" else colorVar = "~s~" end
        end
    end)

    Citizen.CreateThread(function()
        while menuOpened do 
            Wait(500)
            actualColor = actualColor + 1
            if actualColor > #colors then actualColor = 1 end
        end
    end)

    CreateThread(function()
        while menuOpened do
            local shouldClose = true
            RageUIv1.IsVisible(RMenu:Get(menuCat,subCat("main")),true,true,true,function()
                shouldClose = false
                RageUIv1.Separator("↓ ~o~Gestion des drogues ~s~↓")
                local total = 0
                for _,_ in pairs(drugs) do
                    total = total + 1
                end
                if total <= 0 then
                    RageUIv1.ButtonWithStyle(colorVar.."Aucune drogue active", nil, {}, true, function() end)
                else
                    for drugID, drugsInfos in pairs(drugs) do
                        RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~"..drugsInfos.name, nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."Supprimer ~s~→→"}, true, function(_,_,s)
                            if s then
                                shouldClose = true
                                TriggerServerEvent("exedrugs_deletedrug", drugID)
                            end
                        end)
                    end
                end
                RageUIv1.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Création d'une drogue ~s~↓")
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Créer une drogue", nil, {}, true, function(_,_,s)

                end, RMenu:Get(menuCat, subCat("builder")))
            end, function()    
            end, 1)

            RageUIv1.IsVisible(RMenu:Get(menuCat,subCat("builder")),true,true,true,function()
                shouldClose = false
                -- Informations de base
                RageUIv1.Separator("↓ ~g~Informations de base ~s~↓")
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Nom de la drogue"..valueNotDefault(builder.name), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir le nom de votre drogue", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, false)
                        if result ~= nil then builder.name = result end
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Item non traité"..valueNotDefault(builder.rawItem), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir l'item non traité", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, false)
                        if result ~= nil then builder.rawItem = result end
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Item traité"..valueNotDefault(builder.treatedItem), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir l'item traité", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, false)
                        if result ~= nil then builder.treatedItem = result end
                    end
                end)
                RageUIv1.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Valeur numériques ~s~↓")
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Récompense récolte"..valueNotDefault(builder.harvestCount), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir la récompense (x items) pour une récolte", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.harvestCount = result end
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Nécéssaire traitement"..valueNotDefault(builder.treatmentCount), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir combien de votre drogue sont nécéssaire pour la transformer", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.treatmentCount = result end
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Récompense traitement"..valueNotDefault(builder.treatmentReward), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir la récompense (x items) pour un traitement", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.treatmentReward = result end
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Nécéssaire revente"..valueNotDefault(builder.sellCount), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir combien de votre drogue sont nécéssaire pour la vendre", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.sellCount = result end
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Récompense revente"..valueNotDefault(builder.sellRewardPerCount), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir la récompense (x items) pour une revente", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 20, true)
                        if result ~= nil then builder.sellRewardPerCount = result end
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Récompense argent"..valueNotDefault(builder.sale), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir l'argent sale (1) ou propre(0)", {}, true, function(_,_,s)
                    if s then
                        local result = input("Drugs builder", "", 1, true)
                        if result ~= nil then builder.sale = result end
                    end
                end)
                -- Positions et points
                RageUIv1.Separator("↓ ~o~Configuration des points ~s~↓")
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Position récolte"..okIfDef(builder.harvest), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir la position de la récolte", {RightLabel = exports.Tree:serveurConfig().Serveur.color.."Définir ~s~→→"}, true, function(_,_,s)
                    if s then
                        local pos = GetEntityCoords(PlayerPedId())
                        builder.harvest = {x = pos.x, y = pos.y, z = pos.z}
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Position traitement"..okIfDef(builder.treatement), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir la position du traitement", {RightLabel = exports.Tree:serveurConfig().Serveur.color.."Définir ~s~→→"}, true, function(_,_,s)
                    if s then
                        local pos = GetEntityCoords(PlayerPedId())
                        builder.treatement = {x = pos.x, y = pos.y, z = pos.z}
                    end
                end)
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~s~Position revente"..okIfDef(builder.vendor), exports.Tree:serveurConfig().Serveur.color.."Description: ~s~vous permets de définir la position de la revente", {RightLabel = exports.Tree:serveurConfig().Serveur.color.."Définir ~s~→→"}, true, function(_,_,s)
                    if s then
                        local pos = GetEntityCoords(PlayerPedId())
                        builder.vendor = {x = pos.x, y = pos.y, z = pos.z}
                    end
                end)
                -- Interactions
                RageUIv1.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.." Actions ~s~↓")
                RageUIv1.ButtonWithStyle(colors[actualColor].."→ ~g~Sauvegarder et appliquer", exports.Tree:serveurConfig().Serveur.color.."Description: ~s~une fois toutes les étapes effectuées, sauvegardez votre drogue", {RightLabel = "→→"}, true, function(_,_,s)
                    if s then
                        shouldClose = true
                        ESX.ShowNotification("~o~Création de la drogue en cours...")
                        TriggerServerEvent("exedrugs_create", builder)
                    end
                end)
            end, function()    
            end, 1)


            if shouldClose and menuOpened then
                menuOpened = false
            end

            Wait(0)
        end

        delMenus()
    end)
end