--Register number & society
registerNumber('bazar','Autobazar')
registerSociety('bazar','Autobazar')
createDatastore('bazar',true)

-- Creating command
addCmd('help', function(source, args, user)
    -- Send message or something to client with source
    sendChatMessageFromServer(source,'Jouuu','Some cool message and its red!',{r = 255,g = 0, b = 0})
    -- or send notification
    sendNotificationFromServer(source,'Yes please!')
end, '/help - show help informations')

addCmd('saveData',function (source,args,user)
    getDatastore('bazar', function(store)
        store.set('name',{
            some = data
        })

        local val = store.get('value')
        if val == nil then
            store.set('val',true)
        end
    end)

    getPlayerDatastore('steam:123456789','property',function (store)
        local weapons = store.get('weapons')
    end)
end)
