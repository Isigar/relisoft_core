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
        if cb ~= nil then
            TriggerEvent(Config.ESXCallback, function(obj)
                ESX = obj
            end)
            cb(ESX)
        else
            TriggerEvent(Config.ESXCallback, function(obj)
                ESX = obj
            end)
            return ESX
        end
    end
end

exports('getEsxServerInstance',getEsxServerInstance)

---@param source number
---@param message string
function sendNotificationFromServer(source, message)
    TriggerClientEvent('rcore:showNotification',source,message)
end

exports('sendNotificationFromServer',sendNotificationFromServer)

function showNotification(source,message, color, flashing, brief)
    TriggerClientEvent('rcore:showNotification',source,message,color,flashing,brief)
end

exports('showNotification',showNotification)

function showHelpNotification(source,msg)
    TriggerClientEvent(EventConfig.Common.showHelpNotif,source,msg)
end

exports('showHelpNotification',showHelpNotification)

function getPlayerFromId(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer
end

exports('getPlayerFromId',getPlayerFromId)
