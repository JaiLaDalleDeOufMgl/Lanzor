

---@class _Razzway
_Razzway = {};
_Razzway.Data = {};

BLCCCCCCCCCC = true

---@author Razzway
---@type function _Razzway:refreshData
function _Razzway:refreshData()
  if BLCCCCCCCCCC then 
    TriggerServerEvent(_Prefix..":refreshData")
  end
end

RegisterNetEvent(_Prefix..":sendData")
AddEventHandler(_Prefix..":sendData", function(data)
    _Razzway.Data = data
    BLCCCCCCCCCC = true
end)