

---@author Razzway


RegisterNetEvent(_Prefix..":deleteData", function(id)
    local source = source;
    local xPlayer = ESX.GetPlayerFromId(source);
    
    if (xPlayer) then

        MySQL.Async.fetchAll("SELECT * FROM clothes_data WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
        }, function(r)

            for i = 1, #r do

                if (r[i].id == id) then
                    
                    MySQL.Async.execute("DELETE FROM clothes_data WHERE id = @id", {["@id"] = id});

                    if (_ServerConfig.enableLogs) then
                        _Server:toDiscord(_ServerConfig.param.name, (xPlayer.getName()..' a supprimé sa tenue de son dressing | ID tenue : %s'):format(id), _ServerConfig.param.colorRed)
                    end
                end
            end
        end)
    end
end)