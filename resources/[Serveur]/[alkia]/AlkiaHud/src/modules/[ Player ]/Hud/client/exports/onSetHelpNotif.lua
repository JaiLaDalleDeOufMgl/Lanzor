local LoopCheck = false
local NotifTest = false

-- local msgBase = false

exports("onSetHelpNotif", function(msg)
    NotifTest = true

    -- if (msgBase ~= msg) then
    --     MOD_HUD.class:RemoveHelpNotifVisible()
    --     MOD_HUD.class:SetHelpNotifVisible(msg)
    --     msgBase = msg
    -- end

    if (not LoopCheck) then
        LoopCheck = true
        LoopForCheck(msg)

        -- msgBase = msg
    end
end)


function LoopForCheck(msg)
    CreateThread(function()
        while not MOD_HUD.class do
            Wait(100)
        end
        MOD_HUD.class:SetHelpNotifVisible(msg)

        while (LoopCheck) do
            NotifTest = false

            Wait(100)

            if (not NotifTest) then
                LoopCheck = false
            end
        end

        MOD_HUD.class:RemoveHelpNotifVisible()
    end)
end
