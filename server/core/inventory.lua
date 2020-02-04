function getSharedInventory(inventory, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', inventory, function(inventory)
        cb(inventory)
    end)
end

exports('getSharedInventory',getSharedInventory)

function getInventory(owner,inventory,cb)
    TriggerEvent('esx_addoninventory:getInventory', inventory, owner, function(inventory)
        cb(inventory)
    end)
end

exports('getInventory',getInventory)

function isInventoryExists(inventory)
    rdebug(string.format('Checking %s shared inventory if exists.', inventory))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchAll('SELECT name FROM addon_inventory WHERE name = @name', {
            ['@name'] = name
        })
        if data[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end

exports('isInventoryExists',isInventoryExists)

function createInventory(inventory,shared,cb)
    isInventoryExists(inventory,function(is)
        if is then
            rdebug(string.format('Inventory %s already exists! Skipping creation!',inventory))
        else
            rdebug(string.format('Inventory %s not found! Starting creation.', inventory))
            MySQL.ready(function()
                MySQL.Async.execute('INSERT INTO addon_inventory (name, label, shared) VALUES (@name, @name, @shared)', {
                    ['@name'] = inventory,
                    ['@shared'] = shared
                }, function(rowsChanges)
                    rdebug(string.format('Inventory %s created.', inventory))
                    cb(rowsChanges)
                end)
            end)
        end
    end)
end

exports('createInventory',createInventory)