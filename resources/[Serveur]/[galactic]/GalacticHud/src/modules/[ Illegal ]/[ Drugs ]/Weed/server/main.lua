CreateThread(function()
    Wait(500)

    MOD_Items:createUsableItem('pot', function(source)
        TriggerClientEvent('Gamemode:Labo:Weed:UseItemPot', source)
    end)

    MOD_Items:createUsableItem('lamp', function(source)
        TriggerClientEvent('Gamemode:Labo:Weed:UseItemLamp', source)
    end)


    local HeadWeed = {
        'weed_head_candy',
        'weed_head_mac10',
        'weed_head_og',
        'weed_head_rain',
        'weed_head_tropical',
    }
    for i=1, #HeadWeed do
        MOD_Items:createUsableItem(HeadWeed[i], function(source)
            TriggerClientEvent('Gamemode:Labo:Weed:UseItemHeadWeed', source, HeadWeed[i])
        end)
    end
end)