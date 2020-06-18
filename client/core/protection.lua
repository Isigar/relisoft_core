local protectionKey
local count

TriggerServerEvent('rcore:updateCount',GetNumResources())

TriggerServerEvent('rcore:retrieveKey')

RegisterNetEvent('rcore:updateKey')
AddEventHandler('rcore:updateKey', function(key)
    if GetCurrentResourceName() == "rcore" then
        protectionKey = key
        print(string.format('[rcore] Getting key: %s',key))
    else
        TriggerServerEvent('rcore:logCheater',nil,'rcore:updateKey')
    end
end)

function getClientKey(resource)
    if resource == nil then
        TriggerServerEvent('rcore:logCheater',nil,'rcore:getClientKey')
    end
    print(string.format('[rcore] getting key from export %s',protectionKey))
    return protectionKey
end

exports('getClientKey',getClientKey)

AddEventHandler('onClientResourceStop',function(resName)
    TriggerServerEvent('resourceStop',resName)
end)
