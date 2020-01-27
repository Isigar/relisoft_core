Permissions = {}
PlayerData = {}

---@param job string
---@param cb function
---@param force bool
function isAtJob(job, force)
    while ESX == nil do
        Citizen.Wait(10)
    end
    force = force or false
    if force then
        while not ESX.IsPlayerLoaded() do
            Citizen.Wait(500)
        end
        local xPlayer = ESX.GetPlayerData()
        PlayerData = xPlayer
        if xPlayer.job.name == job then
            return true
        else
            return false
        end
    else
        if PlayerData.job ~= nil then
            if PlayerData.job.name == job then
                return true
            else
                return false
            end
        else
            return isAtJob(job,true)
        end
    end
end

exports('isAtJob',isAtJob)

---@param job string
---@param cb function
---@param force bool
function isAtJobGrade(job,grade, force)
    while ESX == nil do
        Citizen.Wait(10)
    end
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

exports('isAtJobGrade',isAtJobGrade)

function getPlayerJob(force)
    while ESX == nil do
        Citizen.Wait(10)
    end
    force = force or false
    if force then
        while not ESX.IsPlayerLoaded() do
            Citizen.Wait(500)
        end

        local xPlayer = ESX.GetPlayerData()
        PlayerData = xPlayer
        return xPlayer.job
    else
        if PlayerData.job ~= nil then
            return PlayerData.job
        else
            return getPlayerJob(true)
        end
    end
end

exports('getPlayerJob',getPlayerJob)

function isPlayerLoaded()
    if PlayerData ~= nil then
        return true
    else
        return false
    end
end

exports('isPlayerLoaded',isPlayerLoaded)

function getPlayer()
    while ESX == nil do
        Citizen.Wait(10)
    end
    return ESX.GetPlayerData()
end

exports('getPlayer',getPlayer)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob',function(job)
    PlayerData.job = job
end)