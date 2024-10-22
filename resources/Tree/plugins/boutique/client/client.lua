local data = {
    ranks                        = 0,
    coins                        = 0,
    id                           = 0,
    vip                          = 0,
    history                      = {},
    vehicle                      = {},
    limited                      = {},
    weapon                       = {},
    mysterybox                   = {},
    mysteryboxSelect             = {},
    mysteryboxSelectPrevisualize = {},
    inventory                    = {},
    pack                         = {},
    viplist                      = {},
    optionVip                    = {
        drift = false,
        peds = {
            { label = "Singe",           model = "a_c_chimp" },
            { label = "Sanglier",        model = "a_c_boar" },
            { label = "Chat",            model = "a_c_cat_01" },
            { label = "Vache",           model = "a_c_cow" },
            { label = "Coyote",          model = "a_c_coyote" },
            { label = "Chien",           model = "a_c_chop" },
            { label = "Cerf",            model = "a_c_deer" },
            { label = "Poule",           model = "a_c_hen" },
            { label = "Husky",           model = "a_c_husky" },
            { label = "Lion",            model = "a_c_mtlion" },
            { label = "Cochon",          model = "a_c_pig" },
            { label = "Chi-WaWa",        model = "a_c_poodle" },
            { label = "Buldog",          model = "a_c_pug" },
            { label = "Lapin",           model = "a_c_rabbit_01" },
            { label = "Rat",             model = "a_c_rat" },
            { label = "Chien Retriever", model = "a_c_retriever" },
            { label = "Singe 2",         model = "a_c_rhesus" },
            { label = "Rottweiler",      model = "a_c_rottweiler" },
            { label = "Chien Shepherd",  model = "a_c_shepherd" },
            { label = "Chien Terrier",   model = "a_c_westy" },
        }
    }
}

local loaded = {
    vehicle = false,
    weapon = false,
    object = false,
    mysteryBoxLoaded = false,
    MysteryBoxVehicle = false,
    MysteryBoxWeapons = false,
    isAllBoutiqueLoaded = false
}
local boxColor = ""
local editMode = false
local editModeIndex = 1
local mysteryBoxEditIndex = 1
local buyerIndex = 1
local mysteryBoxRarityIndex = 1
local numberOfitems = 0
local jspfrere
local editModeList = { "Modifier le prix", "Modifier le label", "Modifier le model", "Modifier la description",
    "Modifier la caisse", "Supprimer" }
local buyerList = { "Acheter", "Prévoir" }
local editMysteryBoxList = { "Modifier la probabilité", "Modifier le label", "Modifier le name", "Ajouter un item",
    "Supprimer" }
local mysteryBoxRarityList = { "argent", "vert", "diamant", "violet", "dorée", "bleu", "vert foncé" }
local mysteryBoxItems = {
    items = {},
    vehicles = {},
    weapons = {}
}

function loadTable2(object)
    for k, v in pairs(object) do
        if IsModelValid(GetHashKey(v)) then
            RequestModel(GetHashKey(v))
            while not HasModelLoaded(GetHashKey(v)) do
                Wait(0)
            end
        end
    end
    return true
end

local vehicleMysteryBox = {
    "sq7", "21rsq8", "4444", "a45", "bmci", "rmode63s", "rmodx6", "alpinab7",
    "amggt63", "aeroxdrag", "ksd", "urus", "amggtr", "bmwg07", "bmwm8wb",
    "cls63", "monza", "rmode63s", "rmodjeep", "HycadeSubaru", "KeyvanyRSQ3", "rmodmk7",
    "rs7abt2", "370z", "206wrc", "718gt4rs", "812mansory", "teslapd", "skyline", "RAPTOR150",
    "19dbs", "20xb7", "650s", "taycants21m", "vanquishzs"
}

local weaponMysteryBox = {
    "WEAPON_ALIEN", "WEAPON_REDL", "WEAPON_TEC9MF", "WEAPON_SIG550",
    "WEAPON_GUARD", "WEAPON_357", "WEAPON_OBLIVION", "WEAPON_ANCIENT", "WEAPON_BLASTAK",
    "WEAPON_BLASTM4", "WEAPON_COACHGUN", "WEAPON_DESERTNIKE", "WEAPON_DESERTPURPLE",
    "WEAPON_GRAU", "WEAPON_UZILS", "WEAPON_SCARSC", "WEAPON_SOVEREIGN", "WEAPON_SNAKE",
    "WEAPON_KINETIC", "WEAPON_BLUERIOT", "WEAPON_VSCO", "WEAPON_SCAR17", "WEAPON_BONEPER"
}

local function getRarity(probabilityID)
    for _, rarity in pairs(Tree.Config.MysteryBoxRarityLevel) do
        if probabilityID == rarity.probabilityID then
            return rarity.name, rarity.color
        end
    end
    return "Inconnu", "Inconnu"
end

CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsPlayerActive(PlayerId()) then
            Tree.TriggerServerCallback("Plugins:Boutique:GetInfo", function()
            end)
            break
        end
    end
end)

