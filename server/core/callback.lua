local serverCallbacks = {}
local callbacksRequestsHistory = {}
local dbg = rdebug()

function registerCallback(cbName, callback)
    dbg.debug(string.format('[rcore] register callback %s',cbName))
    serverCallbacks[cbName] = callback
end

exports('registerCallback',registerCallback)

RegisterNetEvent('rcore:callCallback')
AddEventHandler('rcore:callCallback',function(key, name, requestId,source,...)
    if Config.Debug then
        dbg.debug(string.format('[rcore] trying to call %s callback',name))
    end

    if key == nil or not isProtected(key) then
        logCheater('rcore:callCallback',source)
        return
    end

    if serverCallbacks[name] == nil then
        dbg.critical(string.format('[rcore] trying to call %s callback but its doesnt exists!',name))
        return
    end
    callbacksRequestsHistory[requestId] = {
        key = key,
        name = name,
        source = source,
        done = false
    }
    local call = serverCallbacks[name]
    call(source,function(...)
        TriggerClientEvent('rcore:callback',source,requestId,...)
    end,...)
end)

RegisterNetEvent('rcore:callbackSended')
AddEventHandler('rcore:callbackSended',function(requestId)
    if callbacksRequestsHistory[requestId] then
        callbacksRequestsHistory[requestId].done = true
    else
        dbg.debug('[rcore] not looking good request?')
    end
end)
