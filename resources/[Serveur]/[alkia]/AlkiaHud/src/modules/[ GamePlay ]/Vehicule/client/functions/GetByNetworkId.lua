function MOD_Vehicle:GetByNetworkId(networkId, callback)
    CreateThread(function()
        local obj = NetworkGetEntityFromNetworkId(networkId)
        local tries = 0
        while not DoesEntityExist(obj) do
            obj = NetworkGetEntityFromNetworkId(networkId)
            Wait(0)
            tries = tries + 1
            if tries > 250 then
                break
            end
        end
        if (callback) then callback(obj); end
    end)
end