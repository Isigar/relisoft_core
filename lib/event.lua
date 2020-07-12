local function TriggerServerEvent(internal,event,...)
    print('Using local trigger event')
    if internal then
        TriggerServerEvent(event,...)
    end
end

function TSE(event,...)
    TriggerServerEvent(true,event,...)
end