local BoutiqueMain = function(isOwner)
    Tree.Menu.CloseAll()
    local MainMenu = Tree.Menu.CreateMenu("", "Boutique")
    local HistoryMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "Historique des achats")
    local Inventory = Tree.Menu.CreateSubMenu(MainMenu, "", "Inventaire")
    local VehicleMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "Sélectionnez un véhicule")
    local LimitedMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "Véhicules limités")
    local WeaponMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "Sélectionnez une arme")
    local MysteryBoxMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "Caisse Mystère")
    local MysteryBoxMenuPrevisualize = Tree.Menu.CreateSubMenu(MysteryBoxMenu, "", "Prévisualiser la caisse")
    local MysteryBoxMenuQuantity = Tree.Menu.CreateSubMenu(MysteryBoxMenu, "", "Caisse Mystère")
    local MysteryBoxCreator = Tree.Menu.CreateSubMenu(MysteryBoxMenu, "", "Créer une caisse mystère")
    local MysteryBoxModifier = Tree.Menu.CreateSubMenu(MysteryBoxMenu, "", "Modifier une caisse mystère")
    local PackMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "Packs")
    local VipListMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "VIP")
    local PedsMenu = Tree.Menu.CreateSubMenu(MainMenu, "", "Peds")
    Tree.Menu.Visible(MainMenu, true)
    CreateThread(function()
        CreateThread(function()
            if loaded.isAllBoutiqueLoaded then
                return
            end
            loaded.vehicle = Tree.Entity.Object.loadTable(data.vehicle)
            loaded.weapon = Tree.Entity.Object.loadTable(data.weapon)
            loaded.object = Tree.Entity.Object.loadTable(data.pack)
            loaded.MysteryBoxWeapons = true
            loaded.MysteryBoxVehicle = true
            loaded.isAllBoutiqueLoaded = true
        end)
        while MainMenu do
            MainMenu.Closed = function()
                Tree.Menu.Visible(MainMenu, false)
                MainMenu = false
                Tree.Entity.Vehicle.deleteMovingVehicle()
                Tree.Entity.Weapon.deleteMovingWeapon()
                Tree.Entity.Object.deleteMovingObject()
            end
            if data.inventory then
                numberOfitems = 0
                for k, v in pairs(data.inventory) do
                    numberOfitems = numberOfitems + 1
                end
            end
            if loaded.MysteryBoxVehicle and loaded.MysteryBoxWeapons then
                loaded.MysteryBoxLoaded = true
            end
            Tree.Menu.IsVisible(MainMenu, function()
                Tree.Menu.Info(
                    "Bienvenue sur la boutique " .. Tree.Config.Serveur.color .. GetPlayerName(PlayerId()) .. "~s~ !",
                    { "Coins", "VIP", "Identifiant Boutique" },
                    { Tree.Config.Serveur.color .. "" .. data.coins .. "~s~", Tree.Config.VipRanks[data.vip], data.id },
                    450)
                Tree.Menu.Button("Accéder au site web", nil, {}, true, {
                    onSelected = function()
                        TriggerEvent("Link:Send", exports.Tree:serveurConfig().Serveur.boutique)
                    end
                })
                Tree.Menu.Button("Historique", nil, {}, true, {}, HistoryMenu)
                Tree.Menu.Button("Inventaire [" .. Tree.Config.Serveur.color .. (numberOfitems) .. "x~s~]", nil, {}, true,
                    {
                        onSelected = function()
                            if numberOfitems == 0 then
                                ESX.ShowNotification("Vous n'avez aucun item dans votre inventaire.")
                            else
                                Tree.Menu.CloseAll()
                                Tree.Menu.Visible(Inventory, true)
                            end
                        end
                    })
                Tree.Menu.Line()
                Tree.Menu.Button("Véhicules", nil, {}, loaded.vehicle, {}, VehicleMenu)
                Tree.Menu.Button("Véhicules Limité [" .. Tree.Config.Serveur.color .. (#data.limited or 0) .. "x~s~]",
                    nil, {}, loaded.vehicle, {
                        onSelected = function()
                            if editMode then
                                Tree.Menu.CloseAll()
                                Tree.Menu.Visible(LimitedMenu, true)
                            elseif #data.limited == 0 then
                                ESX.ShowNotification("Il n'y a pas de véhicules limités.")
                            else
                                Tree.Menu.CloseAll()
                                Tree.Menu.Visible(LimitedMenu, true)
                            end
                        end
                    })
                Tree.Menu.Button("Armes", nil, {}, loaded.weapon, {}, WeaponMenu)
                Tree.Menu.Button("Caisse Mystère", nil, {}, loaded.MysteryBoxLoaded, {}, MysteryBoxMenu)
                Tree.Menu.Button("Packs", nil, {}, loaded.object, {}, PackMenu)
                Tree.Menu.Button("VIP", nil, {}, true, {}, VipListMenu)
                Tree.Menu.Line()
                Tree.Menu.Separator("Options: " .. Tree.Config.VipRanks[data.vip])
                if data.vip > 0 then
                    if data.vip > 1 then
                        Tree.Menu.Checkbox("Mode Drift", nil, data.optionVip.drift, {}, {
                            onSelected = function(index)
                                data.optionVip.drift = index
                            end
                        })
                    end
                    Tree.Menu.Button("Menu Peds", nil, {}, true, {}, PedsMenu)
                end
                if isOwner then
                    Tree.Menu.Line()
                    Tree.Menu.Checkbox("Mode éditeur", nil, editMode, {}, {
                        onSelected = function(index)
                            editMode = index
                        end
                    })
                end
            end, MainMenu)

            Tree.Menu.IsVisible(HistoryMenu, function()
                Tree.Menu.Info(
                    "Bienvenue sur la boutique " .. Tree.Config.Serveur.color .. GetPlayerName(PlayerId()) .. "~s~ !",
                    { "Coins", "Identifiant Boutique" }, { Tree.Config.Serveur.color .. data.coins .. "~s~", data.id },
                    450)
                for k, v in pairs(data.history) do
                    Tree.Menu.Button(v.type .. " - " .. v.model, nil,
                        {
                            RightLabel = Tree.Config.Serveur.color .. v.price .. "~s~",
                            RightBadge = Tree.Menu.BadgeStyle
                                .GoldMedal
                        }, true, {})
                end
            end)

            Tree.Menu.IsVisible(Inventory, function()
                for k, v in pairs(data.inventory) do
                    Tree.Menu.Button(v.type .. " - " .. v.label, nil,
                        { RightLabel = Tree.Config.Serveur.color .. "Utiliser" }, true, {
                            onSelected = function()
                                if exports.Gamemode:IsInSafeZone() then
                                    TriggerServerEvent("Plugins:Boutique:ConsumeMysteryBox", v.model)
                                    Tree.Menu.CloseAll()
                                else
                                    ESX.ShowNotification("Vous ne pouvez pas utiliser d'item en dehors de la zone safe.")
                                end
                            end
                        })
                end
            end)

            Tree.Menu.IsVisible(VehicleMenu, function()
                Tree.Menu.Info(
                    "Bienvenue sur la boutique " .. Tree.Config.Serveur.color .. GetPlayerName(PlayerId()) .. "~s~ !",
                    { "Coins", "Identifiant Boutique" }, { Tree.Config.Serveur.color .. data.coins .. "~s~", data.id },
                    450)
                VehicleMenu.Closed = function()
                    Tree.Entity.Vehicle.deleteMovingVehicle()
                end
                if editMode then
                    for k, v in pairs(data.vehicle) do
                        Tree.Menu.List(v.label, editModeList, editModeIndex, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onListChange = function(Index)
                                    editModeIndex = Index
                                end,
                                onSelected = function(index)
                                    if index == 1 then
                                        local price = Tree.Function.Visual.KeyboardInput("Prix")
                                        if price == nil then return end
                                        if price == "" then return end
                                        if pricve == "0" then return end
                                        if not tonumber(price) then return end
                                        TriggerServerEvent("Plugins:Boutique:changePriceMode", "vehicle", v.model,
                                            tonumber(price))
                                    elseif index == 2 then
                                        local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "",
                                            30)
                                        if label == nil then return end
                                        if label == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeLabelMode", "vehicle", v.model, label)
                                    elseif index == 3 then
                                        local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "",
                                            30)
                                        if model == nil then return end
                                        if model == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeModelMode", "vehicle", v.model, model)
                                    elseif index == 4 then
                                        local description = Tree.Function.Visual.KeyboardInput("Description",
                                            "Entrez la description", "", 100)
                                        if description == nil then return end
                                        if description == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeDescriptionMode", "vehicle", v.model,
                                            description)
                                    elseif index == 5 then
                                        TriggerServerEvent('Plugins:Boutique:removeOffreBoutique', "vehicle", v.model)
                                    end
                                end,
                                onActive = function()
                                    Tree.Entity.Vehicle.spawnMovingVehicle(v.model)
                                end,
                            })
                    end
                    Tree.Menu.Line()
                    Tree.Menu.Button("Ajouter un vehicule", nil, {}, true, {
                        onSelected = function()
                            local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "", 30)
                            if label == nil then return end
                            if label == "" then return end
                            local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "", 30)
                            if model == nil then return end
                            if model == "" then return end
                            local price = Tree.Function.Visual.KeyboardInput("Prix")
                            if price == nil then return end
                            if price == "" then return end
                            if price == "0" then return end
                            if not tonumber(price) then return end
                            local description = Tree.Function.Visual.KeyboardInput("Description", "Entrez la description",
                                "", 100)
                            if description == nil then return end
                            if description == "" then return end
                            TriggerServerEvent("Plugins:Boutique:addOffreBoutique", "vehicle", label, model,
                                tonumber(price), description)
                        end,
                        onActive = function()
                            Tree.Entity.Vehicle.deleteMovingVehicle()
                        end,
                    })
                else
                    for k, v in pairs(data.vehicle) do
                        Tree.Menu.Button(v.label, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onActive = function()
                                    Tree.Entity.Vehicle.spawnMovingVehicle(v.model)
                                end,
                                onSelected = function()
                                    local comfirmation = Tree.Function.Visual.KeyboardInput(
                                        "Voulez-vous vraiment acheter ce véhicule ? (oui / non)")
                                    if comfirmation == "oui" then
                                        TriggerServerEvent('Plugins:Boutique:BuyVehicle', v.model)
                                        Tree.Entity.Vehicle.deleteMovingVehicle()
                                        Tree.Menu.CloseAll()
                                    else
                                        ESX.ShowNotification("Achat annulé.")
                                    end
                                end
                            })
                    end
                end
            end)

            Tree.Menu.IsVisible(LimitedMenu, function()
                Tree.Menu.Info(
                    "Bienvenue sur la boutique " .. Tree.Config.Serveur.color .. GetPlayerName(PlayerId()) .. "~s~ !",
                    { "Coins", "Identifiant Boutique" }, { Tree.Config.Serveur.color .. data.coins .. "~s~", data.id },
                    450)
                LimitedMenu.Closed = function()
                    Tree.Entity.Vehicle.deleteMovingVehicle()
                end
                if editMode then
                    for k, v in pairs(data.limited) do
                        Tree.Menu.List(v.label, editModeList, editModeIndex, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onListChange = function(Index)
                                    editModeIndex = Index
                                end,
                                onSelected = function(index)
                                    if index == 1 then
                                        local price = Tree.Function.Visual.KeyboardInput("Prix")
                                        if price == nil then return end
                                        if price == "" then return end
                                        if pricve == "0" then return end
                                        if not tonumber(price) then return end
                                        TriggerServerEvent("Plugins:Boutique:changePriceMode", "limited", v.model,
                                            tonumber(price))
                                    elseif index == 2 then
                                        local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "",
                                            30)
                                        if label == nil then return end
                                        if label == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeLabelMode", "limited", v.model, label)
                                    elseif index == 3 then
                                        local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "",
                                            30)
                                        if model == nil then return end
                                        if model == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeModelMode", "limited", v.model, model)
                                    elseif index == 4 then
                                        local description = Tree.Function.Visual.KeyboardInput("Description",
                                            "Entrez la description", "", 100)
                                        if description == nil then return end
                                        if description == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeDescriptionMode", "limited", v.model,
                                            description)
                                    elseif index == 5 then
                                        TriggerServerEvent('Plugins:Boutique:removeOffreBoutique', "limited", v.model)
                                    end
                                end,
                                onActive = function()
                                    Tree.Entity.Vehicle.deleteMovingVehicle()
                                end,
                            })
                    end
                    Tree.Menu.Line()
                    Tree.Menu.Button("Ajouter un vehicule", nil, {}, true, {
                        onSelected = function()
                            local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "", 30)
                            if label == nil then return end
                            if label == "" then return end
                            local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "", 30)
                            if model == nil then return end
                            if model == "" then return end
                            local price = Tree.Function.Visual.KeyboardInput("Prix")
                            if price == nil then return end
                            if price == "" then return end
                            if price == "0" then return end
                            if not tonumber(price) then return end
                            local description = Tree.Function.Visual.KeyboardInput("Description", "Entrez la description",
                                "", 100)
                            if description == nil then return end
                            if description == "" then return end
                            TriggerServerEvent("Plugins:Boutique:addOffreBoutique", "limited", label, model,
                                tonumber(price), description)
                        end,
                        onActive = function()
                            Tree.Entity.Vehicle.deleteMovingVehicle()
                        end,
                    })
                else
                    for k, v in pairs(data.limited) do
                        Tree.Menu.Button(v.label, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onActive = function()
                                    Tree.Entity.Vehicle.spawnMovingVehicle(v.model)
                                end,
                                onSelected = function()
                                    local comfirmation = Tree.Function.Visual.KeyboardInput(
                                        "Voulez-vous vraiment acheter ce véhicule ? (oui / non)")
                                    if comfirmation == "oui" then
                                        TriggerServerEvent('Plugins:Boutique:BuyLimited', v.model)
                                        Tree.Entity.Vehicle.deleteMovingVehicle()
                                        Tree.Menu.CloseAll()
                                    else
                                        ESX.ShowNotification("Achat annulé.")
                                    end
                                end
                            })
                    end
                end
            end)

            Tree.Menu.IsVisible(WeaponMenu, function()
                Tree.Menu.Info(
                    "Bienvenue sur la boutique " .. Tree.Config.Serveur.color .. GetPlayerName(PlayerId()) .. "~s~ !",
                    { "Coins", "Identifiant Boutique" }, { Tree.Config.Serveur.color .. data.coins .. "~s~", data.id },
                    450)
                WeaponMenu.Closed = function()
                    Tree.Entity.Weapon.deleteMovingWeapon()
                end

                if editMode then
                    for k, v in pairs(data.weapon) do
                        Tree.Menu.List(v.label, editModeList, editModeIndex, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onListChange = function(Index)
                                    editModeIndex = Index
                                end,
                                onSelected = function(index)
                                    if index == 1 then
                                        local price = Tree.Function.Visual.KeyboardInput("Prix")
                                        if price == nil then return end
                                        if price == "" then return end
                                        if pricve == "0" then return end
                                        if not tonumber(price) then return end
                                        TriggerServerEvent("Plugins:Boutique:changePriceMode", "weapon", v.model,
                                            tonumber(price))
                                    elseif index == 2 then
                                        local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "",
                                            30)
                                        if label == nil then return end
                                        if label == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeLabelMode", "weapon", v.model, label)
                                    elseif index == 3 then
                                        local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "",
                                            30)
                                        if model == nil then return end
                                        if model == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeModelMode", "weapon", v.model, model)
                                    elseif index == 4 then
                                        local description = Tree.Function.Visual.KeyboardInput("Description",
                                            "Entrez la description", "", 100)
                                        if description == nil then return end
                                        if description == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeDescriptionMode", "weapon", v.model,
                                            description)
                                    elseif index == 5 then
                                        TriggerServerEvent('Plugins:Boutique:removeOffreBoutique', "weapon", v.model)
                                    end
                                end,
                                onActive = function()
                                    Tree.Entity.Weapon.spawnMovingWeapon(string.upper(v.model))
                                end,
                            })
                    end
                    Tree.Menu.Line()
                    Tree.Menu.Button("Ajouter une arme", nil, {}, true, {
                        onSelected = function()
                            local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "", 30)
                            if label == nil then return end
                            if label == "" then return end
                            local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "", 30)
                            if model == nil then return end
                            if model == "" then return end
                            local price = Tree.Function.Visual.KeyboardInput("Prix")
                            if price == nil then return end
                            if price == "" then return end
                            if price == "0" then return end
                            if not tonumber(price) then return end
                            local description = Tree.Function.Visual.KeyboardInput("Description", "Entrez la description",
                                "", 100)
                            if description == nil then return end
                            if description == "" then return end
                            TriggerServerEvent("Plugins:Boutique:addOffreBoutique", "weapon", label, model,
                                tonumber(price), description)
                        end,
                        onActive = function()
                            Tree.Entity.Weapon.deleteMovingWeapon()
                        end
                    })
                else
                    for k, v in pairs(data.weapon) do
                        Tree.Menu.Button(v.label, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onActive = function()
                                    Tree.Entity.Weapon.spawnMovingWeapon(string.upper(v.model))
                                end,
                                onSelected = function()
                                    local comfirmation = Tree.Function.Visual.KeyboardInput(
                                        "Voulez-vous vraiment acheter ce véhicule ? (oui / non)")
                                    if comfirmation == "oui" then
                                        if exports.Gamemode:IsInSafeZone() then
                                            TriggerServerEvent('Plugins:Boutique:BuyWeapon', v.model)
                                            Tree.Entity.Weapon.deleteMovingWeapon()
                                            Tree.Menu.CloseAll()
                                        else
                                            ESX.ShowNotification(
                                                "Vous ne pouvez pas acheter d'arme en dehors de la zone de sécurité.")
                                        end
                                    else
                                        ESX.ShowNotification("Achat annulé.")
                                    end
                                end
                            })
                    end
                end
            end)

            Tree.Menu.IsVisible(MysteryBoxMenu, function()
                if editMode then
                    -- Filtrage pour ramoune Caisse afk
                    local filteredMysteryBoxes = {}
                    for k, v in pairs(data.mysterybox) do
                        if v.label ~= "Caisse AFK" then
                            table.insert(filteredMysteryBoxes, v)
                        end
                    end
                    for k, v in pairs(filteredMysteryBoxes) do
                        Tree.Menu.List(v.label, editModeList, editModeIndex, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onListChange = function(Index)
                                    editModeIndex = Index
                                end,
                                onSelected = function(index)
                                    if index == 1 then
                                        local price = Tree.Function.Visual.KeyboardInput("Prix")
                                        if price == nil then return end
                                        if price == "" then return end
                                        if pricve == "0" then return end
                                        if not tonumber(price) then return end
                                        TriggerServerEvent("Plugins:Boutique:changePriceMode", "mysterybox", v.model,
                                            tonumber(price))
                                    elseif index == 2 then
                                        local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "",
                                            30)
                                        if label == nil then return end
                                        if label == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeLabelMode", "mysterybox", v.model,
                                            label)
                                    elseif index == 3 then
                                        local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "",
                                            30)
                                        if model == nil then return end
                                        if model == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeModelMode", "mysterybox", v.model,
                                            model)
                                    elseif index == 4 then
                                        local description = Tree.Function.Visual.KeyboardInput("Description",
                                            "Entrez la description", "", 100)
                                        if description == nil then return end
                                        if description == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeDescriptionMode", "mysterybox",
                                            v.model,
                                            description)
                                    elseif index == 5 then
                                        jspfrere = v.model
                                        Tree.Menu.CloseAll()
                                        Wait(250)
                                        Tree.Menu.Visible(MysteryBoxModifier, true)
                                    elseif index == 6 then
                                        TriggerServerEvent("Plugins:Boutique:removeOffreBoutique", "mysterybox", v.model)
                                    end
                                end,
                                onActive = function()
                                end,
                            })
                    end
                    Tree.Menu.Line()
                    Tree.Menu.Button("Ajouter une boîte Mystère", nil, {}, true, {}, MysteryBoxCreator)
                else
                    -- Filtrage pour ramoune Caisse afk
                    local filteredMysteryBoxes = {}
                    for k, v in pairs(data.mysterybox) do
                        if v.label ~= "Caisse AFK" then
                            table.insert(filteredMysteryBoxes, v)
                        end
                    end
                    for k, v in pairs(filteredMysteryBoxes) do
                        Tree.Menu.List(v.label, buyerList, buyerIndex, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onListChange = function(Index)
                                    buyerIndex = Index
                                end,
                                onSelected = function(index)
                                    if index == 1 then
                                        mysteryboxSelect = v;
                                        Tree.Menu.Visible(MysteryBoxMenu, false)
                                        Tree.Menu.Visible(MysteryBoxMenuQuantity, true)
                                        Wait(50)
                                    elseif index == 2 then
                                        mysteryboxSelectPrevisualize = v;
                                        Tree.Menu.Visible(MysteryBoxMenu, false)
                                        Tree.Menu.Visible(MysteryBoxMenuPrevisualize, true)
                                    end
                                end,
                                onActive = function()

                                end
                            })

                        --[[Tree.Menu.Button(v.label, nil, {RightLabel = Tree.Config.Serveur.color..v.price, RightBadge = Tree.Menu.BadgeStyle.GoldMedal}, true, {
                            onSelected = function()
                                mysteryboxSelect = v;
                                Tree.Menu.Visible(MysteryBoxMenu, false)
                                Tree.Menu.Visible(MysteryBoxMenuQuantity, true)
                            end,
                            onActive = function()
                                local infoTitle = "Contenu de la caisse: " .. Tree.Config.Serveur.color .. v.label.."~s~"
                                local content = {}

                                for _, weapon in ipairs(v.items.weapons) do
                                    local rarityName, rarityColor = getRarity(tonumber(weapon.probability))
                                    table.insert(content, rarityColor.." ".. weapon.label .. " " .. rarityName.."~s~")
                                end

                                for _, item in ipairs(v.items.items) do
                                    local rarityName, rarityColor = getRarity(tonumber(item.probability))
                                    table.insert(content, rarityColor.." ".. item.label .. " " .. rarityName.."~s~")
                                end

                                for _, vehicle in ipairs(v.items.vehicles) do
                                    local rarityName, rarityColor = getRarity(tonumber(vehicle.probability))
                                    table.insert(content, rarityColor.." ".. vehicle.label .. " " .. rarityName.."~s~")
                                end

                                Tree.Menu.Info(infoTitle, content, {}, 450)
                            end
                        })--]]
                    end
                end
            end)

            Tree.Menu.IsVisible(MysteryBoxMenuPrevisualize, function()
                MysteryBoxMenuPrevisualize.Closed = function()
                    Tree.Entity.Weapon.deleteMovingWeapon()
                    Tree.Entity.Vehicle.deleteMovingVehicle()
                    Tree.Menu.CloseAll()
                end
                Tree.Menu.Line()
                for k, vehicles in pairs(mysteryboxSelectPrevisualize.items.vehicles) do
                    local rarityNamee, rarityColorr = getRarity(tonumber(vehicles.probability))
                    Tree.Menu.Button(vehicles.label, nil,
                        { RightLabel = rarityColorr .. getRarity(tonumber(vehicles.probability)) .. "~s~" }, true, {
                            onActive = function()
                                Tree.Entity.Vehicle.spawnMovingVehicle(vehicles.name)
                            end
                        })
                end
                Tree.Menu.Line()
                for k, items in pairs(mysteryboxSelectPrevisualize.items.items) do
                    local rarityName, rarityColor = getRarity(tonumber(items.probability))
                    Tree.Menu.Button(items.label .. "$", nil,
                        { RightLabel = rarityColor .. getRarity(tonumber(items.probability)) .. "~s~" }, true, {
                            onActive = function()
                                Tree.Entity.Object.spawnMovingObject(items.name)
                            end
                        })
                end
                Tree.Menu.Line()
                for k, weapons in pairs(mysteryboxSelectPrevisualize.items.weapons) do
                    local rarityNamee, rarityColorrr = getRarity(tonumber(weapons.probability))
                    Tree.Menu.Button(weapons.label, nil,
                        { RightLabel = rarityColorrr .. getRarity(tonumber(weapons.probability)) .. "~s~" }, true, {
                            onActive = function()
                                Tree.Entity.Weapon.spawnMovingWeapon(string.upper(weapons.name))
                            end
                        })
                end
            end)

            Tree.Menu.IsVisible(MysteryBoxMenuQuantity, function()
                Tree.Menu.Button("[" .. Tree.Config.Serveur.color .. "1x~s~] " .. mysteryboxSelect.label, nil,
                    {
                        RightLabel = Tree.Config.Serveur.color .. mysteryboxSelect.price,
                        RightBadge = Tree.Menu
                            .BadgeStyle.GoldMedal
                    }, true, {
                        onSelected = function()
                            local comfirmation = Tree.Function.Visual.KeyboardInput(
                                "Voulez-vous vraiment acheter cette boite ? (oui / non)")
                            if comfirmation == "oui" then
                                TriggerServerEvent("Plugins:Boutique:BuyMysteryBox", mysteryboxSelect.model, 1)
                                Wait(150)
                                for k, v in pairs(data.inventory) do
                                    numberOfitems = numberOfitems + 1
                                end
                            else
                                ESX.ShowNotification("Achat annulé.")
                            end
                        end
                    })
                Tree.Menu.Button("[" .. Tree.Config.Serveur.color .. "5x~s~] " .. mysteryboxSelect.label, nil,
                    {
                        RightLabel = Tree.Config.Serveur.color .. mysteryboxSelect.price * 4,
                        RightBadge = Tree.Menu
                            .BadgeStyle.GoldMedal
                    }, true, {
                        onSelected = function()
                            local comfirmation = Tree.Function.Visual.KeyboardInput(
                                "Voulez-vous vraiment acheter ce véhicule ? (oui / non)")
                            if comfirmation == "oui" then
                                TriggerServerEvent("Plugins:Boutique:BuyMysteryBox", mysteryboxSelect.model, 5)
                                Wait(150)
                                for k, v in pairs(data.inventory) do
                                    numberOfitems = numberOfitems + 1
                                end
                            else
                                ESX.ShowNotification("Achat annulé.")
                            end
                        end
                    })
                Tree.Menu.Button("[" .. Tree.Config.Serveur.color .. "10x~s~] " .. mysteryboxSelect.label, nil,
                    {
                        RightLabel = Tree.Config.Serveur.color .. mysteryboxSelect.price * 7,
                        RightBadge = Tree.Menu
                            .BadgeStyle.GoldMedal
                    }, true, {
                        onSelected = function()
                            local comfirmation = Tree.Function.Visual.KeyboardInput(
                                "Voulez-vous vraiment acheter ce véhicule ? (oui / non)")
                            if comfirmation == "oui" then
                                TriggerServerEvent("Plugins:Boutique:BuyMysteryBox", mysteryboxSelect.model, 10)
                            else
                                ESX.ShowNotification("Achat annulé.")
                            end
                        end
                    })
            end)

            Tree.Menu.IsVisible(MysteryBoxCreator, function()
                Tree.Menu.Line()
                Tree.Menu.Button("Ajouter un item", nil, {}, true, {
                    onSelected = function()
                        local itemLabel = Tree.Function.Visual.KeyboardInput("Label de l'item")
                        local itemName = Tree.Function.Visual.KeyboardInput("Name de l'item")
                        local quantity = Tree.Function.Visual.KeyboardInput("Nombre D'item")
                        local itemProbability = Tree.Function.Visual.KeyboardInput(
                            "probabilité de drop (55% = 1, 35% 2, 25% 3, 15% 4, 5% 5")
                        if itemLabel == nil or itemLabel == "" or itemLabel == "0" then return end
                        if itemName == nil or itemName == "" or itemName == "0" then return end
                        if quantity == nil or quantity == "" or quantity == "0" then return end
                        if itemProbability == nil or itemProbability == "" or itemProbability == "0" then return end
                        table.insert(mysteryBoxItems.items,
                            { label = itemLabel, name = itemName, quantity = quantity, probability = itemProbability })
                    end,
                })
                for i, item in ipairs(mysteryBoxItems.items) do
                    Tree.Menu.Button(item.label, nil, {}, true, {
                        onSelected = function()
                        end,
                    })
                end

                Tree.Menu.Line()
                Tree.Menu.Button("Ajouter un véhicule", nil, {}, true, {
                    onSelected = function()
                        local vehicleLabel = Tree.Function.Visual.KeyboardInput("Label du véhicule")
                        local vehicleName = Tree.Function.Visual.KeyboardInput("Name du véhicule")
                        local vehicleProbability = Tree.Function.Visual.KeyboardInput(
                            "probabilité de drop (55% = 1, 35% 2, 25% 3, 15% 4, 5% 5")
                        if vehicleLabel == nil or vehicleLabel == "" or vehicleLabel == "0" then return end
                        if vehicleName == nil or vehicleName == "" or vehicleName == "0" then return end
                        if vehicleProbability == nil or vehicleProbability == "" or vehicleProbability == "0" then return end
                        table.insert(mysteryBoxItems.vehicles,
                            { label = vehicleLabel, name = vehicleName, probability = vehicleProbability })
                    end,
                })
                for i, vehicle in ipairs(mysteryBoxItems.vehicles) do
                    Tree.Menu.Button(vehicle.label, nil, {}, true, {
                        onSelected = function()
                        end,
                    })
                end

                Tree.Menu.Line()
                Tree.Menu.Button("Ajouter une arme", nil, {}, true, {
                    onSelected = function()
                        local weaponLabel = Tree.Function.Visual.KeyboardInput("Label de l'arme")
                        local weaponName = Tree.Function.Visual.KeyboardInput("Name de l'arme")
                        local weaponProbability = Tree.Function.Visual.KeyboardInput(
                            "probabilité de drop (55% = 1, 35% 2, 25% 3, 15% 4, 5% 5")
                        if weaponLabel == nil or weaponLabel == "" or weaponLabel == "0" then return end
                        if weaponName == nil or weaponName == "" or weaponName == "0" then return end
                        if weaponProbability == nil or weaponProbability == "" or weaponProbability == "0" then return end
                        table.insert(mysteryBoxItems.weapons,
                            { label = weaponLabel, name = weaponName, probability = weaponProbability })
                    end,
                })
                for i, weapon in ipairs(mysteryBoxItems.weapons) do
                    Tree.Menu.Button(weapon.label, nil, {}, true, {
                        onSelected = function()

                        end,
                    })
                end
                Tree.Menu.Line()
                Tree.Menu.Button("Recommencer la boîte Mystère", nil, {}, true, {
                    onSelected = function()
                        mysteryBoxItems = {
                            items = {},
                            vehicles = {},
                            weapons = {}
                        }
                    end,
                })
                Tree.Menu.List("Couleur de la caisse", mysteryBoxRarityList, mysteryBoxRarityIndex, nil,
                    { RightLabel = Tree.Config.Serveur.color }, true, {
                        onListChange = function(Index)
                            mysteryBoxRarityIndex = Index
                        end,
                        onSelected = function(index)
                            if index == 1 then
                                boxColor = "common"
                            elseif index == 2 then
                                boxColor = "common"
                            elseif index == 3 then
                                boxColor = "rare"
                            elseif index == 4 then
                                boxColor = "epique"
                            elseif index == 5 then
                                boxColor = "legendair"
                            elseif index == 6 then
                                boxColor = "rare"
                            elseif index == 7 then
                                boxColor = "uncommon"
                            end
                        end
                    })

                Tree.Menu.Button("Créer la boîte Mystère", nil, {}, true, {
                    onSelected = function()
                        if boxColor == nil or boxColor == "" or boxColor == "0" then
                            return
                                ESX.ShowNotification("Sélectionné une couleur.")
                        end
                        local boxLabel = Tree.Function.Visual.KeyboardInput("Label de la boîte Mystère")
                        local boxModel = Tree.Function.Visual.KeyboardInput("Model de la boîte Mystère")
                        local boxPrice = Tree.Function.Visual.KeyboardInput("Prix de la boîte Mystère")
                        if boxLabel == nil or boxLabel == "" or boxLabel == "0" then return end
                        if boxModel == nil or boxModel == "" or boxModel == "0" then return end
                        if boxPrice == nil or boxPrice == "" or boxPrice == "0" then return end
                        TriggerServerEvent("Plugins:Boutique:addMysteryBox", boxLabel, boxColor, boxProps, boxModel,
                            tonumber(boxPrice), mysteryBoxItems)
                    end,
                })
            end)

            Tree.Menu.IsVisible(MysteryBoxModifier, function()
                Tree.Menu.Line()
                for k, v in pairs(data.mysterybox) do
                    if v.model == jspfrere then
                        Tree.Menu.Button("Ajouter un nouvel item", nil,
                            { RightLabel = Tree.Config.Serveur.color, RightBadge = Tree.Menu.BadgeStyle.GoldMedal }, true,
                            {
                                onSelected = function()
                                    local category = Tree.Function.Visual.KeyboardInput(
                                        "Catégorie (vehicles, weapons, items)")
                                    if category == nil or category == "" then return end
                                    if category ~= "vehicles" and category ~= "weapons" and category ~= "items" then
                                        ESX.ShowNotification("Catégorie invalide.")
                                        return
                                    end

                                    local newItemName = Tree.Function.Visual.KeyboardInput("Name de l'item")
                                    if newItemName == nil or newItemName == "" then return end

                                    local newProbability = Tree.Function.Visual.KeyboardInput("Probabilité")
                                    if newProbability == nil or newProbability == "" or newProbability == "0" or not tonumber(newProbability) then return end

                                    local newLabel = Tree.Function.Visual.KeyboardInput("Label de l'item")
                                    if newLabel == nil or newLabel == "" then return end

                                    TriggerServerEvent("Plugins:Boutique:addItemToCase", jspfrere, category, newItemName,
                                        tonumber(newProbability), newLabel)
                                end,
                            })
                        Tree.Menu.Line()
                        for _, items in pairs(v.items) do
                            for _, item in pairs(items) do
                                Tree.Menu.List(item.label, editMysteryBoxList, mysteryBoxEditIndex, nil,
                                    {
                                        RightLabel = Tree.Config.Serveur.color,
                                        RightBadge = Tree.Menu.BadgeStyle
                                            .GoldMedal
                                    }, true, {
                                        onListChange = function(Index)
                                            mysteryBoxEditIndex = Index
                                        end,
                                        onSelected = function(index)
                                            if index == 1 then -- modifier la probabilité
                                                local newProbability = Tree.Function.Visual.KeyboardInput("Probabilité")
                                                if newProbability == nil or newProbability == "" or newProbability == "0" or not tonumber(newProbability) then return end
                                                TriggerServerEvent("Plugins:Boutique:modifyItemInCase", jspfrere,
                                                    item.name,
                                                    tonumber(newProbability), item.name, item.label)
                                                Tree.Menu.CloseAll()
                                            elseif index == 2 then -- modifier le label
                                                local newLabel = Tree.Function.Visual.KeyboardInput("Modifier le label")
                                                if newLabel == nil or newLabel == "" or newLabel == "0" then return end
                                                TriggerServerEvent("Plugins:Boutique:modifyItemInCase", jspfrere,
                                                    item.name,
                                                    item.probability, item.name, newLabel)
                                                Tree.Menu.CloseAll()
                                            elseif index == 3 then -- modifier le name
                                                local newName = Tree.Function.Visual.KeyboardInput("Modifier le name")
                                                if newName == nil or newName == "" or newName == "0" then return end
                                                TriggerServerEvent("Plugins:Boutique:modifyItemInCase", jspfrere,
                                                    item.name,
                                                    item.probability, newName, item.label)
                                                Tree.Menu.CloseAll()
                                            elseif index == 4 then -- ajouter un item
                                                TriggerServerEvent("Plugins:Boutique:removeItemFromCase", jspfrere, item
                                                    .name)
                                                Tree.Menu.CloseAll()
                                            elseif index == 4 then -- supprimer
                                                TriggerServerEvent("Plugins:Boutique:removeItemFromCase", jspfrere, item
                                                    .name)
                                                Tree.Menu.CloseAll()
                                            end
                                        end
                                    })
                            end
                        end
                    end
                end
            end)

            Tree.Menu.IsVisible(PackMenu, function()
                PackMenu.Closed = function()
                    Tree.Entity.Object.deleteMovingObject()
                end

                if editMode then
                    for k, v in pairs(data.pack) do
                        Tree.Menu.List(v.label, editModeList, editModeIndex, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onListChange = function(Index)
                                    editModeIndex = Index
                                end,
                                onSelected = function(index)
                                    if index == 1 then
                                        local price = Tree.Function.Visual.KeyboardInput("Prix")
                                        if price == nil then return end
                                        if price == "" then return end
                                        if pricve == "0" then return end
                                        if not tonumber(price) then return end
                                        TriggerServerEvent("Plugins:Boutique:changePriceMode", "pack", v.model,
                                            tonumber(price))
                                    elseif index == 2 then
                                        local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "",
                                            30)
                                        if label == nil then return end
                                        if label == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeLabelMode", "pack", v.model, label)
                                    elseif index == 3 then
                                        local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "",
                                            30)
                                        if model == nil then return end
                                        if model == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeModelMode", "pack", v.model, model)
                                    elseif index == 4 then
                                        local description = Tree.Function.Visual.KeyboardInput("Description",
                                            "Entrez la description", "", 100)
                                        if description == nil then return end
                                        if description == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeDescriptionMode", "pack", v.model,
                                            description)
                                    elseif index == 5 then
                                        TriggerServerEvent('Plugins:Boutique:removeOffreBoutique', "pack", v.model)
                                    end
                                end,
                                onActive = function()
                                    Tree.Menu.Info("Description: " .. Tree.Config.Serveur.color .. v.label,
                                        { v.description },
                                        {}, 400)
                                    if IsModelValid(GetHashKey(v.model)) then
                                        Tree.Entity.Object.spawnMovingObject(v.model)
                                    end
                                end
                            })
                    end
                    Tree.Menu.Line()
                    Tree.Menu.Button("Ajouter un pack", nil, {}, true, {
                        onSelected = function()
                            local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "", 30)
                            if label == nil then return end
                            if label == "" then return end
                            local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "", 30)
                            if model == nil then return end
                            if model == "" then return end
                            local price = Tree.Function.Visual.KeyboardInput("Prix")
                            if price == nil then return end
                            if price == "" then return end
                            if price == "0" then return end
                            if not tonumber(price) then return end
                            local description = Tree.Function.Visual.KeyboardInput("Description", "Entrez la description",
                                "", 100)
                            if description == nil then return end
                            if description == "" then return end
                            TriggerServerEvent("Plugins:Boutique:addOffreBoutique", "pack", label, model, tonumber(price),
                                description)
                        end,
                        onActive = function()
                            Tree.Entity.Object.deleteMovingObject()
                        end,
                    })
                else
                    Tree.Menu.Button("Starter pack illégal", nil,
                        { RightLabel = Tree.Config.Serveur.color .. "3500", RightBadge = Tree.Menu.BadgeStyle.GoldMedal },
                        true, {
                            onSelected = function()
                                local confirmation = Tree.Function.Visual.KeyboardInput(
                                    "Voulez-vous vraiment acheter ce pack ? (oui / non)")
                                if confirmation == "oui" then
                                    TriggerServerEvent('Plugins:Boutique:receiveStarterPack', "illegal")
                                    Tree.Menu.CloseAll()
                                else
                                    ESX.ShowNotification("Achat annulé.")
                                end
                            end,
                            onActive = function()
                                Tree.Menu.Info("Contenue du starter pack illégal :",
                                    { "Argent sale", "Speedo", "Revolter", "Pain", "Coca", "Pochon de ketamine",
                                        "Beretta",
                                        "Couteau" },
                                    { Tree.Config.Serveur.color .. "x1 500 000$" .. "~s~", Tree.Config.Serveur.color ..
                                    "x1",
                                        Tree.Config.Serveur.color .. "x1", Tree.Config.Serveur.color .. "x50", Tree
                                    .Config
                                    .Serveur.color .. "x50", Tree.Config.Serveur.color .. "x50", Tree.Config.Serveur
                                    .color ..
                                    "x1", Tree.Config.Serveur.color .. "x1" }, 450)
                            end
                        })
                    Tree.Menu.Button("Starter pack légal", nil,
                        { RightLabel = Tree.Config.Serveur.color .. "3000", RightBadge = Tree.Menu.BadgeStyle.GoldMedal },
                        true, {
                            onSelected = function()
                                local confirmation = Tree.Function.Visual.KeyboardInput(
                                    "Voulez-vous vraiment acheter ce pack ? (oui / non)")
                                if confirmation == "oui" then
                                    TriggerServerEvent('Plugins:Boutique:receiveStarterPack', "legal")
                                    Tree.Menu.CloseAll()
                                else
                                    ESX.ShowNotification("Achat annulé.")
                                end
                            end,
                            onActive = function()
                                Tree.Menu.Info("Contenue du starter pack légal :",
                                    { "Argent", "Panto", "Jugular", "Pain", "Coca", "Kit de réparation" },
                                    { "~g~" .. "x1 500 000$" .. "~s~", "~g~" .. "x1", "~g~" .. "x1", "~g~" .. "x50",
                                        "~g~" ..
                                        "x50", "~g~" .. "x10" }, 450)
                            end
                        })

                    for k, v in pairs(data.pack) do
                        Tree.Menu.Button(v.label, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price,
                                RightBadge = Tree.Menu.BadgeStyle
                                    .GoldMedal
                            }, true, {
                                onActive = function()
                                    Tree.Menu.Info("Description: " .. Tree.Config.Serveur.color .. v.label,
                                        { v.description },
                                        {}, 400)
                                    if IsModelValid(GetHashKey(v.model)) then
                                        Tree.Entity.Object.spawnMovingObject(v.model)
                                    else
                                        Tree.Entity.Object.deleteMovingObject()
                                    end
                                end,
                                onSelected = function()
                                    local comfirmation = Tree.Function.Visual.KeyboardInput(
                                        "Voulez-vous vraiment acheter ce véhicule ? (oui / non)")
                                    if comfirmation == "oui" then
                                        TriggerServerEvent('Plugins:Boutique:BuyPack', v.model)
                                        Tree.Entity.Object.deleteMovingObject()
                                        Tree.Menu.CloseAll()
                                    else
                                        ESX.ShowNotification("Achat annulé.")
                                    end
                                end
                            })
                    end
                end
            end)

            Tree.Menu.IsVisible(VipListMenu, function()
                if editMode then
                    for k, v in pairs(data.viplist) do
                        Tree.Menu.List(v.label, editModeList, editModeIndex, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price .. "€",
                                RightBadge = Tree.Menu
                                    .BadgeStyle.GoldMedal
                            }, true, {
                                onListChange = function(Index)
                                    editModeIndex = Index
                                end,
                                onSelected = function(index)
                                    if index == 1 then
                                        local price = Tree.Function.Visual.KeyboardInput("Prix")
                                        if price == nil then return end
                                        if price == "" then return end
                                        if pricve == "0" then return end
                                        if not tonumber(price) then return end
                                        TriggerServerEvent("Plugins:Boutique:changePriceMode", "vip", v.model,
                                            tonumber(price))
                                    elseif index == 2 then
                                        local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "",
                                            30)
                                        if label == nil then return end
                                        if label == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeLabelMode", "vip", v.model, label)
                                    elseif index == 3 then
                                        local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "",
                                            30)
                                        if model == nil then return end
                                        if model == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeModelMode", "vip", v.model, model)
                                    elseif index == 4 then
                                        local description = Tree.Function.Visual.KeyboardInput("Description",
                                            "Entrez la description", "", 100)
                                        if description == nil then return end
                                        if description == "" then return end
                                        TriggerServerEvent("Plugins:Boutique:changeDescriptionMode", "vip", v.model,
                                            description)
                                    elseif index == 5 then
                                        TriggerServerEvent('Plugins:Boutique:removeOffreBoutique', "vip", v.model)
                                    end
                                end,
                                onActive = function()
                                    Tree.Menu.Info("Description: " .. Tree.Config.Serveur.color .. v.label,
                                        { v.description },
                                        {}, 400)
                                end
                            })
                    end
                    Tree.Menu.Line()
                    Tree.Menu.Button("Ajouter une offre", nil, {}, true, {
                        onSelected = function()
                            local label = Tree.Function.Visual.KeyboardInput("Label", "Entrez le label", "", 30)
                            if label == nil then return end
                            if label == "" then return end
                            local model = Tree.Function.Visual.KeyboardInput("Model", "Entrez le model", "", 30)
                            if model == nil then return end
                            if model == "" then return end
                            local price = Tree.Function.Visual.KeyboardInput("Prix")
                            if price == nil then return end
                            if price == "" then return end
                            if price == "0" then return end
                            if not tonumber(price) then return end
                            local description = Tree.Function.Visual.KeyboardInput("Description", "Entrez la description",
                                "", 100)
                            if description == nil then return end
                            if description == "" then return end
                            TriggerServerEvent("Plugins:Boutique:addOffreBoutique", "vip", label, model, tonumber(price),
                                description)
                        end
                    })
                else
                    for k, v in pairs(data.viplist) do
                        Tree.Menu.Button(v.label, nil,
                            {
                                RightLabel = Tree.Config.Serveur.color .. v.price .. "€",
                                RightBadge = Tree.Menu
                                    .BadgeStyle.GoldMedal
                            }, true, {
                                onActive = function()
                                    Tree.Menu.Info("Description: " .. Tree.Config.Serveur.color .. v.label,
                                        { v.description },
                                        {}, 400)
                                    if IsModelValid(GetHashKey(v.model)) then
                                        Tree.Entity.Object.spawnMovingObject(v.model)
                                    end
                                end,
                                onSelected = function()
                                    SendNUIMessage({
                                        action = 'openLink',
                                        url = v.model
                                    })
                                end
                            })
                    end
                end
            end)

            Tree.Menu.IsVisible(PedsMenu, function()
                Tree.Menu.Button("Normal", "Pour se remettre en normal", { RightLabel = "" }, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            local isMale = skin.sex == 0
                            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)
                            end)
                        end)
                    end
                })
                Tree.Menu.Line()
                for k, v in pairs(data.optionVip.peds) do
                    Tree.Menu.Button(v.label, nil, {}, true, {
                        onSelected = function()
                            local p1 = GetHashKey(v.model)
                            RequestModel(p1)
                            while not HasModelLoaded(p1) do
                                Wait(100)
                            end
                            SetPlayerModel(PlayerId(), p1)
                            SetModelAsNoLongerNeeded(p1)
                            ESX.ShowNotification('Tu est maintenant un ' .. v.label)
                        end
                    })
                end
            end)

            Wait(1)
        end
    end)
