function requestModel(modelName,cb)
    if modelName ~= 'string' then
        cb(false)
        return
    end

    RequestModel(modelName)

    while not HasModelLoaded(modelName) do
        Citizen.Wait(1)
    end

    cb(true)
end

exports('requestModel',requestModel)
