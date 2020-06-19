function isInVehicle(ped)
    ped = ped or PlayerPedId()

    local vehicle = GetVehiclePedIsIn(ped)
    if vehicle == 0 then
        return false
    else
        return vehicle
    end
end

exports('isInVehicle',isInVehicle)

--- @return vector3
function getPlayerPos()
    local ped = PlayerPedId()
    return GetEntityCoords(ped)
end

exports('getPlayerPos', getPlayerPos)

function getDriver(vehicle)
    return GetPedInVehicleSeat(vehicle,-1)
end

exports('getDriver',getDriver)

function isDriver(ped,vehicle)
    if ped == getDriver(vehicle) then
        return true
    end
    return false
end

exports('isDriver',isDriver)

function deleteVehicle(vehicle)
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteVehicle(vehicle)
end

exports('deleteVehicle', deleteVehicle)
