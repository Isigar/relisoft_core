local activePlayers = {}

function getIdentityName(identifier,cb)
    MySQL.Async.fetchAll('SELECT firstname,lastname FROM users WHERE identifier=@identifier LIMIT 1',{
        ['@identifier'] = identifier
    },function(rows)
        if rows[1] then
            cb(rows[1])
        else
            cb(nil)
        end
    end)
end

exports('getIdentityName',getIdentityName)

RegisterNetEvent('rcore:changePlayer')
AddEventHandler('rcore:changePlayer',function(source)
    activePlayers[source] = ESX.GetPlayerFromId(source)
end)

AddEventHandler(EventConfig.Common.playerDropped,function(source)
    activePlayers[source] = nil
end)

function getActivePlayers()
    return activePlayers
end

exports('getActivePlayers',getActivePlayers)
