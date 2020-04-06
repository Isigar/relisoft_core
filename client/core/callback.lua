local callbacks = {}

function callCallback(name,cb,...)
    callbacks[name] = cb
    TriggerServerEvent('rcore:callCallback',name,getClientKey(),GetPlayerServerId(PlayerId()),cb,...)
end

exports('callCallback',callCallback)

RegisterNetEvent('rcore:callback')
AddEventHandler('rcore:callback',function(cbName,...)
    if callbacks[cbName] == nil then
        return
    end
    callbacks[cbName](...)
end)