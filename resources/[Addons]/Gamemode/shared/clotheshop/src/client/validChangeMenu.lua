

local level = 10;
local msg = "Votre garde-robe est pleine, veuillez vous procurer le VIP "..exports.Tree:serveurConfig().Serveur.color.."GOLD ou "..exports.Tree:serveurConfig().Serveur.color.."Diamond pour l'agrandir."

RegisterNetEvent('shops:setStatVip', function(call)

    if (call == 0) then 
        level = 10;
    elseif (call == 1) then
        level = 20;
        msg = "Votre garde-robe est pleine, veuillez vous procurer le VIP "..exports.Tree:serveurConfig().Serveur.color.."Diamond pour l'agrandir."
    elseif (call == 2) then
        level = 35;
        msg = "Votre garde-robe est pleine."
    end

end);

---@author Razzway
---@type function Render:validChangeMenu
function Render:validChangeMenu()
    RageUIClothes.Line()
    RageUIClothes.Button('Oui', nil, {}, true, {
        onActive = function() Uclothes:OnRenderCam() end,
        onSelected = function()
            if (#_Razzway.Data < level) then 
                local nameTenue = KeyboardInput('Spécifiez le nom de la tenue :','','', 20);
                if (nameTenue == "" or nameTenue == nil) then
                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Attention !~s~\nVous devez attitré un nom à votre tenue pour pouvoir la sauvegarder")
                else
                    TriggerServerEvent(_Prefix..':outfit:pay')
                    TriggerEvent('skinchanger:getSkin', function(saveAppearance)
                        TriggerServerEvent(_Prefix..":saveData", "outfit", nameTenue, saveAppearance)
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Vêtement~s~\nVous avez ~g~enregistré~s~ une nouvelle tenue : '..exports.Tree:serveurConfig().Serveur.color..''..nameTenue)
                    end);
                    _Razzway:refreshData();
                    RageUIClothes.CloseAll();
                end
            else
                ESX.ShowNotification("veuillez acheter un '..exports.Tree:serveurConfig().Serveur.color..'VIP~s~ pour plus de place")
            end
        end
    })
    RageUIClothes.Button('Non', nil, {}, true, {
        onActive = function() Uclothes:OnRenderCam() end,
        onSelected = function()
            RageUIClothes.CloseAll()
        end
    })
end