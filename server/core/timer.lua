local timers = {}

function createTimer(time, cb)
    table.insert(timers,{
        time = time,
        cb = cb
    })
end

exports('createTimer',createTimer)

function getTimers()
    return timers
end

exports('getTimers',getTimers)