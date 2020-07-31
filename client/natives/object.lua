NETWORKED = true
NON_NETWORKED = false

function requestModel(model,cb)
    if not HasModelLoaded(model) and IsModelInCdimage(model) then
        while not HasModelLoaded(model) do
            Citizen.Wait(0)
        end

        cb()
    end
end

exports('requestModel', requestModel)

---Create networked object
function createObject(name,pos,cb)
    local model = (type(name) == 'number' and name or GetHashKey(name))

    requestModel(model,function()
        local obj = CreateObject(model,pos.x,pos.y,pos.z,NETWORKED,false,false)
        SetModelAsNoLongerNeeded(model)
        cb(obj)
    end)
end

exports('createObject',createObject)

---Create local object
function createLocalObject(name,pos,cb)
    local model = (type(name) == 'number' and name or GetHashKey(name))

    requestModel(model,function()
        local obj = CreateObject(model,pos.x,pos.y,pos.z,NON_NETWORKED,false,false)
        SetModelAsNoLongerNeeded(model)
        cb(obj)
    end)
end

exports('createLocalObject',createLocalObject)

function deleteObject(obj)
    if IsEntityAttached(obj) then
        DetachEntity(obj,true,true)
    end
    DeleteObject(obj)
end

exports('deleteObject',deleteObject)
