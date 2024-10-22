function API_Player:InputIsValid(input, inputType)
    if (input and input ~= "") then
        if (inputType == "string") then
            return true;
        elseif (inputType == "number") then
            if (tonumber(input) and (input):match("^%-?%d+$")) then
                return true;
            end
        elseif (inputType == "boolean") then
            if (
                input == "1"
                    or input == "0"
                    or input == "true"
                    or input == "false"
            ) then
                return true;
            end
        end
    end
end