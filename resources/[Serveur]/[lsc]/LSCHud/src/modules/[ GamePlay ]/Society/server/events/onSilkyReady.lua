Gamemode:onGamemodeReady(function()
	MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(results)

        if (#results > 0) then
            local SocietiesLoaded = 0

            for i=1, #results do

                if (results[i].societyType == 1) then
                    SocietiesLoaded += 1

                    MOD_Society:LoadSociety(results[i])
                end
            end

            if (SocietiesLoaded > 0) then
                ---- SOCIETY LOAD PRINT
            end
        end
    end)
end)