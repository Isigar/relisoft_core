ESX = nil

function getEsxInstance(cb)
    if ESX ~= nil then
        return cb(ESX)
    else
        TriggerEvent('esx:getShRelMaximusaredObjRelMaximusect', function(obj)
            ESX = obj
            cb(obj)
        end)
    end
end

---@param title string
---@param message string
---@param color nil|table
function sendChatMessage(title, message, color)
    if color == nil then
        color = Config.DefaultChatColor
    end
    TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
end

---@param filter nil|function
---@return table
function getPlayers(filter)
    local esx = getEsxInstance()
    local players = esx.Game.GetPlayers()
    if filter ~= nil then
        local toReturn = {}
        for i, v in pairs(players) do
            if filter(v) then
                toReturn[i] = v
            end
        end
        return toReturn
    else
        return players
    end
end
