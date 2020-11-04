function requestModel(modelName,cb)
    if type(modelName) ~= 'number' then
        modelName = tonumber(modelName)
    end

    local breaker = 0

    RequestModel(modelName)

    while not HasModelLoaded(modelName) do
        Citizen.Wait(1)
        breaker = breaker + 1
        if breaker >= 100 then
            break
        end
    end

    if breaker >= 100 then
        cb(false)
    else
        cb(true)
    end
end

exports('requestModel',requestModel)
