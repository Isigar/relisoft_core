local storages = {}
local storageBusy = {}
local dbg = rdebug()

function findStorageWithSameName(name)
    for k, v in pairs(storages) do
        if v.name == name then
            return k
        end
    end
end

function removeStorage(id)
    storages[id] = nil
    TriggerEvent('rcore:updateStorages')
end

exports('removeStorage',removeStorage)

function setStorageBusy(id,state)
    if Config.Debug then
        dbg.debug(string.format('[rcore] Setting storage with id %s to busy state %s',id,state))
    end
    TriggerServerEvent('rcore:setStorageBusy',id,state)
end

exports('setStorageBusy',setStorageBusy)

function isStorageBusy(id)
    return storageBusy[id] or false
end

exports('isStorageBusy',isStorageBusy)

function updateStorage(id,title,name,datastore,coords,options)
    storages[id] = {
        id = id,
        title = title,
        name = name,
        datastore = datastore,
        coords = coords,
        options = options,
        distance = options.distance or 100,
        updated = true
    }
    if Config.Debug then
        dbg.debug(string.format('[rcore] Updating storage with id %s',id))
    end

    return id
end

exports('updateStorage',updateStorage)

function addStorage(title, name, datastore, coords, options)
    local findId = findStorageWithSameName(name)
    if findId then
        updateStorage(findId,title,name,datastore,coords,options)
        TriggerEvent('rcore:updateStorages')
        return findId
    else
        local id = tableLastIterator(storages)+1
        table.insert(storages,{
            id = id,
            title = title,
            name = name,
            datastore = datastore,
            coords = coords,
            options = options,
            distance = options.distance or 100
        })
        if Config.Debug then
            dbg.debug(string.format('[rcore] Creating storage with id %s',id))
        end

        TriggerEvent('rcore:updateStorages')
        return id
    end
end

exports('addStorage',addStorage)

function closeStorageMenu(id)
    local storage = storages[id]
    if storage ~= nil then
        local idName = string.format('storage-%s-%s-',id,storage.name)
        closeMenu(idName)
        closeMenu(idName..'store_weapon')
        closeMenu(idName..'get_weapon')
        closeMenu(idName..'store_item')
        closeMenu(idName..'get_item')
        closeMenu(idName..'store_money')
        closeMenu(idName..'get_money')
        closeDialog(idName..'get_money_count')
        closeDialog(idName..'store_money_count')
        closeDialog(idName..'store_item_count')
        closeDialog(idName..'get_item_count')
    end
end

