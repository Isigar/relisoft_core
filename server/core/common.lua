---@param source number
---@param title string
---@param message string
---@param color table {r=0,g=0,b=0}
function sendChatMessageFromServer(source,title,message,color)
    color = color or Config.DefaultChatColor
    TriggerClientEvent('chat:addMessage', source, { args = { title, message }, color = color })
end

exports('sendChatMessageFromServer',sendChatMessageFromServer)

function sendChatMessage(source,title,message,color)
    color = color or Config.DefaultChatColor
    TriggerClientEvent('chat:addMessage', source, { args = { title, message }, color = color })
end

exports('sendChatMessage',sendChatMessage)

---@param message string
function rdebug(message)
    if message ~= nil and Config.Debug == true then
        print('[relisoft_core] '..message)
    end
end

exports('rdebug',rdebug)
