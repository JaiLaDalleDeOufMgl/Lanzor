function GamemodeSociety:LoadGrades(callback)
    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @job_name', {
        ["@job_name"] = self.name
    }, function(result)

        for i = 1, #result do
            self.grades[tostring(result[i].grade)] = result[i]
        end
        
        callback()
    end)
end