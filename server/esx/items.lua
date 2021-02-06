local dbg = rdebug()
local allItemsData = {}

function allItems()
    MySQL.ready(function()
        local data = MySQL.Sync.fetchAll('SELECT name FROM items', {
        })
        if data[1] ~= nil then
            for i,v in pairs(data) do
                allItemsData[v.name] = v
            end
        else
            dbg.critical('Cannot find items! SQL error.')
        end
    end)
end

allItems()

function existItem(itemName,cb)
    -- if we have already cached items use cache
    if allItemsData[itemName] ~= nil then
        cb(true)
    else
        -- we dont know if item is existing, try to check it
        MySQL.ready(function()
            local data = MySQL.Sync.fetchAll('SELECT name FROM items WHERE name = @name', {
                ['@name'] = itemName
            })
            if data[1] ~= nil then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end

exports('existItem',existItem)

function createItem(itemName, label, weight, cb, options)
    options = options or {}
    options.can_remove = options.can_remove or true
    options.rare = options.rare or false

    existItem(itemName,function(exists)
        if exists then
            dbg.info('Item %s was found, skipping creation',itemName)
        else
            MySQL.Async.execute('INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES (@itemName, @label, @weight, @rare, @canRemove)', {
                ['@itemName'] = itemName,
                ['@label'] = label,
                ['@weight'] = round(weight,1),
                ['@rare'] = options.rare,
                ['@canRemove'] = options.can_remove
            },function(changes)
                if changes > 0 then
                    if cb ~= nil then
                        cb(true)
                    end
                else
                    if cb ~= nil then
                        cb(false)
                    end
                end
            end)
        end
    end)
end

exports('createItem',createItem)
