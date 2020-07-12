local dbg = rdebug()

function existItem(itemName,cb)
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

function createItem(itemName, label, weight, cb, options)
    options = options or {}
    options.can_remove = options.can_remove or false
    options.rare = options.rare or false

    existItem(itemName,function(exists)
        if exists then
            dbg.info('Item %s was found, skipping creation',itemName)
        else
            MySQL.Async.execute('INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES (@itemName, @label, @weight, @rare, @canRemove)', {
                ['@name'] = itemName,
                ['@label'] = label,
                ['@weight'] = weight,
                ['@rare'] = options.rare,
                ['@canRemove'] = options.can_remove
            },function(changes)
                if changes > 0 then
                    cb(true)
                else
                    cb(false)
                end
            end)
        end
    end)
end

exports('createItem',createItem)
