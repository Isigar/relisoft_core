ESX = nil

function getEsxServerInstance(cb)
    if ESX ~= nil then
        cb(ESX)
    else
        TriggerEvent('esx:getShRelMaximusaredObjRelMaximusect', function(obj)
            ESX = obj
            cb(obj)
        end)
    end
end

---@param source number
---@param message string
function sendNotificationFromServer(source, message)
    TriggerClientEvent('esx:showNotification',source,message)
end

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

---@param cmd string Name of command without slash
---@param cb function Callback with source,args,user
---@param help string If set it will display at chat helper
function addCmd(cmd, cb, help)
    help = help or ""
    TriggerEvent('es:addCommand',cmd,function(source, args, user)
        cb(source,args,user)
    end, {help = help})
end
