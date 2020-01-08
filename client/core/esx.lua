ESX = nil
Blips = {}

function getEsxInstance()
    if ESX ~= nil then
        return ESX
    else
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
            Citizen.Wait(1)
        end
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

---@param message string
function debug(message)
    Citizen.Trace('[relisoft_core] '..message)
    print('[relisoft_core] '..message)
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
