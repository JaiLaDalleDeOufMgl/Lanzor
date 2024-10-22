RegisterNetEvent('Gamemode:Society:SetGrade')
AddEventHandler('Gamemode:Society:SetGrade', function(societyName, identifier, actionType, targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            local target = ESX.GetPlayerFromId(targetId)

            local employee = target and society:GetEmployee(target.getIdentifier()) or society:GetEmployee(identifier)

            if (actionType == "recruit") then
                if (targetId) then
                    if (not employee) then
                        if (target) then
                            local targetJob = target.getJob()

                            if (targetJob and targetJob.name == "unemployed") then
                                if (ESX.DoesJobExist(society.name, 0)) then
                                    target.setJob(society.name, 0)

                                    local job = target.getJob()

                                    xPlayer.showNotification(string.format(
                                        "Vous avez recruter %s%s %s~s~ en tant que %s%s~s~",
                                        "",
                                        target.getFirstName(),
                                        target.getLastName(),
                                        "",
                                        job.grade_label
                                    )
                                    )
                                    target.showNotification(string.format(
                                        "Vous avez été recruter dans la société %s%s~s~ par %s%s %s~s~ en tant que %s%s",
                                        "",
                                        society.label,
                                        "",
                                        target.getFirstName(),
                                        target.getLastName(),
                                        "",
                                        job.grade_label
                                    )
                                    )
                                elseif (ESX.DoesJobExist(society.name, 0)) then
                                    target.setJob(society.name, 1)

                                    local job = target.getJob()

                                    xPlayer.showNotification(string.format(
                                        "Vous avez recruter %s%s %s~s~ en tant que %s%s~s~",
                                        "",
                                        target.getFirstName(),
                                        target.getLastName(),
                                        "",
                                        job.grade_label
                                    )
                                    )
                                    target.showNotification(string.format(
                                        "Vous avez été recruter dans la société %s%s~s~ par %s%s %s~s~ en tant que %s%s",
                                        "",
                                        society.label,
                                        "",
                                        target.getFirstName(),
                                        target.getLastName(),
                                        "",
                                        job.grade_label
                                    )
                                    )
                                else
                                    xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color ..
                                    "Une erreur est survenue~s~, Code erreur: " ..
                                    exports.Tree:serveurConfig().Serveur.color .. " 'Society:SetGrade'");
                                end
                            else
                                xPlayer.showNotification("La personne possède déjà un métier.")
                                target.showNotification(
                                "Impossible d'accepter la proposition d'embauche, vous avez déjà un métier")
                            end
                        else
                            xPlayer.showNotification("La personne n'est plus disponnible")
                        end
                    else
                        xPlayer.showNotification("La personne est déjà dans votre société.")
                    end
                else
                    xPlayer.showNotification("La personne n'est plus disponnible")
                end
            elseif (actionType == "promote") then
                if (employee) then
                    if (not employee.isBoss) then
                        if (ESX.DoesJobExist(society.name, employee.grade_level + 1)) then
                            society:UpdateEmployee(identifier, employee.grade_level + 1);

                            society:UpdateBossEvent('Gamemode:Society:ReceiveEmployees', society:GetEmployees());
                        else
                            xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color ..
                            "Une erreur est survenue~s~, Code erreur: " ..
                            exports.Tree:serveurConfig().Serveur.color .. " 'Society:SetGrade'");
                        end
                    else
                        xPlayer.showNotification("Impossible de promouvoir cette personne.")
                    end
                end
            elseif (actionType == "demote") then
                if (employee) then
                    -- if (not employee.isBoss) then

                    if (ESX.DoesJobExist(society.name, employee.grade_level - 1)) then
                        society:UpdateEmployee(identifier, employee.grade_level - 1);

                        society:UpdateBossEvent('Gamemode:Society:ReceiveEmployees', society:GetEmployees());
                    else
                        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color ..
                        "Une erreur est survenue~s~, Code erreur: " ..
                        exports.Tree:serveurConfig().Serveur.color .. " 'Society:SetGrade'");
                    end

                    -- else
                    --     xPlayer.showNotification("Impossible de promouvoir cette personne.")
                    -- end
                end
            elseif (actionType == "fire") then
                if (employee) then
                    -- if (not employee.isBoss) then

                    society:UpdateEmployee(identifier, false);

                    society:UpdateBossEvent('Gamemode:Society:ReceiveEmployees', society:GetEmployees());

                    -- else
                    --     xPlayer.showNotification("Impossible de promouvoir cette personne.")
                    -- end
                end
            end
        else
            DropPlayer(xPlayer.source,
                "[" .. exports.Tree:serveurConfig().Serveur.label .. "] Vous n'êtes pas le patron de cette entreprise.")
        end
    end
end)
