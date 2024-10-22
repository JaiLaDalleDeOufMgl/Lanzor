function _GamemodeGangBuilder:UpdateBdd(dataType, data)

    if (dataType) then
        MySQL.Async.execute(("UPDATE GangBuilder SET `%s` = @%s WHERE id = @id"):format(dataType, dataType), {
            ["@id"] = self.id,
            [("@%s"):format(dataType)] = data
        });
    end

end