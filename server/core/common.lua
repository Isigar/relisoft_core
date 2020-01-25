---@param source number
---@param title string
---@param message string
---@param color table {r=0,g=0,b=0}
function sendChatMessageFromServer(source,title,message,color)
    color = color or Config.DefaultChatColor
    TriggerClientEvent('chat:addMessage', source, { args = { title, message }, color = color })
end

exports('sendChatMessageFromServer',sendChatMessageFromServer)

---@param message string
function rdebug(message)
    if message ~= nil then
        print('[relisoft_core] '..message)
    end
end

exports('rdebug',rdebug)