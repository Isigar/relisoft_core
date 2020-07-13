local dbg = rdebug()

--- @param name string
--- @param cb function
function getDatastore(name, cb)
    TriggerEvent(EventConfig.Datastore.getSharedDatastore, name, function(store)
        cb(store)
    end)
end

exports('getDatastore',getDatastore)

--- @param identifier string
--- @param name string
--- @param cb function return with store instance
function getPlayerDatastore(identifier, name, cb)
    TriggerEvent(EventConfig.Datastore.getDatastore, name, identifier, function(store)
        cb(store)
    end)
end

exports('getPlayerDatastore',getPlayerDatastore)

--- @param name string
--- @param shared boolean
--- @param cb function return with store instance
function createDatastore(name, shared, cb)
    cb = cb or function() end
    --Firstly check if datastore exists!
    isDatastoreExists(name,function(res)
        if res then
            dbg.info(string.format('Datastore %s already exists! Skipping creation.', name))
            cb(true)
        else
            dbg.info(string.format('Datastore %s not found! Starting creation.', name))
            MySQL.ready(function()
                MySQL.Async.execute('INSERT INTO datastore (name, label, shared) VALUES (@name, @name, @shared)', {
                    ['@name'] = name,
                    ['@shared'] = shared
                }, function(rowsChanges)
                    dbg.info(string.format('Datastore %s created.', name))
                    cb(rowsChanges)
                end)
            end)
        end
    end)
end

exports('createDatastore',createDatastore)

--- @param name string
--- @return boolean
function isDatastoreExists(name,cb)
    dbg.info(string.format('Checking %s datastore if exists.', name))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchAll('SELECT name FROM datastore WHERE name = @name', {
            ['@name'] = name
        })
        if data[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end

exports('isDatastoreExists',isDatastoreExists)
