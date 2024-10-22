local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion de l'acces")

    menu.Menu:IsVisible(function(Items)
        local employee = menu.DataMenu;
    
        if (employee) then
    
            Items:Button("Promouvoir", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('Gamemode:Society:SetGrade', MOD_Society.data.name, employee.identifier, "promote")
                    RageUI.GoBack();
                end
            });
    
            Items:Button("Rétrograder", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('Gamemode:Society:SetGrade', MOD_Society.data.name, employee.identifier, "demote")
                    RageUI.GoBack();
                end
            });
    
            Items:Button("Virer", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('Gamemode:Society:SetGrade', MOD_Society.data.name, employee.identifier, "fire")
                    RageUI.GoBack();
                end
            });
        else
            Items:Separator("Chargement des données de l'employé...");
        end
    end, function()
    end)
end

return menu