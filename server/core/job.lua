---@param player number
---@param job string
---@param grade number
function setPlayerJob(player, job, grade)
    local xPlayer = getPlayerFromId(player)
    if xPlayer ~= nil then
        xPlayer.setJob(job,grade)
    end
end

exports('setPlayerJob',setPlayerJob)