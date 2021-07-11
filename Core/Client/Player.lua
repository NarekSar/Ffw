Citizen.CreateThread(function()
    while not NetworkIsSessionActive() do Wait(50) end
    TriggerServerEvent('Ffw:InitPlayer')
end)
