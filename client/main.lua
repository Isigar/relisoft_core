Citizen.CreateThread(function()
    -- Get ESX instance
    getEsxInstance()
end)

-- Creating blips example
Citizen.CreateThread(function ()
    local blip = createBlip("Testing name",53,vector3(0.0,0.0,0.0),{
        color = 12
    })

    while true do
        Citizen.Wait(100)
        local coords = getPlayerPos()
        SetBlipCoords(blip,coords.x,coords.y,coords.z)
    end
end)