end

Keys.Register("F1", "F1", "Ouvrir la boutique", function()
    if MainMenu then
        Tree.Menu.Visible(MainMenu, false)
        MainMenu = false
        Tree.Entity.Vehicle.deleteMovingVehicle()
        Tree.Entity.Weapon.deleteMovingWeapon()
    else
        Tree.TriggerServerCallback("Plugins:Boutique:GetInfo", function()
            Tree.TriggerServerCallback("Plugins:Boutique:GetOwner", function(isOwner)
                BoutiqueMain(isOwner)
            end)
        end)
    end
end)

RegisterNetEvent("Plugins:Boutique:ReceiveCoins", function(receivedData)
    data.coins = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveId", function(receivedData)
    data.id = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveVip", function(receivedData)
    data.vip = receivedData
end)

exports('getVip', function()
    return {
        label = Tree.Config.VipRanks[data.vip],
        level = data.vip
    }
end)

RegisterNetEvent("Plugins:Boutique:ReceiveHistory", function(receivedData)
    data.history = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveVehicle", function(receivedData)
    data.vehicle = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveLimited", function(receivedData)
    data.limited = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveWeapon", function(receivedData)
    data.weapon = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveMysteryBox", function(receivedData)
    data.mysterybox = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveInventory", function(receivedData)
    data.inventory = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceivePack", function(receivedData)
    data.pack = receivedData
end)

