local storages = {}

function addStorage(title, name, datastore, coords, options)
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
    return id
end

exports('addStorage',addStorage)

function openStorageMenu(id, title, name, datastore)
    local idName = string.format('storage-%s-%s-',id,name)
    createMenu(title, idName, {
        { label = 'Uschovat zbran', value = 'store_weapon' },
        { label = 'Vybrat zbran', value = 'get_weapon' },
        { label = 'Uschovat predmet', value = 'store_item' },
        { label = 'Vybrat predmet', value = 'get_item' },
        { label = 'Uschovat penize', value = 'store_money' },
        { label = 'Vybrat penize', value = 'get_money' },
    }, {
        submit = function(data, menu)
            local value = data.current.value
            if value == "store_weapon" then
                ESX.TriggerServerCallback('rcore:getWeapons', function(weapons)
                    createMenu(title, idName..'store_weapon', weapons, {
                        submit = function(data, menu2)
                            menu2.close()
                            ESX.TriggerServerCallback('rcore:storeWeapon', function(stored)
                                showNotification('~g~Uspesne jste ulozili zbran do trezoru!')
                            end, data.current.value, datastore)
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
                            end, datastore, data.current.value)
                        end
                    })
                end, datastore)
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
                                    end,datastore,data.current.value,count)
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
                                    end, datastore, data.current.value,count)
                                else
                                    showNotification('~r~Neplatny~w~ pocet!')
                                end
                            end)

                        end
                    })
                end, datastore)
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
                                end,datastore,data.current.value,count)
                            else
                                showNotification('~r~Neplatny~w~ pocet!')
                            end
                        end)
                    end
                })
            elseif value == "get_money" then
                ESX.TriggerServerCallback('getStoredMoney',function(options)
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
                                    end,datastore,data.current.value,count)
                                else
                                    showNotification('~r~Neplatny~w~ pocet!')
                                end
                            end)
                        end
                    })
                end,datastore)
            end
        end
    })
end

function getStorages()
    return storages
end

exports('getStorages',getStorages)