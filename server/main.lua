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

ESX.RegisterServerCallback('rcore:getWeapons',function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local output = {}
    for k,v in ipairs(xPlayer.getLoadout()) do
        table.insert(output,{
            label = string.format('%s - %sx',v.label, v.ammo),
            value = v.name
        })
    end
    cb(output)
end)

ESX.RegisterServerCallback('rcore:getWeapon',function(source,cb, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local loadout = xPlayer.getLoadout()
    if xPlayer.hasWeapon(weaponName) then
        local loadIndex, weapon = ESX.GetWeapon(name)
        if loadout[loadIndex] ~= nil then
            cb(weapon)
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback('rcore:storeWeapon',function(source,cb,weaponName,datastore)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.hasWeapon(weaponName) then
        local loadIndex, weapon = ESX.GetWeapon(weaponName)
        print(ESX.DumpTable(weapon))
        xPlayer.removeWeapon(weaponName,weapon.ammo)

        getDatastore(datastore,function(store)
            local weapons = store.get('weapons') or {}
            table.insert(weapons, weapon)
            store.set('weapons',weapons)
            cb(true)
        end)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('rcore:getStoredWeapons',function(source,cb,datastore)
    getDatastore(datastore,function(store)
        local weapons = store.get('weapons') or {}
        local output = {}
        for k, v in pairs(weapons) do
            table.insert(output,{
                label = string.format('%s - %sx',v.label, v.ammo),
                value = v.name
            })
        end

        cb(output)
    end)
end)