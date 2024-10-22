function API_Logs:getSide()
    if (IsDuplicityVersion()) then
        return "^5SERVER";
    else
        return "^5CLIENT";
    end
end