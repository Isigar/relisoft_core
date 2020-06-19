local storageBusy = {}

function setStorageBusy(id,state)
    if Config.Debug then
        print(string.format('[rcore] Setting storage with id %s to busy state %s',id,state))
    end
    storageBusy[id] = state

    TriggerClientEvent('rcore:updateStorageBusy',-1,storageBusy)
end

function isStorageBusy(id)
    return storageBusy[id] or false
end

RegisterNetEvent('rcore:setStorageBusy')
AddEventHandler('rcore:setStorageBusy',function(id,state)
    setStorageBusy(id,state)
end)