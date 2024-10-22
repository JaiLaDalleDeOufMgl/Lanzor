function GamemodeSociety:Update(dataType, data)
    if (not dataType) then
        MySQL.Async.execute("UPDATE societies_storage SET weapons=@weapons, money=@money, dirty_money=@dirty_money WHERE name=@name", {
            ["@name"] = self.name,
            ["@money"] = self.money,
            ["@dirty_money"] = self.dirty_money
        });
    else
        MySQL.Async.execute(("UPDATE societies_storage SET `%s` = @%s WHERE `name` = @name"):format(dataType, dataType), {
            ["@name"] = self.name,
            [("@%s"):format(dataType)] = data
        });
    end
end