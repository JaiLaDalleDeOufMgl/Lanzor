Gamemode:OnJobChange(function(typeJob, job)
    TriggerServerEvent('Gamemode:Zones:ChangePlayerJob', typeJob, job)
end)