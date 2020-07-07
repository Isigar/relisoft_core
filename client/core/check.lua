Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        TriggerServerEvent('rcore:checkDone',GetCurrentResourceName(), getClientKey(GetCurrentResourceName()))
    end
end)
