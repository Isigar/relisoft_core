local clientCallbacks = {}
local currentRequest = 0

function callCallback(name,cb,...)
    clientCallbacks[currentRequest] = cb
    TriggerServerEvent('rcore:callCallback',name,currentRequest,GetPlayerServerId(PlayerId()),...)

    if currentRequest < 65535 then
        currentRequest = currentRequest + 1
    else
        currentRequest = 0
    end
end

exports('callCallback',callCallback)

RegisterNetEvent('rcore:callback')
AddEventHandler('rcore:callback',function(requestId,...)
    if clientCallbacks[requestId] == nil then
        return
    end
    clientCallbacks[requestId](...)
end)
