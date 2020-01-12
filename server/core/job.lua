---@param player number
---@param job string
---@param grade number
function addPlayerToJob(player, job, grade)
    getEsxServerInstance(function(esx)
        getPlayerFromId(player,function(xPlayer)
            xPlayer.setJob(job,grade)
        end)
    end)
end