ESX = nil

Citizen.CreateThread(function()
    ESX = getEsxInstance()
end)

RegisterNetEvent('rcore:getWeaponAmmoClient')
AddEventHandler('rcore:getWeaponAmmoClient',function(weapon,cb)
    local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
    cb(ammo)
end)

RegisterNetEvent('rcore:setWeaponAmmo')
AddEventHandler('rcore:setWeaponAmmo',function(weapon,ammo)
    SetPedAmmo(PlayerPedId(),weapon,ammo)
end)

RegisterNetEvent('rcore:addWeaponAmmo')
AddEventHandler('rcore:addWeaponAmmo',function(weapon,ammo)
    AddAmmoToPed(PlayerPedId(),weapon,ammo)
end)