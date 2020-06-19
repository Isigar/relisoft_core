function addWeapon(xPlayer, weapon, ammo, components)
    xPlayer.addWeapon(weapon)
    addAmmo(xPlayer,weapon, ammo)
    for _, v in pairs(components) do
        xPlayer.addWeaponComponent(weapon, v)
    end
end

exports('addWeapon',addWeapon)

function findWeaponFromLoadout(xPlayer,weapon)
    local weaponLoadout = xPlayer.getLoadout()
    for _, v in pairs(weaponLoadout) do
        if v.name == weapon then
            return v
        end
    end
    return nil
end

exports('findWeaponFromLoadout',findWeaponFromLoadout)

function setAmmo(xPlayer, weapon, ammo)
    if xPlayer.hasWeapon(weapon) then
        TriggerClientEvent('rcore:setWeaponAmmo',xPlayer.source,weapon,ammo)
    end
end

exports('setAmmo',setAmmo)

function addAmmo(xPlayer, weapon, ammo)
    if xPlayer.hasWeapon(weapon) then
        TriggerClientEvent('rcore:addWeaponAmmo',xPlayer.source,weapon,ammo)
    end
end

exports('addAmmo',addAmmo)