RegisterNetEvent('Gamemode:Labo:Weed:UseItemHeadWeed')
AddEventHandler('Gamemode:Labo:Weed:UseItemHeadWeed', function(HeadWeed)
    MOD_Weed:StartPlaceHeadWeed(HeadWeed)
end)