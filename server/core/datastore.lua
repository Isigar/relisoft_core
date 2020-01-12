--- @param name string
--- @param cb function
function getDatastore(name, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', name, function(store)
        cb(store)
    end)
end

--- @param identifier string
--- @param name string
--- @param cb function return with store instance
function getPlayerDatastore(identifier, name, cb)
    TriggerEvent('esx_datastore:getDataStore', name, identifier, function(store)
        cb(store)
    end)
end

--- @param name string
--- @param shared boolean
--- @param cb function return with store instance
function createDatastore(name, shared, cb)
    cb = cb or function() end

    local societyName = 'society_'..name
    --Firstly check if datastore exists!
    isDatastoreExists(societyName,function(res)
        if res then
            rdebug(string.format('Datastore %s already exists! Skipping creation.', societyName))
            cb(true)
        else
            rdebug(string.format('Datastore %s not found! Starting creation.', societyName))
            MySQL.ready(function()
                MySQL.Async.execute('INSERT INTO datastore (name, label, shared) VALUES (@name, @name, @shared)', {
                    ['@name'] = societyName,
                    ['@shared'] = shared
                }, function(rowsChanges)
                    rdebug(string.format('Datastore %s created.', societyName))
                    cb(rowsChanges)
                end)
            end)
        end
    end)

end

--- @param name string
--- @return boolean
function isDatastoreExists(name,cb)
    rdebug(string.format('Checking %s datastore if exists.', name))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchAll('SELECT * FROM datastore WHERE name = @name', {
            ['@name'] = name
        })
        if data[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end
