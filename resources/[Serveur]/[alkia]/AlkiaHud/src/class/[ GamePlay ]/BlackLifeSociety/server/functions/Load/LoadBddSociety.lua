function GamemodeSociety:LoadBddSociety(callback)
    MySQL.Async.fetchAll("SELECT * FROM societies_storage WHERE name = @name", {
        ["@name"] = self.name
    }, function(result)
        if (#result > 0) then
            
            self.money = result[1].money
            self.dirty_money = result[1].dirty_money

            
            self.inventory = json.decode(result[1].inventory)
        else
            ----- INSERT INTO BDD
            MySQL.Async.execute("INSERT INTO societies_storage (name, label, money, dirty_money, inventory) VALUES (@name, @label, @money, @dirty_money, @inventory)", {
                ["@name"] = self.name,
                ["@label"] = self.label,
                ["@money"] = Gamemode.enums.Society.DefaultMoney,
                ["@dirty_money"] = Gamemode.enums.Society.DefaultDirtyMoney,
                ["@inventory"] = json.encode({}),
            })
            
            self.money = 0
            self.dirty_money = 0

            self.inventory = {}
        end

        callback()
    end)
end