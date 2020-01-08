--Register number & society
registerNumber('bazar','Autobazar')
registerSociety('bazar','Autobazar')

-- Creating command
addCmd('help', function(source, args, user)
    -- Send message or something to client with source
end, '/help - show help informations')
