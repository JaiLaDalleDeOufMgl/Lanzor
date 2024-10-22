RegisterNetEvent('Gamemode:Society:AddMoney')
AddEventHandler('Gamemode:Society:AddMoney', function(societyName, amount, accountType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    local local_date = os.date('%H:%M:%S', os.time())

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            local playerAccount = xPlayer.getAccount(accountType)

            if (playerAccount) then
                if (playerAccount.money >= amount) then
                    xPlayer.removeAccountMoney(playerAccount.name, amount)

                    if (accountType == "cash") then
                        society:AddMoney(amount)
                        society:UpdateBossEvent("Gamemode:Society:ReceiveMoney", society:GetMoney())

                        society:SendLogsDiscord(local_date, Gamemode.enums.Society.Zones[society.name].logs.money, {
                            {
                                ["title"]  = "**Dépot d'argent :**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :",          value = xPlayer.getFirstName() .. " " .. xPlayer.getLastName() .. " [" .. xPlayer.source .. "] [" .. xPlayer.identifier .. "]" },
                                    { name = "- Montant déposé :",   value = amount .. " $" },
                                    { name = "- Entreprise :",       value = society.label },
                                },
                                ["type"]   = "rich",
                                ["color"]  = 65280,
                                ["footer"] = {
                                    ["text"] = "Logs Society | " .. exports.Tree:serveurConfig().Serveur.label,
                                },
                            }
                        })
                    elseif (accountType == "dirty_cash") then
                        society:AddDirtyMoney(amount)
                        society:UpdateBossEvent("Gamemode:Society:ReceiveDirtyMoney", society:GetDirtyMoney())

                        society:SendLogsDiscord(local_date, Gamemode.enums.Society.Zones[society.name].logs.money, {
                            {
                                ["title"]  = "**Dépot d'argent [SALE]:**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :",          value = xPlayer.getFirstName() .. " " .. xPlayer.getLastName() .. " [" .. xPlayer.source .. "] [" .. xPlayer.identifier .. "]" },
                                    { name = "- Montant déposé :",   value = amount .. " $" },
                                    { name = "- Entreprise :",       value = society.label },
                                },
                                ["type"]   = "rich",
                                ["color"]  = 65280,
                                ["footer"] = {
                                    ["text"] = "Logs Society | " .. exports.Tree:serveurConfig().Serveur.label,
                                },
                            }
                        })
                    end
                else
                    xPlayer.showNotification("Vous n'avez pas assez d'argent");
                end
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color ..
                "Une erreur est survenue~s~, Event du Code erreur: " ..
                exports.Tree:serveurConfig().Serveur.color .. " 'Society:AddMoney'")
            end
        else
            DropPlayer(xPlayer.source,
                "" .. exports.Tree:serveurConfig().Serveur.label .. " | Vous n'êtes pas le patron de cette entreprise")
        end
    end
end)
