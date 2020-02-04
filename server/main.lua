ESX = nil
IsStorageBusy = {}

ESX = getEsxServerInstance()

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
            cb(loadout[loadIndex])
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
        local weapon = findWeaponFromLoadout(xPlayer,weaponName)
        if weapon == nil then
            cb(false)
            return
        end
        xPlayer.removeWeapon(weaponName,weapon.ammo)

        getDatastore(datastore,function(store)
            local weapons = store.get('weapons') or {}
            local saveWeapon = {}
            saveWeapon.name = weapon.name
            saveWeapon.label = weapon.label
            saveWeapon.ammo = weapon.ammo
            saveWeapon.components = weapon.components
            table.insert(weapons, saveWeapon)
            store.set('weapons',weapons)
            cb(true)
        end)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('rcore:getWeaponAmmo',function(source,cb,weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local loadout = xPlayer.GetPlayerLoadout()
    local found
    for _, v in pairs(loadout) do
        if v.name == weapon then
            found = v
            break
        end
    end
    if found ~= nil then
        cb(found.ammo)
    else
        cb(0)
    end
end)

ESX.RegisterServerCallback('rcore:getStoredWeapons',function(source,cb,datastore)
    getDatastore(datastore,function(store)
        local weapons = store.get('weapons') or {}
        local output = {}
        for k, v in pairs(weapons) do
            table.insert(output,{
                label = string.format('%s - %sx',v.label, v.ammo),
                value = k
            })
        end

        cb(output)
    end)
end)

ESX.RegisterServerCallback('rcore:getStoredWeapon',function(source,cb,datastore,index)
    local xPlayer = ESX.GetPlayerFromId(source)
    getDatastore(datastore,function(store)
        local weapons = store.get('weapons') or {}
        if weapons[index] ~= nil then
            local weapon = weapons[index]
            addWeapon(xPlayer,weapon.name, weapon.ammo, weapon.components)

            weapons[index] = nil
            store.set('weapons',weapons)
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('rcore:getInventory',function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = xPlayer.getInventory()
    local output = {}
    for _, v in pairs(inventory) do
        if v.count > 0 then
            table.insert(output,{label = string.format('%s - %sx',v.label, v.count),value = v.name})
        end
    end
    cb(output)
end)

ESX.RegisterServerCallback('rcore:storeInventoryItem',function(source,cb,datastore,item,count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(item)
    if item ~= nil and item.count > count then
        getDatastore(datastore,function(store)
            local items = store.get('items') or {}
            local found
            for k, v in pairs(items) do
                if v.name == item then
                    found = items[k]
                    break
                end
            end

            if found then
                found.count = found.count + count
            else
                item.count = count
                table.insert(items, item)
            end

            xPlayer.removeInventoryItem(item.name, count)
        end)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('rcore:getStoredInventoryItem',function(source,cb,datastore,item,count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerItem = xPlayer.getInventoryItem(item)
    getDatastore(datastore,function(store)
        local items = store.get('items') or {}
        local found = false
        for k, v in pairs(items) do
            if v.name == item then
                found = k
                break
            end
        end

        if found then
            local foundItem = items[found]
            if foundItem.count > count then
                if playerItem.limit > (playerItem.count + count) then
                    if foundItem.count == count then
                        items[found] = nil
                        store.set('items',items)
                    else
                        foundItem.count = foundItem.count - count
                        items[found] = foundItem
                        store.set('items',items)
                    end
                    xPlayer.addInventoryItem(item,count)
                    cb(true)
                else
                    cb(false)
                end
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('rcore:getStoredItems',function(source,cb,datastore)
    getDatastore(datastore,function(store)
        local items = store.get('items') or {}
        local output = {}
        for k, v in pairs(items) do
            table.insert(output,{
                label = string.format('%s - %sx',v.label, v.count),
                value = k
            })
        end

        cb(output)
    end)
end)

ESX.RegisterServerCallback('rcore:setStorageState',function(source,cb,datastore,state)
    IsStorageBusy[datastore] = state
end)