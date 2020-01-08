---@param name string
---@param cb function
function getDatastore(name, cb)
    TriggerEvent('esx_datastore:getSharedDataStore', name, function(store)
        cb(store)
    end)
end

---@param identifier string
---@param name string
---@param cb function return with store instance
function getPlayerDatastore(identifier, name, cb)
    TriggerEvent('esx_datastore:getDataStore', name, identifier, function(store)
        cb(store)
    end)
end

---@param name string
---@param shared boolean
---@param cb function return with store instance
function createDatastore(name, shared, cb)
    --Firstly check if datastore exists!
    if isDatastoreExists(name) then
        debug(string.format('Datastore %s already exists! Skipping creation.', name))
    else
        MySQL.Async.execute('INSERT INTO datastore (name, label, shared) VALUES (@name, @name, @shared)', {
            ['@name'] = name,
            ['@shared'] = shared
        }, function(rowsChanges)
            cb(true)
        end)
    end
end

---@param name string
---@return boolean
function isDatastoreExists(name)
    local data = MySQL.Sync.fetchAll('SELECT name WHERE name = @name LIMIT 1', {
        ['@name'] = name
    })
    local length = tableLength(data)
    if length >= 1 then
        return true
    else
        return false
    end
end
