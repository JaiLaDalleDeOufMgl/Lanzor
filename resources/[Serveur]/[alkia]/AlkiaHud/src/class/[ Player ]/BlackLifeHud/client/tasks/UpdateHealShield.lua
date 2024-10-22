function _GamemodeHud:LoadTaskUpdateHealShieldAndStatus()
    local HungerNotif = false
    local ThirstNotif = false

    CreateThread(function()
        while (true) do
            local PlayerPed = PlayerPedId()

            local PlayerHealth = GetEntityHealth(PlayerPed) - 100
            if (PlayerHealth <= 0) then PlayerHealth = 0 end

            self.PlayerData.health = tostring(PlayerHealth)
            self.PlayerData.shield = tostring(GetPedArmour(PlayerPed))

            self.PlayerData.states = {
                hunger = math.ceil(MOD_Status.list["hunger"]:getPercent()),
                thirst = math.ceil(MOD_Status.list["thirst"]:getPercent())
            }

            if (self.PlayerData.states.thirst < 25) then
                CreateThread(function()
                    if (not HungerNotif) then
                        HungerNotif = true
                        Wait(30000)
                        ESX.ShowNotification("Attention\n~s~Tu semble avoir soif...")
                        HungerNotif = false
                    end
                end)
            end

            if (self.PlayerData.states.hunger < 25) then
                CreateThread(function()
                    if (not ThirstNotif) then
                        ThirstNotif = true
                        Wait(30000)
                        ESX.ShowNotification("Attention\n~s~Tu semble avoir faim...")
                        ThirstNotif = false
                    end
                end)
            end

            self:UpdatePlayerData()

            Wait(500)
        end
    end)
end
