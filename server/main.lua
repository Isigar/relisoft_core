--Register number & society
registerNumber('bazar','Autobazar')
registerSociety('bazar','Autobazar')

-- Creating command
addCmd('help', function(source, args, user)
    -- Send message or something to client with source
    sendChatMessageFromServer(source,'Jouuu','Some cool message and its red!',{r = 255,g = 0, b = 0})
    -- or send notification
    sendNotificationFromServer(source,'Yes please!')
end, '/help - show help informations')
