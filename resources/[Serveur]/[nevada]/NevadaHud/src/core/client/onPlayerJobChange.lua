function Gamemode:OnJobChange(callback)
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        callback("job", job)
    end)

    RegisterNetEvent('esx:setJob2')
    AddEventHandler('esx:setJob2', function(job)
        callback("job2", job)
    end)
end