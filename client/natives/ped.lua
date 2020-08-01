PED_NETWORKED = true
PED_NON_NETWORKED = false

function createPed(pedType, model, position, heading,cb)
    requestModel(model,function()
        local ped = CreatePed(pedType,model,position.x,position.y,position.z,heading,PED_NETWORKED,false)
        SetModelAsNoLongerNeeded(model)
        cb(ped)
    end)
end

exports('createPed',createPed)

function createLocalPed(pedType, model, position, heading,cb)
    requestModel(model,function()
        local ped = CreatePed(pedType,model,position.x,position.y,position.z,heading,PED_NON_NETWORKED,false)
        SetModelAsNoLongerNeeded(model)
        cb(ped)
    end)
end

exports('createLocalPed',createLocalPed)
