function requestAnimDict(animDict,cb)
    local loadCount = 0
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(2)
        loadCount = loadCount + 1
        if loadCount > 100 then
            dprint('Canceling loading anim dict %s, cannot load after 200ms', animDict)
            break
        end
    end
    cb()
end

exports('requestAnimDict',requestAnimDict)

function playAnim(ped,animDict, anim, flags)
    flags = flags or 0
    requestAnimDict(animDict,function()
        TaskPlayAnim(ped, animDict, anim, 8.0, 8.0, -1, flags, 0, false, false, false)
    end)
end

exports('playAnim',playAnim)

function taskGoTo(ped,entity,cb,offset)
    offset = offset or {
        x = 0.0,
        y = 0.0,
        z = 0.0
    }
    local entityPos = GetOffsetFromEntityInWorldCoords(entity,offset.x,offset.y,offset.z)

    TaskGoStraightToCoord(ped, entityPos, 1.0, 20000, GetEntityHeading(entity), 0.1)
    while #(entityPos-GetEntityCoords(ped)) > 0.5 do
        Citizen.Wait(250)
    end
    cb()
end

exports('taskGoTo',taskGoTo)
