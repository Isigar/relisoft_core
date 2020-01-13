Permissions = {}
PlayerData = {}

function addPermission()

end

function addPlayerPermission(identifier, permission)

end

function removePlayerPermission(identifier, permission)

end

---@param job string
---@param cb function
function isAtJob(job,cb, force)
    if force then
        getEsxInstance(function(esx)
            local xPlayer = esx.GetPlayerData()
            if xPlayer.job.name == job then
                cb(true)
            else
                cb(false)
            end
        end)
    else
        if PlayerData.job ~= nil then
            if PlayerData.job.name == job then
                cb(true)
            else
                cb(false)
            end
        else
            isAtJob(job,function(is)
                cb(is)
            end,true)
        end
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob',function(job)
    PlayerData.job = job
end)