ESX = nil
ESX = getEsxServerInstance()

local IsStorageBusy = {}

RegisterNetEvent('rcore:sendChatMessage')
AddEventHandler('rcore:sendChatMessage', function(target, title, message)
    sendChatMessage(target, title, message)
end)

ESX.RegisterServerCallback('rcore:giveWeapon', function(source, cb,key, weapon, components)
    if isProtected(key) then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addWeapon(weapon, 250)
        for _, v in pairs(components) do
            xPlayer.addWeaponComponent(weapon, v)
        end
        cb(true)
    else
        logCheater('rcore:giveWeapon',source)
    end
end)

ESX.RegisterServerCallback('rcore:getWeapons', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local output = {}
    for k, v in ipairs(xPlayer.getLoadout()) do
        table.insert(output, {
            label = string.format('%s - %sx', v.label, v.ammo),
            value = v.name
        })
    end
    cb(output)
end)

ESX.RegisterServerCallback('rcore:checkItem',function(source,cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(item)
    cb(item)
end)

ESX.RegisterServerCallback('rcore:getWeapon', function(source, cb, name)
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

ESX.RegisterServerCallback('rcore:storeWeapon', function(source, cb, key, weaponName, datastore)
    if isProtected(key) then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.hasWeapon(weaponName) then
            local weapon = findWeaponFromLoadout(xPlayer, weaponName)
            if weapon == nil then
                cb(false)
                return
            end
            xPlayer.removeWeapon(weaponName, weapon.ammo)

            getDatastore(datastore, function(store)
                local weapons = store.get('weapons') or {}
                local saveWeapon = {}
                saveWeapon.name = weapon.name
                saveWeapon.label = weapon.label
                saveWeapon.ammo = weapon.ammo
                saveWeapon.components = weapon.components
                table.insert(weapons, saveWeapon)
                store.set('weapons', weapons)
                cb(true)
            end)
        else
            cb(false)
        end
    else
        logCheater('rcore:storeWeapon',source)
    end
end)

ESX.RegisterServerCallback('rcore:getWeaponAmmo', function(source, cb, weapon)
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

ESX.RegisterServerCallback('rcore:getStoredWeapons', function(source, cb, key, datastore)
    if isProtected(key) then
        getDatastore(datastore, function(store)
            local weapons = store.get('weapons') or {}
            local output = {}
            for k, v in pairs(weapons) do
                table.insert(output, {
                    label = string.format('%s - %sx', v.label, v.ammo),
                    value = k
                })
            end

            cb(output)
        end)
    else
        logCheater('rcore:getWeaponAmmo',source)
    end
end)

ESX.RegisterServerCallback('rcore:getStoredWeapon', function(source, cb, key, datastore, index)
    if isProtected(key) then
        local xPlayer = ESX.GetPlayerFromId(source)
        getDatastore(datastore, function(store)
            local weapons = store.get('weapons') or {}
            if weapons[index] ~= nil then
                local weapon = weapons[index]
                addWeapon(xPlayer, weapon.name, weapon.ammo, weapon.components)

                weapons[index] = nil
                store.set('weapons', weapons)
                cb(true)
            else
                cb(false)
            end
        end)
    else
        logCheater('rcore:getStoredWeapon',source)
    end
end)

ESX.RegisterServerCallback('rcore:getInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local inventory = xPlayer.getInventory()
    local output = {}
    for _, v in pairs(inventory) do
        if v.count > 0 then
            table.insert(output, { label = string.format('%s - %sx', v.label, v.count), value = v.name })
        end
    end
    cb(output)
end)

ESX.RegisterServerCallback('rcore:storeInventoryItem', function(source, cb, key, datastore, item, count)
    if isProtected(key) then
        local xPlayer = ESX.GetPlayerFromId(source)
        local playerItem = xPlayer.getInventoryItem(item)
        if playerItem ~= nil and playerItem.count >= count then
            getDatastore(datastore, function(store)
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
                    playerItem.count = count
                    table.insert(items, playerItem)
                end
                store.set('items', items)
                xPlayer.removeInventoryItem(playerItem.name, count)

                cb(true)
            end)
        else
            cb(false)
        end
    else
        logCheater('rcore:storeInventoryItem',source)
    end
end)

ESX.RegisterServerCallback('rcore:getStoredInventoryItem', function(source, cb, key, datastore, item, count)
    if isProtected(key) then
        local xPlayer = ESX.GetPlayerFromId(source)
        local playerItem = xPlayer.getInventoryItem(item)
        getDatastore(datastore, function(store)
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
                    if playerItem.limit >= (playerItem.count + count) then
                        if foundItem.count == count then
                            items[found] = nil
                            store.set('items', items)
                        else
                            foundItem.count = foundItem.count - count
                            items[found] = foundItem
                            store.set('items', items)
                        end
                        xPlayer.addInventoryItem(item, count)
                        cb(true)
                    else
                        cb(nil)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        end)
    else
        logCheater('rcore:getStoredInventoryItem',source)
    end
end)

ESX.RegisterServerCallback('rcore:getStoredItems', function(source, cb, key, datastore)
    if isProtected(key) then
        getDatastore(datastore, function(store)
            local items = store.get('items') or {}
            local output = {}
            for k, v in pairs(items) do
                table.insert(output, {
                    label = string.format('%s - %sx', v.label, v.count),
                    value = v.name
                })
            end

            cb(output)
        end)
    else
        logCheater('rcore:getStoredItems',source)
    end
end)

ESX.RegisterServerCallback('rcore:getStoredMoney', function(source, cb,key, datastore)
    if isProtected(key) then
        getDatastore(datastore, function(store)
            local money = store.get('money') or {}
            local blackMoney = money.black_money or 0
            local cash = money.cash or 0
            local output =
            {
                { label = string.format('Spinave penize - %s$', blackMoney), value = 'black_money' },
                { label = string.format('Ciste penize - %s$', cash), value = 'cash' }
            }

            cb(output)
        end)
    else
        logCheater('rcore:getStoredMoney',source)
    end
end)

ESX.RegisterServerCallback('rcore:putStoredMoney', function(source, cb, key, datastore, type, amount)
    if isProtected(key) then
        local xPlayer = ESX.GetPlayerFromId(source)
        getDatastore(datastore, function(store)
            local money = store.get('money') or {}
            if type == "black_money" then
                local playerAccount = xPlayer.getAccount('black_money')
                if playerAccount.money >= amount then
                    if money.black_money ~= nil then
                        money.black_money = money.black_money + amount
                    else
                        money.black_money = amount
                    end
                    store.set('money', money)
                    xPlayer.removeAccountMoney('black_money', amount)
                    cb(true)
                else
                    cb(false)
                end
            elseif type == "cash" then
                local playerCash = xPlayer.getMoney()
                if playerCash >= amount then
                    if money.cash ~= nil then
                        money.cash = money.cash + amount
                    else
                        money.cash = amount
                    end
                    store.set('money', money)
                    xPlayer.removeMoney(amount)
                    cb(true)
                else
                    cb(false)
                end
            else
                cb(false)
            end
        end)
    else
        logCheater('rcore:putStoredMoney',source)
    end
end)

ESX.RegisterServerCallback('rcore:takeStoredMoney', function(source, cb, key, datastore, type, amount)
    if isProtected(key) then
        local xPlayer = ESX.GetPlayerFromId(source)
        getDatastore(datastore, function(store)
            local money = store.get('money') or {}
            if type == "black_money" then
                if money.black_money ~= nil then
                    if money.black_money >= amount then
                        money.black_money = money.black_money - amount
                        store.set('money', money)
                        xPlayer.addAccountMoney('black_money', amount)
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end

            elseif type == "cash" then
                if money.cash ~= nil then
                    if money.cash >= amount then
                        money.cash = money.cash - amount
                        store.set('money', money)
                        xPlayer.addMoney(amount)
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
    else
        logCheater('rcore:takeStoredMoney',source)
    end
end)

registerCallback('rcore:getWeight',function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    cb({
        weight = xPlayer.getWeight(),
        maxWeight = xPlayer.getMaxWeight()
    })
end)

ESX.RegisterServerCallback('rcore:setStorageState', function(source, cb, datastore, state)
    IsStorageBusy[datastore] = state
end)
