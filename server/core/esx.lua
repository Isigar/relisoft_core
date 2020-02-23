ESX = nil

---@return object function
function getEsxServerInstance(cb)
    if ESX ~= nil then
        print('[rcore] Getting cached ESX instance!')
        if cb ~= nil then
            cb(ESX)
        else
            return ESX
        end
    else
        TriggerEvent(Config.ESXCallback, function(obj)
            ESX = obj
        end)
        if cb ~= nil then
            cb(ESX)
        else
            return ESX
        end
    end
end

exports('getEsxServerInstance',getEsxServerInstance)

---@param source number
---@param message string
function sendNotificationFromServer(source, message)
    TriggerClientEvent('esx:showNotification',source,message)
end

exports('sendNotificationFromServer',sendNotificationFromServer)

---@param cmd string Name of command without slash
---@param level number Needed admin level
---@param cb function Callback with source,args,user
---@param help string If set it will display at chat helper
function addAdminCmd(cmd, level, cb, help)
    help = help or ""
    TriggerEvent('es:addAdminCommand', cmd, level, function(source, args, user)
        cb(source,args,user)
    end, function(source, args, user)
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Nedostatečné oprávnění!' } })
    end, {help = help})
end

exports('addAdminCmd',addAdminCmd)

---@param cmd string Name of command without slash
---@param cb function Callback with source,args,user
---@param help string If set it will display at chat helper
function addCmd(cmd, cb, help)
    help = help or ""
    TriggerEvent('es:addCommand',cmd,function(source, args, user)
        cb(source,args,user)
    end, {help = help})
end

exports('addCmd',addCmd)

function getPlayerFromId(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer
end

exports('getPlayerFromId',getPlayerFromId)