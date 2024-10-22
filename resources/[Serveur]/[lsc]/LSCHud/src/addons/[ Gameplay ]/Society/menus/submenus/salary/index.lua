local menu = {}

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Garage")

    menu.Menu:IsVisible(function(Items)
        local grades = MOD_Society.data.grades

        if (grades) then
            for _, grade in pairs(grades) do
                Items:Button(grade.label, nil, {
                    RightLabel = ("%s~g~$"):format(grade.salary)
                }, true, {
                    onSelected = function()
                        local newSalary = KeyboardInput("Définir le nouveau salaire", "", 4);

                        if (API_Player:InputIsValid(newSalary, "number") and tonumber(newSalary) > 0) then
                            TriggerServerEvent('Gamemode:Society:SetSalary', MOD_Society.data.name, grade.grade,
                                tonumber(newSalary));
                        else
                            ESX.ShowNotification("Entré invalide.")
                        end
                    end
                });
            end
        end
    end)
end

return menu
