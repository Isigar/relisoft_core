local callbacks = {}

function registerCallback(cbName, callback)
    if Config.Debug then
        print(string.format('[rcore] register callback %s',cbName))
    end
    callbacks[cbName] = callback
end

exports('registerCallback',registerCallback)

RegisterNetEvent('rcore:callCallback')
AddEventHandler('rcore:callCallback',function(name,key,source,cb,...)
    if Config.Debug then
        print(string.format('[rcore] trying to call %s callback',name))
    end

    if callbacks[name] == nil then
        print(string.format('[rcore] trying to call %s callback but its doesnt exists!'))
        return
    end

    if not isProtected(key) then
        print(string.format('[rcore] possible exploit detected! %s callback is trigger without correct key!'))
        return
    end

    local call = callbacks[name]
    call(source,function(...)
        TriggerClientEvent('rcore:callback',source,name,...)
    end,...)
end)