RegisterNetEvent("Plugins:Boutique:ReceiveVipList", function(receivedData)
    data.viplist = receivedData
end)
local showMQ = false

function Request(scaleform)
    local scaleform_handle = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform_handle) do
        Citizen.Wait(0)
    end
    return scaleform_handle
end

function CallFunction(scaleform, returndata, the_function, ...)
    BeginScaleformMovieMethod(scaleform, the_function)
    local args = { ... }

    if args ~= nil then
        for i = 1, #args do
            local arg_type = type(args[i])

            if arg_type == "boolean" then
                ScaleformMovieMethodAddParamBool(args[i])
            elseif arg_type == "number" then
                if not string.find(args[i], '%.') then
                    ScaleformMovieMethodAddParamInt(args[i])
                else
                    ScaleformMovieMethodAddParamFloat(args[i])
                end
            elseif arg_type == "string" then
                ScaleformMovieMethodAddParamTextureNameString(args[i])
            end
        end

        if not returndata then
            EndScaleformMovieMethod()
        else
            return EndScaleformMovieMethodReturnValue()
        end
    end
end

function showMissionQuit(_title, _subtitle, _duration)
    Citizen.CreateThread(function()
        function drawScale(title, subtitle, duration)
            local scaleform = Request('MISSION_QUIT')
            CallFunction(scaleform, false, "SET_TEXT", title, subtitle)
            CallFunction(scaleform, false, "TRANSITION_IN", 0)
            CallFunction(scaleform, false, "TRANSITION_OUT", duration)
            return scaleform
        end

        local scale = drawScale(_title, _subtitle, _duration)
        while showMQ do
            Citizen.Wait(1)
            DrawScaleformMovieFullscreen(scale, 255, 255, 255, 255)
        end
    end)
