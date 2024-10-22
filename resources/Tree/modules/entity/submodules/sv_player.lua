Tree.players = {}

function Tree.getPlayer(src)
    return Tree.players[src]
end

function Tree.createPlayer(src)
    local self = {}

    self.id       = src
    self.name     = GetPlayerName(src)
    self.ped      = GetPlayerPed(src)
    self.coords   = GetEntityCoords(self.ped)
    self.heading  = GetEntityHeading(self.ped)
    self.health   = GetEntityHealth(self.ped)
    self.armor    = GetPedArmour(self.ped)
    self.wanted   = GetPlayerWantedLevel(src)

    self.getIdentifierByType = function(type)
        return GetPlayerIdentifierByType(self.id, type)
    end

    self.triggerEvent = function(eventName, ...)
        TriggerClientEvent(eventName, self.source, ...)
    end

    self.set = function(key, value)
        self[key] = value
    end

    self.get = function(key)
        return self[key]
    end

    self.teleport = function(x, y, z)
        SetEntityCoords(self.ped, x, y, z)
    end

    self.getChunkId= function()
        local chunkId = nil
        Tree.TriggerClientCallback(self.id, 'Tree:chunk:getChunkId', function(data)
            chunkId = data
        end)
        while chunkId == nil do
            Wait(0)
        end
        return chunkId
    end

    self.applySkin = function (skin, clothes)
        Tree.Ender.ApplySkin(self.id, skin, clothes)
    end

    self.change = function (key, value)
        Tree.Ender.Change(self.id, key, value)
    end

    self.getMaxValues = function ()
        Tree.Ender.GetMaxValues(self.id)
    end

    self.getData = function ()
        Tree.Ender.GetData(self.id)
    end

    self.LoadModel = function (isMale)
        Tree.Ender.LoadModel(self.id, isMale)
    end

    self.loadSkin = function (skin)
        Tree.Ender.LoadSkin(self.id, skin)
    end

    return self
end

RegisterServerEvent("Tree:Loaded", function()
    local src = source
    if not Tree.players[src] then
        local player = Tree.createPlayer(src)
        Tree.players[src] = player
        TriggerClientEvent("Tree:PlayerJoined", src, player)
    end
end)

RegisterServerEvent("Tree:PlayerLeft", function()
    local src = source
    Tree.players[src] = nil
end)