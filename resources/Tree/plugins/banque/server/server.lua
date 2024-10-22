RegisterNetEvent("tree:bank:deposit", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    local account = xPlayer.getAccount('cash')
    if account.money >= amount then
        xPlayer.removeAccountMoney('cash', amount)
        xPlayer.addAccountMoney('bank', amount)
        xPlayer.showNotification("~g~Vous avez déposé "..ESX.Math.GroupDigits(amount).." $ sur votre compte bancaire !")
    else
        xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent sur vous !")
    end
end)

RegisterNetEvent("tree:bank:withdraw", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    local account = xPlayer.getAccount('bank')
    if account.money >= amount then
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addAccountMoney('cash', amount)
        xPlayer.showNotification("~g~Vous avez retiré "..ESX.Math.GroupDigits(amount).." $ de votre compte bancaire !")
    else
        xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent sur votre compte bancaire !")
    end
end)


RegisterNetEvent("tree:bank:transfert", function(target, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(target)
    if not xPlayer then
        return
    end
    if not xTarget then
        xPlayer.showNotification(Tree.Config.Serveur.color.."Le ID du joueur entré est invalide veuillez entrer un ID valide !")
        return
    end
    if xPlayer.getAccount('bank', amount) then
        xPlayer.removeAccountMoney('bank', amount)
        xTarget.addAccountMoney('bank', amount)
        xPlayer.showNotification("~g~Vous avez transféré "..ESX.Math.GroupDigits(amount).." $ à "..GetPlayerName(target).." !")
        xTarget.showNotification("~g~Vous avez reçu un transfert de "..ESX.Math.GroupDigits(amount).." $ de la part de "..GetPlayerName(_source).." !")
    else
        xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent sur votre compte bancaire pour effectuer ce transfert !")
    end
end)