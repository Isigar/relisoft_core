Citizen.CreateThread(function()
    -- Get ESX instance
    getEsxInstance()
end)

-- Creating blips
Citizen.CreateThread(function ()
    createBlip("Testing name",53,vector3(0.0,0.0,0.0),{
        color = 12
    })
end)
