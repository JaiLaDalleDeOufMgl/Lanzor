_GamemodeInventory = {}

local __instance = {
    __index = _GamemodeInventory
}

local Type = type

setmetatable(_GamemodeInventory, {
    __call = function(_, type, inventoryData, inventoryClothes, slots, maxweight, class)
        local self = setmetatable({}, __instance)

        self.class = class

        self.type = type
        self.playersOpened = {}

        self.inventoryItems = {}
        self.inventoryClothes = {}

        if (inventoryClothes ~= nil) then
            self.inventoryClothes = json.decode(inventoryClothes) or {}
        end

        self.weight = 0
        self.maxweight = maxweight

        for i=1, slots, 1 do
            self.inventoryItems[i] = "empty"
        end


        if (self.type == "player") then
            self.inventoryName = 'JOUEUR : '..self.class.name

            self.inventoryItems["weapons"] = {}
            for i=1, 5, 1 do
                self.inventoryItems["weapons"][i] = "empty"
            end

            if (inventoryData) then
                local inventoryData = json.decode(inventoryData) or {}
                local ItemsNotSlot = {}

                for i=1, #self.class.accounts, 1 do
                    if (self.class.accounts[i].name == 'cash' or self.class.accounts[i].name == 'dirtycash') then
                        local ItemInfos = MOD_Items:getItem(self.class.accounts[i].name)

                        if (self.class.accounts[i].money > 0) then
                            table.insert(ItemsNotSlot, {
                                name = ItemInfos.name,
                                count = self.class.accounts[i].money,
                                slot = "empty",
                                label = ItemInfos.label,
                                type = ItemInfos.type,
    
                                id = false,
                                args = nil,
                            })
                        end

                        self.class.removeAccountsNameFistLoad(self.class.accounts[i].name)
                    end
                end

                for key, items in pairs(inventoryData) do
                    if (key == "main") then
                        for i=1, #items, 1 do
                            local Item = items[i]

                            if (Item ~= nil) then
                                self.inventoryItems[Item.slot] = Item
                            end
                        end
                    elseif  (key == "weapons") then
                        for i=1, #items, 1 do
                            local Item = items[i]

                            if (Item ~= nil) then
                                self.inventoryItems["weapons"][Item.slot] = Item
                            end
                        end
                    else
                        local ItemInfos = MOD_Items:getItem(items.name)

                        table.insert(ItemsNotSlot, {
                            name = items.name,
                            count = items.count,
                            slot = items.slot or "empty",
                            label = ItemInfos.label,
                            type = ItemInfos.type,

                            id = items.id or false,
                            args = items.args or nil,
                        })
                    end
                end

                if (next(ItemsNotSlot) ~= nil) then
                    for i=1, #ItemsNotSlot, 1 do
                        for _i=1, #self.inventoryItems, 1 do
                            if (self.inventoryItems[_i] == "empty") then
                                self.inventoryItems[_i] = ItemsNotSlot[i]
                                self.inventoryItems[_i].slot = _i

                                if (self.inventoryItems[_i].type == "weapons") then
                                    self.inventoryItems[_i].id = tostring(math.random(1000, 9999)).."-"..tostring(math.random(1000, 9999))
                                    self.inventoryItems[_i].args = {}

                                    if (MOD_inventory:getWeaponIsPerma(self.inventoryItems[_i].name)) then
                                        self.inventoryItems[_i].args.antiActions = 'perma'
                                    end
                                end
                                break
                            end
                        end
                    end
                end
            end
        elseif (self.type == "vehicule") then
            self.inventoryName = 'PLAQUE : '..self.class.plate

            if (inventoryData) then
                local inventoryData = json.decode(inventoryData) or {}

                for i=1, #inventoryData, 1 do
                    local item = inventoryData[i]

                    local ItemInfos = MOD_Items:getItem(string.lower(item.name))
                    if (ItemInfos ~= nil) then 
                        if (self.inventoryItems[item.slot] ~= nil) then
                            self.inventoryItems[item.slot] = item
                            
                            if (self.inventoryItems[item.slot].count == nil) then
                                self.inventoryItems[item.slot].count = 1
                            end
                        end
                    end
                end
            end
        elseif (self.type == "properties") then
            self.inventoryName = 'PROPRIÉTÉ : '..self.class.propertiesName
            
            if (inventoryData and next(inventoryData) ~= nil) then
                for i=1, #inventoryData, 1 do
                    local item = inventoryData[i]

                    local ItemInfos = MOD_Items:getItem(string.lower(item.name))
                    if (ItemInfos ~= nil) then 
                        if (self.inventoryItems[item.slot] ~= nil) then
                            self.inventoryItems[item.slot] = item
                            
                            if (self.inventoryItems[item.slot].count == nil) then
                                self.inventoryItems[item.slot].count = 1
                            end
                        end
                    end
                end
            end
        elseif (self.type == "coffrebuilder") then
            self.inventoryName = 'COFFRE : '..self.class.idCoffre

            if (inventoryData and next(inventoryData) ~= nil) then
                for i=1, #inventoryData, 1 do
                    local item = inventoryData[i]

                    local ItemInfos = MOD_Items:getItem(string.lower(item.name))
                    if (ItemInfos ~= nil) then
                        if (self.inventoryItems[item.slot] ~= nil) then
                            self.inventoryItems[item.slot] = item
                            
                            if (self.inventoryItems[item.slot].count == nil) then
                                self.inventoryItems[item.slot].count = 1
                            end
                        end
                    end
                end
            end
        elseif (self.type == "coffresociety") then
            self.inventoryName = 'COFFRE : '..self.class.jobName
            
            if (inventoryData and next(inventoryData) ~= nil) then
                for i=1, #inventoryData, 1 do
                    local item = inventoryData[i]

                    local ItemInfos = MOD_Items:getItem(string.lower(item.name))
                    if (ItemInfos ~= nil) then
                        if (self.inventoryItems[item.slot] ~= nil) then
                            self.inventoryItems[item.slot] = item
                            
                            if (self.inventoryItems[item.slot].count == nil) then
                                self.inventoryItems[item.slot].count = 1
                            end
                        end
                    end
                end
            end
        elseif (self.type == "coffregang") then
            self.inventoryName = 'COFFRE : '..self.class.jobName
            
            if (inventoryData and next(inventoryData) ~= nil) then
                for i=1, #inventoryData, 1 do
                    local item = inventoryData[i]

                    local ItemInfos = MOD_Items:getItem(string.lower(item.name))
                    if (ItemInfos ~= nil) then
                        if (self.inventoryItems[item.slot] ~= nil) then
                            self.inventoryItems[item.slot] = item
                            
                            if (self.inventoryItems[item.slot].count == nil) then
                                self.inventoryItems[item.slot].count = 1
                            end
                        end
                    end
                end
            end
        end




        --Functions
        exportMetatable(_GamemodeInventory, self)

        return (self)
    end
})