end

function showMessage(_title, _subtitle, _waitTime, _playSound)
    showMQ = true
    if _playSound ~= nil and _playSound == true then
        local textsound = PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    end
    showMissionQuit(_title, _subtitle, _waitTime)
    Citizen.CreateThread(function()
        Citizen.Wait(tonumber(_waitTime) * 1000)
        StopSound(textsound)
        showMQ = false
    end)
end

function getStringColor(str)
    if string.find(str, "crate_argent") then -- argent, common, diamant, epique, legendair, rare, uncommon
        return "~HUD_COLOUR_SILVER~"
    elseif string.find(str, "crate_common") then
        return "~g~"
    elseif string.find(str, "crate_diamant") then
        return "~b~"
    elseif string.find(str, "crate_epique") then
        return "~p~"
    elseif string.find(str, "crate_legendair") then
        return "~y~"
    elseif string.find(str, "crate_rare") then
        return "~b~"
    elseif string.find(str, "crate_uncommon") then
        return "~HUD_COLOUR_GREENDARK~"
    else
        return "~s~"
    end
end

local objectCreated = false

RegisterNetEvent("Plugins:Boutique:OnOpenCase", function(props, props2, category, name, label)
    if objectCreated then
        ESX.ShowNotification("Un objet est déjà en cours de création. Veuillez attendre.")
        return
    end

    objectCreated = true

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    local forwardVector = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 1.0, 0.0)
    local spawnX, spawnY, spawnZ = forwardVector.x, forwardVector.y, coords.z

    RequestModel(props)
    RequestModel(props2)
    while not HasModelLoaded(props) or not HasModelLoaded(props2) do
        Wait(0)
    end

    local caseProp = CreateObject(props, spawnX, spawnY, spawnZ, true, true, true)


    local caseRotation = 180.0
    local newHeading = (heading + caseRotation) % 360.0
    SetEntityRotation(caseProp, 0.0, 0.0, newHeading, 2, true)
    PlaceObjectOnGroundProperly(caseProp)
    FreezeEntityPosition(caseProp, true)
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
    Wait(1000)
    DeleteObject(caseProp)



    caseProp = CreateObject(props2, spawnX, spawnY, spawnZ, true, true, true)
    newHeading = (heading + caseRotation) % 360.0
    SetEntityRotation(caseProp, 0.0, 0.0, newHeading, 2, true)
    PlaceObjectOnGroundProperly(caseProp)
    FreezeEntityPosition(caseProp, true)

    local elementProp = nil
    local propsToScroll = 50
    local delayBetweenProps = 150
    local scrollModels = {}

    for k, v in pairs(Tree.Config.MysteryBoxProps) do
        local model = GetHashKey(v)
        RequestModel(model)
        table.insert(scrollModels, model)
    end

    for _, model in ipairs(scrollModels) do
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end

    local sound = PlaySoundFrontend(-1, "Frontend_Beast_Frozen_Screen_Loop", "FM_Events_Sasquatch_Sounds", true)

    for i = 1, propsToScroll do
        if elementProp then
            DeleteObject(elementProp)
        end

        local currentModel = scrollModels[(i % #scrollModels) + 1]
        elementProp = CreateObject(currentModel, spawnX, spawnY, spawnZ - 0.50, true, true, true)
        local rotation = i * 36.0
        Wait(delayBetweenProps)
    end

    StopSound(sound)
    if elementProp then
        DeleteObject(elementProp)
    end

    propsToShow = Tree.Config.MysteryBoxProps[name]

    if propsToShow == nil then
        propsToShow = Tree.Config.MysteryBoxProps["default"]
    end

    local sound = PlaySoundFrontend(-1, "Flag_Collected", "DLC_SM_STPI_Player_Sounds", true)
    ClearPedTasksImmediately(playerPed)

    elementProp = CreateObject(GetHashKey(propsToShow), spawnX, spawnY, spawnZ - 0.50, true, true, true)

    if (category == "vehicles") then
        showMessage(getStringColor(props) .. "Vous avez gagné !.~s~", "Félicitations ! vous avez gagné une " ..
            label .. " !", 5000, false)
    elseif (category == "weapons") then
        showMessage(getStringColor(props) .. "Vous avez gagné !.~s~", "Félicitations ! vous avez gagné un " ..
            label .. " !", 5000, false)
    elseif (category == "items") then
        showMessage(getStringColor(props) .. "Vous avez gagné !.~s~",
            "Félicitations ! vous avez gagné un(e) " .. label .. " !", 5000, false)
    else
        ESX.ShowNotification("Erreur: Catégorie invalide, veuillez ouvrir un ticket sur Discord pour " .. label .. " !")
    end

    Wait(4500)
    if DoesEntityExist(caseProp) then
        DeleteObject(caseProp)
    end
    if DoesEntityExist(elementProp) then
        DeleteObject(elementProp)
    end

    objectCreated = false
end)

CreateThread(function()
    local timer = 0
    while true do
        timer = 1000
        if data.optionVip.drift then
            timer = 0
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                carSpeed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId())) * 3.6
                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
                    if IsControlPressed(0, 21) then
                        SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), false), true)
                    else
                        SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), false), false)
                    end
                end
            end
        end
        Wait(timer)
    end
end)

RegisterNetEvent('Boutique:UpdateInventory')
AddEventHandler('Boutique:UpdateInventory', function(newInventory)
    data.inventory = newInventory
    numberOfitems = 0
    for k, v in pairs(data.inventory) do
        numberOfitems = numberOfitems + 1
    end
end)