function openStorageMenu(id, title, name, datastore, menuContext)
    local menuOptions = {}
    if menuContext == nil then
        menuOptions = {
            { label = 'Uschovat zbran', value = 'store_weapon' },
            { label = 'Vybrat zbran', value = 'get_weapon' },
            { label = 'Uschovat predmet', value = 'store_item' },
            { label = 'Vybrat predmet', value = 'get_item' },
            { label = 'Uschovat penize', value = 'store_money' },
            { label = 'Vybrat penize', value = 'get_money' },
        }
    else
        for k, v in pairs(menuContext) do
            if v == "store_weapon" then
                table.insert(menuOptions,{ label = 'Uschovat zbran', value = 'store_weapon' })
            elseif v == "get_weapon" then
                table.insert(menuOptions,{ label = 'Vybrat zbran', value = 'get_weapon' })
            elseif v == "store_item" then
                table.insert(menuOptions,{ label = 'Uschovat predmet', value = 'store_item' })
            elseif v == "get_item" then
                table.insert(menuOptions,{ label = 'Vybrat predmet', value = 'get_item' })
            elseif v == "store_money" then
                table.insert(menuOptions,{ label = 'Uschovat penize', value = 'store_money' })
            elseif v == "get_money" then
                table.insert(menuOptions,{ label = 'Vybrat penize', value = 'get_money' })
            end
        end
    end
    local idName = string.format('storage-%s-%s-',id,name)
    createMenu(title, idName, menuOptions, {
        submit = function(data, menu)
            local value = data.current.value
            if value == "store_weapon" then
                ESX.TriggerServerCallback('rcore:getWeapons', function(weapons)
                    createMenu(title, idName..'store_weapon', weapons, {
                        submit = function(data, menu2)
                            menu2.close()
                            ESX.TriggerServerCallback('rcore:storeWeapon', function(stored)
                                showNotification('~g~Uspesne jste ulozili zbran do trezoru!')
                            end,getClientKey(GetCurrentResourceName()), data.current.value, datastore)
                        end
                    })
                end)
            elseif value == "get_weapon" then
                ESX.TriggerServerCallback('rcore:getStoredWeapons', function(weapons)
                    createMenu(title, idName..'get_weapon', weapons, {
                        submit = function(data, menu2)
                            menu2.close()
                            ESX.TriggerServerCallback('rcore:getStoredWeapon', function(get)
                                if get then
                                    showNotification('~g~Uspesne jste si vybral zbran z trezoru!')
                                else
                                    showNotification('~r~Tak tuto zbran tu opravdu nemame!')
                                end
                            end,getClientKey(GetCurrentResourceName()), datastore, data.current.value)
                        end
                    })
                end,getClientKey(GetCurrentResourceName()), datastore)
            elseif value == "store_item" then
                ESX.TriggerServerCallback('rcore:getInventory', function(inv)
                    createMenu(title, idName..'store_item', inv, {
                        submit = function(data, menu2)
                            createDialog('Pocet k ulozeni?',idName..'store_item_count',function(data2,menu3)
                                menu3.close()
                                menu2.close()
                                local count = tonumber(data2.value)
                                if count ~= nil and count > 0 then
                                    ESX.TriggerServerCallback('rcore:storeInventoryItem',function(state)
                                        if state then
                                            showNotification('~g~Uspesne~w~ si uschoval predmet')
                                        else
                                            showNotification('~r~Nepodarilo~w~ se ti to tam narvat!')
                                        end
                                    end,getClientKey(GetCurrentResourceName()),datastore,data.current.value,count)
                                else
                                    showNotification('Neplatna castka')
                                end
                            end)
                        end
                    })
                end)
            elseif value == "get_item" then
                ESX.TriggerServerCallback('rcore:getStoredItems', function(items)
                    createMenu(title, idName..'get_item', items, {
                        submit = function(data, menu2)
                            createDialog('Pocet k vybrani?',idName..'get_item_count',function(data2,menu3)
                                menu3.close()
                                menu2.close()
                                local count = tonumber(data2.value)
                                if count ~= nil and count > 0 then

                                    ESX.TriggerServerCallback('rcore:getStoredInventoryItem', function(get)
                                        if get == true then
                                            showNotification('~g~Uspesne~w~ jste vybrali ze skladu!')
                                        elseif get == false then
                                            showNotification('~r~Tak takto asi ne!')
                                        else
                                            showNotification('~w~Tolik toho opravdu ~r~neuneses!')
                                        end
                                    end,getClientKey(GetCurrentResourceName()), datastore, data.current.value,count)
                                else
                                    showNotification('~r~Neplatny~w~ pocet!')
                                end
                            end)

                        end
                    })
                end,getClientKey(GetCurrentResourceName()), datastore)
            elseif value == "store_money" then
                createMenu(title,  idName..'store_money', {
                    {label = 'Spinave penize', value = 'black_money'},
                    {label = 'Ciste penize', value = 'cash'}
                }, {
                    submit = function(data, menu2)
                        createDialog('Pocet k ulozeni?', idName..'store_money_count',function(data2,menu3)
                            menu3.close()
                            menu2.close()
                            local count = tonumber(data2.value)
                            if count ~= nil and count > 0 then
                                ESX.TriggerServerCallback('rcore:putStoredMoney',function(is)
                                    if is then
                                        if data.current.value == "cash" then
                                            showNotification(string.format('Vyborne, prave jste ~g~ulozili %s$',ESX.Math.GroupDigits(count)))
                                        else
                                            showNotification(string.format('Vyborne, prave jste ~g~ulozili %s$~w~ spinavych penez',ESX.Math.GroupDigits(count)))
                                        end
                                    else
                                        showNotification('~w~Takto to nepujde, ~r~nemuzete~w~ dat vice nez mate')
                                    end
                                end,getClientKey(GetCurrentResourceName()),datastore,data.current.value,count)
                            else
                                showNotification('~r~Neplatny~w~ pocet!')
                            end
                        end)
                    end
                })
            elseif value == "get_money" then
                ESX.TriggerServerCallback('rcore:getStoredMoney',function(options)
                    createMenu(title,  idName..'get_money', options, {
                        submit = function(data, menu2)
                            createDialog('Pocet k ulozeni?', idName..'get_money_count',function(data2,menu3)
                                menu3.close()
                                menu2.close()
                                local count = tonumber(data2.value)
                                if count ~= nil and count > 0 then
                                    ESX.TriggerServerCallback('rcore:takeStoredMoney',function(is)
                                        if is then
                                            if data.current.value == "cash" then
                                                showNotification(string.format('Vyborne, prave jste ~g~vybrali %s$',ESX.Math.GroupDigits(count)))
                                            else
                                                showNotification(string.format('Vyborne, prave jste ~g~vybrali %s$~w~ spinavych penez',ESX.Math.GroupDigits(count)))
                                            end
                                        else
                                            showNotification('~w~Takto to nepujde, ~r~nemuzete~w~ vzit vice nez tam je')
                                        end
                                    end,getClientKey(GetCurrentResourceName()),datastore,data.current.value,count)
                                else
                                    showNotification('~r~Neplatny~w~ pocet!')
                                end
                            end)
                        end
                    })
                end,getClientKey(GetCurrentResourceName()),datastore)
            end
        end
    })
end

function getStorages()
    return storages
end

exports('getStorages',getStorages)

RegisterNetEvent('rcore:updateStorageBusy')
AddEventHandler('rcore:updateStorageBusy',function(storages)
    storageBusy = storages
end)
