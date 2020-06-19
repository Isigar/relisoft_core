function playFxLoopedEntity(name, entity,offset, rot, scale, axis)
    if DoesParticleFxLoopedExist(name) then
        return StartNetworkedParticleFxLoopedOnEntity(name,entity,offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale, axis.x, axis.y, axis.z)
    else
        return false
    end
end

exports('playFxLoopedEntity',playFxLoopedEntity)
