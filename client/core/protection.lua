local protectionKey
local count

TriggerServerEvent('rcore:updateCount',GetNumResources())

TriggerServerEvent('rcore:retrieveKey')

RegisterNetEvent('rcore:updateKey')
AddEventHandler('rcore:updateKey', function(key)
    if GetCurrentResourceName() == "rcore" then
        protectionKey = key
--        dprint(string.format('[rcore] Getting key: %s',key))
    else
        TriggerServerEvent('rcore:logCheater',nil,'rcore:updateKey')
    end
end)

function getClientKey(resource)
    if resource == nil then
        dprint('Found not resource getClientKey export')
        TriggerServerEvent('rcore:logCheater',nil,'rcore:getClientKey')
        return
    end
--    dprint(string.format('[rcore] getting key from export %s by %s',protectionKey, resource))
    return protectionKey
end

exports('getClientKey',getClientKey)
