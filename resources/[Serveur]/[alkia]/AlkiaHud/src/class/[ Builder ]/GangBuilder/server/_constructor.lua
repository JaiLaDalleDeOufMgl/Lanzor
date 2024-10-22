_GamemodeGangBuilder = {}

local __instance = {
    __index = _GamemodeGangBuilder
}

setmetatable(_GamemodeGangBuilder, {
    __call = function(_, newGang, data)
        local self = setmetatable({}, __instance)

        if (not newGang) then
            self.id = data.id
        end

        self.name = data.name
        self.label = data.label

        self.societies = {
            name = self.name,
            label = self.label,
            grades = Gamemode.enums.GangBuilder.DefaultJobGrade
        }

        self.grades = data.grades or {}
        self.membres = {}
 
        self.posGarage = MOD_Zones:AddZone(vector3(data.posGarage.x, data.posGarage.y, data.posGarage.z), function(xPlayer, Zone)
            
            if (not self:GetPlayerGradeByLicense(xPlayer.identifier, "GarageMenu")) then return end

            TriggerClientEvent('Gamemode:GangBuilder:OpenGangGarage', xPlayer.source, self:GetVehiclesTemplate(), {
                name = self.name,
                label = self.label,
                spawnPos =  self.posSpawnVeh,
                id = self.id
            })

        end, { name = self.name, type = "job2" }, 0.8, 'Ouvrir le garage des '.. self.name, true)

        self.posSpawnVeh = data.posSpawnVeh
    
        self.posDeleteVeh = MOD_Zones:AddZone(vector3(data.posDeleteVeh.x, data.posDeleteVeh.y, data.posDeleteVeh.z), function(xPlayer, Zone)
            
            TriggerClientEvent("Gamemode:GangBuilder:GetParkVehicule", xPlayer.source, self.id)

        end, { name = self.name, type = "job2" }, 3.0, "Ranger le vehicule", true)

        self.posCoffre = MOD_Zones:AddZone(vector3(data.posCoffre.x, data.posCoffre.y, data.posCoffre.z), function(xPlayer, Zone)

            if (not self:GetPlayerGradeByLicense(xPlayer.identifier, "CoffreMenu")) then return end

            TriggerEvent("Gamemode:Inventory:OpenSecondInventory", "coffregang", self.name, xPlayer)

        end, { name = self.name, type = "job2" }, 0.8, 'Ouvrir le coffre des '.. self.name, true)

        self.posBoss = MOD_Zones:AddZone(vector3(data.posBoss.x, data.posBoss.y, data.posBoss.z), function(xPlayer, Zone)

            if (not self:GetPlayerGradeByLicense(xPlayer.identifier, "BossMenu")) then return end

            TriggerClientEvent('Gamemode:GangBuilder:OpenGangManage', xPlayer.source, {
                name = self.name,
                label = self.label,
                spawnPos =  self.posSpawnVeh,
                id = self.id
            })

        end, { name = self.name, type = "job2" }, 0.8, 'Ouvrir la gestion des '.. self.name, true)

        self.vehiclesOut = {}
        self.vehicles = data.vehicules or {}

		self.maxWeight = Gamemode.enums.GangBuilder.MaxWeight;
		self.maxSlots = Gamemode.enums.GangBuilder.MaxSlots;

		self.inventory = MOD_CoffreGang:loadCoffreGang(self.name, self.posCoffre.coords, data.inventory or {}, self.maxWeight, self.maxSlots)

        self:Initialize(data.membres)


        CreateThread(function()
            Wait(2000)

            for _, playerId in ipairs(GetPlayers()) do
                local xPlayer = ESX.GetPlayerFromId(playerId)

                if (xPlayer) then
                    if (xPlayer.job2.name == self.name) then
                        MOD_Zones:loadZonesByJob(playerId, xPlayer.job2)
                    end
                end
            end  
        end)

        --Functions
        exportMetatable(_GamemodeGangBuilder, self)

        return (self)
    end
})