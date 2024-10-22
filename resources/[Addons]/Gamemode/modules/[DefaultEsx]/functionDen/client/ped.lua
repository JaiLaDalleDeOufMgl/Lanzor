Citizen.CreateThread(function()
    while ESX.GetPlayerData() == nil do  
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
function DEN:SpawnPed(pedmodel,pos,heading,freeze,invincible,ragdoll,target,TemporaryEvents)
    CreateThread(function()
		local pc = pos
		local pedHash = GetHashKey(pedmodel)
        RequestModel(pedHash)
        while not HasModelLoaded(pedHash) do
            Citizen.Wait(10)
        end
		local pped = CreatePed(2, pedHash, pc.x , pc.y , pc.z - 1 , heading, true, false)
        if freeze then
		    FreezeEntityPosition(pped, true)
        end
        if invincible then
		    SetEntityInvincible(pped, true)
        end
        if ragdoll then
		    SetPedCanRagdoll(pped, true)
        end
        if target then
		    SetPedCanBeTargetted(pped, true)
        end
        if TemporaryEvents then
		    SetBlockingOfNonTemporaryEvents(pped, true)
        end
    end)
end

----- Player -----
function DEN:GetPlayerMoney()
    return ESX.PlayerData.money
end

function DEN:GetPlayerBank()
    return ESX.PlayerData.accounts.Bank
end
function DEN:GetPlayerJob()
    return ESX.PlayerData.job
end
function DEN:GetPlayerJob2()
    return ESX.PlayerData.job2
end
function DEN:GetPlayerGroup()
    return ESX.PlayerData.group
end
function DEN:GetPlayerWeapon()
    return ESX.PlayerData.loadout
end
function DEN:GetPlayerWeaponData()
    return Player.WeaponData
end
function DEN:GetPlayerName()
    return GetPlayerName(PlayerId())
end
function DEN:GetFirstName()
    ESX.TriggerServerCallback('DEN:GetFirstName', function(cb)
        return cb
    end)
end
function DEN:GetLastName()
    ESX.TriggerServerCallback('DEN:GetLastName', function(cb)
        return cb
    end)
end