RegisterNetEvent('rcore:logCheater')
AddEventHandler('rcore:logCheater',function(reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    reason = reason or "neznámý"
    sendDiscordMessage('Cheater!',string.format('Heleď máme tu cheatera! Menu detected!\nHráč: %s\nIdentifier: %s\nDůvod: %s',xPlayer.name,xPlayer.identifier,reason),Config.DiscordColors.Red)
end)