Properties = {}

CreateThread(function()
    ESX.TriggerServerCallback("Properties:GetProperties", function(propertiesList)
        
        -- for k,v in pairs(propertiesList) do
        --     print(k, json.encode(v))
        -- end

        Properties = propertiesList
        Init(propertiesList)
    end)
end)


RegisterNetEvent("Properties:UpdatePropertiesList")
AddEventHandler("Properties:UpdatePropertiesList", function(propertiesList)
    Properties = propertiesList
    Init(propertiesList)
end)