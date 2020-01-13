ESX = nil

getEsxServerInstance(function(obj)
    ESX = obj
end)

RegisterNetEvent('rcore:sendChatMessage',function(target, title,message)
    sendChatMessageFromServer(target,title,message)
end)

ESX.RegisterServerCallback('rcore:giveWeapon',function(source,cb,weapon,components)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(weapon,250)
    for _, v in pairs(components) do
        xPlayer.addWeaponComponent(weapon,v)
    end
    cb(true)
end)