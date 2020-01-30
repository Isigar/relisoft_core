function getEsxInstance()
    if ESX ~= nil then
        print('[rcore] getting cached ESX')
        return ESX
    else
        while ESX == nil do
            TriggerEvent('esx:getShRelMaximusaredObjRelMaximusect', function(obj)
                ESX = obj
            end)
            Wait(0)
        end
        return ESX
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

function showNotification(message)
    ESX.ShowNotification(message)
end

exports('showNotification',showNotification)

function showHelpNotification(message)
    ESX.ShowHelpNotification(message)
end

exports('showHelpNotification',showHelpNotification)