RegisterNetEvent('Gamemode:Society:RemoveMoney')
AddEventHandler('Gamemode:Society:RemoveMoney', function(societyName, amount, accountType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    local local_date = os.date('%H:%M:%S', os.time())

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            local playerAccount = xPlayer.getAccount(accountType)

            if (playerAccount) then
                local societyMoney = accountType == "cash" and society:GetMoney() or
                accountType == "dirty_cash" and society:GetDirtyMoney() or 0

                if (societyMoney - amount >= 0) then
                    xPlayer.addAccountMoney(playerAccount.name, amount)

                    if (accountType == "cash") then
                        society:RemoveMoney(amount)
                        society:UpdateBossEvent("Gamemode:Society:ReceiveMoney", society:GetMoney())

                        society:SendLogsDiscord(local_date, Gamemode.enums.Society.Zones[society.name].logs.money, {
                            {
                                ["title"]  = "**Retrait Argent :**",
                                ["fields"] = {
                                    { name = "**- Date & Heure :**", value = local_date },
                                    { name = "- Employé :",          value = xPlayer.getFirstName() .. " " .. xPlayer.getLastName() .. " [" .. xPlayer.source .. "] [" .. xPlayer.identifier .. "]" },
                                    { name = "- Montant retiré :",   value = amount .. " $" },
                                    { name = "- Entreprise :",       value = society.label },
                                },
                                ["type"]   = "rich",
                                ["color"]  = 16711680,
                                ["footer"] = {
                                    ["text"] = "Logs Society | " .. exports.Tree:serveurConfig().Serveur.label,
                                },
                            }
                        })
                    elseif (accountType == "dirty_cash") then
                        society:RemoveDirtyMoney(amount)
                        society:UpdateBossEvent("Gamemode:Society:ReceiveDirtyMoney", society:GetDirtyMoney())

                        society:SendLogsDiscord(local_date, Gamemode.enums.Society.Zones[society.name].logs.linkAddMoney,
                            {
                                {
                                    ["title"]  = "**Retrait Argent [SALE]:**",
                                    ["fields"] = {
                                        { name = "**- Date & Heure :**", value = local_date },
                                        { name = "- Employé :",          value = xPlayer.getFirstName() .. " " .. xPlayer.getLastName() .. " [" .. xPlayer.source .. "] [" .. xPlayer.identifier .. "]" },
                                        { name = "- Montant retiré :",   value = amount .. " $" },
                                        { name = "- Entreprise :",       value = society.label },
                                    },
                                    ["type"]   = "rich",
                                    ["color"]  = 16711680,
                                    ["footer"] = {
                                        ["text"] = "Logs Society | " .. exports.Tree:serveurConfig().Serveur.label,
                                    },
                                }
                            })
                    end
                else
                    xPlayer.showNotification("Votre société n'a pas assez d'argent")
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
