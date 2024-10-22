_GamemodeDrugWeed = {}

local __instance = {
    __index = _GamemodeDrugWeed
}

setmetatable(_GamemodeDrugWeed, {
    __call = function(_, bucket)
        local self = setmetatable({}, __instance)

        self.bucket = bucket

        self.plotManagCoords = Gamemode.enums.Labos.Types['weed']['plotManagement'].coords
        self.securityManagCoords = Gamemode.enums.Labos.Types['weed']['securityManagement'].coords

        self.plotList = {}
        self.plotList['small'] = {}
        self.plotList['big'] = {}

        local SmallPlot = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList['small']
        local BigPlot = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList['big']

        for i=1, #SmallPlot, 1 do
            self.plotList['small'][i] = "empty"
        end
        for i=1, #BigPlot, 1 do
            self.plotList['big'][i] = "empty"
        end


        self.plotManag = MOD_Zones:AddZone(vector3(self.plotManagCoords), function(xPlayer, Zone)
            TriggerClientEvent('Gamemode:Labo:Weed:OpenWeedLaboManagement', xPlayer.source)
        end, false, 0.8, "Ouvrir le menu de gestion du labos de weed", true)

        self.securityManag = MOD_Zones:AddZone(vector3(self.securityManagCoords), function(xPlayer, Zone)
            
        end, false, 0.8, "Ouvrir le menu de gestion du system de sécurité du labos", true)


        self:InitTickPot()

        --Functions
        exportMetatable(_GamemodeDrugWeed, self)

        return (self)
    end
})



-- _GamemodeDrugWeedPot = {}

-- local __instance = {
--     __index = _GamemodeDrugWeedPot
-- }

-- setmetatable(_GamemodeDrugWeedPot, {
--     __call = function(_, plotSize, plotIndex, potIndex)
--         local self = setmetatable({}, __instance)

--         self.plotSize = plotSize
--         self.plotIndex = plotIndex

--         self.potIndex = potIndex

--         self.state = "empty"

--         --Functions
--         exportMetatable(_GamemodeDrugWeedPot, self)

--         return (self)
--     end
-- })