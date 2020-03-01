local protectionKey

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

function getClientKey()
    print(string.format('[rcore] getting key from export %s',protectionKey))
    return protectionKey
end

exports('getClientKey',getClientKey)