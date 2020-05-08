local clientCallbacks = {}

function callCallback(name,cb,...)
    clientCallbacks[name] = cb
    TriggerServerEvent('rcore:callCallback',name,GetPlayerServerId(PlayerId()),...)
end

exports('callCallback',callCallback)

RegisterNetEvent('rcore:callback')
AddEventHandler('rcore:callback',function(cbName,...)
    if clientCallbacks[cbName] == nil then
        return
    end
    clientCallbacks[cbName](...)
end)