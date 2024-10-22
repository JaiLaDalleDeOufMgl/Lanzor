function API_Logs:Success(message, ...)
    self:send("success", message, ...);
end

exports("Success", function(message, ...)
    API_Logs:Success(message, ...)
end)