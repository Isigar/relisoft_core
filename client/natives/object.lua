function createObject(name,pos,cb)
    local model = (type(name) == 'number' and name or GetHashKey(name))

    requestModel(model,function()
        local obj = CreateObject(model,pos.x,pos.y,pos.z,true,false,false)
        SetModelAsNoLongerNeeded(model)
        cb(obj)
    end)
end

exports('createObject',createObject)

function deleteObject(obj)
    if IsEntityAttached(obj) then
        DetachEntity(obj,true,true)
    end
    DeleteObject(obj)
end

exports('deleteObject',deleteObject)
