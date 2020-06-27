function logCheater(reason,source)
    local xPlayer = ESX.GetPlayerFromId(source)
    reason = reason or "neznámý"
    sendCustomDiscordMessage(SConfig.DiscordLogWebhook,'Cheater!',string.format('Heleď máme tu cheatera! Menu detected!\nHráč: %s\nIdentifier: %s\nDůvod: %s',xPlayer.name,xPlayer.identifier,reason),Config.DiscordColors.Red)
end

function logStopResource(source,resource)
    local identifiers = GetPlayerIdentifiers(source)
    local message = string.format('User stopped resource - %s\n',resource)
    message = message..string.format('\nName: %s',GetPlayerName(source))
    if identifiers then
        for i,v in pairs(identifiers) do
            message = message..string.format('\n%s: %s',i,v)
        end
    end
    sendCustomDiscordMessage(SConfig.DiscordLogWebhook,'Stopped resource',message,Config.DiscordColors.Red)
end

RegisterNetEvent('rcore:logCheater')
AddEventHandler('rcore:logCheater',function(_source,reason)
    if _source == nil then
        logCheater(reason,source)
    else
        logCheater(reason,_source)
    end
end)
