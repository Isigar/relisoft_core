Permissions = {}
PlayerData = {}

Citizen.CreateThread(function()
    ESX = getEsxInstance()
end)

function addPermission()

end

function addPlayerPermission(identifier, permission)

end

function removePlayerPermission(identifier, permission)

end

---@param job string
---@param cb function
---@param force bool
function isAtJob(job, cb, force)
    force = force or false
    if force then
        while not ESX.IsPlayerLoaded() do
            Citizen.Wait(500)
        end
        local xPlayer = ESX.GetPlayerData()
        PlayerData = xPlayer
        if xPlayer.job.name == job then
            cb(true)
        else
            cb(false)
        end
    else
        if PlayerData.job ~= nil then
            if PlayerData.job.name == job then
                cb(true)
            else
                cb(false)
            end
        else
            return isAtJob(job,true)
        end
    end
end

---@param job string
---@param cb function
---@param force bool
function isAtJobGrade(job,grade, force)
    force = force or false
    if force then
        while not ESX.IsPlayerLoaded() do
            Citizen.Wait(500)
        end

        local xPlayer = ESX.GetPlayerData()
        PlayerData = xPlayer
        if xPlayer.job.name == job then
            if xPlayer.job.grade_name == grade then
                return true
            else
                return false
            end
        else
            return false
        end
    else
        if PlayerData.job ~= nil then
            if PlayerData.job.name == job then
                if PlayerData.job.grade_name == grade then
                    return true
                else
                    return false
                end
            else
                return false
            end
        else
            return isAtJobGrade(job,grade,true)
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