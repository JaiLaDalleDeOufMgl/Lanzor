CreateThread(function()
    RegisterKeyMapping("interaction", "Touche d'interaction", "keyboard", "E")
    RegisterCommand("interaction", function()
        for _, func in pairs(MOD_InteractionKey.listeners) do
            func()
        end
    end)
end)