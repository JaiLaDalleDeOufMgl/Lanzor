function MOD_Items:load(callback)
	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for i = 1, #result, 1 do
            local item = _GamemodeItems(result[i].type, result[i])

            MOD_Items:setItem(item.name, item)

			callback()
		end
	end)
end