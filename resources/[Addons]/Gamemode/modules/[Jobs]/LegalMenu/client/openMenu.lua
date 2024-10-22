RegisterKeyMapping('openMenuMetier', 'Ouvrir le Menu Metier', 'keyboard', 'F6')
RegisterCommand("openMenuMetier", function(source, args)

    if ESX.PlayerData.job.name == 'ambulance' then
        openambulanceF6 = true
        openF6Ambulance()

    elseif ESX.PlayerData.job.name == 'boatseller' then
        OpenMenuBoatShop()

	elseif ESX.PlayerData.job.name == 'planeseller' then
        OpenMenuPlaneShop()

    elseif ESX.PlayerData.job.name == 'bcso' then
        openF6no = true
        openF6BCSO()

    elseif ESX.PlayerData.job.name == 'police' then
        openF6= true
        openF6Police()

	elseif ESX.PlayerData.job.name == 'cardealer' then
        OpenMenuCarShop()

	elseif ESX.PlayerData.job.name == 'tequilala' then
		OpenMenutequilala()

	elseif ESX.PlayerData.job.name == 'unicorn' then
		OpenMenuunicorn()


    elseif ESX.PlayerData.job.name == 'mecano' then
        openMecanoF6()

    elseif ESX.PlayerData.job.name == 'mecano2' then
        openLsF6()

    elseif ESX.PlayerData.job.name == 'label' then
        openF6 = true
        OpenF6Label()

    elseif ESX.PlayerData.job.name == 'realestateagent' then
        OpenF6Immo()

    elseif ESX.PlayerData.job.name == 'journalist' then
        OpenWeazel()

    elseif ESX.PlayerData.job.name == 'avocat' then
        OpenF6Avocat()

    elseif ESX.PlayerData.job.name == 'burgershot' then
        OpenF6BurgerShot()

    elseif ESX.PlayerData.job.name == 'ltd_sud' then
        OpenF6ltd_sud()
        
    elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
        Taxi:interactionMenu()
    end

end)