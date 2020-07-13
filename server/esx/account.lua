local dbg = rdebug()

function getSharedAccount(account,cb)
    TriggerEvent(EventConfig.Account.getSharedAccount, account, function(account)
        cb(account)
    end)
end

exports('getSharedAccount',getSharedAccount)

function getAccount(owner,account,cb)
    TriggerEvent(EventConfig.Account.getAccount, account, owner, function(account)
        cb(account)
    end)
end

exports('getAccount',getAccount)

function isAccountExists(account,cb)
    dbg.info(string.format('Checking %s shared account if exists.', account))
    MySQL.ready(function()
        local data = MySQL.Sync.fetchScalar('SELECT COUNT(name) FROM addon_account WHERE name = @name', {
            ['@name'] = account
        })
        if data == nil then
            cb(false)
        else
            if data > 0 then
                cb(true)
            else
                cb(false)
            end
        end
    end)
end

exports('isAccountExists',isAccountExists)

function createAccount(account,shared,cb)
    isAccountExists(account,function(is)
        if is then
            dbg.info(string.format('Account %s already exists! Skipping creation!',account))
        else
            dbg.info(string.format('Account %s not found! Starting creation.', account))
            MySQL.ready(function()
                MySQL.Async.execute('INSERT INTO addon_account (name, label, shared) VALUES (@name, @name, @shared)', {
                    ['@name'] = account,
                    ['@shared'] = shared
                }, function(rowsChanges)
                    dbg.info(string.format('Account %s created.', account))
                    if cb then
                        cb(rowsChanges)
                    end
                end)
            end)
        end
    end)
end

exports('createAccount',createAccount)
