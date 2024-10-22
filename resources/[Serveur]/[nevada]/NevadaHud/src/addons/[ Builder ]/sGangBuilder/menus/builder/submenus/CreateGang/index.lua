
local menu = {}

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Crée un Gang")

    local gangData = {}

    local Params = {
        name = false,
        label = false,
        posBoss = false,
        posCoffre = false,
        posGarage = false,
        posSpawnVeh = false,
        posDeleteVeh = false
    }

    local function GetAllParamsValid()
        for name, bool in pairs(Params) do
            if (not bool) then
                return false
            end
        end

        return true
    end

    menu.Menu:IsVisible(function(Items)
        Items:Separator('↓ Infos générale ↓')
        Items:Button("Nom du gang", nil, { RightLabel = gangData.name }, true, {
            onSelected = function()
                local GangName = KeyboardInput("Indiquer le nom du gang", "", 99);

                if (GangName) then
                    gangData.name = GangName

                    Params.name = true
                end
            end
        });
        Items:Button("Label du gang", nil, { RightLabel = gangData.label }, true, {
            onSelected = function()
                local GangLabel = KeyboardInput("Indiquer le label du gang", "", 99);

                if (GangLabel) then
                    gangData.label = GangLabel

                    Params.label = true
                end
            end
        });

        Items:Separator('↓ Postions du gang ↓')
        Items:Button("Position du boss", nil, {}, true, {
            onSelected = function()
                gangData.posBoss = GetEntityCoords(PlayerPedId())

                Params.posBoss = true
            end
        });
        Items:Button("Position du coffre", nil, {}, true, {
            onSelected = function()
                gangData.posCoffre = GetEntityCoords(PlayerPedId())

                Params.posCoffre = true
            end
        });
        Items:Button("Position du garage", nil, {}, true, {
            onSelected = function()
                gangData.posGarage = GetEntityCoords(PlayerPedId())

                Params.posGarage = true
            end
        });
        Items:Button("Position du spawn des vehicules", nil, {}, true, {
            onSelected = function()
                gangData.posSpawnVeh = GetEntityCoords(PlayerPedId())

                Params.posSpawnVeh = true
            end
        });
        Items:Button("Position du delete des vehicules", nil, {}, true, {
            onSelected = function()
                gangData.posDeleteVeh = GetEntityCoords(PlayerPedId())

                Params.posDeleteVeh = true
            end
        });

        Items:Separator('↓ Actions ↓')
        Items:Button("Crée le gang", nil, {}, true, {
            onSelected = function()
                if (GetAllParamsValid()) then
                    TriggerServerEvent("Gamemode:GangBuilder:CreateNewGang", gangData)

                    menu.Menu:Toggle()
                end
            end
        });
    end, nil, function()
        gangData = {}
        Params = {
            name = false,
            label = false,
            posBoss = false,
            posCoffre = false,
            posGarage = false,
            posSpawnVeh = false,
            posDeleteVeh = false
        }
    end)

end

return menu