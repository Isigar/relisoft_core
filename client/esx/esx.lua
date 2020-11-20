function getEsxInstance(cb)
    if ESX ~= nil then
        if cb ~= nil then
            cb(ESX)
        else
            return ESX
        end
    else
        while ESX == nil do
            TriggerEvent(Config.ESXCallback, function(obj)
                ESX = obj
            end)
        end

        if cb == nil then
            return ESX
        else
            cb(ESX)
        end
    end
end

exports('getEsxInstance',getEsxInstance)

---@param title string
---@param message string
---@param color nil|table
function sendChatMessage(title, message, color)
    if color == nil then
        color = Config.DefaultChatColor
    end
    TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
end

exports('sendChatMessage',sendChatMessage)

---@param filter nil|function
---@return table
function getPlayers(filter)
    local players = ESX.Game.GetPlayers()
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

exports('getPlayers',getPlayers)

function showNotification(message, color, flashing, brief)
    flashing = flashing or false
    brief = brief or true
    color = color or 140
    ThefeedNextPostBackgroundColor(color)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(flashing, brief)
end

exports('showNotification',showNotification)

function showHelpNotification(message)
    ESX.ShowHelpNotification(message)
end

exports('showHelpNotification',showHelpNotification)
