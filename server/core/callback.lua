local serverCallbacks = {}

function registerCallback(cbName, callback)
    if Config.Debug then
        print(string.format('[rcore] register callback %s',cbName))
    end
    serverCallbacks[cbName] = callback
end

exports('registerCallback',registerCallback)

RegisterNetEvent('rcore:callCallback')
AddEventHandler('rcore:callCallback',function(name,source,...)
    if Config.Debug then
        print(string.format('[rcore] trying to call %s callback',name))
    end

    if serverCallbacks[name] == nil then
        print(string.format('[rcore] trying to call %s callback but its doesnt exists!',name))
        return
    end

    local call = serverCallbacks[name]
    call(source,function(...)
        TriggerClientEvent('rcore:callback',source,name,...)
    end,...)
end)
