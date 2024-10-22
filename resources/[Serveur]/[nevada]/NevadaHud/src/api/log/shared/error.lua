function API_Logs:Error(message, ...)
    self:send("error", message, ...);
end

exports("Error", function(message, ...)
    API_Logs:Error(message, ...)
end)