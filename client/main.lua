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

-- Creating distance marker for user
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        createMarker(1,vector3(x,y,z),{
            color = {
                r = 50,
                g = 150,
                b = 60
            },
            rotate = true
        })

        createDistanceMarker(1,vector3(x,y,z),100.0,{},function ()
            sendChatMessage('Super!','Press E to kill your self!')
        end, function()
            sendChatMessage('Ouuuch?','Where are you leaving?! I will find you!')
        end)
    end
end)
