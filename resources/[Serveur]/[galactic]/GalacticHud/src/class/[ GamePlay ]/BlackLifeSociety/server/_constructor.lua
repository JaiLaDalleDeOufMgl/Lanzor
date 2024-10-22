GamemodeSociety = {}

local __instance = {
    __index = GamemodeSociety
}

setmetatable(GamemodeSociety, {
    __call = function(_, society)
        local self = setmetatable({}, __instance)

        self.name = society.name
        self.label = society.label

        self.canUseOffShore = society.canUseOffShore

        self.grades = {}
        self.employees = {}
        
        self.posBoss = MOD_Zones:AddZone(Gamemode.enums.Society.Zones[string.lower(self.name)]?.pos or society.posBoss, function(xPlayer, Zone)
            if (xPlayer.job.name == self.name and xPlayer.job.grade_name == "boss") then
                print('SOCIETY OPEN')
                TriggerClientEvent("Gamemode:Society:OpenMenuBoss", xPlayer.source, {
                    name = self.name,
                    label = self.label,
                    canUseOffShore = self.canUseOffShore
                })
            end
        end, { name = self.name, type = "job" }, 0.8, Gamemode.enums.Society.OpenMenuBoss, true)

        self.HasCoffre = Gamemode.enums.Society.Zones[string.lower(self.name)]?.coffre

        if (self.HasCoffre) then
            self.posCoffre = MOD_Zones:AddZone(Gamemode.enums.Society.Zones[string.lower(self.name)]?.coffreInfos.pos, function(xPlayer, Zone)
                TriggerEvent('Gamemode:Inventory:OpenSecondInventory', "coffresociety", self.name, xPlayer)
            end, { name = self.name, type = "job" }, 0.8, Gamemode.enums.Society.OpenMenuCoffre, true)

            self.maxWeight = Gamemode.enums.Society.Zones[string.lower(self.name)]?.coffreInfos.maxWeight;
            self.maxSlots = Gamemode.enums.Society.Zones[string.lower(self.name)]?.coffreInfos.maxSlots;
        end

        self:Initialize(function()
            if (self.HasCoffre) then
                self.inventory = MOD_CoffreSociety:loadCoffreSociety(self.name, self.posCoffre.coords, self.inventory or {}, self.maxWeight, self.maxSlots)
            end
        end)
        

        CreateThread(function()
            Wait(2000)

            for _, playerId in ipairs(GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(playerId)

                if (xPlayer) then
                    if (xPlayer.job.name == self.name) then
                        MOD_Zones:loadZonesByJob(playerId, xPlayer.job)
                    end
                end
            end  
        end)

        --Functions
        exportMetatable(GamemodeSociety, self)

        return (self)
    end
})