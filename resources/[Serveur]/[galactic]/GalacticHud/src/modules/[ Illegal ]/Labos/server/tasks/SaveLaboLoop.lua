CreateThread(function()
    while (true) do

        for id, labo in pairs(MOD_Labos.list) do
            labo:SaveLabo()
        end

        Wait(5000)
    end
end)