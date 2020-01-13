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
---@param force bool
function isAtJob(job,cb, force)
    force = force or false
    if force then
        getEsxInstance(function(esx)
            while not esx.IsPlayerLoaded() do
                Citizen.Wait(500)
            end
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

---@param job string
---@param cb function
---@param force bool
function isAtJobGrade(job,grade,cb, force)
    force = force or false
    if force then
        getEsxInstance(function(esx)
            while not esx.IsPlayerLoaded() do
                Citizen.Wait(500)
            end
            local xPlayer = esx.GetPlayerData()
            if xPlayer.job.name == job then
                if xPlayer.job.grade_name == grade then
                    cb(true)
                else
                    cb(true)
                end
            else
                cb(false)
            end
        end)
    else
        if PlayerData.job ~= nil then
            if PlayerData.job.name == job then
                if xPlayer.job.grade_name == grade then
                    cb(true)
                else
                    cb(false)
                end
            else
                cb(false)
            end
        else
            isAtJobGrade(job,grade,function(is)
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