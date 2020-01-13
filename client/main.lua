ESX = nil

Citizen.CreateThread(function()
    getEsxInstance(function(obj) ESX = obj end)
end)
