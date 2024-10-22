local menu = {}

local SocietyEmployeesPlayer = require 'src.addons.[ Gameplay ].Society.menus.submenus.employees.player'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Garage")

    SocietyEmployeesPlayer:LoadMenu(menu.Menu)

    menu.Menu:IsVisible(function(Items)
        local employees = MOD_Society.data.employees

        if (employees) then
            for _, employee in pairs(employees) do
                Items:Button(string.format("%s %s", employee.firstname, employee.lastname), nil, {
                    RightLabel = employee.grade,
                    Color = {
                        HightLightColor = employee.isBoss and RageUI.ItemsColour.Damage or nil,
                    }
                }, true, {
                    onSelected = function()

                        SocietyEmployeesPlayer:SetData(employee);

                    end
                }, SocietyEmployeesPlayer.Menu);
            end
        else
            Items:Separator("Chargement de la liste des employés...");
        end
        
    end)
end

return menu